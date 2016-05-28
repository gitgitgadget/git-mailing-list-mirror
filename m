From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC-PATCH v2 1/2] send-email: quote-email populates the fields
Date: Sat, 28 May 2016 16:35:10 +0200
Message-ID: <vpqk2iel081.fsf@anie.imag.fr>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
	<1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
	<1464369102-7551-2-git-send-email-tom.russello@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jordan.de-gea@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	e@80x24.org, aaron@schrab.com, gitster@pobox.com
To: Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Sat May 28 16:45:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6fUK-0000mr-4h
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 16:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbcE1OfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2016 10:35:24 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57563 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269AbcE1OfX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 10:35:23 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4SEZALY027098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 28 May 2016 16:35:10 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4SEZANZ030845;
	Sat, 28 May 2016 16:35:10 +0200
In-Reply-To: <1464369102-7551-2-git-send-email-tom.russello@grenoble-inp.org>
	(Tom Russello's message of "Fri, 27 May 2016 19:11:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Sat, 28 May 2016 16:35:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4SEZALY027098
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465050911.14853@5CXdOBPRvEi1DprdYqaE2Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295815>

Tom Russello <tom.russello@grenoble-inp.org> writes:

> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -106,6 +106,11 @@ illustration below where `[PATCH v2 0/3]` is in reply to `[PATCH 0/2]`:
>  Only necessary if --compose is also set.  If --compose
>  is not set, this will be prompted for.
>  
> +--quote-email=<email_file>::
> +	Reply to the given email and automatically populate the "To:", "Cc:" and
> +	"In-Reply-To:" fields.

I think this is a bit too technical for a user documentation. To: and
Cc: is OK, but people need not know about "In-Reply-To:" to understand
this. See what the doc of --in-reply-to says. If you want to be
technical, you'd need to mention the References: field too.

Talking about Reference: field, something your patch could do is to add
all references in <email_file> to the references of the new email (see
what a mailer is doing when replying). This way, the recipient can still
get threading if the last message being replied-to is missing.

> +"Re: [<email_file>'s subject]".

Perhaps `Re: ...` instead of double-quotes.

> +if ($quote_email) {
> +	my $error = validate_patch($quote_email);
> +	$error and die "fatal: $quote_email: $error\nwarning: no patches were sent\n";

I know it's done this way elsewhere, but I don't like this "$error and
die", I'd rather see a proper if here.

> +		if (defined $input_format && $input_format eq 'mbox') {

To me, the input format refers to patch files, not the <email_file>.

I'm not sure anyone still use the "lots of email" format, and you are
not testing it. So, this is claiming that we have a feature without
being sure we have it nor that anyone's ever going to use it.

I'd just drop this "if" and the "else" branch, and just assume the email
file is a normal email file.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
