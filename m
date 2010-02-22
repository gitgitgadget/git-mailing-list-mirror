From: Bryan Alves <bryanalves@gmail.com>
Subject: [PATCH] merge: --no-ff configuration setting
Date: Sun, 21 Feb 2010 21:59:15 -0500
Message-ID: <1266807555-86199-1-git-send-email-bryanalves@gmail.com>
Cc: Bryan Alves <bryanalves@gmail.com>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 04:57:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjOWL-0004Ks-NI
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 03:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474Ab0BVC7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 21:59:37 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:42175 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876Ab0BVC7g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 21:59:36 -0500
Received: by qw-out-2122.google.com with SMTP id 8so392022qwh.37
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 18:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=yTtnSHqbOREeE8hLk88JSrsMrgQxLwYyVE82cwMI72A=;
        b=fkxDDLmL6zvnml4YioWkmhPFSsMBl7YGzgnsqJ0NIhn4HcJ6NyoLtWzFuMOj1guAap
         Y2NJz/4v7mI5gcTZYCINOFdT7EiLKfDE5JJa8146aAzKD2X0aXASpZU5X+/1TgXj1T7e
         Mm1XSKYmihlVb4x+2gwpk8IZAt/dlbvCzK9gY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=NrJ1YoV/3XVHvSMjs3WPrWEsuwHJeIEu0znWT3GPUoCl32+vpcN0E53cm31/Naw/51
         3VkjeFglG/iZwynB1AiPrqcwao0PwtcPTtCnPrgDg3b6vY9fItipjdk2ATTYAy7URVEv
         Xvf16NrhveINf94+Ecu8nfSi4tVVSKpYSmpN4=
Received: by 10.224.99.132 with SMTP id u4mr5544963qan.9.1266807576167;
        Sun, 21 Feb 2010 18:59:36 -0800 (PST)
Received: from localhost (pool-74-104-161-201.bstnma.fios.verizon.net [74.104.161.201])
        by mx.google.com with ESMTPS id 7sm7705827qwb.27.2010.02.21.18.59.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Feb 2010 18:59:35 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140574>

Add a new configuration option, merge.allowfastforward

When set to false, causes --no-ff to be the default behavior
for merges. When set to true, or not present, the default
behavior is unchanged, and acts like --ff is set.

Signed-off-by: Bryan Alves <bryanalves@gmail.com>
---
 Documentation/merge-options.txt |    4 +++-
 builtin-merge.c                 |    3 +++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 3b83dba..6638af7 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -14,7 +14,9 @@ inspect and further tweak the merge result before committing.
 	the default behavior of git-merge.
 +
 With --no-ff Generate a merge commit even if the merge
-resolved as a fast-forward.
+resolved as a fast-forward.  --no-ff can be made the
+default behavior with the configuration option
+merge.allowfastforward
 
 --log::
 --no-log::
diff --git a/builtin-merge.c b/builtin-merge.c
index 3aaec7b..a96aaac 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -495,6 +495,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		free(buf);
 	}
 
+	if (!strcmp(k, "merge.allowfastforward"))
+		allow_fast_forward = !git_config_bool(k, v);
+
 	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
 		show_diffstat = git_config_bool(k, v);
 	else if (!strcmp(k, "pull.twohead"))
-- 
1.6.6.1
