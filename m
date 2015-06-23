From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] Enable core.fsyncObjectFiles by default
Date: Tue, 23 Jun 2015 14:57:23 -0700
Message-ID: <1435096643-18159-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, peff@peff.net, torvalds@linux-foundation.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 23 23:57:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7WCJ-00046t-6W
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 23:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933347AbbFWV5e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jun 2015 17:57:34 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38851 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932323AbbFWV5d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 17:57:33 -0400
Received: by igin14 with SMTP id n14so21771065igi.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 14:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=cB+L2jrgsAwqyRw9DAIjkT2/b+9QwiftFdribFCBRGo=;
        b=KTq4K4dKvMk3JQk4TqBvgQoq1WZo5KVDgY8Fd8FfldSmxUVfn6HzKt4Pie/aC8FN9e
         LN35zneB2UDy9xgT0AZq5FXcY+NSd6s9hJXt86T3GuwPg49V5+jrzPjJWY0xh0n69wqr
         cc6ssZWQvlpax9iuPVfStFbc1jTKIRn+2qti/KpSofYIncZG7QhdH2kJUBmob1Zy+9Nt
         kt0GtttdnJSxEcnfxcSw0s+xiZQxltkusPumCA8BJeClais0+6GyZMqnkpm0y27oasvt
         6om0tM64D+3fGzx00Bnuqj/y1F/D3d5V+PMLCAc98kSfaZ/FtZci9g9N2uBZuNMZCyld
         9z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=cB+L2jrgsAwqyRw9DAIjkT2/b+9QwiftFdribFCBRGo=;
        b=NyNdWpxhPUv3kftyg2+7AK0B94hceOjC4PgYkOFCFLundQ86qqK1YN5hKMjJ4OKj21
         30e+xSoEfzvGyn4Dt7VZ21WFiNUoIbsBil96gFOnaMdqgROMD7F9aidEQZ59xsDQ0iQA
         xMMZIYVARKn8fJDZHYRdfZOLPMk9IG4GOr+u5vBTSv6uViC7xY2QzuG/Cja9c60Khy8G
         1RZzyBCrevq17ClfUpmDv+jhzYmw32NzxqyDEgTBo78jzl0dxaj37G4HmWZDzi5WuBMs
         knbGRP2+MG0CVE3/bcdAPeFMzOkxpbsaXh3FZTbWt0S6bc2fHOTa2S7TebwKapLPpHfl
         JK2A==
X-Gm-Message-State: ALoCoQndN+2A6/CGSUrVOxlh0XqDz8uQrCHe7LdMUFjWHdOPgz2hHU/jn9/NAHqMr58yuC1HGSc9
X-Received: by 10.107.164.89 with SMTP id n86mr18630065ioe.73.1435096652634;
        Tue, 23 Jun 2015 14:57:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:5993:4446:e67a:566a])
        by mx.google.com with ESMTPSA id r4sm636443igh.9.2015.06.23.14.57.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jun 2015 14:57:31 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272523>

Linus Torvalds started a discussion[1] if we want to play rather safe
than use defaults which make sense only for the most power users of Git=
:

> So git is "safe" in the sense that you won't really lose any data,
> but you may well be inconvenienced.  The "fsync each object" config
> option is there in case you don't want that inconvenience, but it
> should be noted that it can make for a hell of a performance impact.

> Of course, it might well be the case that the actual default
> might be worth turning around. Most git users probably don't
> care about that kind of "apply two hundred patches from Andrew
> Morton" kind of workload, although "rebase a big patch-series"
> does end up doing basically the same thing, and might be more
> common.=EF=BB=BF

This patch enables fsync_object_files by default.

[1] https://plus.google.com/u/1/+JonathanCorbet/posts/JBxiKPe3VXa

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt | 8 ++++----
 environment.c            | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 43bb53c..dce2640 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -693,10 +693,10 @@ core.whitespace::
 core.fsyncObjectFiles::
 	This boolean will enable 'fsync()' when writing object files.
 +
-This is a total waste of time and effort on a filesystem that orders
-data writes properly, but can be useful for filesystems that do not us=
e
-journalling (traditional UNIX filesystems) or that only journal metada=
ta
-and not file contents (OS X's HFS+, or Linux ext3 with "data=3Dwriteba=
ck").
+This ensures objects are written to disk instead of relying on the
+operating systems cache and eventual write. Disabling this option will
+yield performance with a trade off in safety for repository corruption
+during power loss.
=20
 core.preloadIndex::
 	Enable parallel index preload for operations like 'git diff'
diff --git a/environment.c b/environment.c
index 61c685b..b406f5e 100644
--- a/environment.c
+++ b/environment.c
@@ -35,7 +35,7 @@ const char *git_attributes_file;
 int zlib_compression_level =3D Z_BEST_SPEED;
 int core_compression_level;
 int core_compression_seen;
-int fsync_object_files;
+int fsync_object_files =3D 1;
 size_t packed_git_window_size =3D DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit =3D DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit =3D 96 * 1024 * 1024;
--=20
2.4.1.345.gab207b6.dirty
