From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] unpack-trees: preserve the index file version of original
Date: Fri, 27 Apr 2012 15:58:13 -0700
Message-ID: <xmqqzk9w93zu.fsf@junio.mtv.corp.google.com>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 28 00:58:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNu7I-0007Ej-GS
	for gcvg-git-2@plane.gmane.org; Sat, 28 Apr 2012 00:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756314Ab2D0W6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 18:58:16 -0400
Received: from mail-wi0-f202.google.com ([209.85.212.202]:62790 "EHLO
	mail-wi0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237Ab2D0W6P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 18:58:15 -0400
Received: by wibhj13 with SMTP id hj13so63528wib.1
        for <git@vger.kernel.org>; Fri, 27 Apr 2012 15:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type:x-gm-message-state;
        bh=PtW8q2VCx8Gca1/5ooNtAHJgq6BNdfgwHDQImM6qh2g=;
        b=Se+Xjp1MX/x89E5E1D1Rt12bHdY8+egK35UCd+oiLQqvydBWoaHtw9yy1gd82543Cy
         /CjGhpbUlYL2MMW0LAULtgyGcvFCntEicmEOyx6WhEuOlCVrKVnJLv2WznriEhOOKxVp
         nM5hYHBwZplFNvZWkIoSjwiDr4Lg8QaoSY46MpIhMgwJU6j7HqmQkOv+zvfpt+S9CIoM
         NfE4ywtEwmgcafMHN+6dQ1CwpNsuUhU+npj2x6bVQQt8naLzfevUkc3uCE0qWBLsGU3U
         NUta9zuMvcmb+q4HYJgqNe9QlxkgTagnKIM7ECyZj3QAncJOt+GhOMTvoP5T3wVC8Fv9
         Tanw==
Received: by 10.213.22.13 with SMTP id l13mr757589ebb.5.1335567494123;
        Fri, 27 Apr 2012 15:58:14 -0700 (PDT)
Received: by 10.213.22.13 with SMTP id l13mr757578ebb.5.1335567493970;
        Fri, 27 Apr 2012 15:58:13 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id s9si7613316eei.3.2012.04.27.15.58.13
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 27 Apr 2012 15:58:13 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id C2A7B20004E;
	Fri, 27 Apr 2012 15:58:13 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 20DB5E125C; Fri, 27 Apr 2012 15:58:13 -0700 (PDT)
In-Reply-To: <1333493596-14202-1-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Tue, 3 Apr 2012 15:53:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmTuFqNAFls1eUQaHjNUHcsyqXdoJEg8VKPJxskjklKhRKuTa1BxCYyeXGNnlg7bjdpkIXiTrxI8rNjwXztqenwrtmkRJ2KargCl/YOw5cUYdzzB1HYl1OJM+IXyJXxGv8cr1Y97JClsFFRgqakZ5G6OwruNy9THo1l1n0o2DPrYVZ2lrE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196488>

Otherwise "git checkout $other_branch" (or even "git checkout HEAD")
would end up writing the index out in the default format.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * The first of a two patch series to update the jc/index-v4 series:
   http://thread.gmane.org/gmane.comp.version-control.git/194660

 unpack-trees.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index 7c9ecf6..2a037d6 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1020,6 +1020,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->result.initialized = 1;
 	o->result.timestamp.sec = o->src_index->timestamp.sec;
 	o->result.timestamp.nsec = o->src_index->timestamp.nsec;
+	o->result.version = o->src_index->version;
 	o->merge_size = len;
 	mark_all_ce_unused(o->src_index);
 
-- 
1.7.10.526.gb0571
