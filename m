From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email.perl: Fold long header lines to 78 chars
Date: Wed, 07 Oct 2009 22:02:28 -0700
Message-ID: <7vd44yo4uz.fsf@alter.siamese.dyndns.org>
References: <1254759898.1799.449.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 07:03:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvlAD-000056-FA
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 07:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbZJHFDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 01:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbZJHFDV
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 01:03:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56122 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbZJHFDU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 01:03:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C9C850787;
	Thu,  8 Oct 2009 01:02:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0nXvLUka85c01qi9TJUKsiEhHzM=; b=Eqc93z
	QwgYu7sf1TqVr+NLPTh2AsQoGx9eDMOfzZQcW0cYaGsNjqktmyeQMFDMz8Rc5FKc
	fhDzOtUgPzqxgZjucGn3Hg52urqiVEXTzC/J337y5U8s/RU+Kj2D/huVbvLecs2M
	DQqC8GARpPWWDogU7RIdb3pQPDxQ81//O92xc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ko3ssSdvQRdENd8dmmXvLRhm2WZ+zscK
	ROSMia8yOfxk3iHT/d+cJTXWalnydcl/GMNuhT58GYYsELv4rvhAJ2ly1yGbvzwQ
	MY5myf4TVfLXtxsO1cKuV9+0bNj/5I5eWAJH2fZSD3VNqbgJpQ8Xd81bqeZiOh8E
	J4+kj1xBL74=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C5C950786;
	Thu,  8 Oct 2009 01:02:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8306250785; Thu,  8 Oct
 2009 01:02:30 -0400 (EDT)
In-Reply-To: <1254759898.1799.449.camel@Joe-Laptop.home> (Joe Perches's
 message of "Mon\, 05 Oct 2009 09\:24\:58 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CA6A2FAE-B3C7-11DE-867D-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129672>

Joe Perches <joe@perches.com> writes:

> Some MTAs reject or filter long header lines which can
> be generated if the cc list is only a few entries.
>
> Fold long header lines to 78 chars to be more rfc compliant.
>
> Signed-off-by: Joe Perches <joe@perches.com>
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index dd821f7..cb8b48b 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -835,10 +870,10 @@ sub send_message
>  	    $gitversion = Git::version();
>  	}
>  
> -	my $cc = join(", ", unique_email_list(@cc));
> +	@cc = unique_email_list(@cc);
>  	my $ccline = "";
> -	if ($cc ne '') {
> -		$ccline = "\nCc: $cc";
> +	if (@cc gt 0) {

"gt"?  I think you meant (@cc > 0) but you can also say "if (@cc) {" which
would most clearly convey what you want to say..

> +		$ccline = fold_header("\nCc: ", ", ", @cc);
>  	}
>  	my $sanitized_sender = sanitize_address($sender);
>  	make_message_id() unless defined($message_id);
> @@ -976,7 +1011,7 @@ X-Mailer: git-send-email $gitversion
>  		if ($smtp_server !~ m#^/#) {
>  			print "Server: $smtp_server\n";
>  			print "MAIL FROM:<$raw_from>\n";
> -			print "RCPT TO:".join(',',(map { "<$_>" } @recipients))."\n";
> +			print fold_header("RCPT TO:", ",", map { "<$_>" } @recipients)."\n";
I do not think this hunk is correct.

Shouldn't we be rather repeating "RCPT TO: " for each recipient, as
RFC2821 4.1.1.3 says (this is an issue with the original code)?  I do not
think SMTP's "RCPT TO" command has the notion of continuation line used
for the payload (i.e. RFC 2822 Internet Message Format), and folding the
line is a new bug this patch introduces.

>  		} else {
>  			print "Sendmail: $smtp_server ".join(' ',@sendmail_parameters)."\n";
>  		}
