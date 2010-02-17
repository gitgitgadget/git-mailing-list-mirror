From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: [PATCH v2] require_work_tree broken with NONGIT_OK
Date: Tue, 16 Feb 2010 23:18:50 -0500
Message-ID: <4B7B6E2A.3050704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 05:19:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhbNc-0000AE-38
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 05:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934019Ab0BQES6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 23:18:58 -0500
Received: from mail-qy0-f178.google.com ([209.85.221.178]:37106 "EHLO
	mail-qy0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934011Ab0BQES5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 23:18:57 -0500
Received: by qyk8 with SMTP id 8so1568134qyk.24
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 20:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=ll+uSanaiyEQrDOQ6qD6QPSIsFJrUdqOVBrpR0GfEPg=;
        b=K2xhLoVLEsesihZ00Dabqhtd4TuF94GNplBazomU6oa1w3Il6cIuc0jtda0imIwOFB
         CqesLhqDxZCsxrXz04ZGO9D00eJXdF7RpK+X/4wrnZNQOeDbV4OBYNi6eok8dvGby54J
         Hw5ahLHe0pCm8Wj6hg36Kv9rxxRHP2FeH+E3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=Q9lXR3RdmhqdoCbKMjTZCujYyXKH6ZZpqFCy3dIjKYM1ls9QQDLRJutq1fm4pf4D6I
         7EQdqPgiDrlmim4GcYHKM52eI9mIpET6S5/mbPgXQhDXNa7nIdasvVSlTeEojV/KLjGP
         Hvnz8tC1AlHyn1QHpuh6FZMcl/ukMstq7ZmSY=
Received: by 10.229.108.202 with SMTP id g10mr3697122qcp.19.1266380334795;
        Tue, 16 Feb 2010 20:18:54 -0800 (PST)
Received: from ?192.168.2.202? (dsl-152-38.aei.ca [66.36.152.38])
        by mx.google.com with ESMTPS id 22sm5617863qyk.2.2010.02.16.20.18.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 20:18:53 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20100108 Lightning/1.0b1 Icedove/3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140204>

Sourcing git-sh-setup: After having set NONGIT_OK, when calling the
function require_work_tree while outside of a git repository shows a
syntax error.
This is caused by the call to git rev-parse --is-inside-work-tree
printing nothing when it is called outside of a git repository.

Quoting the call removes the syntax error and sending stderr to
/dev/null removes duplicate error messages.

Signed-off-by: Gabriel Filion <lelutin@gmail.com>
---
 git-sh-setup.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index d56426d..5e22440 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -128,7 +128,7 @@ cd_to_toplevel () {
 }
  require_work_tree () {
-	test $(git rev-parse --is-inside-work-tree) = true ||
+	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true ||
 	die "fatal: $0 cannot be used without a working tree."
 }
 -- 1.6.6
