From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 0/8] Expose submodule parallelism to the user
Date: Mon, 11 Jan 2016 11:41:53 -0800
Message-ID: <1452541321-27810-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de
To: sbeller@google.com, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 11 20:42:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIiM6-0004wq-JF
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 20:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758752AbcAKTmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 14:42:14 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33929 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757379AbcAKTmN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 14:42:13 -0500
Received: by mail-pa0-f43.google.com with SMTP id uo6so309179565pac.1
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 11:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8Zsb6TI1OySApHVI9fm2xp86ulVxI5O0+VJZixulkU4=;
        b=UQ1r1TcGnSR5FeRqBZRQ8nosjrPFYHO+uveoyYlc07H3hthXQcplQGdmZExbKJ2wp7
         zmi82FWLxmobYKx5Iewc6gkjC5UWxXK+9kV1Zc5PTriAWX7qLUuZZaMLiui89mk4ZDyG
         XLZvtRAHhO2S72NTLc0ZcfvKoaPmtfpftgwKiZYmLAmOLgM5FR4MO8QtJtNhOgVpCkh2
         NFWsZuD9TxiOa3ArtYkjm2Wl7lNpGdVKJe/qyNIjom/9nXepNhN37cRUDkY3bq59X5B1
         sVOwhLRQ5vHPCinNKXjd06UoqKHGIT3im5vIGKKlqXGoFcdBiDBgWr9MDE5E33XN9mS9
         V6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8Zsb6TI1OySApHVI9fm2xp86ulVxI5O0+VJZixulkU4=;
        b=GG2AjWbO4TghfKNA5WK383jmzKnZkCVOCBdxnfl9umLaAOs9HJvDGGLoUrV3VVfscE
         2mcAJKjpC+1zg7Jv9lRRn0Sdr9IQQa9cWKyQE5B+ne63/3MVlU4t/J2InT9Wqire4I65
         7fflHnMVYLt9LgwStpL5PleR5Y+i5cBE1lINmnr9kb25prS9mNamabquSALJ9BU0svtp
         hrePd0XazYOlN3UmL1R8yWjxXHpca8QjyzxTdQqJbzG49YaSF6+9+6EAMeQjWWoMzpAb
         7IdL5qy8VCwT7HbaNk0GE1IphmkrcddQYiLtMCECbumD6wtNlZb6SoWJ0RiWVxEc7JTl
         LEOw==
X-Gm-Message-State: ALoCoQnkmC7gwYEpQiaKUbH1uQ+xdehK1CaDIrPEDEFpE3+AokXnOwx/v4xsXoVLhOjdFAp0jMfFztoqWXhtCjYh8xatiUPTHw==
X-Received: by 10.66.227.1 with SMTP id rw1mr185599502pac.35.1452541333320;
        Mon, 11 Jan 2016 11:42:13 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:8d8c:9316:e7e7:6f4f])
        by smtp.gmail.com with ESMTPSA id ty5sm11431256pac.48.2016.01.11.11.42.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 11 Jan 2016 11:42:12 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc1.7.gf4541cb.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283703>

This is a resend of sb/submodule-parallel-update and is available at github[1] as well.
It applies on top of sb/submodule-parallel-fetch

What does it do?
---
This series should finish the on going efforts of parallelizing
submodule network traffic. The patches contain tests for
  clone
  fetch
  submodule update
to use the actual parallelism both via command line as well as a
configured option. I decided to go with "submodule.fetchJobs" for
all three for now.

What changed to v5,6?
---
No major changes, I just made it compile again as the order of parameters
to the parallel processing engine changed.

Thanks,
Stefan

[1] https://github.com/stefanbeller/git/tree/submodule-parallel-update-v7

Stefan Beller (8):
  submodule-config: keep update strategy around
  submodule-config: drop check against NULL
  submodule-config: remove name_and_item_from_var
  submodule-config: introduce parse_generic_submodule_config
  fetching submodules: respect `submodule.fetchJobs` config option
  git submodule update: have a dedicated helper for cloning
  submodule update: expose parallelism to the user
  clone: allow an explicit argument for parallel submodule clones

 Documentation/config.txt        |   7 ++
 Documentation/git-clone.txt     |   6 +-
 Documentation/git-submodule.txt |   7 +-
 builtin/clone.c                 |  19 +++-
 builtin/fetch.c                 |   2 +-
 builtin/submodule--helper.c     | 239 ++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh                |  54 ++++-----
 submodule-config.c              | 109 +++++++++++-------
 submodule-config.h              |   3 +
 submodule.c                     |   5 +
 t/t5526-fetch-submodules.sh     |  14 +++
 t/t7400-submodule-basic.sh      |   4 +-
 t/t7406-submodule-update.sh     |  27 +++++
 13 files changed, 413 insertions(+), 83 deletions(-)

-- 
2.7.0.rc1.7.gf4541cb.dirty
