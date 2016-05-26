From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 0/2] Submodule shallow recommendation [WAS: Submodules: have a depth field in the .gitmodules file]
Date: Thu, 26 May 2016 14:59:41 -0700
Message-ID: <20160526215943.29526-1-sbeller@google.com>
Cc: gitster@pobox.com, jrnieder@gmail.com, Jens.Lehmann@web.de,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 00:00:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b63KF-0007pT-Jz
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 00:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524AbcEZV74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 17:59:56 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35608 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755513AbcEZV7x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 17:59:53 -0400
Received: by mail-pf0-f171.google.com with SMTP id g64so34920848pfb.2
        for <git@vger.kernel.org>; Thu, 26 May 2016 14:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8eK2u7i54qoUCjn7tDSNP8ITGv/qUmcI90EcM5v721U=;
        b=j5fieiN6N9K/fToRX7GGx7IRhXowm1A6h20AVYxq4sGVXGRwVoTcPnyTAlqBhKDRBx
         PocLMYHA25kbfEOP/JCEhJEws3nJV8I1gMScJQDYKRJaD8OtmCb4p0zzXFaRlrDfMBO5
         DFpZcw0+c/2as8PbOhdGeX3ezBzf8U1oJ7NLymtd5zLwFnFWCf2BOetdlwaC++fQFCiT
         eAhRzs17sDVV8ZWhZwmLREYHPC0vQ3y0myx247+4FDfT57zNBJ8svWbc7EAkBuyjg3v2
         u2pIy0p9wbg2qQpmAuellkX3M6U3IkSQJJalUxpjyfhNw0/xmtm/j9KNnawUID5Eu+hQ
         xU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8eK2u7i54qoUCjn7tDSNP8ITGv/qUmcI90EcM5v721U=;
        b=LtxGSoksiO2NI8oTI75h/2rRIL+oBHxxP9x28Jwzhkk7QAylWPEMGRnzi3izlAjR7J
         4SracvOC6fgpXgQJGCmbygIHXLn/oEzbKpI4qUdurQMwCOgNrT5yaLZmaU4oHs1rC6s4
         7cp94uGIXZGhIjSz3ShICuHXZlNnvQqukXvo9ekidM1g7y7y1/CLxfdfo0m6uq2qgbFs
         vrxzq36RTxgV32jCdrlJQ8CkbK1207QSxLyivfCnEfc3TDbtg/VH7NDtT9gVOCUcIVtM
         KDUOfL1cLDyWTHbbGXmENmioIRD19gUqu/7aiQMu+39GNU48eXHQ9/ZdPjRxkYKXuoi5
         HAPg==
X-Gm-Message-State: ALyK8tJsCWFS3ytbeJ2NbzZ3CaakhyTgS8qCKz8YyefyBugS+x62CO3x3egK29eVRJ6qD75U
X-Received: by 10.98.82.16 with SMTP id g16mr4232334pfb.157.1464299991906;
        Thu, 26 May 2016 14:59:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f5f9:aea3:ef22:58b3])
        by smtp.gmail.com with ESMTPSA id p187sm8370225pfb.3.2016.05.26.14.59.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 26 May 2016 14:59:51 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc0.2.g145fc64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295698>

v3:
* fixed documentation to consistently mention recommend-shallow
* realigned code in the config patch
* Thanks Remi for reviewing! diff to v2:

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index c928c0d..bf3bb37 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
 'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
-	      [--[no-]recommended-depth] [-f|--force] [--rebase|--merge]
+	      [--[no-]recommend-shallow] [-f|--force] [--rebase|--merge]
 	      [--reference <repository>] [--depth <depth>] [--recursive]
 	      [--jobs <n>] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
@@ -385,10 +385,11 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
 	clone with a history truncated to the specified number of revisions.
 	See linkgit:git-clone[1]
 
---[no-]recommended-depth::
+--[no-]recommend-shallow::
 	This option is only valid for the update command.
 	The initial clone of a submodule will use the recommended
-	`submodule.<name>.depth` as provided by the .gitmodules file.
+	`submodule.<name>.shallow` as provided by the .gitmodules file
+	by default. To ignore the suggestions use `--no-recommend-shallow`.
 
 -j <n>::
 --jobs <n>::
diff --git a/submodule-config.c b/submodule-config.c
index e11b35d..db1847f 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -355,8 +355,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			 &submodule->update_strategy) < 0)
 				die(_("invalid value for %s"), var);
 	} else if (!strcmp(item.buf, "shallow")) {
-		if (!me->overwrite &&
-			 submodule->recommend_shallow != -1)
+		if (!me->overwrite && submodule->recommend_shallow != -1)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					     "shallow");
 		else {


v2:
* Instead of storing the depth, we keep a boolean `shallow` field in the
  `.gitmodules` file.
* slightly renamed options (--recommend-shallow instead of --recommended-depth)
* one more test
* I dropped [PATCH 1/3] submodule update: make use of the existing fetch_in_submodule function
  as Junio picked it up separately as sb/submodule-misc-cleanups

v1:
Sometimes the history of a submodule is not considered important by
the projects upstream. To make it easier for downstream users, allow
a field 'submodule.<name>.depth' in .gitmodules, which can be used
to indicate the recommended depth.

Thanks,
Stefan


Stefan Beller (2):
  submodule-config: keep shallow recommendation around
  submodule update: learn `--[no-]recommend-shallow` option

 Documentation/git-submodule.txt | 11 +++++++--
 builtin/submodule--helper.c     |  7 +++++-
 git-submodule.sh                |  9 ++++++-
 submodule-config.c              |  9 +++++++
 submodule-config.h              |  1 +
 t/t5614-clone-submodules.sh     | 52 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 85 insertions(+), 4 deletions(-)

-- 
2.9.0.rc0.2.g145fc64

base-commit: 3a0f269e7c82aa3a87323cb7ae04ac5f129f036b
