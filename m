From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Correctly close config file handle in case of error
Date: Fri, 14 Aug 2015 14:00:54 -0700
Message-ID: <xmqqsi7lh9fd.fsf@gitster.dls.corp.google.com>
References: <55CE3F23.7040702@cs-ware.de>
	<CAPig+cQMng-bPjO3WLYb1z7aghYhhHqewSr+EGFgV6Gs6_JZRQ@mail.gmail.com>
	<55CE4511.6050704@cs-ware.de>
	<CAPig+cStMdZUwDgSfzT_DgBpF-OMQe-PqTKbSLkzXFHQW8ca=Q@mail.gmail.com>
	<55CE49AD.4010605@cs-ware.de>
	<CAPig+cTo=iiMvvcfRu68feofoBVSFjrd4zG8GYwXN5L6THr=8Q@mail.gmail.com>
	<55CE4DBD.2070308@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Sven Strickroth <sven@cs-ware.de>
X-From: git-owner@vger.kernel.org Fri Aug 14 23:01:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQM61-0001An-FZ
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 23:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbbHNVA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 17:00:56 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33434 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbbHNVA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 17:00:56 -0400
Received: by pabyb7 with SMTP id yb7so66661809pab.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 14:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1/TV0lVs3W/DUTuLe9gjn5HbJb8V80CnGcQlZc/CNX8=;
        b=vYEDLOKE+7KIejNOAUgwEyVgaW2dDjf1B/4VJllx9+a/KqkzPR0b5H+2PH6HrmhQfL
         I6O3K30PBVkWUYI3k6TEKx8WqrmexiaokLxdqjUppatDXQQnXybYTdt4NeYjPyWTCc3R
         VpIh/87QDOPxKRpGsJtBGvk3bfkrWLU29JZoPDmi9bn9gkHTzPLpdDA0PpMil7bNLjrH
         u9bEx4WjOAAh5cug3hEzmh/YN57YgzMOwVdgPOnaaiNxcwQ2U4bZipVw7M3DvCotjkeE
         G0RapAQW4ispvXJnz5+DMKDLs+dnSCdUtnyHjsY9v77m6myvttP5bYIN7Q5r/XTprlaG
         856A==
X-Received: by 10.68.239.69 with SMTP id vq5mr63193580pbc.111.1439586055788;
        Fri, 14 Aug 2015 14:00:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a820:aa0d:2b52:954f])
        by smtp.gmail.com with ESMTPSA id k10sm7001367pbq.63.2015.08.14.14.00.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Aug 2015 14:00:55 -0700 (PDT)
In-Reply-To: <55CE4DBD.2070308@cs-ware.de> (Sven Strickroth's message of "Fri,
	14 Aug 2015 22:21:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275951>

Sven Strickroth <sven@cs-ware.de> writes:

> Without this patch there might be open file handle leaks.
>
> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> Signed-off-by: Sup Yut Sum <ch3cooli@gmail.com>

Who are these two people and how are they related to this change?
I am wondering if "Sup" is the author of this change and "Sven" is
only relaying his change, or the other way around or what.

In any case, your log message left a lot of room for improvement;
here is my attempt.

-- >8 --
From: Sven Strickroth <sven@cs-ware.de>
Date: Fri, 14 Aug 2015 22:21:17 +0200
Subject: [PATCH] config: close config file handle in case of error

When updating an existing configuration file, we did not always
close the filehandle that is reading from the current configuration
file when we encountered an error (e.g. when unsetting a variable
that does not exist).

Signed-off-by: Sven Strickroth <email@cs-ware.de>
Signed-off-by: Sup Yut Sum <ch3cooli@gmail.com>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 9fd275f..83caa25 100644
--- a/config.c
+++ b/config.c
@@ -1935,7 +1935,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
 				const char *key, const char *value,
 				const char *value_regex, int multi_replace)
 {
-	int fd = -1, in_fd;
+	int fd = -1, in_fd = -1;
 	int ret;
 	struct lock_file *lock = NULL;
 	char *filename_buf = NULL;
@@ -2065,6 +2065,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
 			goto out_free;
 		}
 		close(in_fd);
+		in_fd = -1;
 
 		if (chmod(lock->filename.buf, st.st_mode & 07777) < 0) {
 			error("chmod on %s failed: %s",
@@ -2148,6 +2149,8 @@ out_free:
 	free(filename_buf);
 	if (contents)
 		munmap(contents, contents_sz);
+	if (in_fd >= 0)
+		close(in_fd);
 	return ret;
 
 write_err_out:
-- 
2.5.0-487-g2edca40
