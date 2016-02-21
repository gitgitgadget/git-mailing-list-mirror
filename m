From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: interactive rebase results across shared histories
Date: Sun, 21 Feb 2016 14:08:44 -0500
Message-ID: <CAPig+cSxmWc_Guab0UoQbRMEkVLr-qhF=LCiVk10G5AdnTqnGA@mail.gmail.com>
References: <87io1j6laz.fsf@gmail.com>
	<56C91D21.90306@moritzneeb.de>
	<8737sm6kmk.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Seb <spluque@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 20:08:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXZNC-0007tn-4k
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 20:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbcBUTIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 14:08:46 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:34031 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbcBUTIp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 14:08:45 -0500
Received: by mail-vk0-f50.google.com with SMTP id e185so112860640vkb.1
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 11:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/QOToYqe2DXzhL+vTVBbjkG9I4iU+2WoUg0/4jXYHTo=;
        b=JeK8zS4jLm/etry4vEy7wuJsONSIR/ZPrirW3PoNgkipDIGrm1b1V9RYI9uXtbYHZR
         0D8OyXVKYkQPLv4YGCw6SV0qL6IonbX+mJdjndKWyrhlMSbvj2oFOcYqu7hZedZlTvKx
         m7P6pFksWv9osW7A1F9Qxs7tMRtjr+IfkxyE7M9PS4RuVag1dsDt/VSm8HSXEE3fdzqA
         3rejw7ogYP/zBAR2bu5d9Gck0PZifLhf2dezNFAQPc45mdWeMbnG0HmFTrtquDJ4hy7b
         GinhYBkSJVSdf5HJhnFCbFiR/QxPCD/ZV5mANIKMwLqBy0f5Z5sFuZ9MqtqwWDmR3zCt
         cX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/QOToYqe2DXzhL+vTVBbjkG9I4iU+2WoUg0/4jXYHTo=;
        b=S9FKb+r1PpgnL/B7Kcr2b30GOoftHF3xRwPZIIddQhyM9sMcIqDBSYiMe3XtmwIb59
         okKcxq3O0Gv/CL4T8V4ilePlbTZP1dwviJTKAI7Z6iQM38VSJmbxvucTWf/NUsjS1pGR
         NOLvovRLwpiVBCpsUv4yC5iogreJ/aJGEPkaaet1OI1nhcOp9YF+Gk/yRtwoOB0+3XID
         yjLbV9Xn2WylGDla+KHnucNLNJ/u2D85fu4T8ycBdEBrfM9HAp9vejkbCgWaXmId7dF1
         4PX4XlIkbvayEaslDf9HSp8IkEsdXzr9b5pWMju2sKXV/bWLif6FIcRRYPHG3j3KP9js
         HGlQ==
X-Gm-Message-State: AG10YOSDMKsJuLFwWO82WUtOUq/mtNRr4FK5azpcqCHbCQ+VkM+3pg9lEbHSxxzwBKr0E0Dg6f4Z2/Efq2r70A==
X-Received: by 10.31.150.76 with SMTP id y73mr19931928vkd.84.1456081724858;
 Sun, 21 Feb 2016 11:08:44 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 21 Feb 2016 11:08:44 -0800 (PST)
In-Reply-To: <8737sm6kmk.fsf@gmail.com>
X-Google-Sender-Auth: iEoyLF6EMT63gFT2RNiB8iXrBkc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286826>

On Sun, Feb 21, 2016 at 12:25 PM, Seb <spluque@gmail.com> wrote:
> The scenario is much simpler; imagine master has a longer history behind
> the point where the topic branch started:
>
>                 A---B---C topic
>                /
>   *---D---E---F---G master
>
> And we want to keep both branches separate (no desire to merge them for
> now), but we realize that, say, commits D and E should be
> squashed/fixup, so we do an interactive rebase.  Now, the problem is
> that if I do that from the topic branch, the results are not reflected
> in the master branch, even though these commits are certainly shared
> with master.  It seems counterintuitive that a part of history that is
> shared among branches can be independently manipulated/rewritten with
> rebase.  I must be missing something...

What you're probably missing is that you can't actually edit commits
in Git. Instead, what you think of as "editing" actually creates a new
commit with its own commit-ID, and the original commit still exists
with its own commit-ID. Since Git commits are chained together by
their commit-ID's, any commits pointing at the original commit-ID
continue to point to that commit, and only commits rebased atop the
new commit-ID of the "edited" commit point at it.

In your example, you're "editing" D and E, which creates new commits
D' and E', so your resulting graph looks like this:

    D'---E'---A---B---C topic
   /
  *---D---E---F---G master

So, "master" and "topic" really are not sharing D and E (or D' and
E'). You could "fix" this to match your intuition by rebasing F...G
onto E' (see git-rebase --onto, for instance), which would give you
this:

                  A---B---C topic
                 /
  *---D'---E'---F---G master

and then "master" and "topic" would really be sharing D' and E' as
common history. (Of course, rebasing "master" or any branch may not be
desirable if you've published it, so applicable warnings about
rebasing apply.)

By the way, the problem isn't restricted to when you rebase "topic"
(as your problem description implies). You'd see the same behavior if
you'd rebased D and E in "master" to become D' and E'. "topic" would
still have old D and E in its history, and not D' and E'.
