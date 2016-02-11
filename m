From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Gated Merge?
Date: Fri, 12 Feb 2016 09:42:51 +1100
Message-ID: <CAH5451=rVmdTra0rVNEkfdfOeSyeETSMo7YGWdYozZr_=YyAtw@mail.gmail.com>
References: <xmqqvb5uvr40.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 23:44:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTzxx-000386-C7
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 23:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbcBKWnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 17:43:31 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:34965 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbcBKWnb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 17:43:31 -0500
Received: by mail-io0-f181.google.com with SMTP id g203so47021552iof.2
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 14:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9oXP64Jpye2XTcpkJAEjEi+1fseEb47uQggZZ0JbZos=;
        b=T0HJxWxdBqJYKT5/ewhwHyyyuquHzsuftjlMxsYq9FjKUj/wEpzkteGwAmNt6NzWr8
         ZAdPWw6we0taQmgVwDd3VrmmimfX3OuuZikrtadLs4n/tcdIcl3Ki/sAnyW2J5jRZSa2
         j0gZsJ1atSLeevl18TW+I9o5zhTd7RI9uiPAEqofS/WQia62zUMQEWZIgb1lmCv+8qJR
         n8BQkUE/GvBYi7VlfCvabZOlRTh6DgeCYHpXTyCmSABGlz25G5M5LW7FhOHjf41bi2fq
         2zUpZA53LkjoUojiAVOIXsl2tPRvTk0O/yEaOA3R3/fR8F9dmb0QZ0cSOZKxJsMIf3gQ
         9C5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=9oXP64Jpye2XTcpkJAEjEi+1fseEb47uQggZZ0JbZos=;
        b=NsL0VDn7bJZBA3ce7JVqQOMbst0gHxMp3W2ZUlKNXzDWn8KFt9pRN+Cw7goyboVa8F
         wXZAgV/kcKL+d3qNrVEaxy+vgtX+xghJMi47GEuYIfTB6rtAfNflKR4b1cDa5Zj3XGUj
         SMsY45u7pTXAqbLhTaukvel3EoNYPWxB/1CnZltSf5ICXxcEe3SFa9p+tl8NLJ2ufVwL
         EMj0mAYzZcZSKm+s8UKlXQbWz1varVtjq9VxHJ5SGHWU8EVJrtRm19cURjh8wYVT3yxl
         gx4GJ12e+E0zSlKUtV1jpWfsTB31LLDIR0LfeF1QCPBRptksEhN8xMtnbk7ZB3UA29Vj
         b4UA==
X-Gm-Message-State: AG10YOQu57VBRWEm+nqjGucMrLHB7uiboK7+OhFY9/+adBpUKQIrbt9bOn9zHYknhwjFoUYH3af3Jlg92zJuYQ==
X-Received: by 10.107.129.228 with SMTP id l97mr47535391ioi.76.1455230610614;
 Thu, 11 Feb 2016 14:43:30 -0800 (PST)
Received: by 10.36.60.195 with HTTP; Thu, 11 Feb 2016 14:42:51 -0800 (PST)
In-Reply-To: <xmqqvb5uvr40.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286016>

On 12 February 2016 at 09:06, Junio C Hamano <gitster@pobox.com> wrote:
>
> To realize this, there are low-hanging-fruit building blocks that
> are trivial:
>
>  - Such an annotation can be made as a note attached to the commit
>    in question;
>
>  - Such a check can be done in pre-commit hook;
>
>  - Such a pre-commit hook can iterate over this set of commits
>
>     DIFF=$(git rev-list --left-right HEAD...MERGE_HEAD)
>
>    collect these Merge Gate annotations from the commit appears on
>    the left hand side (e.g. only exists on the trunk that a side
>    branch is about to be merged in), and run them.
>
> But the last one feels very costly, and I suspect that there must be
> a better way to do this.  I do not think we want the "what to do"
> part (i.e. checking new lines for __attribute__ in the first
> example, or rewriting new lines that has __attribute_ in the second
> example) to be in git-core; that clearly is outside the scope of the
> plumbing.  But the part that finds these "annotations", especially
> if we can come up with a fast implementation that may be hard to
> script, may be a good addition to the plumbing command set.
>
> Thoughts?

What is the benefit in doing this in notes vs having the tests in the
working tree?

Pros:

 - merge-gates can be added after the commit, but will stick with the
commit if it moves around (as opposed to creating a second commit to
add the merge-gate to the working tree)

 - cross repository standards can be established that allow
merge-gates to be detected and run automatically (arguably could be
done with a standardised folder structure too, but that is more
disruptive)

 - can view the relevant merge-gates in git log against each commit
that they are protecting

Cons:

 - difficult to see the current complete set of merge-gates

 - difficult to make changes to a number of merge-gates at the same time

 - poorly defined behaviour when multiple merge-gates overlap in
functionality. Which gates execute first? What if I reorder the
commits?


My practical knowledge of notes is severely lacking so excuse me if I
missed anything obvious.

Regards,

Andrew Ardill

(sorry for the double post Junio, gmail ate my plain text encoding at
some point...)
