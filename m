From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [RFC] Enable 'check for copy and renames' (-C) also when path filtering
Date: Wed, 16 Aug 2006 11:06:49 +0200
Message-ID: <e5bfff550608160206w606008ddv2da42ce49e98fa2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 16 11:07:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDHMa-0005ag-3z
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 11:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWHPJGv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 05:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWHPJGv
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 05:06:51 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:21480 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751035AbWHPJGu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 05:06:50 -0400
Received: by py-out-1112.google.com with SMTP id z74so536309pyg
        for <git@vger.kernel.org>; Wed, 16 Aug 2006 02:06:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hrymMnM8A4IdYuQ+T5Jxr46hrTTBn+ioKLEg6a8aWVB0AsMxrQvALMQj6AkmlVw6W/LKFC7GgIqaUs/BCCkBB/FnaYp8SV9uzgXxbh5/AAgGvSvO3rodkINHjYBq9DwJn9Ks0S4oMzlUmQx8rjfo4ThCndF1hWAtqwtfkDGr61w=
Received: by 10.35.98.6 with SMTP id a6mr961302pym;
        Wed, 16 Aug 2006 02:06:49 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Wed, 16 Aug 2006 02:06:49 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25509>

It seems that -C option of git-diff-tree it works only if the whole
changeset is retrieved.

>From git repository:

- Ask for all

$git diff-tree  -r -p -C 5d4a600
5d4a60033543e063bc9d77ca957de0187fb58fb3
diff --git a/Makefile b/Makefile
index 132c9cf..4fd62bc 100644
--- a/Makefile
+++ b/Makefile
@@ -177,7 +177,7 @@ PROGRAMS = \
  	git-convert-objects$X git-fetch-pack$X git-fsck-objects$X \

            ----cut----

diff --git a/pack-objects.c b/builtin-pack-objects.c
similarity index 100%                          <-------  similarity and
rename from pack-objects.c              <--------  rename info shown
rename to builtin-pack-objects.c      <--------  only in this case
index 861c7f0..2301cd5 100644
--- a/pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1,3 +1,4 @@
+#include "builtin.h"
 #include "cache.h"


- Ask for pack-objects.c only

$git diff-tree  -r -p -C 5d4a600 -- pack-objects.c
5d4a60033543e063bc9d77ca957de0187fb58fb3
diff --git a/pack-objects.c b/pack-objects.c
deleted file mode 100644
index 861c7f0..0000000
--- a/pack-objects.c
+++ /dev/null
@@ -1,1376 +0,0 @@
-#include "cache.h"
-#include "object.h"


- Ask for builtin-pack-objects.conly

$git diff-tree  -r -p -C 5d4a600 -- builtin-pack-objects.c
5d4a60033543e063bc9d77ca957de0187fb58fb3
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
new file mode 100644
index 0000000..2301cd5
--- /dev/null
+++ b/builtin-pack-objects.c
@@ -0,0 +1,1376 @@
+#include "builtin.h"
+#include "cache.h"
+#include "object.h"

Showing rename info also when filtering on a specified path could be
useful to retrieve a single file history following renames.

Thanks
Marco
