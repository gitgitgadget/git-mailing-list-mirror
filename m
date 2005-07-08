From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: [PATCH] 5/7 Add the -N option to cg-add.
Date: Fri, 08 Jul 2005 06:54:44 -0400
Message-ID: <42CE5B74.8090409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 08 13:11:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqqlE-0006GR-T6
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 13:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbVGHLIa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 07:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVGHLHb
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 07:07:31 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:22190 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262468AbVGHLEZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 07:04:25 -0400
Received: by zproxy.gmail.com with SMTP id z31so182568nzd
        for <git@vger.kernel.org>; Fri, 08 Jul 2005 04:04:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=Gu3+ARGdnmCw7xYkj93XBPh/iecps+j7mrJcyW70+OC5a80CHP8ZvgBXNw7X3RkPSKzGhNYX0OGAn4+smw2WRRu58vIj5Eh1yBcAZR+/GAmEDyhw1tgV/7lCD6BQgM7kgQwXh8mx6iDJU0STu8LGRlLFU7ke43NCPQlYwDKf2Fs=
Received: by 10.36.222.4 with SMTP id u4mr659076nzg;
        Fri, 08 Jul 2005 04:04:24 -0700 (PDT)
Received: from ?192.168.1.100? ([70.26.43.137])
        by mx.gmail.com with ESMTP id 24sm757949nzn.2005.07.08.04.04.24;
        Fri, 08 Jul 2005 04:04:24 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



Add the -N option to cg-add.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

  cg-add |   21 ++++++++++++++++++---
  1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/cg-add b/cg-add
--- a/cg-add
+++ b/cg-add
@@ -13,20 +13,35 @@
  # is that 'Cogito' manages content and empty directories have no content.
  # Instead, directories are added automatically when adding files inside
  # them.
+#
+# OPTIONS
+# -------
+# -N::
+#   Only update the cache: do not copy the data into the object database.
+#

-USAGE="cg-add FILE..."
+USAGE="cg-add [-N] FILE..."

  . ${COGITO_LIB}cg-Xlib

  [ "$1" ] || usage

+infoonly=
+while optparse; do
+	if optparse -N; then
+		infoonly=--info-only
+	else
+		optfail
+	fi
+done
+
  TMPFILE=$(mktemp -t gitadd.XXXXXX) || exit 1
-find "$@" -type f -print0 > $TMPFILE || {
+find "${ARGS[@]}" -type f -print0 > $TMPFILE || {
  	die "not all files exist, nothing added"
  	rm $TMPFILE
  }

  cat $TMPFILE | tr '\0' '\n' | sed 's/^/Adding file /'
-cat $TMPFILE | xargs -0r git-update-cache --add --
+cat $TMPFILE | xargs -0r git-update-cache --add ${infoonly} --

  rm $TMPFILE



