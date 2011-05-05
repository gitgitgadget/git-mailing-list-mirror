From: Dima Sharov <git.avalakvista@gmail.com>
Subject: [PATCH] shell: add missing initialization of argv0_path
Date: Thu, 5 May 2011 09:40:17 +0300
Message-ID: <62D8CA91-5C11-458E-AADB-D8EC8EB99F09@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 08:40:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHsEe-0000fn-P4
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 08:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745Ab1EEGkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 02:40:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55935 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab1EEGkU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 02:40:20 -0400
Received: by fxm17 with SMTP id 17so1318311fxm.19
        for <git@vger.kernel.org>; Wed, 04 May 2011 23:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:content-type:content-transfer-encoding
         :subject:date:message-id:cc:to:mime-version:x-mailer;
        bh=7CjTZFHj/cn/Q7gjsgWEnZtCwslVgz6vj//8UMHrjBI=;
        b=w4Mvi04yqEaKp0AZCvo6NSz+AENMKUnmmTmcFsbPlvaeWbyW/DQPD0lQZwOurVF9Tu
         qIPENh+NfvX3m4ZXQHoExosauXxaHvN3HdH02Y/gupbF+4eESOEkvWS7uq+dlCmTcdW4
         z9wsvuNu/jqxUkwTSe5U6QrYk0hW9Q4duakSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :cc:to:mime-version:x-mailer;
        b=L33n2WTSIVo3tNoX583EscLsBz8FBTEMGnqs1jHBANE8hoerjM0suWw1Po9+fcLZJP
         wGgfHk8ZOy0351UwKy4D1PwNLy87lJNhbMVywnsdmY/89iD7ERmCvwssXyvPb5mohNUF
         2K1yS7TizK2fepqykJj9ScYQmDg9AFoew+xeU=
Received: by 10.223.60.81 with SMTP id o17mr888065fah.48.1304577619655;
        Wed, 04 May 2011 23:40:19 -0700 (PDT)
Received: from [192.168.1.100] (spearhead.flap.volia.net [93.74.24.105])
        by mx.google.com with ESMTPS id j11sm625792faa.20.2011.05.04.23.40.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2011 23:40:19 -0700 (PDT)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172805>

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
