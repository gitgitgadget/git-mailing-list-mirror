From: Shawn Pearce <spearce@spearce.org>
Subject: experimenting with JGit and bitmaps
Date: Sat, 16 Mar 2013 18:29:42 -0700
Message-ID: <CAJo=hJtvfXvLZo2HgBPo4rM5Xbc32da4sCbiC7wWAD2hhgSMCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Colby Ranger <cranger@google.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 17 02:30:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH2Qv-0002LO-3L
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 02:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515Ab3CQBaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 21:30:05 -0400
Received: from mail-ia0-f180.google.com ([209.85.210.180]:43956 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477Ab3CQBaE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 21:30:04 -0400
Received: by mail-ia0-f180.google.com with SMTP id f27so4370525iae.11
        for <git@vger.kernel.org>; Sat, 16 Mar 2013 18:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=x-received:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=vNd8VksOIAMnO5JiKfMECWC4e5BQnb/s9XOumT2h2cQ=;
        b=DhRTTVOK2l5FSiRccpxWqqNYcsWVr7cwHP50KVpUwsI6mXHw0D3MFXM5Bst6JmFN9z
         h/m026sfGm8g/RbkrKFqSRSko5TZwNzLEaabExnJI5gV7k8JcnHCvmYjFqjbQT/YZ3Wl
         iAFAHu0u+XlvJYgRgm+2ZOXqlhqOM5iC0EyK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to:cc
         :content-type:x-gm-message-state;
        bh=vNd8VksOIAMnO5JiKfMECWC4e5BQnb/s9XOumT2h2cQ=;
        b=pcT1LCcnJ+qJLIFd5oQ7BMVqTkTWd0AlNv13XEtdIZM1avLqV7O6StwIAIz4ioUrN5
         172BecnnRzoePgw5ITaurAqJ2Aqsou+Qisb042j6j1c16XkjRhxu/pAu++g237mzp3K2
         NBV4/vlA7VrJ5NmymtsFA7orEYzJ2T3gq6YHvUie2v+wRVe5+AFtyYFhy/52hCU9ceU2
         EoErOIBxhFCajNifnvYIrDnuWfHiWAJWGFGsTCtOapad4SNYoT4v7/8lPLgnGgOCUAMH
         CMG050wo2AJGvislCypgA5tclbus8hvCvo4EaF7eSic86uELIcp6Q1w8oV92o2kVsp2I
         iQhA==
X-Received: by 10.50.2.101 with SMTP id 5mr4036049igt.29.1363483802868; Sat,
 16 Mar 2013 18:30:02 -0700 (PDT)
Received: by 10.64.92.130 with HTTP; Sat, 16 Mar 2013 18:29:42 -0700 (PDT)
X-Gm-Message-State: ALoCoQnVX//BzwXod1OWweevfgPxRA721RNve81VBrtlGNsiSRpsh5z2udUY3riDEMMPeL/gJoUl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218322>

JGit has merged the bitmap work Colby and I were working on[1] and
plans to ship it in JGit 2.4. The bitmaps are now stored in a separate
".bitmap" file alongside of a pack, making the entire system
backward-compatible with git-core.

If you have Java and Maven installed you can try this out locally:

  $ git clone https://eclipse.googlesource.com/jgit/jgit
  # (fastest mirror of jgit is self-hosted here)

  $ cd jgit
  $ mvn package -Dmaven.test.skip=true -Dmaven.javadoc.skip=true

  $ org.eclipse.jgit.pgm/target/jgit debug-gc
  $ org.eclipse.jgit.pgm/target/jgit daemon --export-all --listen 127.0.0.1 . &
  $ git clone git://127.0.0.1/. tmp

I will be presenting some of this work at EclipseCon and ALMConnect.

JGit's GC implementation is still being worked on, hence the
"debug-gc" name. I would only run it on a backup of a repository.
Fortunately this is easy with Git. :-)

[1] http://thread.gmane.org/gmane.comp.version-control.git/206457
[2] http://www.eclipsecon.org/2013/sessions/scaling-jgit
    http://www.eclipsecon.org/2013/sessions/deploying-gerrit-code-review
