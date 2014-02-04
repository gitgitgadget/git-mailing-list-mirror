From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v6 2/6] t0060: Add test for prefix_path on symlinks via absolute paths
Date: Tue,  4 Feb 2014 15:25:16 +0100
Message-ID: <1391523920-26946-3-git-send-email-martinerikwerner@gmail.com>
References: <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
 <1391523920-26946-1-git-send-email-martinerikwerner@gmail.com>
Cc: richih@debian.org, tboegi@web.de, gitster@pobox.com,
	pclouds@gmail.com, dak@gnu.org,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 15:28:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAgws-0002hc-4u
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 15:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbaBDOZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 09:25:45 -0500
Received: from mail-ee0-f48.google.com ([74.125.83.48]:54357 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbaBDOZn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 09:25:43 -0500
Received: by mail-ee0-f48.google.com with SMTP id t10so4261478eei.21
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 06:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v8LiHR+s9zN5cewyqWBbMrEndPbnAeaVz0q9StvIz8U=;
        b=BQQ/KSOpkpkAf7oI3Ivw5y6HEL8Ojk8rUFYK45gVlaDSudEnP8CcnT8kXYyW4oO/Ds
         FfkUGz+Yt4my2iJWQLsCk+bhTQKweuyDMnEXUtwbqlhP1ydUmKTvTkodK/vhCxstN2wA
         Jp31p5a2R9D4BvJsrXcnSMewpuLz04uBymko8djQBIY0lHcRRlEvY3i87mYTlpAfmeRH
         OAXBL+9wfWNF7Y8xsDJnNv83uk6Gr7k0wlAYPdETsW0icESeba5ph31o4dRBe1lswBjQ
         /VOaXuAj48NvGctlFF8JSbkBQ9MsOP+wyd93AbXZ5/sIaj5FLTzaMHGO4RcWmskkM7Es
         wx2Q==
X-Received: by 10.14.194.2 with SMTP id l2mr12633739een.39.1391523941996;
        Tue, 04 Feb 2014 06:25:41 -0800 (PST)
Received: from localhost.localdomain ([194.150.18.52])
        by mx.google.com with ESMTPSA id u7sm89446218eep.11.2014.02.04.06.25.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Feb 2014 06:25:41 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1391523920-26946-1-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241526>

When symlinks in the working tree are manipulated using the absolute
path, git dereferences them, and tries to manipulate the link target
instead.

This applies to most high-level commands but prefix_path is the common
denominator for all of them.

Add a known-breakage tests using the prefix_path function, which
currently uses real_path, causing the dereference.

Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
Reviewed-by: Duy Nguyen <pclouds@gmail.com>
---
 t/t0060-path-utils.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 07c10c8..0bba988 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -190,6 +190,11 @@ test_expect_success SYMLINKS 'real path works on symlinks' '
 	test "$sym" = "$(test-path-utils real_path "$dir2/syml")"
 '
 
+test_expect_failure SYMLINKS 'prefix_path works with absolute paths to work tree symlinks' '
+	ln -s target symlink &&
+	test "$(test-path-utils prefix_path prefix "$(pwd)/symlink")" = "symlink"
+'
+
 relative_path /foo/a/b/c/	/foo/a/b/	c/
 relative_path /foo/a/b/c/	/foo/a/b	c/
 relative_path /foo/a//b//c/	///foo/a/b//	c/		POSIX
-- 
1.8.5.2
