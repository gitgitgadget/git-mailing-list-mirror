From: Dima Sharov <git.avalakvista@gmail.com>
Subject: [PATCH] shell: add missing initialization of argv0_path
Date: Sun, 1 May 2011 09:06:36 +0300
Message-ID: <8F1D5462-15DC-4F01-9F6A-5C0E477B12F6@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 08:06:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGPo1-0001SI-LL
	for gcvg-git-2@lo.gmane.org; Sun, 01 May 2011 08:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062Ab1EAGGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2011 02:06:39 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49782 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab1EAGGj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2011 02:06:39 -0400
Received: by bwz15 with SMTP id 15so3948841bwz.19
        for <git@vger.kernel.org>; Sat, 30 Apr 2011 23:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:content-type:content-transfer-encoding
         :date:subject:to:message-id:mime-version:x-mailer;
        bh=evVBHVD7VY4zYdDgINpVPq7hfB//JoEi06XrCMONPIA=;
        b=TnVhj9gfFUpEUfztt1FkU2Z8LGiuldk7Hnr32c5TyUwWTDghyFo0h/10tvFXnMlS6G
         KMKcGuVzEoGZhNAW3L1jzadSXPxoQ4YqQZ5DteYDxWWs1v2lxP8noL5qJ/308rH5E9xO
         SFzvxkReaDTTvAeUms+/PdryNErYKXvKyuR+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:date:subject:to
         :message-id:mime-version:x-mailer;
        b=R+UM1En7CTq2fQUS4HFYQ+AqpE16IjOKgdtNxf19qFlF0+K3T7LUC4o4DduWOq5WcN
         TMmsaTW8voPU3dfGuUEE6e5iYrm+4dKW1WL1ryol8NM1sUWK+asQCRH/Ywy4qUflgfQQ
         6j5U6J9sBkyuBiesYDbhLQVSsOxCscPHVlVzM=
Received: by 10.205.36.65 with SMTP id sz1mr2881071bkb.74.1304229997888;
        Sat, 30 Apr 2011 23:06:37 -0700 (PDT)
Received: from [192.168.1.101] (spearhead.flap.volia.net [93.74.24.105])
        by mx.google.com with ESMTPS id y22sm2510433bku.20.2011.04.30.23.06.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 30 Apr 2011 23:06:37 -0700 (PDT)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172530>

According to c6dfb39 (remote-curl: add missing initialization of
argv0_path, 2009-10-13), stand-alone programs (non-builtins)
must call git_extract_argv0_path(argv[0]) in order to help builds
that derive the installation prefix at runtime. Without this call,
the program segfaults (or raises an assertion failure).

Signed-off-by: Dima Sharov <git.avalakvista@gmail.com>
---
 shell.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/shell.c b/shell.c
index dea4cfd..abb8622 100644
--- a/shell.c
+++ b/shell.c
@@ -137,6 +137,8 @@ int main(int argc, char **argv)
 	int devnull_fd;
 	int count;
 
+	git_extract_argv0_path(argv[0]);
+
 	/*
 	 * Always open file descriptors 0/1/2 to avoid clobbering files
 	 * in die().  It also avoids not messing up when the pipes are
-- 
1.7.2.3
