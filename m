From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] log doc: explain --encoding=none and default output encoding
Date: Mon, 05 Aug 2013 09:02:54 -0700
Message-ID: <7vvc3km8gh.fsf@alter.siamese.dyndns.org>
References: <20130802223924.GA7634@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 18:03:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6NFN-0002Ta-Ru
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 18:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081Ab3HEQC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 12:02:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60322 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834Ab3HEQC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 12:02:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A411736BE7;
	Mon,  5 Aug 2013 16:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F7XZ0VTLi6aSHwehPFDcuif3nao=; b=xHWSlz
	u9oKCbbW8/mroF3EKkf+hr9EfH3KpOGdL7h8lhmy/gyu1Z82m1JlmgthvK6U0Bis
	DhmILbTcSR8a5P15LC8csfUoFf1OYz0iK/5zPlSTqcndWil9RNpJFG1op03A2Bge
	iZHZsiqvXRB9RcQLMQqmFpvyTREgVpnBgRg1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vzctwvaO/RoWGY+Gdm7tlEjHsRYP+U9n
	G2B+EMQazpuH5zpqKRu6qw3QIzeIducNKZDTR2pc3gqK0krW7Tzix93bCN41bqGP
	DMje48pD0IieiIHDZmzMnea+rQ3dLTCv0M8jRLf/iSPnvKbxgzt9gC8uXgpRTfuU
	JA31WUN2kcw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96E0F36BE6;
	Mon,  5 Aug 2013 16:02:56 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2C7036BE4;
	Mon,  5 Aug 2013 16:02:55 +0000 (UTC)
In-Reply-To: <20130802223924.GA7634@elie.Belkin> (Jonathan Nieder's message of
	"Fri, 2 Aug 2013 15:39:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7DD7461C-FDE8-11E2-8664-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231667>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> I'm not thrilled with the wording.  This can probably be explained
> more simply.  Ideas?

Some random thoughts on text, both before and after this patch.

 - The first stentence in this paragraph up to the semicolon is
   irrelevant (it is an implementation detail that allows us to
   re-encode in the first place, and the user does not care).

 - The use of word "default" is fuzzy.  With this description, we
   want to tell the user to what encoding we reencode to by default,
   but it is easy to miss that the reencoding always happen for
   output with or without --encoding=<anything> option (which is not
   clear from the text, especially the original) and incorrectly
   assume that without --encoding=<anything> the recorded text is
   spit out without mangling.

So perhaps along this line?

        --encoding=<encoding>::

                The encoding used to output the log messages in commit
                objects.  When this option is not given, non-plumbing
                commands output messages in the commit log encoding
                (`i18n.commitEncoding`, or UTF-8 if the configuration
                variable is not set).  `--encoding=none` lets you view the
                raw log message without any reencoding.

>
>  Documentation/pretty-options.txt | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
> index 5e499421..e31fd494 100644
> --- a/Documentation/pretty-options.txt
> +++ b/Documentation/pretty-options.txt
> @@ -32,8 +32,14 @@ people using 80-column terminals.
>  	The commit objects record the encoding used for the log message
>  	in their encoding header; this option can be used to tell the
>  	command to re-code the commit log message in the encoding
> -	preferred by the user.  For non plumbing commands this
> -	defaults to UTF-8.
> +	preferred by the user.  "--encoding=none" means to use the
> +	raw log message without paying attention to its encoding header.
> ++
> +For non plumbing commands, the output encoding defaults to the commit
> +encoding (as set using the `i18n.commitEncoding` variable, or UTF-8
> +by default).  This default can be overridden using the
> +`i18n.logOutputEncoding` configuration item. See linkgit:git-config[1]
> +for details.
>  
>  --notes[=<ref>]::
>  	Show the notes (see linkgit:git-notes[1]) that annotate the
