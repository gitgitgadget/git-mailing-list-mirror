From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 5/5] bisect: allow any terms set by user
Date: Fri, 26 Jun 2015 09:48:24 -0700
Message-ID: <xmqqtwtuv2jr.fsf@gitster.dls.corp.google.com>
References: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435258257-29047-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435258257-29047-6-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqk2urwjmq.fsf@gitster.dls.corp.google.com>
	<xmqqfv5fwib3.fsf@gitster.dls.corp.google.com>
	<vpqegkyyj7z.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 26 18:48:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8Wnp-0003Cg-9C
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 18:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbbFZQs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 12:48:29 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33035 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbbFZQs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 12:48:28 -0400
Received: by igtg8 with SMTP id g8so5418809igt.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=3DMykOmsEWwmZLpE6AJcliGVFC8aIwDAEULeyhee8DE=;
        b=rca7qnhqTADEEIN/OLlb11DTl3DTB7/WotX3ZGPViI8McFVD0XcgE4j9IAL+lbnm8+
         vOMBlxKmeJKxmQJEZ16c657R8O5DP4sirk/leJ2sEx+7LIwADgtEKrajLpShymcxoBwJ
         Vsk6Vw5kL4OR079CsGtaFnQNITbSV1Jldgt/PQ4Z3YIOKMluGL7B4uvT/q5kyPbYHyx/
         f7ehpPpJkOomTf8EgGQpIRVjYzyAXlF0cT61mYAuq3KkI8Nm9GZ/zpBgfHXc+C/8xsJs
         pDbdRtib9D6s5ctCHzOhm13SVkFGSSSmHBzK3pAYuu8yr929GBj3LH1B6eroLrHAzF7K
         Lhsw==
X-Received: by 10.107.156.140 with SMTP id f134mr3391122ioe.34.1435337307704;
        Fri, 26 Jun 2015 09:48:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id x4sm21957016iod.26.2015.06.26.09.48.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 09:48:26 -0700 (PDT)
In-Reply-To: <vpqegkyyj7z.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	26 Jun 2015 10:20:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272790>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> The second sentence may want to be something like
>>
>> 	If you mistyped one of the terms, you can do another "git
>> 	bisect terms <term-new> <term-old>" to correct them, but
>> 	that is possible only before you start the bisection.
>
> Applied, thanks.

I didn't say it out loud while writing the above, but this (and we
have other places that use the same phrase in the doc) mentions that
you have some point in time where you "start" the bisection, without
having a clear definition of where that bisection starts, and that
bothers me.  "You can do X until you do Y", when it is not clear
what Y exactly happens, is not very helpful.

We who know how bisection works internally know that the point of no
return is when we commit to the two terms and write one of the good
or bad bisect refs.  At that point, technically we haven't done a
bisection yet ("git bisect good maint" would bisect_autostart, but
without the other end, does not have a graph to bisect yet to find a
midpoint).

And worse yet, majority of users may read "git bisect start" is
where "you start bisection", but "bisect start" (either called
directly, or via bisect_autostart by the first "git bisect good")
is where you set up the machinery, so doing "bisect terms" before
doing "bisect start" does not make much sense.



> I currently have this in addition to v9 in my branch. I'll resend later
> (https://github.com/moy/git/tree/bisect-terms is up to date).
>
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> index e783f87..7609cd6 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -143,19 +143,19 @@ set your own terms.
>  git bisect terms <term-new> <term-old>
>  ------------------------------------------------
>  
> -This command has to be used before a bisection has started. <term-old>
> -must be associated with the latest revisions and <term-new> with the
> -ancestors of <term-old>. For example, if something was buggy in the
> +This command has to be used before a bisection has started. <term-new>
> +must be associated with the latest revisions and <term-old> with some
> +ancestors of <term-new>. For example, if something was buggy in the
>  old part of the history, you know somewhere the bug was fixed, and you
>  want to find the exact commit that fixed it, you may want to say `git
> -bisect terms fixed broken`; this way, you would mark a commit that
> +bisect terms broken fixed`; this way, you would mark a commit that

The example talks about a bug we used to have that was corrected, so
"broken" is old and "fixed" is new.  The earlier parts of this hunk
are correct but the last line should not be changed, no?

There unfortunately are two reasons why we cannot flip the order to
"git bisect terms old new":

 * "git bisect start $bad $good" established the
   convention to list bad before good (and 'B'ad comes before
   'G'ood, so does 'N'ew before 'O'ld).

 * "git bisect start $good $bad", even if we could use a time
   machine, would not be a good syntax, as you give zero or more
   good ones and one and only one bad one.
