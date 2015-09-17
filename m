From: Robert Strobl <robert.strobl@surialabs.com>
Subject: Bug after removing a local branch and restore the remote branch during a rebase
Date: Thu, 17 Sep 2015 18:12:14 +0800
Message-ID: <CF93B86B-8CCF-483D-918A-47C910CEE8BA@surialabs.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 12:12:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcWB6-0006XI-9L
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 12:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbbIQKMX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Sep 2015 06:12:23 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33662 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbbIQKMW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Sep 2015 06:12:22 -0400
Received: by wiclk2 with SMTP id lk2so16934728wic.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 03:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-type:content-transfer-encoding
         :subject:message-id:date:to:mime-version;
        bh=/yE3RhcvkbH960DhpAIe1jdORf9jzoKun19LnhWcnRI=;
        b=VwEJ0RUXCiQ7U4drxjg9MdNtM8pavrmeNJLQVPafbjE9OUoPaEVlZDqZNtxE3txCmg
         ONcEH9QBiPkgB85E65QZyi1wLejTB69peYDCuHKlY9pHpKyzd3yZLLleElbhJq5vHi34
         l63uv0mDH5Tgnqog/eCKeO6i1BwlR7IDm9yNGyJAYDDfa5m1eooI+34P1CidxP/ed/j/
         B8LD7sDtZXSapESLxWq40/P5m6Fy20Dj3W5HGiEbgyCPsSUV/Mbtsn45tAtev/tdIg0I
         xCYRezV21B+ZeGXCJbALspgk+IYPDz9h/IHBmn18Nx7Zx0qtmksvHJw3Urpd4Llge3bl
         pYnA==
X-Gm-Message-State: ALoCoQl+ZqvLwPxCdMNvHYC1mkf4ac49cxD6ZbKdmdCtmPq3ZzgeeX5D4VDwepgehe14udzqMFAR
X-Received: by 10.180.10.197 with SMTP id k5mr12760361wib.22.1442484741285;
        Thu, 17 Sep 2015 03:12:21 -0700 (PDT)
Received: from [192.168.0.9] (pjc-132-106.tm.net.my. [210.186.132.106])
        by smtp.gmail.com with ESMTPSA id fs9sm9205702wic.24.2015.09.17.03.12.19
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 03:12:20 -0700 (PDT)
X-Mailer: Apple Mail (2.2104)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278104>

It might be an unusual workflow, however it leads to a bug:

git checkout feature_branch
git rebase master

# a couple of conflicts occur, which I don=E2=80=99t want to fix. there=
 is an updated version on origin
# so I=E2=80=99d like to go with that one

git add .
git stash
git checkout master
git branch -D feature_branch
git pull
git checkout feature_branch
git status

# On branch feature_branch
# You are currently rebasing branch =E2=80=98feature_branch' on '195269=
d'.
#  (all conflicts fixed: run "git rebase --continue")

# nothing to commit, working directory clean

# It still thinks that I=E2=80=99m rebasing the branch, so let=E2=80=99=
s try:

git rebase =E2=80=94abort

# On branch feature_branch
# Your branch and =E2=80=98origin/feature_branch' have diverged,
# and have 104 and 77 different commits each, respectively.
#  (use "git pull" to merge the remote branch into yours)
# nothing to commit, working directory clean

I=E2=80=99m aware that I should have aborted the rebase and then fetch =
the remote branch.
However, I still think that when I delete a local branch, it should als=
o abort the rebase that is attached to it.

I hope you find that useful. If it makes sense, I would be happy writin=
g a patch for it :)

Cheers,
Robert