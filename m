From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/4] mw-to-git: use git-credential's URL parser
Date: Wed, 18 Jul 2012 14:24:13 +0200
Message-ID: <vpqd33tjlzm.fsf@bauges.imag.fr>
References: <20120718120307.GA6399@sigill.intra.peff.net>
	<20120718120656.GD6726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 18 14:24:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrTIq-0005e4-2J
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 14:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424Ab2GRMYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 08:24:23 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55789 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336Ab2GRMYW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 08:24:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q6ICMJBC032343
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2012 14:22:19 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SrTIc-0004tl-Ez; Wed, 18 Jul 2012 14:24:14 +0200
In-Reply-To: <20120718120656.GD6726@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 18 Jul 2012 08:06:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 18 Jul 2012 14:22:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6ICMJBC032343
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343218940.23785@GwOfwxCUZZipXJXvGoHjgg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201683>

Jeff King <peff@peff.net> writes:

> @@ -216,7 +190,9 @@ sub credential_write {
>  sub credential_run {
>  	my $op = shift;
>  	my $credential = shift;
> +	my $url = shift;
>  	my $pid = open2(my $reader, my $writer, "git credential $op");
> +	print $writer "url=$url\n" if defined $url;
>  	credential_write($credential, $writer);
>  	print $writer "\n";
>  	close($writer);
> @@ -246,10 +222,10 @@ sub mw_connect_maybe {
>  	$mediawiki = MediaWiki::API->new;
>  	$mediawiki->{config}->{api_url} = "$url/api.php";
>  	if ($wiki_login) {
> -		my %credential = credential_from_url($url);
> +		my %credential;
>  		$credential{username} = $wiki_login;
>  		$credential{password} = $wiki_passwd;
> -		credential_run("fill", \%credential);
> +		credential_run("fill", \%credential, $url);
>  		my $request = {lgname => $credential{username},
>  			       lgpassword => $credential{password},
>  			       lgdomain => $wiki_domain};

I would find it more elegant not to special-case the URL field, and just

  my %credential = ('url' => $url);

but I'm fine with your version too.

Other than that, and for the 4 patches of the serie:

Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
