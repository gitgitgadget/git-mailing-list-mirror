From: Robert Schiele <rschiele@gmail.com>
Subject: [PATCH] add simple install replacement
Date: Thu, 11 Oct 2007 23:52:37 +0200
Message-ID: <20071011215237.GI20753@schiele.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 11 23:52:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig5xd-0001xW-Gv
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 23:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756962AbXJKVwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 17:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754457AbXJKVwn
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 17:52:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:41901 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755956AbXJKVwm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 17:52:42 -0400
Received: by nf-out-0910.google.com with SMTP id g13so597922nfb
        for <git@vger.kernel.org>; Thu, 11 Oct 2007 14:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        bh=ipcv1LNW0Oe9mK+RDCTrr6GJf8z2cKFeI19wmiFhlyQ=;
        b=ERCoyZ+vgWwEplpKJkGor4ahRKiARUiMRVuD9TIghbIz2R5IV2HV73sQF8BuHn76oQqyNUAEbKT+Ote1FwIVKDRJJEHks8BBILBX4fgZzMZP8Y5BBVznmv0FOVUWtHeVZOSSWQgmqfpx3O5la7M8nj1McsNWkpHlAnjJAUaNMro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        b=HbXcwi5PF96HN1+dIEvIV6xrpy+ZVQV1gtGafo9OkDwGqXribknk5sog5ATKYmJeezym4dixbYfdlNk4WRMGIPr7BbJ5lSoL33ED2jxbS105+aFFtg8nzpq445y3zoV+g7a/fkcxfdBy7RrI9DoCyxD7RC4id//fev2Qxx8Ngmg=
Received: by 10.86.93.17 with SMTP id q17mr1801125fgb.1192139560286;
        Thu, 11 Oct 2007 14:52:40 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [87.178.69.11])
        by mx.google.com with ESMTPS id 31sm4588167fkt.2007.10.11.14.52.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Oct 2007 14:52:39 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 19FC198547E; Thu, 11 Oct 2007 23:52:37 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60646>

This patch adds a very simple install replacement script to git.
This allows more easy installation on systems that don't have a
compatible install.

Signed-off-by: Robert Schiele <rschiele@gmail.com>
---
 gitinstall |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)
 create mode 100755 gitinstall

diff --git a/gitinstall b/gitinstall
new file mode 100755
index 0000000..8b346d6
--- /dev/null
+++ b/gitinstall
@@ -0,0 +1,35 @@
+#!/bin/sh
+
+MKDIRMODE=0
+MODE=755
+while getopts 'dm:' FLAG; do
+    case "$FLAG" in
+        d) MKDIRMODE=1;;
+        m) MODE="$OPTARG";;
+	*) exit 1;;
+    esac
+done
+if test "$OPTIND" != 1; then
+    shift `expr $OPTIND - 1`
+fi
+if test $MKDIRMODE = 1; then
+    mkdir -p "$@"
+    chmod "$MODE" "$@"
+else
+    if test $# = 2 && ! test -d "$2"; then
+	rm -rf "$2"
+	cp "$1" "$2"
+	chmod "$MODE" "$2"
+    else
+	FILES=
+	while test $# != 1; do
+	    FILES="$FILES $1"
+	    shift
+	done
+	for i in $FILES; do
+	    rm -rf "$1/"`basename "$i"`
+	    cp "$i" "$1"
+	    chmod "$MODE" "$1/"`basename "$i"`
+	done
+    fi
+fi
-- 
1.5.2.4
