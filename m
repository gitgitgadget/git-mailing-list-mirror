From: Hemmo Nieminen <hemmo.nieminen@iki.fi>
Subject: Re: [PATCH] graph: Fix log's graph's colors when merging branches.
Date: Thu, 17 Oct 2013 20:16:01 +0300
Message-ID: <20131017171601.GB3747@duunidell>
References: <20131017064853.GA7419@duunidell>
 <20131017081336.GS27238@serenity.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qlTNgmc+xy1dBmNv"
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Oct 17 19:17:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWrCD-0006Da-FP
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 19:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756427Ab3JQRRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 13:17:08 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:36630 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754994Ab3JQRRH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 13:17:07 -0400
Received: by mail-lb0-f176.google.com with SMTP id y6so2133185lbh.7
        for <git@vger.kernel.org>; Thu, 17 Oct 2013 10:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-type:content-disposition
         :in-reply-to;
        bh=OHKdxdamgBEGQxj6zp5itN9O8jW4Elsy04lq1Lj+6F4=;
        b=YjQWnG/sAB0uoC1wJNFXkZ88pNHqXS9dg91wr+Xfahz6k3UCgChALs5H/I1E4qWru1
         VDylYzv4LPMrraB0Lol9B5NwERVjJix0fU6+Y+k5iTQPlLQeR0KWQUsOm24+vLLqE9ib
         xQykRMD+/lu44Pfr8XjVfqSBfaAg/g4F/l2KnYDzBFhRKIGa7aKrD8ZJCYWkbatZUCMw
         UH4V511PKvpK4+SpcV7mJOTlhvumehNnNxAygNddUB45QBAht2dLj5i+ZReSFtu4ZoJr
         60tRU2LvJ4amAl/gUlVWJ22Rtv+E6+Ud+rvyZhAHqUkoKsLBM/jzxVLq2W/mh6U+jNV0
         3zKg==
X-Received: by 10.112.159.166 with SMTP id xd6mr8166897lbb.22.1382030225655;
        Thu, 17 Oct 2013 10:17:05 -0700 (PDT)
Received: from duunidell (cs27053018.pp.htv.fi. [89.27.53.18])
        by mx.google.com with ESMTPSA id mz3sm50119561lbb.14.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Oct 2013 10:17:05 -0700 (PDT)
Mail-Followup-To: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20131017081336.GS27238@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236300>


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

On 09:13 Thu 17 Oct, John Keeping wrote:
> It took me a minute to spot the problem when I tested this, but you're
> right that there is a bug and I agree that the patch below is the right
> fix.
> 
> Perhaps a better commit message will help others looking at this, maybe
> something like this?

Updated the patch. Attaching it here.


-- 
Best Regards
Hemmo Nieminen


--qlTNgmc+xy1dBmNv
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: inline; filename="0001-graph-fix-coloring-around-octopus-merges.patch"

>From 46b7ae56e08bc8ca9c29697da2c1210bd2a242b0 Mon Sep 17 00:00:00 2001
From: Hemmo Nieminen <hemmo.nieminen@iki.fi>
Date: Wed, 16 Oct 2013 11:28:50 +0300
Subject: [PATCH v2] graph: fix coloring around octopus merges

When drawing the graph of an octopus merge, we draw a horizontal line
from parents 3 and above into the asterisk representing the commit. The
sections of this line should be colored to match the graph lines coming
in from above.

However, if the commit is not in the left-most column we do not take
into account the columns to the left of the commit when calculating
these colors. Fix this by adding the appropriate offset to the column
index used for calculating the color.

Signed-off-by: Hemmo Nieminen <hemmo.nieminen@iki.fi>
---

Notes:
    Commit 211232b (Octopus merge of the following five patches.,
    2005-05-05) in git.git's history exhibits this problem.

 graph.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/graph.c b/graph.c
index b24d04c..6404331 100644
--- a/graph.c
+++ b/graph.c
@@ -801,10 +801,10 @@ static int graph_draw_octopus_merge(struct git_graph *graph,
 	int num_dashes =
 		((graph->num_parents - dashless_commits) * 2) - 1;
 	for (i = 0; i < num_dashes; i++) {
-		col_num = (i / 2) + dashless_commits;
+		col_num = (i / 2) + dashless_commits + graph->commit_index;
 		strbuf_write_column(sb, &graph->new_columns[col_num], '-');
 	}
-	col_num = (i / 2) + dashless_commits;
+	col_num = (i / 2) + dashless_commits + graph->commit_index;
 	strbuf_write_column(sb, &graph->new_columns[col_num], '.');
 	return num_dashes + 1;
 }
-- 
1.8.4.1


--qlTNgmc+xy1dBmNv--
