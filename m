From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] unpack-trees: do not delete i-t-a entries in worktree
 even when forced
Date: Thu, 25 Feb 2016 17:45:55 +0700
Message-ID: <CACsJy8C1fgu584Uxte+x4aHHQwishOeAzofyU7BGx0V-Pav7Kg@mail.gmail.com>
References: <1456314317-30301-1-git-send-email-pclouds@gmail.com>
 <xmqqa8mpsom6.fsf@gitster.mtv.corp.google.com> <xmqq60xdsnfr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 11:46:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYtRJ-0006qz-Qk
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 11:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759853AbcBYKq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 05:46:28 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33052 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759412AbcBYKq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 05:46:27 -0500
Received: by mail-lb0-f177.google.com with SMTP id x4so26707027lbm.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 02:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=i6zZoNhA4RgQ1O363eYum03ftnLD7fN+FEO/eFNdyiA=;
        b=E1Woq9yDt2s0TTjsMhyirhEW5Me0m+QeBkGl1IJzeZaTxkRiTUt6j90dmxywcZiDH/
         V76iIGDrbJqxcIoPYDSGWiz5lmtYJJScXUsnY/WIULu2/aHXv0+8PYF3JLHyB9AEZ6L4
         /KXOlE8nvbt3Ktkk0gFnHPebjiyjGU8v68kHmSSyyHNM8NhkJkuxHwA23SbZysAg6SJq
         GchLxjSctZIw1iPY+oJ8Cd3StD+YctZ2li7Ra4R8Ehz6oxNyWMwT3nsvWfPFt0M+xDYE
         3LQo0YSDVDoPQKyivtrGglApIufO6QybAxAHoDxTGHOhwhNjCJaOpXORE3cBJVB0Uzau
         JoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=i6zZoNhA4RgQ1O363eYum03ftnLD7fN+FEO/eFNdyiA=;
        b=ETlol3hrkcWcU1XH5wcvMiFfvp58rbJxfruU8Ij/zGrqy1CO01cS7/EuX10mZfyuk6
         HTER/WZpm1JH3ql5HjbIzP6aghktBJv4aPEdLpB+g3IXfLrIDXJcsh4rog9dkETYkwE6
         3Ji8C0LqalfLvkgJ6ZKNI81FUcmac2dohydpsV2eDMPPEckfzd3TXerdDWunWkenegKn
         Dt1AYo/4PcC26ux9+uVBmpEFJETTTzQrqlMQd0i9JLnIL4rsHg0eGqnmpaUV9Wu8mjdg
         mmk9eL9IMpwf84NgTrJI+4QrUr9eQGRL1IGMQsF+UnrkeTCkVSJuZdPkNq9Z8KjIAE/T
         1jNQ==
X-Gm-Message-State: AG10YORC2hOAiPgxrmjL0przBbfC83gkIwFewTwOZz1piq3DwNyaNiBgAq5XMdfV7IeE6tit6FOqPjJBL3Q+0A==
X-Received: by 10.112.150.133 with SMTP id ui5mr16162966lbb.12.1456397185326;
 Thu, 25 Feb 2016 02:46:25 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 25 Feb 2016 02:45:55 -0800 (PST)
In-Reply-To: <xmqq60xdsnfr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287362>

On Thu, Feb 25, 2016 at 6:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Thinking about it more, I have to say that I do not agree with the
> basic premise of this patch.  I-T-A is not "may want to commit, but
> they are untracked" at all.  It is "I know I want to add, I just
> cannot yet decide the exact contents".
>
> That is why "git add -N newfile && git grep string" would find the
> string from newfile, and "git add -N newfile && git diff HEAD newfile"
> would show the addition.

We can agree to disagree. To me i-t-a is still a reminder, not a real
tracked entry (with unknown content).

> Sane people would expect that "git reset --hard HEAD" would behave
> as "git diff HEAD | git apply --index -R" when your index is fully
> merged, but this change will break the expectation.

$ echo abc >abc
$ git add -N abc
$ git diff HEAD|LANG=C git apply --index -R
error: abc: does not match index
$ cat abc
abc

OK this is just nit-picking. We could probably make it work, though
I'm not interested in doing that.

> Earlier we changed "git commit" to pretend as if an I-T-A entry does
> not exist in "git add -N newfile && git commit", but I think that
> was a mistake that was caused by the same fuzzy thinking.
>
> 3f6d56de (commit: ignore intent-to-add entries instead of refusing,
> 2012-02-07) does talk about the use of "git add -N" in conjunction
> with "git status" and "git diff", but somehow nobody realized that
> it was introducing inconsistency in the semantics.
-- 
Duy
