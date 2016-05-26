From: ryenus <ryenus@gmail.com>
Subject: [feature request] find git commit log before rebase
Date: Fri, 27 May 2016 00:55:26 +0800
Message-ID: <CAKkAvax5Yf2=qLhVkn8EgkNEgHL97Doxr3JWR10aqxksYVsYXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 19:02:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5yg0-0002DP-Pu
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 19:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725AbcEZRCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 13:02:24 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:38125 "EHLO
	mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbcEZRCY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 13:02:24 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 May 2016 13:02:24 EDT
Received: by mail-it0-f46.google.com with SMTP id l63so57468362ita.1
        for <git@vger.kernel.org>; Thu, 26 May 2016 10:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=rZW9If4hl+NzWp7+AKa5u4eJvjdJXYYOOZ636r4+vTU=;
        b=XaQEPMehWPRUZ2fSLz4BLxcnlndk1mWrZVMMBxxHuiUuXWSGvyJL9sFwEQ8dgWNVt/
         7nuhc47fwozGAQdIreqYDqluu3dj6yq6tSZ42livdxJhXY/Q/wOU8W9a1+JbQIpdD21b
         s5/RQqyGID6Zl7z3d8UIh+TwVcj0LV/q4VwHWQrmTAhEbciuq2RDkwavMe10DU7WAear
         jTT0zw5cFqCpziLF79ifNff8gmthld/ZHXvQBCvslqpAcmZ052iOkp6fdKufvq8gEGsY
         +/EM3eYAAQOZbR2v++Ai0fl6KVnsnVrqmCNgv3lEzGTV6yH8ZB/yJGRzYVJQOCdiu1oy
         7V9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rZW9If4hl+NzWp7+AKa5u4eJvjdJXYYOOZ636r4+vTU=;
        b=FGekUn5c84KPjKT51fDEQ7hf11ZQpFtWYMM7NIKJRLzTeU0zkpu4ffHR8XUYys2ESC
         ZtoozCciPtwnmu9XpVbwJJlcnDl5HAo7zcweu86o62Zl6gRDN/vHFiTHYg9fyJUxqZ8r
         Zu63/6i2C/Ihey4/J8Wp4cmSdMX78dNL9yAdwIpxS823Rsc8EpLM3dx6jq4LnA28b6nB
         p78OHJa6dwf5xKNGmCMKnQozXMxmb9Mr3lEAIAy+N8WDCrfSuHaxw77zdV7Bi4fpzztk
         sw0cBWsZr/3Hx4J24lFFeoQh6JtUbdaCWo/jXpVduA8hy6LtGv77eCePtpI4Ny/FS/J9
         zahg==
X-Gm-Message-State: ALyK8tJ5zF+3wGW8ApxCVvqEcx0L2Aoal7IitVvQlqm8jRq8ammXxOQ5JIYTULSA5K11GjHl5Cn3DLc2GgaAiw==
X-Received: by 10.36.68.88 with SMTP id o85mr3945249ita.39.1464281746253; Thu,
 26 May 2016 09:55:46 -0700 (PDT)
Received: by 10.64.28.47 with HTTP; Thu, 26 May 2016 09:55:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295674>

Assuming I have branches master (m), and a side branch (b), with a
history tree like below:

m0 --- m1 -- m2 -- m3 -- m4 --- master (m)
        \          /      \
        b1 ------ b2       b3 -- b4 -- branch (b) (HEAD)
                  |
      (tag:POINT_BEFORE_REBASE)

The history of branch b is can be described as:

1. branch b is forked at point of m1
2. branch b is merged to master into m3,
3. branch b then is rebased (fast-forward) from b2 to m4
4. then branch b started its new life as b3 b4 after rebase

With the following command: I can find b3 and b4 since last fork-point

    git log --oneline $(git merge-base --fork-point master)..b

But how to find out commits b1 b2, given the fact that b2 is the point
before rebase?

I understand it can be achieved via:

    git log --oneline m2..b2

That's because I know b2 is the point before rebase,
and m2 is another child of the subsequent merge commit m3

I wonder how to do this with an simple (enough) command without me
looking through the history and find b2 and m2 manually?

Thanks!
