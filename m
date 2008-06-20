From: Cristian Peraferrer <corellian.c@gmail.com>
Subject: [PATCH] Added the printing of 'errno' error number when the attempt to open the COMMIT_EDITMSG file is failed
Date: Fri, 20 Jun 2008 17:55:54 +0200
Message-ID: <1D8D9EA1-720A-446D-BA32-E83E88155E0A@gmail.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 17:57:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9iyw-0007NE-A0
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 17:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756865AbYFTP4C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 11:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756819AbYFTP4B
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 11:56:01 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:21779 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756726AbYFTP4A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 11:56:00 -0400
Received: by fg-out-1718.google.com with SMTP id 19so674104fgg.17
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 08:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=S+Xo5GFarzclXDB77kbELvoXugadmMuBmk1Vkf7W6cU=;
        b=CobLcJh+QBaiKje36vcnqQZ3TkklNsY8PlOUbmb9I5gl34gvCEgiq8yiuibN1uUmo9
         4xLb6FUtVbOmyxnUEgHptnHujbL8/mdEwltVpmBZJM+IzxQ3kq6HxrubSDYM79+HRpRE
         vWRwqtVDqgzkhwvyUVL0pV2ykeQBCSNdKubi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=Bqy6iVpfoSP10VeJlsUVa8HdvT3ndxH5hHJ5Oz3IreOW1xycyiSe8wX9jnhKTzXgRc
         YCdKrmDZre5oQmW9058i1hwR12VwuE+xC/1GtQYiuH/zb1ZlS3XxpPGGO/zYWHbcjcaO
         9xGFp2JSz33t8R40B3l9yeJeVzpriHLu0lBdA=
Received: by 10.210.50.6 with SMTP id x6mr3179908ebx.87.1213977358614;
        Fri, 20 Jun 2008 08:55:58 -0700 (PDT)
Received: from ?192.168.1.5? ( [80.33.90.183])
        by mx.google.com with ESMTPS id g9sm3217405gvc.0.2008.06.20.08.55.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Jun 2008 08:55:57 -0700 (PDT)
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85657>

From: Cristian Peraferrer <corellian.c@gmail.com>
Date: Fri, 20 Jun 2008 17:24:20 +0200
Subject: [PATCH] Added the printing of 'errno' error number when the  
attempt to open the COMMIT_EDITMSG file is failed

Now when the COMMIT_EDITMSG cannot be opened, the die message gives
more information to the user by giving the 'errno' number.

Signed-off-by: Cristian Peraferrer <corellian.c@gmail.com>
---
  builtin-commit.c |    3 ++-
  1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 90200ed..a33f43a 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -502,7 +502,8 @@ static int prepare_to_commit(const char  
*index_file, const char *prefix)

  	fp = fopen(git_path(commit_editmsg), "w");
  	if (fp == NULL)
-		die("could not open %s", git_path(commit_editmsg));
+		die("could not open %s: %s",
+		    git_path(commit_editmsg), strerror(errno));

  	if (cleanup_mode != CLEANUP_NONE)
  		stripspace(&sb, 0);
-- 
1.5.5
