From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] diffcore-pickaxe doc: document -S and -G properly
Date: Fri, 24 May 2013 15:07:20 +0530
Message-ID: <CALkWK0n+NTnO0_4jNuR3Z5qmA_=-Dux+gq8kNzAT4YLC12Z8uQ@mail.gmail.com>
References: <1368793403-4642-1-git-send-email-artagnon@gmail.com>
 <1368793403-4642-3-git-send-email-artagnon@gmail.com> <7vfvxlw055.fsf@alter.siamese.dyndns.org>
 <7vsj1jzao7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 24 11:38:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfoRw-0002tI-1a
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 11:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760096Ab3EXJiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 05:38:04 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:55286 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760000Ab3EXJiB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 05:38:01 -0400
Received: by mail-ie0-f170.google.com with SMTP id aq17so11726524iec.1
        for <git@vger.kernel.org>; Fri, 24 May 2013 02:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Z/92jl67t4qTBq1W7Ei6YEJXKF3OOZOD9I7zbhXnIg4=;
        b=Y34dP0Cidqt/kpIhLcULgjdUBmdbJY1nWtTk8KGv2hOGQTWGJ5YzhkJUMLCx76OUvx
         1nqEk4A8u4D1tFIcDxpo8uK2wbWxwTxeBL63QUx9vMJerqtbbxj7gdD+KG1CyGwETNb0
         BjcH908Pj9/rQFnHtAq2F0acJLT85nXvdH5peSvdvhGX7EhNuk9NVojr0a+qp10PYffS
         VJqC1UBJg8/MARlXnn6S7zncTyQ/Ku2XqiSsSD8+TE3GIaSdGgN72DzM2eHdZtwvcCsR
         yRHOMRRoUwFWB2eCCyA5w/T5uZxjbYv1zkp/Fk5hfLeX4K6DC1lKVpYqPzln1ECiHHuY
         uFdA==
X-Received: by 10.50.66.197 with SMTP id h5mr13008398igt.63.1369388280832;
 Fri, 24 May 2013 02:38:00 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 24 May 2013 02:37:20 -0700 (PDT)
In-Reply-To: <7vsj1jzao7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225336>

Junio C Hamano wrote:
> [...]

I agree with the other comments, and have made suitable changes.
Let's review your block now.

>         This transformation is used to find filepairs that represent
>         two kinds of changes, and is controlled by the -S, -G and
>         --pickaxe-all options.

Why do you call this a "transformation"?  Is git log --author="foo" a
transformation on the git-log output?  Then how is git log -Sfoo a
transformation?

Two kinds of changes controlled by three different options?  Isn't the
original much clearer?

The title says diffcore-pickaxe, and the first paragraph says:

There are two kinds of pickaxe: the S kind (corresponding to 'git log
-S') and the G kind (mnemonic: grep; corresponding to 'git log -G').

>         The "-S<block of text>" option tells Git to consider that a
>         filepair has differences only if the number of occurrences
>         of the specified block of text is different between its
>         preimage and its postimage, and treat other filepairs as if
>         they did not have any change.

I'll rewrite this without the trailing "and treat other filepairs as
if they did not have any change" (which I'm not fond of).

>         This is meant to be used with
>         a block of text that is unique enough to occur only once (so
>         expected the number of occurences is 1 vs 0 or 0 vs 1) to
>         use with "git log" to find a commit that touched the block
>         of text the last time.

You're saying how you think it's "meant" to be used, but in doing so
you've failed to describe its operation faithfully.  I've already
described how it's meant to be used in diff-options (digging a block
of text iteratively) and this is the place to explain what it is doing
faithfully.  Hence my previous writeup on changes in number of
occurrences and rename detection: I _had_ to read the code to
understand it properly, and your writeup is not helping by telling me
about idiomatic usage.

Also, you've dropped computational expense which was there in the original.

>         When used with the "--pickaxe-regex"
>         option, the <block of text> is used as a POSIX extended
>         regular expression to match, instead of a literal string.

Better.

>         The "-G<regular expression>" option tells Git to consider
>         that a filepair has differences only if a textual diff
>         between its preimage and postimage would indicate a line
>         that matches the given regular expression is changed, and
>         treat other filepairs as if they did not have any change.

"would indicate"?  Really?  I'll rewrite this without the trailing
"and treat other filepairs ..".

You've once again dropped what it means in the context of in-file
moves (rename detection), and computational expense from the original.

>         When -S or -G option is used without "--pickaxe-all" option,
>         only filepairs that match their respective criterion are
>         kept in the output.

Much better.

>         When `--pickaxe-all` is used, all
>         filepairs intact if there is such a filepair, or makes the
>         output empty otherwise.

-ENOPARSE.  I didn't particularly like the original, and this isn't
better.  I'll rewrite it.

>         This behaviour is designed to make
>         reviewing of the changes in the context of the whole
>         changeset easier.

Same as original.  Okay.

Thanks.
