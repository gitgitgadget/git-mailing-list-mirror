From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/2] dir.c: fix dir re-inclusion rules with "NODIR" and "MUSTBEDIR"
Date: Thu, 17 Mar 2016 19:54:14 +0700
Message-ID: <1458219254-16343-1-git-send-email-pclouds@gmail.com>
References: <1458218744-15810-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: durham@fb.com, mitrandir@fb.com,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 13:54:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agXRy-000149-Fr
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 13:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935969AbcCQMyg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 08:54:36 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36825 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933037AbcCQMye (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 08:54:34 -0400
Received: by mail-pf0-f179.google.com with SMTP id u190so120233032pfb.3
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 05:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gCJKOjbC9btHXdmOH3bRD5CP6nglgD7xU3euSfJTK+s=;
        b=mZwtAIawNr0JSYEX/vTQ2OpOnzp2wZOLpZM6zm7FCawzMEjubH8UavNeH8FQMqsTN7
         6fSG6wIjb0fSypm8Ig8SxTMmatW1qPXMc5LgD0VtrVgfqOi9naWNdw+xa1SBZQqURKIo
         iwEhYIXwRXSk8+unZ1krW9vDADOaKUvcrIokcK6n1S+iRhnnH3pk9SmJrWi5UkTW/xxf
         RFWoQcjPcCs2ZurK2zkh1K5WVeuROPvBRiQLnXsZ4dK8tGpgs44ONsFN2IXx8FbjrCAb
         VeziQp4X84co1QatltNt07759HkaTKck4ey1JR6ySULc2cuOziCJB71SMG5uQhHf0D6R
         UR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gCJKOjbC9btHXdmOH3bRD5CP6nglgD7xU3euSfJTK+s=;
        b=IUoskcYR096CwjveAdkX1htV9ymYFuOPUiJ75XTpCEZ5yRpqTTd0rOIAIRXy5gWe2Y
         19jcG5vxZzZVOuLQ7ZqnUrlFHy0izOxe4DWToCjvGpYvR1UdhwNDcD+mdg+4f93QAAuo
         ErD9zrHZRQuRcBAQJFRNo9pn8ggTpVG6PoN4VgEKNQhBUY8Zu3pAYmev/Zf6XsLM7B40
         37ypYibKR3efqjbg2G3Jnl71OOVjkLOcZK5tmkBy1o+dCf5wDpcQLHkWAVBLMB18Tv0x
         j/NqgQ1BHo3txzndewqysu1F9w3HzYXyg/Tu11vibinxtGT4tcqmDQn/ZdL3U8jgsVIr
         VvzA==
X-Gm-Message-State: AD7BkJLsMHAj5h4XDYbRTf9i3xltjDgmHzzuE4PaF3JownV/n6+tddbUiuUvZ29kwT6H8w==
X-Received: by 10.66.55.73 with SMTP id q9mr14790978pap.50.1458219268470;
        Thu, 17 Mar 2016 05:54:28 -0700 (PDT)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id ko9sm13324769pab.37.2016.03.17.05.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Mar 2016 05:54:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 17 Mar 2016 19:54:21 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1458218744-15810-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289105>

=46or NODIR case, the patterns look like this

    *          # exclude dir, dir/file1 and dir/file2..
    !dir       # ..except that dir and everything inside is re-included=
=2E.
    dir/file2  # ..except (again!) that dir/file2 is excluded
               # ..which means dir/file1 stays included

When we stay at topdir and test "dir", everything is hunky dory, curren=
t
code returns "re-include dir" as expected. When we stay in "dir" and
examine "dir/file1", however, match_basename() checks if the base name
component, which is "file1", matches "dir" from the second rule.

This is wrong. We contradict ourselves because earlier we decided to
re-include dir/file1 (from the second rule) when we were at toplevel.
Because the second rule is ignored, we hit the first one and return
"excluded" even though "dir/file1" should be re-included.

In the MUSTBEDIR case, the patterns look like this

    *          # exclude dir, dir/file1 and dir/file2..
    !dir/      #  ..except that dir and everything inside is re-include=
d..
    dir/file2  # ..except (again!) that dir/file2 is excluded
               # ..which means dir/file1 stays included

Again, we're ok at the toplevel, then we enter "dir" and test
"dir/file1". The MUSTBEDIR code tests if the _full_ path (ie. "dir/file=
1")
is a directory. We want it to test the "dir" part from "dir/file1"
instead.

In both cases, the second decision on "dir/file1" is wrong and
contradicts with the first one on "dir". This is a perfect use case for
"sticky path list" added earlier to solve a different (but quite
similar) problem. So, when we have the right decision the first time, w=
e
mark the path sticky to override the coming wrong decision.

The reason to do this, instead of actually fixing the code to make the
right second decision in the first place, is because it's soooooo
complicated. There are many combinations to take care of, many
optimizations involved to keep the cost on normal/common case (and
what's being described here is NOT normal) down to minimum. On top of
that, exclude code is already complicated as it is. It's best to not
turn the code upside down. Not until this approach is proved
insufficient.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This is NOT for 2.8.0! Posted here to give you some context on the
 problem mentioned in the first patch.

 If you actually read the link in 1/2, you'll notice this patch is
 completely different. "soooooo complicated" is not an exaggeration. I
 found some problem with that old patch, which ended up with a
 combination explosion of cases I would have to cover separately,
 essentially the same thing I encountered in my first try before that
 patch. I finally admitted I could not fit all that in my brain
 anymore.

 dir.c                              |  5 ++++
 t/t3007-ls-files-other-negative.sh | 51 ++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 56 insertions(+)

diff --git a/dir.c b/dir.c
index 2028094..a704e8a 100644
--- a/dir.c
+++ b/dir.c
@@ -1090,6 +1090,11 @@ static struct exclude *last_exclude_matching_fro=
m_list(const char *pathname,
 					 x->pattern, x->srcpos);
 			return NULL;
 		}
+	} else if (exc->flags & EXC_FLAG_NEGATIVE) {
+		if (*dtype =3D=3D DT_UNKNOWN)
+			*dtype =3D get_dtype(NULL, pathname, pathlen);
+		if (*dtype =3D=3D DT_DIR)
+			add_sticky(exc, pathname, pathlen);
 	}
=20
 	trace_printf_key(&trace_exclude, "exclude: %.*s vs %s at line %d =3D>=
 %s%s\n",
diff --git a/t/t3007-ls-files-other-negative.sh b/t/t3007-ls-files-othe=
r-negative.sh
index 0797b86..c8f39dd 100755
--- a/t/t3007-ls-files-other-negative.sh
+++ b/t/t3007-ls-files-other-negative.sh
@@ -150,4 +150,55 @@ test_expect_success 'match, literal pathname, nest=
ed negatives' '
 	test_cmp tmp/expected tmp/actual
 '
=20
+test_expect_success 're-include case, NODIR' '
+	git init re-include-nodir &&
+	(
+		cd re-include-nodir &&
+		mkdir dir &&
+		touch dir/file1 dir/file2 &&
+		cat >.gitignore <<-\EOF &&
+		*
+		!dir
+		dir/file2
+		EOF
+		git ls-files -o --exclude-standard >../actual &&
+		echo dir/file1 >../expected &&
+		test_cmp ../expected ../actual
+	)
+'
+
+test_expect_success 're-include case, MUSTBEDIR with NODIR' '
+	git init re-include-mustbedir &&
+	(
+		cd re-include-mustbedir &&
+		mkdir dir &&
+		touch dir/file1 dir/file2 &&
+		cat >.gitignore <<-\EOF &&
+		*
+		!dir/
+		dir/file2
+		EOF
+		git ls-files -o --exclude-standard >../actual &&
+		echo dir/file1 >../expected &&
+		test_cmp ../expected ../actual
+	)
+'
+
+test_expect_success 're-include case, MUSTBEDIR without NODIR' '
+	git init re-include-pathname &&
+	(
+		cd re-include-pathname &&
+		mkdir -p dir1/dir2 &&
+		touch dir1/dir2/file1 dir1/dir2/file2 &&
+		cat >.gitignore <<-\EOF &&
+		*
+		!dir1/dir2/
+		dir1/dir2/file2
+		EOF
+		git ls-files -o --exclude-standard >../actual &&
+		echo dir1/dir2/file1 >../expected &&
+		test_cmp ../expected ../actual
+	)
+'
+
 test_done
--=20
2.8.0.rc0.210.gd302cd2
