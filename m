From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/3] Iron output of describe --contains --all
Date: Sun,  7 Jul 2013 18:13:13 +0530
Message-ID: <1373200996-9753-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 07 14:47:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvoN1-0007Uz-Ap
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 14:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745Ab3GGMrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 08:47:11 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:37287 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664Ab3GGMrK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 08:47:10 -0400
Received: by mail-pd0-f175.google.com with SMTP id 4so3237704pdd.34
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 05:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=GGM2YISWTl2jEYpBZJjdfEISEc8ymwQRfeUlsIIyQgA=;
        b=Hrxo/rHtL/Y38t0S49l8oQnK6DrhBTti1XMZtFWPy8RbV970IfjUKqlvblvrIMd9+x
         iXsh+OK2BmqoTBwdA1tZ3h7fcoNQLN0fmTXIfaAvYFo/HKoVRopT23NF/tRDvQSyJLtL
         Cu6hjm9Fp2MQurUS+sdKCqAxFhg0obWa8EwQD6vlDVV/WKKafTS3tA+biUuHcblFb5qM
         Y7ygVLClN6QE3HOnGBvmBS86SrWywG4GUSwWfhEpuTKm++zwI0HEuTRlt1o0Bu+5frWj
         e/jwPpTAvMgwJtukyfYfWFM+VaDDCvW9PpVGJu7oLrqwTb+JwXXya/p9U0+wuZieUWAd
         0rRA==
X-Received: by 10.66.67.5 with SMTP id j5mr18280784pat.176.1373201229907;
        Sun, 07 Jul 2013 05:47:09 -0700 (PDT)
Received: from localhost.localdomain ([122.174.59.189])
        by mx.google.com with ESMTPSA id eq5sm17024014pbc.15.2013.07.07.05.47.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 05:47:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.737.gcbc076a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229768>

Hi,

I actually sent these patches to the list last month, but nobody
seemed to be interested.  This is an unedited resend.

I looked into adding tests, but decided that it was a lost cause: the
output is too loosely defined for any scripts to rely on it strongly.
[1/3] already shows a race between branches and tags.  For another
example, consider two tags are pointing to same commit (D and R in
t6120-describe.sh).  Run the following on the two tags and see what
happens for yourself:

  $ git describe --contains
  $ git describe --all
  $ git describe --tags

Now think about various combinations of these options.  I'm not saying
that it's a Bad Thing (TM), but that nobody has bothered tightening
the output.

My main motivation for doing this series is my prompt: I don't want to
see

  artagnon|(tags/v1.8.3^0)~/src/git$

when

  artagnon|(v1.8.3)~/src/git$

is so much more pleasant and consistent.  Obviously, hacking around
this problem in the prompt script is the Wrong thing to do.

Thanks.

Ramkumar Ramachandra (3):
  name-rev: fix assumption about --name-only usage
  name-rev: strip trailing ^0 in when --name-only
  name-rev doc: rewrite --stdin paragraph

 Documentation/git-name-rev.txt       | 12 +++++++-----
 builtin/name-rev.c                   | 12 +++++++++++-
 t/t4202-log.sh                       |  8 ++++----
 t/t6007-rev-list-cherry-pick-file.sh | 32 ++++++++++++++++----------------
 4 files changed, 38 insertions(+), 26 deletions(-)

-- 
1.8.3.2.737.gcbc076a.dirty
