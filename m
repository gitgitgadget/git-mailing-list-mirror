From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v3 2/4] t0060: Add test for prefix_path when path == work tree
Date: Fri, 31 Jan 2014 21:22:28 +0100
Message-ID: <20140131202228.GC9731@mule>
References: <1390781250-20389-2-git-send-email-martinerikwerner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: richih@debian.org, gitster@pobox.com, tboegi@web.de,
	pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 31 21:22:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9Kbn-00066q-Dc
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 21:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660AbaAaUWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 15:22:35 -0500
Received: from mail-la0-f53.google.com ([209.85.215.53]:44411 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271AbaAaUWf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 15:22:35 -0500
Received: by mail-la0-f53.google.com with SMTP id e16so3897603lan.12
        for <git@vger.kernel.org>; Fri, 31 Jan 2014 12:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RkWJN/rasDWmg835phTWFAN11Te+fXG/o/+wBb5Y5Ww=;
        b=Y7DGXEfIbSIzXD5m+ylZ8dc8DbL0+LQ39n6xsiGWv4GbQnxHvSR5TuoZiRHPHTsLrZ
         nseEPxmnSDdI+cth3o4dBU4JR99KhQ+Oks8gML2lrMkS/9LXcWSbfw4C7Orr/yv6dAQq
         fCs1oQkXks8fMZRnNCuiHmuJGX5rorM48rVf2zM6xaQmJdH1k38ZXjHyYjgoYcLQMs2v
         WxosD0yN+CdOlla0sMynHl3SGyH/fwhiY+4p3tfcJjL3kj1ok3weGzMJxMKm84z1dC3E
         iaEG+g2mgLaY8afhjc4Q05s/YdjNwVbdKHp+XK/jninjtHIlJ56E2zJZ2g3O+m1J8du7
         gRUA==
X-Received: by 10.152.43.47 with SMTP id t15mr2680881lal.38.1391199753686;
        Fri, 31 Jan 2014 12:22:33 -0800 (PST)
Received: from mule (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id mx3sm11354834lbc.14.2014.01.31.12.22.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jan 2014 12:22:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1390781250-20389-2-git-send-email-martinerikwerner@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241316>

The current behaviour of prefix_path is to return an empty string if
prefixing and absolute path that only contains exactly the work tree.
This behaviour is a potential regression point.

Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
---
 t/t0060-path-utils.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 0bba988..b8e92e1 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -195,6 +195,12 @@ test_expect_failure SYMLINKS 'prefix_path works with absolute paths to work tree
 	test "$(test-path-utils prefix_path prefix "$(pwd)/symlink")" = "symlink"
 '
 
+test_expect_success 'prefix_path works with only absolute path to work tree' '
+	echo "" >expected &&
+	test-path-utils prefix_path prefix "$(pwd)" >actual &&
+	test_cmp expected actual
+'
+
 relative_path /foo/a/b/c/	/foo/a/b/	c/
 relative_path /foo/a/b/c/	/foo/a/b	c/
 relative_path /foo/a//b//c/	///foo/a/b//	c/		POSIX
-- 
1.8.5.2
