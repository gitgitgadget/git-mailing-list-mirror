From: larsxschneider@gmail.com
Subject: [PATCH v3 0/3] git-p4: fix Git LFS pointer parsing
Date: Sun, 24 Apr 2016 20:58:09 +0200
Message-ID: <1461524292-20490-1-git-send-email-larsxschneider@gmail.com>
Cc: sschuberth@gmail.com, gitster@pobox.com, ben.woosley@gmail.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 20:58:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auPEc-0006Dm-B2
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 20:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbcDXS6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 14:58:18 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38038 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbcDXS6R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 14:58:17 -0400
Received: by mail-wm0-f52.google.com with SMTP id u206so96929795wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 11:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qpJcP9mGtoxc7fmW5NqXOtHZwm9W0FAlEHwUY4Ch2XU=;
        b=O/jBA9z5RMb+DQxLgUZKctDnefmJGw2u6i5l3g0hTm4VNTgSSDAFGpghi1fAvBOvlo
         1kA5cycQ9kFxslOK/EDNCXLvEKa9Bv587zlADxvTD/UvQS6/Msir6XScU647NpFXXQmu
         DGEC0apfhTlFCEWy9dCUu2fSCG77ELQwhymjHKUCk6vbFNmLeb2EpRv7AjHZPKOjbcMa
         JpsCEuqLO97QDeLpvodg4c8Dnp4NcmpkkxyowBI1iJIQ/NS2eS8sOIs6lwHcd3rmhzUA
         UxOQb3lCuqWYurkYMPMuvw/qCFttsMmpMVL5M28EfFGKJgEHflSl3o3iuncLv03kqook
         byzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qpJcP9mGtoxc7fmW5NqXOtHZwm9W0FAlEHwUY4Ch2XU=;
        b=DCyGFXE9fBOfitlAJmJhWGxbe5Fu+QsYRAyart0jjBH9DOQOUJgTmwz9dukuqKdPjd
         /YMxzRer9QN/+PtZXX22jILj3A6S59f+QAt7sNbs/7H2+SukBpOjvPs4vd/4d/1Vx6/R
         tze3Rv50/Wr19k52WEtWmogFiYIMiaxYPjn3gIaUEqYM/pORGjk9vwsFEJ7zdD3L7mSD
         HcIYtDlyxNEpy0IXxv6NOPxXPfvvRTP+VXUbQMcuWZXTlnO9XI0Zgwq2P+eMkN/PqvJK
         wAAWhuFHcozcxecwfJnTvt1wDOTgc24jaUZb12NtPPFzrM+Oks/PQ8tmiFuoMVJZiWOM
         wu0Q==
X-Gm-Message-State: AOPr4FXB48OtaDNXkJ+FTpBaW31h0Qz4g0zz5VKUkGmmwlW4mxLfog7gdGqAhrC69zyt7A==
X-Received: by 10.28.216.83 with SMTP id p80mr6533562wmg.49.1461524295764;
        Sun, 24 Apr 2016 11:58:15 -0700 (PDT)
Received: from slxBook3.fritz.box (p508BA7B8.dip0.t-ipconnect.de. [80.139.167.184])
        by smtp.gmail.com with ESMTPSA id d79sm14948541wmi.23.2016.04.24.11.58.13
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 11:58:14 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292425>

From: Lars Schneider <larsxschneider@gmail.com>

v1: $gmane/291917
v2: $gmane/291991

diff to v2:
 * use regex to parse "oid" instead of a complicated split logic
   ($gmane/291995, thanks Sebastian)
 * add a note to the commit message emphasizing the change from array
   to string in the second return parameter ($gmane/292077, thanks Junio)
 * detect the Git-LFS preamble by the constant first part of the string
   ($gmane/292079, thanks Ben)
 * change the name of the Git-LFS and Perforce version variables to
   express that they are only used in the Linux build

Thanks,
Lars

Lars Schneider (3):
  travis-ci: update Git-LFS and P4 to the latest version
  travis-ci: express Linux/OS X dependency versions more clearly
  git-p4: fix Git LFS pointer parsing

 .travis.yml               | 17 ++++++++++-------
 git-p4.py                 | 13 ++++++++++---
 t/t9824-git-p4-git-lfs.sh |  4 ++++
 3 files changed, 24 insertions(+), 10 deletions(-)

--
2.5.1
