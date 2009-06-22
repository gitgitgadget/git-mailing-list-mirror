From: newren@gmail.com
Subject: [PATCH v2] fast-export: Make sure we show actual ref names instead of "(null)"
Date: Mon, 22 Jun 2009 07:06:37 -0600
Message-ID: <1245676001-14734-3-git-send-email-newren@gmail.com>
References: <1245676001-14734-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, kusmabite@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 15:09:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIjGx-0004LE-SG
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 15:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730AbZFVNIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 09:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752587AbZFVNIv
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 09:08:51 -0400
Received: from mail-pz0-f197.google.com ([209.85.222.197]:55508 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbZFVNIt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 09:08:49 -0400
Received: by mail-pz0-f197.google.com with SMTP id 35so731490pzk.33
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 06:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ypceb3s1DYe2QYXIuJt8y4Hh2y3VLuuyWHy4EmigOIc=;
        b=HpaKmvlVCixs0EVkifSmHWrJPMTpD0p4JXSIT+IQkb52forJjHCVSWTg5541ptGs8I
         Inp0Zcr0SIUD+Z5PWaVHf0fWLkSuM5k/XcPSKoEX4molUFrkAEHjo9wi6x0YjdQsmWCL
         kN8FvfjqQxkUvXnxQ0MVYcGvTC5If3OLpZwRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=P+ElzoLxV2Q/56pdYaXHsUTPhS9SwZKPHCy/zT/AIX05dDvCzSaO1BigEc6uG0mlo7
         B7nlsbN2Qja/xwmGJe4wWLbpKFWRwwE1UPrcweO+p1ty2AC6dReGhnQLS64fuXeYqDHR
         IJW1HEsM3pEfTnbKeu/2VtjL300bRy7guJ4Jk=
Received: by 10.142.213.5 with SMTP id l5mr2106042wfg.89.1245676132930;
        Mon, 22 Jun 2009 06:08:52 -0700 (PDT)
Received: from localhost.localdomain (c-68-35-108-93.hsd1.nm.comcast.net [68.35.108.93])
        by mx.google.com with ESMTPS id 28sm675507wfd.23.2009.06.22.06.08.51
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Jun 2009 06:08:52 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.323.gfb84f
In-Reply-To: <1245676001-14734-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122038>

From: Elijah Newren <newren@gmail.com>

Under some cases (e.g. 'git fast-export --parents master -- COPYING' run
in git.git), the output included the lines
  reset (null)
  commit (null)
instead of
  reset refs/heads/master
  commit refs/heads/master
This simple change fixes that.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
(No change to this patch since the first series.)
As noted above, run 'git fast-export --parents master -- COPYING' in
git.git to see this bug triggered.

 builtin-fast-export.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 891e2d4..9aa409b 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -531,6 +531,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	get_tags_and_duplicates(&revs.pending, &extra_refs);
 
 	revs.topo_order = 1;
+	revs.show_source = 1;
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	revs.diffopt.format_callback = show_filemodify;
-- 
1.6.0.6
