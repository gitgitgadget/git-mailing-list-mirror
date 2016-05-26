From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 0/2] Persistent submodule pathspec specification
Date: Thu, 26 May 2016 13:47:28 -0700
Message-ID: <20160526204730.20309-1-sbeller@google.com>
Cc: sunshine@sunshineco.com, gitster@pobox.com, pclouds@gmail.com,
	ramsay@ramsayjones.plus.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 22:47:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b62Bv-00056k-3z
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 22:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755145AbcEZUrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 16:47:35 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36419 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369AbcEZUre (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 16:47:34 -0400
Received: by mail-pa0-f45.google.com with SMTP id eu11so23719915pad.3
        for <git@vger.kernel.org>; Thu, 26 May 2016 13:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=m0qZDmsJCpScnMiWcgL4aO2NKuWRPT8bFofkEQyap8U=;
        b=C9eR+6bzHkIuOykZA35FoWpjal+3WwmQJ9nzSN+UWoVHMGv8F7btJCXrCb77rW7a8R
         AEbnwCc0iB9Tq/k2he81kDgyfJFiPqtA6wVajMNRDK/nCdLyR+J12lpjfS6/QlKiOVJN
         4YZ6/BQAvzFJnh7G8ambAjqbAHPNKuWejEuIfRC4wgYb8WwYjQLBuTJsMcw++jjN/628
         /vKkPjoaF9PcaPZYZ6yXgpR0Ovss5xwQ7t8+Tm2mJlwUX2wQX05eYZeLtWLhooI9SXiM
         dVC1weAfzaYq2WUONFCZzvVDl2n6PrS2BGzly0L6GcHYSKY/Y9Npm5egb0hN6tQxBl2O
         dRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m0qZDmsJCpScnMiWcgL4aO2NKuWRPT8bFofkEQyap8U=;
        b=LRlhiPam/EI+EVMfHPIIEDVMNp2B1x2P6rRLPOJ+tlrah/nADyRnFmrnTsbVivlOjt
         OP/3G0qZat4xk1VgVeKt0JPv+0OHjLscS1JbXhIx+IoFrLJnlytpriNXwXZ/YIHx0wq/
         HyLD9boPW7zT9d6/ybrYOrBgLFHwQOPw6T1b1Uvm25g0xAEHsMI48/q4jD3ueSfuWT5a
         9hdI22kz1mQRR+qTmWx0zbV7LpOi6iyds/qNwq9U8vPKLiivGmKqzAJsDPGLhSw8Np38
         WawhR0vCJGV04G/v12OVVQKD6wroO5qSrJuydjCLbXMJINZX32EIsIV4tSqflNctAbXQ
         TqGg==
X-Gm-Message-State: ALyK8tJHKOuM5MpktLOLvBX5SC2mCUNNh0BwzT7R0CKKV7PtWcL6s0pwnUcAA97HOgpzIMDQ
X-Received: by 10.66.179.169 with SMTP id dh9mr16904093pac.133.1464295653948;
        Thu, 26 May 2016 13:47:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f5f9:aea3:ef22:58b3])
        by smtp.gmail.com with ESMTPSA id 7sm8113304pfe.88.2016.05.26.13.47.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 26 May 2016 13:47:32 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc0.2.g145fc64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295690>

Changes since v2:
 * I replaced one 0 by NULL as pointed out by Ramsay, and reformatted the line
   to stay within 80 characters:
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -908,8 +908,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
                struct string_list_item *item;
                struct strbuf sb = STRBUF_INIT;
                for_each_string_list_item(item, &init_submodules) {
-                       strbuf_addf(&sb, "submodule.defaultUpdatePath=%s", item->string);
-                       string_list_append(&option_config, strbuf_detach(&sb, 0));
+                       strbuf_addf(&sb, "submodule.defaultUpdatePath=%s",
+                                   item->string);
+                       string_list_append(&option_config,
+                                          strbuf_detach(&sb, NULL));
                }
        }
 

Changes since v1:
 * fixed a broken && chain in a subshell for testing, as pointed out by Eric!

This was part of the former series 'submodule groups'.
However the labeling was ripped out and goes in its own series
sb/pathspec-label.

First we introduce a switch `--init-default-path` for `git submodule update`
which will read the pathspec to initialize the submodules not from the command
line but from `submodule.defaultUpdatePath`, which can be configured permanently.

The second patch utilizes this by having `clone` set that config option
and using that new option when calling to update the submodules.

Thanks,
Stefan

Stefan Beller (2):
  submodule update: add `--init-default-path` switch
  clone: add --init-submodule=<pathspec> switch

 Documentation/config.txt        |   5 ++
 Documentation/git-clone.txt     |  25 +++++---
 Documentation/git-submodule.txt |  11 +++-
 builtin/clone.c                 |  36 ++++++++++-
 git-submodule.sh                |  21 ++++++-
 t/t7400-submodule-basic.sh      | 134 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 218 insertions(+), 14 deletions(-)

-- 
2.9.0.rc0.2.g145fc64

base-commit: 3a0f269e7c82aa3a87323cb7ae04ac5f129f036b
