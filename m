From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 0/9] Expose submodule parallelism to the user
Date: Tue, 24 Nov 2015 17:14:47 -0800
Message-ID: <1448414096-22021-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 02:15:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Ofs-0000qN-7f
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 02:15:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821AbbKYBPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 20:15:05 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33563 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852AbbKYBPD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 20:15:03 -0500
Received: by pabfh17 with SMTP id fh17so40372225pab.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 17:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9hCCc57TK3PaNh9K1wmzqMMbORBEYZRsraSMtpDfy6g=;
        b=WfhmNa3T7AcFA9CIXJT1Mc1e/wKV7O5Bs8yRQlcdXh3UPVEy9YfyyTbqXXpGDSxW77
         5m6z1rAystEHM0qBY2NafVuxm9JLdogQkMe6yFrul5v/sHWpRBgtEcw90+FCa6nntiu9
         Kr/DPoEORBRJoHEfZLMP55opfhHwSakDEBKFTEzF6pdpxWfQeT9NJJTvh5g53+EczUxt
         A9waejkYoVpZzKWI4/SqLSPTQnT6ORNO5UdJTHfBbY8zIon33Mlh+OoPwvStf7eVzUG/
         CLyTtATEsxGEWd2KgFH/l2iiGmY2EvVuoCIJnyZ5LxzAWnUl6+Lp/JOi5yCENTu0MvWr
         LQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9hCCc57TK3PaNh9K1wmzqMMbORBEYZRsraSMtpDfy6g=;
        b=K20srVZaPnuW1xewWjNkDL5ClCn/GBeubTIq5K8CG7+5omK9KH1Ar+04SrIOT0PHsO
         JU/3ioEhIUld+VWZGpqw66CMxDP59/fYgDKCnqSQYPwe+cKZpEMB8zlcNQbp4PDazMar
         BCvYJB1hWMXq4O/htAeHNUwoipfc0ZjcVnE8cngLsXbFF+Ud0HbXxMF0dp0bO/WSHqmx
         JvsUBsx4FhfxJO016dIVUerz6r8iiWHlJurlnqLWPgKw3O4hs8B6Ta1VUD3wWC+fXjiV
         4l7wm+9fITzIoIJD6k1spaHIpkuu5rjk6OuK/coasyrfAyTn6iKln+jiB08sP/yEHk3A
         9KSA==
X-Gm-Message-State: ALoCoQlyjyAm1dAIIec7BIsEAsEItpnivNIQAI9sU4Uxzuca9mLuub8zZl3fDoywgjTMmKQG49A3
X-Received: by 10.98.1.75 with SMTP id 72mr27551072pfb.14.1448414102449;
        Tue, 24 Nov 2015 17:15:02 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5407:71cc:c14:4343])
        by smtp.gmail.com with ESMTPSA id 68sm9093985pfq.37.2015.11.24.17.15.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Nov 2015 17:15:01 -0800 (PST)
X-Mailer: git-send-email 2.6.1.261.g0d9c4c1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281660>

This is also available at github/stefanbeller/git submodule-parallel-update
It applies on top of a merge of sb/submodule-parallel-fetch
(including the "run-command: detect finished children by closed pipe rather than waitpid"
sent yesterday) with
"Merge branch 'rs/daemon-plug-child-leak' into sb/submodule-parallel-update"
(d075d2604c0f9204)

The diff to v4 is below, just a change in braces.

My main motivation for resending this patch series is have it available to
reviewers of the series I am going to send next, which builds on top of this
series.

Thanks,
Stefan

Stefan Beller (9):
  run_processes_parallel: delimit intermixed task output
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
 run-command.c                   |   4 +
 submodule-config.c              | 109 +++++++++++-------
 submodule-config.h              |   3 +
 submodule.c                     |   5 +
 t/t5526-fetch-submodules.sh     |  14 +++
 t/t7400-submodule-basic.sh      |   4 +-
 t/t7406-submodule-update.sh     |  27 +++++
 14 files changed, 417 insertions(+), 83 deletions(-)
 
Interdiff to series v4: (ignoring the merge base as that changed, too)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 662d329..254824a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -487,9 +487,9 @@ static int update_clone(int argc, const char **argv, const char *prefix)
                return 1;
        }
 
-       for_each_string_list_item(item, &pp.projectlines) {
+       for_each_string_list_item(item, &pp.projectlines)
                utf8_fprintf(stdout, "%s", item->string);
-       }
+
        return 0;
 }
 
-- 
2.6.1.261.g0d9c4c1
