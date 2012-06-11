From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] add git credential login to remote mediawiki
Date: Mon, 11 Jun 2012 21:13:49 +0200
Message-ID: <vpqaa094q6q.fsf@bauges.imag.fr>
References: <1339440893-8522-1-git-send-email-Javier.Roucher-Iglesias@enismag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: Javier.Roucher-Iglesias@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Mon Jun 11 21:14:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeA3u-0000iE-Ig
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 21:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895Ab2FKTN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 15:13:59 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55076 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699Ab2FKTN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 15:13:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5BJ4uci011086
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2012 21:04:56 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SeA3i-0003U6-O0; Mon, 11 Jun 2012 21:13:50 +0200
In-Reply-To: <1339440893-8522-1-git-send-email-Javier.Roucher-Iglesias@enismag.imag.fr>
	(Javier Roucher-Iglesias's message of "Mon, 11 Jun 2012 20:54:53
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 11 Jun 2012 21:04:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5BJ4uci011086
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340046301.23341@2bproilQsRDcr0HUMQedUQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199708>

Javier.Roucher-Iglesias@ensimag.imag.fr writes:

> --- a/contrib/mw-to-git/git-remote-mediawiki
> +++ b/contrib/mw-to-git/git-remote-mediawiki
> @@ -154,26 +154,107 @@ while (<STDIN>) {
>  # MediaWiki API instance, created lazily.
>  my $mediawiki;
>  
[...]
> +my $mediawiki;

You're adding a second declaration of $mediawiki. Cut-and-paste issue?

Plus, didn't I already mention that this "my $mediawiki;" was meant to
be right above mw_connect_maybe?

> +        if ($wiki_login ne "") {
> +                $msg .= "username=$wiki_login\n";
> +        }

Indentation with space.

> +	my $key;
> +	my $value;
> +	my $Prog = "git credential $op";
> +	open2(*Reader, *Writer, $Prog);
> +	print Writer $msg;
> +	close (Writer);

No space before "(" (already mentionned off-list).

> +			# error if key undef
> +			if (not defined $key) {

The comment is useless and therefore counter-productive. Remove it.

> +				print STDERR "ERROR reciving reponse git credential fill\n";

You can add $_ to the message. If this ever happens, the user will
appreciate to see what's going on.

>  sub mw_connect_maybe {
> +
>  	if ($mediawiki) {

Don't add useless newlines.

> +		if (!$wiki_passwd) {
> +			#user knows, password not.
> +			ask_login();
>  		} else {
> -			print STDERR "Logged in with user \"$wiki_login\".\n";
> +			#user and password knows.
> +			ask_login();
>  		}

What is this? You have an "if" with both branches identical.

If the user didn't specify any login name, then you should try to
connect to the wiki anonymously, which works in many wikis.

(BTW, doesn't "ask_login" ask for a password more than a login? If so,
please rename the function).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
