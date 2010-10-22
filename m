From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/7] update-index -h: show usage even with corrupt index
Date: Fri, 22 Oct 2010 01:51:00 -0500
Message-ID: <20101022065100.GH6081@burratino>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 08:54:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9BWe-0004a9-64
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 08:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983Ab0JVGyr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 02:54:47 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53498 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421Ab0JVGyq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 02:54:46 -0400
Received: by gxk23 with SMTP id 23so127425gxk.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 23:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8iogET/L5QHosyqvesVlVh2odZeQgFLRKnl+D9bx3T0=;
        b=Bk4ZsU1+1WYbjNRTeAQzDW81jX+WbOilNiQ5rYJj2O52aWQUzGBoqKIcR0iy3xwEM1
         7ZCt+p/YQxmY5FypbrSSHXSw/WnEgqD6cSEx1byVO7KUNBZi0XmCL0htAzEeTnz2pwrd
         dXFutymnVzu+wk841qMZ6HCsfyYD8JmwATgB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Vhp586CaBPjtyddexwYV5mFVoN39GFTQ26hoisymjUsYElVBX4zfW8oDsb9pRWjjIW
         4Zxcwjw8gkqjLaX+E4Ht8y3pLCptICX0zT3urz8uyw2IKybP6EV0GiotF40yHJvCSoJu
         xnJP7yUY1zEZo9ExPNKn/W9fGLf4QAvGy0T6w=
Received: by 10.150.236.12 with SMTP id j12mr5374349ybh.335.1287730486127;
        Thu, 21 Oct 2010 23:54:46 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id z23sm2097749yhc.32.2010.10.21.23.54.44
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 23:54:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101022063837.GA6081@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159657>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

When trying to fix up a corrupt repository, one might prefer that
"update-index -h" print an accurate usage message and exit rather
than reading the repository and complaining about the corruption.

[jn: with rewritten log message and tests]

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/update-index.c        |    3 +++
 t/t2107-update-index-basic.sh |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)
 create mode 100755 t/t2107-update-index-basic.sh

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 3ab214d..a41d6d7 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -589,6 +589,9 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 	int lock_error =3D 0;
 	struct lock_file *lock_file;
=20
+	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+		usage(update_index_usage);
+
 	git_config(git_default_config, NULL);
=20
 	/* We can't free this memory, it becomes part of a linked list parsed=
 atexit() */
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic=
=2Esh
new file mode 100755
index 0000000..33f8be0
--- /dev/null
+++ b/t/t2107-update-index-basic.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description=3D'basic update-index tests
+
+Tests for command-line parsing and basic operation.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'update-index --nonsense fails' '
+	test_must_fail git update-index --nonsense 2>msg &&
+	cat msg &&
+	test -s msg
+'
+
+test_expect_failure 'update-index --nonsense dumps usage' '
+	test_expect_code 129 git update-index --nonsense 2>err &&
+	grep "[Uu]sage: git update-index" err
+'
+
+test_expect_success 'update-index -h with corrupt index' '
+	mkdir broken &&
+	(
+		cd broken &&
+		git init &&
+		>.git/index &&
+		test_expect_code 129 git update-index -h >usage 2>&1
+	) &&
+	grep "[Uu]sage: git update-index" broken/usage
+'
+
+test_done
--=20
1.7.2.3
