From: Colin Yates <colin.yates@gmail.com>
Subject: Please help provide clarity on git rebase internals
Date: Mon, 8 Sep 2014 12:25:25 +0100
Message-ID: <CAE2xRkHgnXK84u5zeLyVZqAnvu3u+0gSgaB+smFXu6Y7pkY1kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 13:25:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQx4c-0001po-Ms
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 13:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033AbaIHLZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 07:25:26 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:41262 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbaIHLZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 07:25:26 -0400
Received: by mail-yh0-f44.google.com with SMTP id a41so9132608yho.3
        for <git@vger.kernel.org>; Mon, 08 Sep 2014 04:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Jr/2wTW3rKYh21Gc3qaow5H2nOn2r/N9Qi+1wRxbp5w=;
        b=sWiglm+n9LVyOQoMTEdDIE/fo0QObIZ5ZsglZlVW77487iBCsyN0HvmUcjbgHxduoq
         L0ozGvVmdDQcjLFt/vTdsqL1b60tz/145SK5O8r+228cd0OFQPdDIDZ8dxW38JUiTSRn
         opC35YHbTlYQeYlNHSKUABkb6xpA/T4XVHpouDsPPCk/841IdXHayTJto2BWSWHn3R4q
         sGavWag5aw5AW7BJE47i+AdLhvlF5aEKrtEi9I0dorS9QqgtRvUOVMEECVIkBmN20/qu
         HoysShiHT7Oro2qo98bxBaWrQI8UmcTYhpSHUiKa844LO5RwUT4a4j3V6QMXuZfUiNpG
         aNlg==
X-Received: by 10.236.165.199 with SMTP id e47mr41466239yhl.12.1410175525552;
 Mon, 08 Sep 2014 04:25:25 -0700 (PDT)
Received: by 10.182.231.232 with HTTP; Mon, 8 Sep 2014 04:25:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256640>

Hi all,

TLDR; I am seeing merge conflicts when rebasing even though applying
them to HEAD of target branch should work. Can you please upgrade my
understanding so I understand.

My understanding is that rebasing branch B onto branch A unrolls all
of branch B's commits and then "reduces" them onto the HEAD of branch
A.

For example, I took featureA branch from develop three days ago.
develop subsequently had commits #d1, #d2 and #d3. featureA also had
#f1 and #f2 and in terms of time they are all intermingled.

My understanding of rebase is that after issuing "git fetch; git
rebase origin/develop" in featureA branch a git log should show #f2,
#f1, #d3, #d2, #d1.

I am seeing this, but sometimes I see something I can't explain and
that is a merge conflict as if git was doing a merge rather than a
rebase.

For example, let's imagine that #f1 removed fileA, some time later #d1
added a line to that file. If I was doing a merge then of course this
should be a conflict, however applying #f1 to develop HEAD should work
even if fileA has changed (i.e. #f1 removes the updated fileA).

As it is I am frequently running into merge conflicts in this manner
when it *appears* git is applying a patch from featureA onto develop
_as it was then the patch was made_.

I am also seeing merge conflicts that occur between commits in the
develop branch itself as well, which I assumed would be effectively
read-only.

In terms of functional programming I thought rebase was a pure reduce
of a sequence of patches from featureA branch onto HEAD.

I have no idea what git is doing internally, and if I am confident of
anything it is almost certainly that the bug is in my understanding
:).

What am I missing?

Thanks,

Col
