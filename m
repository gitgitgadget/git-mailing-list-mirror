From: William Pursell <bill.pursell@gmail.com>
Subject: shared permissions on COMMIT_EDITMSG
Date: Wed, 27 Jan 2010 23:19:22 -1000
Message-ID: <4B61569A.1010808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 10:24:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaQcR-0008PR-0d
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 10:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574Ab0A1JYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 04:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755195Ab0A1JYr
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 04:24:47 -0500
Received: from mail-yw0-f198.google.com ([209.85.211.198]:36802 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131Ab0A1JYq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 04:24:46 -0500
Received: by ywh36 with SMTP id 36so469046ywh.15
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 01:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=i4hQ3B59TbLcG8WzY82w5eDyl1ou7HDExWChTGvq6g8=;
        b=pKNrU8a3cFWS9L2EfKveY5l5bUS/s0CKz2jU6JHy7ffOdAic++QLS7ruKLrB5tCaaz
         p178jaNfZaUZUFXnJxergEfM6Z7o0jj3VQQ8r23xGK3Ao+YX5L/khDY8eij1G9RBBqAU
         0CmWMCzOBixzpKu1qghMnUZ4W2hvJVADl4BrE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=X5Kq2AfIEm+Fk7pGDhiND2TS5f2ankqlL6FKtZwNFrd3AzW5BuObEunXkwT9dZ/FzS
         kpV/DNSnl6y0zrX3cdxCy8F0stcVk6qjsm2nsjghWafBWjzK5mv4OKbXPKpqE5L6SWMf
         GMgLRX3EdGO9B9IRT2pVAWTElw0vSSukUwPaY=
Received: by 10.101.132.32 with SMTP id j32mr13788632ann.48.1264670366952;
        Thu, 28 Jan 2010 01:19:26 -0800 (PST)
Received: from clam.westell.com (udp278831uds.hawaiiantel.net [72.234.51.251])
        by mx.google.com with ESMTPS id 13sm490058gxk.13.2010.01.28.01.19.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Jan 2010 01:19:25 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138235>

With git-init --shared=0660 and a umask of 022,
the first commit to the repository creates
the file COMMIT_EDITMSG with mode 0644
instead of 0660.  I believe this is incorrect
behavior.  Simple fix:

diff --git a/builtin-commit.c b/builtin-commit.c
index 55676fd..06ce94d 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -687,6 +687,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}

 	fclose(fp);
+	adjust_shared_perm(git_path(commit_editmsg));

 	if (!commitable && !in_merge && !allow_empty &&
 	    !(amend && is_a_merge(head_sha1))) {


-- 
William Pursell
