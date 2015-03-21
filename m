From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 00/15] Fixing memory leaks
Date: Fri, 20 Mar 2015 17:27:57 -0700
Message-ID: <1426897692-18322-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 21 01:28:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ7H6-0001Z4-Vq
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 01:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbbCUA2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 20:28:19 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34851 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbbCUA2S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 20:28:18 -0400
Received: by igcau2 with SMTP id au2so1633475igc.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 17:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=szih/WfQOdKle6pdKVbDowOlQPSq46gSirsdP0YdjG4=;
        b=E0Bsps0XchdUQI61IntDPi/e54sGw+mr0DDrMR3tulr2m3szY9JR7kvjRuRSu71UXV
         5Lhw6zgkhhyhY30vv9+9WTAG+u2fPdh+B8VsAw+FmiDvysa+jQFp1BKzzWRwI7Vp6kDg
         T1/en2FVG4c7Y9qr4rDIFuyZH5ZKXI+s2OVtzkwS8v8oehD0EOqp/uyXfwb+lcqWhyRm
         M8PsHtNBJe/bodOZ4FSj5zgdfhgFsPt6zWepmhWRqQQFmQaBnr14wsZNVmloUA/JV5LD
         d94f8B7hFodYu/lZDkeTzW+RHCc5RX5FVhV4C++xCE9HpQVx1eGMKuY4qXjugBQgbdnu
         VckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=szih/WfQOdKle6pdKVbDowOlQPSq46gSirsdP0YdjG4=;
        b=fkWa23UVwswZsMEahlEN5Fq8iZiSBY+iJo1uTs141tCtxNRr8ocX/FVeJRA/9xfVbL
         hV5Qq0vsj4/oppPbwRnQEGcmRlWkWff/oNg3mScW9yAtJ3C0wfA/17phWkoRY/g0bc4H
         4TlBwkdpl3fNUO1VJMLyteJp8I2kQ8WDFk71zoyVxtNIg3uuTZlk0il/j2kWHQnOixwo
         KgcZrC+vIeG/Y1dagzoeYnt7h0quuRgba5HtykAfX4DwnnokkETasC8tow1CELOqRdb3
         F2J/722haYpvO6WixZv4hUBf6OwVybzv4yk/OTa5tawaj+ZE+cL6NAm+iG9D0ImzLZN1
         GV8g==
X-Gm-Message-State: ALoCoQkRZeQDpnvj0Go2URcaWb2kqCxTCjk1qW2C3OxX1gB6wEso5V+oYtzw1w7QDpQW1bIYPlTw
X-Received: by 10.107.47.216 with SMTP id v85mr149248175iov.86.1426897697674;
        Fri, 20 Mar 2015 17:28:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c4ad:7c66:d5e8:7112])
        by mx.google.com with ESMTPSA id h19sm172314igq.10.2015.03.20.17.28.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Mar 2015 17:28:17 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265984>

So here comes another bunch of mem leak fixes. While 
I consider the first 10 patches a pretty safe bet,
the last 5 hopefully spark a discussion if we want 
patches which just clean up before the program ends.

Stefan Beller (15):
  read-cache: fix memleak
  read-cache: Improve readability
  read-cache: free cache entry in add_to_index in case of early return
  update-index: fix a memleak
  builtin/apply.c: fix a memleak
  merge-blobs.c: Fix a memleak
  merge-recursive: fix memleaks
  http-push: Remove unneeded cleanup
  http: release the memory of a http pack request as well
  commit.c: fix a memory leak
  builtin/check-attr: fix a memleak
  builtin/merge-base: fix memleak
  builtin/unpack-file: fix a memleak
  builtin/cat-file: free memleak
  ls-files: fix a memleak

 builtin/apply.c        |  1 +
 builtin/cat-file.c     |  1 +
 builtin/check-attr.c   |  2 ++
 builtin/commit.c       |  6 ++++--
 builtin/ls-files.c     |  1 +
 builtin/merge-base.c   |  1 +
 builtin/unpack-file.c  |  1 +
 builtin/update-index.c |  1 +
 http-push.c            |  1 -
 http.c                 |  1 +
 merge-blobs.c          |  4 +++-
 merge-recursive.c      |  3 +++
 read-cache.c           | 13 ++++++++-----
 13 files changed, 27 insertions(+), 9 deletions(-)

-- 
2.3.0.81.gc37f363
