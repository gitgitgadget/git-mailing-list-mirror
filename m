From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Tue, 27 Dec 2011 18:41:03 -0800
Message-ID: <7vpqf91kqo.fsf@alter.siamese.dyndns.org>
References: <4EC52508.9070907@tu-clausthal.de>
 <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
 <4EC65DE4.90005@tu-clausthal.de>
 <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
 <4ED0CE8B.70205@tu-clausthal.de>
 <20111130064401.GC5317@sigill.intra.peff.net>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org>
 <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Wed Dec 28 03:41:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfjSN-0007us-5c
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 03:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077Ab1L1ClI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 21:41:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62362 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753011Ab1L1ClG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 21:41:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C86FC7876;
	Tue, 27 Dec 2011 21:41:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=C090DmalxXrNEc2YrEKCX3fngLE=; b=a1Oei5pAwqP4egByStyB
	oOitrVyCZ/Rzp9XykhD7bxL7vyRioeIdSNAEzDY8OK9mLmv+FI/hgaOWyg9cc4TL
	eL7M2pC34asmEX9yweOGtFeikF6mHehSjzVv2kFfAe2e/1PdiA79K/oLfpb0muv/
	p6UCV8Iz8UVm/qxJKJMgYeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Lqts1A2SNj9K4u6/bfx5AH6fsvBmOwwEXkRvRIg5FLEzfd
	gwBTW953KhQVacph6i9+Vf9HK5web1enOBLBZzVTIB5j/9sKK71d8f4iqozZAzp2
	txtvKMg6qbSelmfwH3xmEzV3GT6aMdwrBi40Ls7zOUpzGoFPIn5YRNP3aSPN0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C10F07875;
	Tue, 27 Dec 2011 21:41:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B6BF7872; Tue, 27 Dec 2011
 21:41:05 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 639213A4-30FD-11E1-832F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187743>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> @@ -4357,11 +4357,10 @@ sub ssl_server_trust {
>  	                               issuer_dname fingerprint);
>  	my $choice;
>  prompt:
> -	print STDERR $may_save ?
> +	my $options = $may_save ?
>  	      "(R)eject, accept (t)emporarily or accept (p)ermanently? " :
>  	      "(R)eject or accept (t)emporarily? ";
> -	STDERR->flush;
> -	$choice = lc(substr(<STDIN> || 'R', 0, 1));
> +	$choice = substr(Git->prompt("Certificate unknown. " . $options) || 'R', 0, 1);

I am afraid the extra "Certificate unknown. " prefix may make the prompt
way too long to fit on a line on the terminal or in the GUI. Would it be
Ok to perhaps add LF to make it a multi-line prompt? Do GUI based helpers
make that into a dialog box with multi-line prompt, or do they just barf?

>  	if ($choice =~ /^t$/i) {
>  		$cred->may_save(undef);

We seem to have lost lc() there, but it probably is deliberate and
harmless, as the value is checked with /^x$/i later.

As we are making sure $choice has a single character anyway, I think that
checking with "=~ /^x$/i" is unnecessarily ugly and wrong, even though it
is obviously not the fault of this patch.

> @@ -4378,10 +4377,7 @@ prompt:
>  sub ssl_client_cert {
>  	my ($cred, $realm, $may_save, $pool) = @_;
>  	$may_save = undef if $_no_auth_cache;
> -	print STDERR "Client certificate filename: ";
> -	STDERR->flush;
> -	chomp(my $filename = <STDIN>);
> -	$cred->cert_file($filename);
> +	$cred->cert_file(Git->prompt("Client certificate filename: "));
>  	$cred->may_save($may_save);
>  	$SVN::_Core::SVN_NO_ERROR;
>  }

We may later add an option to "prompt" method to allow the caller to say
that we are asking for a filename, and let GUI prompt helper to run a file
picker, but I think that is outside the immediate scope of this patch.
Just a thing for the future to keep in mind.

This patch itself looks almost perfect to me (modulo the above minor
nits), and except that it textually depends on 1/2 that may need to be
updated.

Thanks.
