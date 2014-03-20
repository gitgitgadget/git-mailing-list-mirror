From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Lost commit during rebase!
Date: Thu, 20 Mar 2014 14:37:12 -0500
Message-ID: <CAHd499CBkuCJvZ+U3GEcnw0UFot5JooZVdj2sHT_3p0s6ScwcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 20:37:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQimI-00004y-3U
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 20:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759710AbaCTThP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 15:37:15 -0400
Received: from mail-ve0-f179.google.com ([209.85.128.179]:62017 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964943AbaCTThN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 15:37:13 -0400
Received: by mail-ve0-f179.google.com with SMTP id db12so1472890veb.24
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 12:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=mAvQH1t+t6t7yQEQS9bLGNIJ3z1yfx35g1z9bOyAF0k=;
        b=mo3zNfb7bn0N/s7aI2yUw+ZellAQkKrq8PGCSFXlyC1PX0elFvRWwRGHmi81yJLhUJ
         xlGLH69dv6oN85CeUZMomTAIFzQqpL2N+hocis5TIGG5k+q5TKMiqSZQhWhEM2t+2gmg
         IVaGDDY9psotffHHoZBuctOZCvjAD+2Z7LHqith/JB08EzbN2o1M61my9cJxjJcKwp26
         Hab33kD2SnpBymlwyCTLYYVXp1MF/yRL7EEzfHiCq5e+Nc7lLFqrCgMQcZRguH5id4ZE
         Oy3xMJz7I1IgdXhhMo5RpUa+llEB8Ec8GFAnyoO+M1GCymBVuWTQjMwbQSYyQ7GmfbA0
         2hjQ==
X-Received: by 10.58.69.20 with SMTP id a20mr169637veu.63.1395344232442; Thu,
 20 Mar 2014 12:37:12 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.2.79 with HTTP; Thu, 20 Mar 2014 12:37:12 -0700 (PDT)
X-Google-Sender-Auth: Tl_CLNLz1u_2i3mXZtKPWDfGpqo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244575>

I have a local-only branch with just under 70 commits. I also have
merge commits on this branch.

The log of the top few commits on my branch looks like so:

* de651ff       (20 minutes ago) (HEAD, survey) Robert Dailey - WIP:
GOTO implementation
* 2a68a23       (21 minutes ago) Robert Dailey - Move boost::phoenix
include & namespace changes to own header file
* e1cd568       (19 hours ago) Robert Dailey - WIP: GOTO flow changes
* b039bb5       (19 hours ago) Robert Dailey - Remove superfluous
include of own header
* 4bdeb27       (20 hours ago) Robert Dailey - Rename NavigateBackwards()

I had two commits that I wanted to squash and also reorder another
one. The command I ran is:

git rebase -pi `git merge-base origin/master survey`

I ran this command with 'survey' branch checked out. Once my editor
appears, the last few commits in the file look like so:

pick 4bdeb27 Rename NavigateBackwards()
pick b039bb5 Remove superfluous include of own header
pick e1cd568 WIP: GOTO flow changes
pick 2a68a23 Move boost::phoenix include & namespace changes to own header file
pick de651ff WIP: GOTO implementation

I modify the last 3 commits in the file so now it looks like this:

pick 4bdeb27 Rename NavigateBackwards()
pick b039bb5 Remove superfluous include of own header
pick 2a68a23 Move boost::phoenix include & namespace changes to own header file
pick e1cd568 WIP: GOTO flow changes
squash de651ff WIP: GOTO implementation

What I did was:

1. Move 2a68a23 back one commit
2. Mark de651ff for squash

After this, I save the file, close, and rebase operations begin. After
the rebase is done, my log looks like this:

* 94d06df       (19 hours ago) (HEAD, survey) Robert Dailey - WIP:
GOTO flow changes
* b039bb5       (19 hours ago) Robert Dailey - Remove superfluous
include of own header
* 4bdeb27       (20 hours ago) Robert Dailey - Rename NavigateBackwards()

Notice that the commit with description "Move boost::phoenix include &
namespace changes to own header file" is missing! I looked at reflog:

$ git reflog
94d06df HEAD@{0}: rebase -i (finish): returning to refs/heads/survey
94d06df HEAD@{1}: rebase -i (squash): WIP: GOTO flow changes
e1cd568 HEAD@{2}: rebase -i (pick): updating HEAD
2a7b27a HEAD@{3}: rebase -i (pick): Move boost::phoenix include &
namespace changes to own header file
b039bb5 HEAD@{4}: rebase -i (pick): updating HEAD
4bdeb27 HEAD@{5}: rebase -i (pick): updating HEAD
2e40bcd HEAD@{6}: rebase -i (pick): updating HEAD
3ca6bb3 HEAD@{7}: rebase -i (pick): updating HEAD
e63b1e5 HEAD@{8}: rebase -i (pick): updating HEAD
4d40c00 HEAD@{9}: rebase -i (pick): updating HEAD
ec078c1 HEAD@{10}: rebase -i (pick): updating HEAD
de48c5d HEAD@{11}: rebase -i (pick): updating HEAD

It shows that it "picked" the commit that's missing now. Is this a bug
or am I not doing something right? I'm using Git for Windows version
1.9.0
