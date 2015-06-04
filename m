From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH 1/3] git bisect old/new
Date: Thu, 04 Jun 2015 11:05:08 -0700
Message-ID: <xmqqh9qnuz6z.fsf@gitster.dls.corp.google.com>
References: <1433404753-12039-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre@ensimag.grenoble-inp.fr,
	matthieu.moy@grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	Christian Couder <chriscool@tuxfamily.org>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 04 20:05:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0ZW2-0006mH-Qn
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 20:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbbFDSFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 14:05:13 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34338 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849AbbFDSFL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 14:05:11 -0400
Received: by igbhj9 with SMTP id hj9so21567163igb.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 11:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=k3mGdinftpTBz3zr1BzpqZwYLSmmMBxucvvtPzYbNmo=;
        b=HCw6YbWs7RYNmvlQHIwOvIIUSYeMr5YfzuuV8x6FKuhiDmP9BsCutBZLX/Oo2Yb5u5
         u+vfw+Zt8im0eZbIL0YJARr1A1UsOwOhM3WX4jyDh01g2qLzWnZx6GOnE33hD2LUEqmt
         haKi3I1S/76+z0TrfilzNOA7E5HJ2rytwTyrih4OiRxuUTnHJEGalaym1+ryq7ih9ejv
         MtdxwjUcycdxhPsZHcrOr9qZ2vpnj+ZuJspQx8Alq28RC0I/I3s3/9z9163O7BH0jVaw
         DIPHJbdwK29Xml75QSJoLhKkFqh9QZb4zcEAmUkMeqV8rwZKKyxEtQ6DqStbOSxxQ0eM
         dzOA==
X-Received: by 10.50.79.202 with SMTP id l10mr6964058igx.7.1433441111157;
        Thu, 04 Jun 2015 11:05:11 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8c50:e66f:fc40:1825])
        by mx.google.com with ESMTPSA id rr5sm3056981igb.7.2015.06.04.11.05.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jun 2015 11:05:10 -0700 (PDT)
In-Reply-To: <1433404753-12039-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	(Antoine Delaite's message of "Thu, 4 Jun 2015 09:59:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270792>

Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:

> From: Christian Couder <chriscool@tuxfamily.org>
>
> When not looking for a regression during a bisect but for a fix or a
> change in another given property, it can be confusing to use 'good'
> and 'bad'.
>
> This patch introduce `git bisect new` and `git bisect old` as an
> alternative to 'bad' and good': the commits which have the most
> recent version of the property must be marked as `new` and the ones
> with the older version as `old`.

The phrase "the most recent version of" invites an unnecessary
confusion.  "git bisect" is a tool to find a single bit flip and if
the behaviour changed twice in the history from A to B to C, you
cannot look for the transition between A to B or B to C.  You need
to say "I classify behaviour B and C to be both good (new) and I
know it used to have behaviour A which was bad (old)".

    You can mark the commits with the "new" property as "new", and
    the "old" property as "old"; "good" being "new" and "bad" being
    "old" becomes a mere special case of this.  The "new" property
    in the traditional bisection is "commit has the bug we are
    hunting", while "old" is "commit lacks that bug".

> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> index 4cb52a7..12c7711 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> ...
> @@ -104,6 +104,33 @@ For example, `git bisect reset HEAD` will leave you on the current
>  bisection commit and avoid switching commits at all, while `git bisect
>  reset bisect/bad` will check out the first bad revision.
>  
> +
> +Alternative terms: bisect new and bisect old
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +If you are not at ease with the terms "bad" and "good", perhaps
> +because you are looking for the commit that introduced a fix, you can
> +alternatively use "new" and "old" instead.
> +But note that you cannot mix "bad" and good" with "new" and "old".

There is a dq missing somewhere on this line.

> +
> +------------------------------------------------
> +git bisect new [<rev>]
> +------------------------------------------------
> +
> +Marks the commit as new, which means the version is fixed.

I am not sure ", which means the version is fixed." is a good idea.

The whole point of introducing "old" vs "new", the reason why we may
want to do this patch series, is to reduce confusion by removing the
value judgement associated with "good" vs "bad".  That is what made
the bisect confusing when the old ones were bad and new ones were
good.  Saying "fixed" implicitly contrasts it with "broken", and
introduces the value judgement on the states again.

	Side note: yes, if the reader is careful, "fixed" needs to
	have previous states to be "broken", so in that sense,
	"fixed" can be read about time-sequence and not about value
	judgement.  But let's try to be understandable by even
	casual readers.

We would instead want to emphasize that what we are judging is not
values but time sequence.  You would want to say "It used to be X
but it no longer is X", without saying if X is a good thing or not,
e.g.

	Marks the commit as new, e.g. "the bug is no longer there",
        if you are looking for a commit that fixed a bug, or "the
        feature that used to work is now broken at this point", if
        you are looking for a commit that introduced a bug.

> +------------------------------------------------
> +git bisect old [<rev>...]
> +------------------------------------------------
> +
> +Marks the commit as old, which means the bug is present.

This is much worse than the previous one. Unless you force the
reader to _assume_ that you are hunting for a fix, "bug is present"
can mean "bug is still present", or "bug was introduced somewhere
along the line and now it is there".  And a casual mention of
"perhaps because you are looking for a fix" at the beginning of the
section is not strong enough hint that these examples are _only_
about "hunting for bugfix".

I'd stop here for now, but a casual skimming told me that the same
issue exists throughout the remainder of the doc.

Thanks.
