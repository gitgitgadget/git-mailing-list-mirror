From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff --check always shows line 1 for blank at EOF for new
 files
Date: Sun, 10 Oct 2010 03:46:27 -0700
Message-ID: <7vpqvitjek.fsf@alter.siamese.dyndns.org>
References: <4CAC411E.3010204@gmx.de> <20101007093258.GA10941@burratino>
 <4CADBE01.4000901@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Christoph Mallon <christoph.mallon@gmx.de>
X-From: git-owner@vger.kernel.org Sun Oct 10 12:46:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4tQT-0007Mg-N8
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 12:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286Ab0JJKqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 06:46:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756811Ab0JJKqj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 06:46:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BB61BDD088;
	Sun, 10 Oct 2010 06:46:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3gEOIy7Su7NpzlwNsD4Mah9YrfU=; b=YITBGA
	LzOOc5/PzOtj7eYhdxQypNaZDKC/YFyXwR4l+Ln0NtaG+FJk7czx1dtSaQ7eSnvq
	LeCdVDWiMpXZxldcKPTGy0zGvT4YqJ/Lleeo32203SiCyscpHhux3cyaR+5i31Qj
	WQbdaPT5mWhCuvOcYHAuL5IeWADP6aPf2NT80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E9q1TKnUNtYU/3W61oZxdDXkgQlo6fBm
	Wy1l0ovCK7GIfJawA5vXkY6BSa4V/nxBye5Rwx0hQWfGuds9SFZklVSxQSYT6/c5
	VOARNj50j/BmEO5l6WD8KEWFuP78wMfcY8SUkQy4qFg2e+qDXI7LWkdTD7tAsBFE
	TT7NZ4/Ob/A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 886C5DD086;
	Sun, 10 Oct 2010 06:46:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AE8DDD071; Sun, 10 Oct
 2010 06:46:29 -0400 (EDT)
In-Reply-To: <4CADBE01.4000901@gmx.de> (Christoph Mallon's message of "Thu\,
 07 Oct 2010 14\:33\:05 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A5EC4EEA-D45B-11DF-9C37-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158654>

Christoph Mallon <christoph.mallon@gmx.de> writes:

> On 07.10.2010 11:32, Jonathan Nieder wrote:
>> Try this:
>>
>>      git init test
>>      cd test
>>      printf 'a\nb\nc\n'>  file
>>      git add -A
>>      echo hello>>  file
>>      echo>>  file
>>      git diff --check
>>
>> As you can see, it still returns line 4, which is the beginning of the
>> hunk that adds the blank line.
>>
>> A change to make it print the line number of the blank line itself
>> does not sound so bad, though.
>
> You're right. I think, the attached patch corrects the issue.
>
> From 45eaa882dae35f2976e77cf0b6b06be78283c13f Mon Sep 17 00:00:00 2001
> From: Christoph Mallon <christoph.mallon@gmx.de>
> Date: Thu, 7 Oct 2010 14:22:02 +0200
> Subject: [PATCH] When git diff --check detects a blank line at EOF, show the line number of the empty line, not the line number of the beginning of the hunk.
>
> ---

Could you check Documentation/SubmittingPatches, please?

>  diff.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 71efa8e..452fdf4 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2153,7 +2153,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
>  
>  			ecbdata.ws_rule = data.ws_rule;
>  			check_blank_at_eof(&mf1, &mf2, &ecbdata);
> -			blank_at_eof = ecbdata.blank_at_eof_in_preimage;
> +			blank_at_eof = ecbdata.blank_at_eof_in_postimage;

Hmm, I am confused.  Your subject line claims that for this patch:

        diff --git a/Makefile b/Makefile
        index 1f1ce04..90075e0 100644
        --- a/Makefile
        +++ b/Makefile
        @@ -2375,3 +2375,8 @@ cover_db: coverage-report

         cover_db_html: cover_db
                cover -report html -outputdir cover_db_html cover_db
        +
        +new-rule:
        +	echo here is a new rule
        +
        +

the code used to diagnose the error by showing the first line of the hunk
(2375 taken from either -2375 or +2375, it does not matter much).  The
claim is that your patch makes it to show the first line in the trailing
blank line block (the line after "here is a new rule", i.e. line 2381 in
the postimage).

But my reading of the code is that it is showing (incorrectly) the first
line of the trailing blank line block in the preimage (in this case,
because our codebase is clean, there is zero line of trailing blank line
block in the preimage, so it points at 2378.

So the patch looks correct, but the diagnosis / description seems wrong.
Since I am asking you to refer to SubmittingPatches to give a better
subject line, patch description and a sign-off anyway,...

Thanks.
