From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/6] refs.c: replace write_str_in_full by write_in_full
Date: Wed, 21 Jan 2015 15:23:42 -0800
Message-ID: <1421882625-916-4-git-send-email-sbeller@google.com>
References: <1421882625-916-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu,
	peff@peff.net, loic@dachary.org
X-From: git-owner@vger.kernel.org Thu Jan 22 00:24:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE4cx-0000Lu-Qt
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 00:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbbAUXX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 18:23:56 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:54527 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbbAUXXv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 18:23:51 -0500
Received: by mail-ig0-f181.google.com with SMTP id hn18so10954970igb.2
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 15:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bkeFlM6VCtLnjDk9AvHlGKhK4CYHgx1uyLgNp9tTWrg=;
        b=lH3oYjwPRj4FyDjwfoTuNgvlpkttSwE5pa5EJZhEaqAUEJxA7uN+9R+KYrmZ7EJZfB
         3CrC6Z5ZxdnzAjDjuHi18f6y/ko5HTf3WUFKgdeHXRRAlmNzV/ruW544olH19AZLwpbb
         bfpwUtm9ko4E5Cy36IHO+eAx7mXwWqHB3kOV63y6HIi+Vt93XZoawuk4p3BoA2Wuu9uL
         4Dx//y7mmZlsAf4AwBjhJjsp306pt6P4/pQ3ET/+U1Fy/6paZW/bEGK1p1hPgpmgu/Uv
         jHJxCrpNptdi4/4Lg+2N/OMKWD2cchLymaVH3VCPV2zemSBCd9m7Z2/AeAZEnTUMu9xL
         rJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bkeFlM6VCtLnjDk9AvHlGKhK4CYHgx1uyLgNp9tTWrg=;
        b=Blyl1zZOq8zLHyfJejIlNI/VQunP6n7E3GjidqQ2ol3PSNOrAs3iBtGeReuWX/TUcQ
         xnAxF7UdIipmYgBGWxwJxkMwLs4Af0jLYd3uOLbvZyCKwEB7t9PtQo8JUBPPV8UxCILl
         eUbhm31IUQPr7KPeR4xlEEG/KWow0hMVEeWHGgz+hNjazcpeHhATvRLNBGomDuboVPYA
         /uesZC7kHmfT0HAyh8fB6LXvGqIOcPhWIASzro2t+o5L7egcIOj98oFrzV3R0JBYXVvJ
         E1w6KpZprPMkuF2n/puqcSEH4Lifxrgs3J3tVbi8EhDj1BpAZGxhGoS4xsrWTdEOdJgl
         RE5g==
X-Gm-Message-State: ALoCoQlLd0cgrE1oIohdL2Vqrk1FhHdbcG2YJ+dDa4ei2wQ7DAG+Y5HaCEO039K+mLXLdM1m1wfJ
X-Received: by 10.50.142.38 with SMTP id rt6mr38758720igb.39.1421882630734;
        Wed, 21 Jan 2015 15:23:50 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a4e7:f2b3:5669:74a3])
        by mx.google.com with ESMTPSA id n4sm675581igr.15.2015.01.21.15.23.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Jan 2015 15:23:50 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1421882625-916-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262778>

There is another occurrence where we could have used write_str_in_full
(line 3107: write_in_full(lock->lk->fd, &term, 1)), so the current state
is inconsistent. This replaces the only occurrence of write_str_in_full
by write_in_full, so we only need to wrap write_in_full in the next patch.

No functional changes intended.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index e905f51..8281bed 100644
--- a/refs.c
+++ b/refs.c
@@ -4080,7 +4080,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
 			(write_in_full(lock->lk->fd,
 				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
-			 write_str_in_full(lock->lk->fd, "\n") != 1 ||
+			 write_in_full(lock->lk->fd, "\n", 1) != 1 ||
 			 close_ref(lock) < 0)) {
 			status |= error("couldn't write %s",
 					lock->lk->filename.buf);
-- 
2.2.1.62.g3f15098
