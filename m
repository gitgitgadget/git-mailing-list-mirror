From: Stefan Beller <sbeller@google.com>
Subject: [PATCH V2 0/6] Memory leaks once again
Date: Fri, 27 Mar 2015 15:32:43 -0700
Message-ID: <1427495569-10863-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 23:33:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbcoP-0005WD-2a
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 23:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbbC0WdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 18:33:04 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35207 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbbC0WdC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 18:33:02 -0400
Received: by igcau2 with SMTP id au2so33012617igc.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 15:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=lMRZ9kXZYQvbMUGO0SczRGJ0Mi24fNepXuuX3SXKM6A=;
        b=T1u70ZDgPd5jJSrUp83cQzVbmnxrI3g1NcDIyXOihKy8zlCoKLUo3U3S+muPdzTG3t
         vNQat3OfHt+zI3nMpU6ha+Ek8Q09kK2sBRPzGcL8WQ+8+/TrWy+Vw0r4cpi+UIoNAWZf
         qpq5MF89oep4gzzQIBFr8/ypzQCEQiCtffdN4Dsg8VUagufKECAgMy2PdDy+71gxs0CI
         HJDhrZ4R/dKzTAGm1KdtBQMdsxnoLbWQL/whQ5u6IzTD0SEMP5qUChNGOKzriOdD5nBe
         VOQgqOohkLoOXTQHDWOQQo5Az8oQ1byhepEgQADsOpScPrcCWfNTtDVWfGgDQBGX5HkH
         O1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lMRZ9kXZYQvbMUGO0SczRGJ0Mi24fNepXuuX3SXKM6A=;
        b=S/AFYzXxwAHXXfIae52zIGCvXpw+T1cPRW1mTMnWy6JfLGxNYByFBMP6kr8PKhokZV
         GmKQ+hqBs4ELYEVf1VkkTnZU605tJEG5Z08mQqf9/zqkCk8D6u3cjlVf3y/lQoVH/b8t
         hVpVEaLdSUgmhaSkQtwGcJNJ//wVH9I0wZEUn0oChRVz3FhLyyfLkZw63emHhD2cauC9
         +RqOHeTAle+vq8w0mRwuFXSihdfSMQzOemnQuRAytGGquTK4bVjNzrj1F7ezfERkibk4
         8+iCkyu/zhX7sAfZAKlWgUDIiJlYtwQoN3mjJ3FWhaa3NzqXSdJ6KI7OfvepHian6Jll
         rJ/Q==
X-Gm-Message-State: ALoCoQkdwWyb8LDbWrNZfkQumLnwMU7jYo0FjViLf8DuVzic1Ib7Gy6QARzMrrxW9LmTOIyCIVMz
X-Received: by 10.43.65.144 with SMTP id xm16mr46712909icb.57.1427495581329;
        Fri, 27 Mar 2015 15:33:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:7174:4672:de72:7789])
        by mx.google.com with ESMTPSA id s10sm2263635igr.2.2015.03.27.15.33.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Mar 2015 15:33:00 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266394>

Here comes another bunch of memory leaks fixed.
patches 1-4 are safe bets, but 5 and 6 are not so.

In patch 5 I wonder if we need to fix more aggressively and
in patch 6 I just know there is a leak but I have no idea how to
actually fix it.

The patches are apply-able to origin/master.

Version 2 has no changes in code but in recipients. CC'ing parties who
may be qualified to review the patches.

Stefan Beller (6):
  shallow: fix a memleak
  line-log.c: fix a memleak
  line-log.c: fix a memleak
  wt-status.c: fix a memleak
  pack-bitmap: fix a memleak
  WIP/RFC/entry.c: fix a memleak

 entry.c       |  4 +++-
 line-log.c    |  4 ++++
 pack-bitmap.c | 27 ++++++++++++++++++---------
 shallow.c     |  4 ++--
 wt-status.c   |  2 ++
 5 files changed, 29 insertions(+), 12 deletions(-)

-- 
2.3.0.81.gc37f363
