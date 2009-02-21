From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH] revision.c: add --format option for 'git log'
Date: Sat, 21 Feb 2009 17:26:55 +0200
Message-ID: <1235230015-17641-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 16:28:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LatmI-000585-V6
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 16:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbZBUP1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 10:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753235AbZBUP1B
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 10:27:01 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:41734 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205AbZBUP1A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 10:27:00 -0500
Received: by bwz5 with SMTP id 5so3522551bwz.13
        for <git@vger.kernel.org>; Sat, 21 Feb 2009 07:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=XuGpEM/zsJUXsHUNXU58dLYyxhoernEyZhtxwr5F2os=;
        b=xhGAgbhI7kLEEPLLZCGRbmI7+SYL8H/0uWtBgl99n9E92d1J7cdJafogTEfvt1xU5f
         NTHma0JqmRO9qJfNohJCTFRN3wYcOXiFjr7IVZH6pMUPLAfaC1LbV5aQec1QiLfmVA9F
         jlEcNsFv5MuqHnaGELy+Ph08yo0MpArx8hFtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=asT6VKGFuZE6ca6hK1VxWVAhdxCh4L660maHRVAQ5TRcFKs3E7cH8Nw9gk3YgPoyjw
         cOqZcYFPVggz/B+8djvGAtyEQr8w+O481TXK+vbNaSo5sZxUx4MsSMCkGL9llO7Mw11z
         5nC5WX+tRK+LF0PeN029YmBFMR2aAmCRDnsbE=
Received: by 10.223.108.211 with SMTP id g19mr78852fap.39.1235230018508;
        Sat, 21 Feb 2009 07:26:58 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id b17sm6769332fka.24.2009.02.21.07.26.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Feb 2009 07:26:58 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110962>

--format=:foo is a shorthand for --pretty=tformat:foo, otherwise this
new option acts just like --pretty=foo, except it's more intuitive for
users of 'git log'.

As discussed in the mailing list, this is implemented as an undocumented
option. The specifics of the implementation were suggested by Junio C
Hamano.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 revision.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 286e416..6796e39 100644
--- a/revision.c
+++ b/revision.c
@@ -1147,6 +1147,16 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!prefixcmp(arg, "--pretty=")) {
 		revs->verbose_header = 1;
 		get_commit_format(arg+9, revs);
+	} else if (!prefixcmp(arg, "--format=")) {
+		char *modified = NULL;
+		revs->verbose_header = 1;
+		if (arg[9] == ':') {
+			modified = xmalloc(strlen(arg+9) + 7 + 1);
+			strcpy(modified, "tformat");
+			strcat(modified, arg+9);
+		}
+		get_commit_format(modified ? modified : arg+9, revs);
+		free(modified);
 	} else if (!strcmp(arg, "--graph")) {
 		revs->topo_order = 1;
 		revs->rewrite_parents = 1;
-- 
1.6.1.3
