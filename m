From: Andrey Borzenkov <arvidjaar@gmail.com>
Subject: Cannot push anything via export transport helper after push fails.
Date: Sat, 11 May 2013 16:29:36 +0400
Message-ID: <20130511162936.0354e5d7@opensuse.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 14:29:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub8vo-0008K7-A0
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 14:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213Ab3EKM3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 08:29:40 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:51714 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab3EKM3j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 08:29:39 -0400
Received: by mail-la0-f41.google.com with SMTP id lx15so2366934lab.28
        for <git@vger.kernel.org>; Sat, 11 May 2013 05:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=twSREr8I+8ag4OqRQpSdSxs608LUimkKJm8lMgCtPAI=;
        b=a9cOFnzqp2ITkdpeTF3J3SERPthVFaFTZnowHuGk3lChr4XrgSOEbJ0yYXaj2iHanu
         uJPY7XSUfNqVVG0yB5IKEGFpG/qbA+nSbDlVQrVn/ZcUl+DmuhBLqRXk81YDBzgF2wU+
         Hai8DMmWgR7mOrXF2WhF3LpI+Tu6qL9pdt/7JL6SIVF5Fq9Q0pHgvC0yW6MwRiHNlQVU
         Ao45vJ8v9AIdnRGBrK1WqfNJpmbYX3EQi/x6s5jSawM/qpBg+pE6ewtNKzU1VORMvQPi
         DztH57vEWIBKa9CmgH2dN6D7t/4bprGXlcbzP41eL8HAxTXYwegugZlJmGB6VGlwruzJ
         2kaQ==
X-Received: by 10.112.167.98 with SMTP id zn2mr9396934lbb.86.1368275378201;
        Sat, 11 May 2013 05:29:38 -0700 (PDT)
Received: from opensuse.site ([94.29.72.160])
        by mx.google.com with ESMTPSA id lb9sm2418844lab.9.2013.05.11.05.29.37
        for <git@vger.kernel.org>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Sat, 11 May 2013 05:29:37 -0700 (PDT)
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.14; x86_64-suse-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223962>

I noticed that using git-remote-bzr, but as far as I can tell this is
generic for all transport helpers using fast-export.



What happened was "git push" failed due to merge conflict. So far so
good - but from now on git assumes everything is up to date.

bor@opensuse:/tmp/test/git> git push origin master
To bzr::bzr+ssh://bor@localhost/tmp/test/bzr
 ! [rejected]        master -> master (non-fast-forward)
error: failed to push some refs to 'bzr::bzr+ssh://bor@localhost/tmp/test/bzr'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Merge the remote changes (e.g. 'git pull')
hint: before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
bor@opensuse:/tmp/test/git> git push origin master
Everything up-to-date
bor@opensuse:/tmp/test/git> 

The problem seems to be that git fast-export updates marks
unconditionally, whether export actually applied or not. So next time
it assumes everything is already exported and does nothing.

Is it expected behavior?

TIA

-andrey
