From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should the --encoding argument to log/show commands make any guarantees about their output?
Date: Wed, 17 Jun 2015 13:02:09 -0700
Message-ID: <xmqqzj3y5cji.fsf@gitster.dls.corp.google.com>
References: <557E91D2.3000908@googlemail.com>
	<xmqqzj3y2snq.fsf@gitster.dls.corp.google.com>
	<5581A964.4000500@googlemail.com> <20150617184607.GA28455@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jan-Philip Gehrcke <jgehrcke@googlemail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 17 22:02:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5JXN-0004iH-5M
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 22:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963AbbFQUCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 16:02:13 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:34742 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbbFQUCL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 16:02:11 -0400
Received: by iebmu5 with SMTP id mu5so41348571ieb.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tMBFMiIwHDRghcjT3XDT4Hg0b7WVllwR9qdXxLoxri4=;
        b=NmSWwWsslzS6lkOYEFRjEsKX8Hho1fL2TdKJbjMWTZT0ZVXUFe9kSJj7PTz0PXzwnH
         nJDS9ePAuoGyNhCU/9BaPRImJLPUVjZGfGfN1KKf/bF17IEqx5ufZz/2Lgpu5B05C0QL
         Tgx5jHyLRrbeAPo0gbtC2vOqIge+JQA6EiB2a18qnpIMr8e3dlJtLn4RDOPGPtNqGJk0
         d9dCdWDGCZtQFd2IlpCgh8E+/fM1KqxV7I/9z9GPvs6pcu/bNQcsCNtp909WhlrT4hsd
         az/+yziqDHmy6WbOHBx+rG1G01YEljXHrJvC1mS47BXxMdMYAhTDeQv3ONXS5EYamJGY
         jAGA==
X-Received: by 10.107.162.147 with SMTP id l141mr10521879ioe.77.1434571331123;
        Wed, 17 Jun 2015 13:02:11 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id j20sm3825081igt.16.2015.06.17.13.02.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 13:02:10 -0700 (PDT)
In-Reply-To: <20150617184607.GA28455@peff.net> (Jeff King's message of "Wed,
	17 Jun 2015 14:46:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271903>

Jeff King <peff@peff.net> writes:

> I would vote for a documentation change, perhaps like:
>
> Subject: docs: clarify that --encoding can produce invalid sequences
>
> In the common case that the commit encoding matches the
> output encoding, we do not touch the buffer at all, which
> makes things much more efficient. But it might be unclear to
> a consumer that we will pass through bogus sequences.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Sounds like a sensible thing to do.

>  Documentation/pretty-options.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
> index 74aa01a..642af6e 100644
> --- a/Documentation/pretty-options.txt
> +++ b/Documentation/pretty-options.txt
> @@ -37,7 +37,10 @@ people using 80-column terminals.
>  	in their encoding header; this option can be used to tell the
>  	command to re-code the commit log message in the encoding
>  	preferred by the user.  For non plumbing commands this
> -	defaults to UTF-8.
> +	defaults to UTF-8. Note that if an object claims to be encoded
> +	in `X` and we are outputting in `X`, we will output the object
> +	verbatim; this means that invalid sequences in the original
> +	commit may be copied to the output.
>  
>  --notes[=<ref>]::
>  	Show the notes (see linkgit:git-notes[1]) that annotate the
