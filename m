From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Unexpected merge results in git-svn repo
Date: Wed, 31 Jul 2013 21:51:34 +1000
Message-ID: <CAH3AnrqAXhNEnKFxta5TGHwus+Sck1moEZe5V1J_9k7ZHQuW=A@mail.gmail.com>
References: <CAH3AnrqmFJxuy7PyJZS83VEwzrQB+mA5Frttd5fzKBhpZGP4Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 31 13:51:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4UwO-0003my-Dz
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 13:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350Ab3GaLvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 07:51:36 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:64342 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098Ab3GaLvg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 07:51:36 -0400
Received: by mail-lb0-f171.google.com with SMTP id t13so503702lbd.2
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 04:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=UAIgeGek6H/XXHASVFbxIhea37x5eOFscbmDLlRDJIs=;
        b=cj7sBL7mfncSQBxJan+8rcY6yLx8xUFR7NR9AAirXHrB4ZFfvHCFJDXFxQSISoQ+be
         0BUjDeVqjk+16TnCL8OI3X14/37BSaptva2vNXkCU2QoMh8aXtMKk1g8W69u+f9ar50u
         NUALNfVDnxklzTD5Poq0VVB3xisIhTL0/3MAG80GRTej5Xg+KdWGz5yXcooM28CjDaT7
         QtsDHwbD5fdPB1n0EHRvB001bmLVfS3WiV93AJBBXzJ2XMacrsDWLJeXZXQXE8hxPxoM
         diF4Zkr0M+xRRFB6gZO9CdY02LlTqJW1sAxBYBdJDl1+Pi7nnWNgP0cXtgQj8MpLQKS6
         PL8A==
X-Received: by 10.112.219.102 with SMTP id pn6mr29465654lbc.18.1375271494696;
 Wed, 31 Jul 2013 04:51:34 -0700 (PDT)
Received: by 10.114.4.99 with HTTP; Wed, 31 Jul 2013 04:51:34 -0700 (PDT)
In-Reply-To: <CAH3AnrqmFJxuy7PyJZS83VEwzrQB+mA5Frttd5fzKBhpZGP4Eg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231418>

To answer my own question...

My issue turned to be caused by a bad graft in my repo (unfortunately,
since hardened with filter-branch) that was making the commit that
modified F on Y reachable from X. The graft was an (incorrectly
executed) attempt to deal with the "3+ parent" problem that sometimes
occurs when git-svn pulls merges back from SVN.

jon.

On Wed, Jul 31, 2013 at 8:14 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
> I am getting some unexpected results from a merge and I'd like to
> understand why.
>
> I have two commits X and Y that I want to merge.
>
> git merge-base X Y # yields B
> git diff B X -- F  # is empty
> git diff B Y -- F  # contains the change I want merged
> git rev-list X ^B -- F # is empty
> git rev-list Y ^B -- F # contains one commit
>
> git checkout X
> git merge Y
>
> fails with fixable merge conflicts on other files, but uses X's copy
> of F instead of Y's.
>
> I was expecting it to use Y's copy of F, since only Y has modified F since B.
>
> What could cause this?
>
> BTW: I am using a git-svn repo that does have some 4+ parent merges in it.
>
> jon.
