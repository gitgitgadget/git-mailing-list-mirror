From: Allan Caffee <allan.caffee@gmail.com>
Subject: [PATCH 3/3] graph API: fix a bug in the rendering of octopus merges
Date: Wed, 22 Apr 2009 17:27:59 -0400
Message-ID: <20090422212759.GA30512@linux.vnet>
References: <20090422193838.GA1841@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 23:29:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwk0m-0002SD-16
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 23:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755735AbZDVV2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 17:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755181AbZDVV2I
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 17:28:08 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:7728 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379AbZDVV2H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 17:28:07 -0400
Received: by wf-out-1314.google.com with SMTP id 26so162686wfd.4
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 14:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=gLEPvR5MX4rjYPeC8HLfuD8aU0lJQnQzE/rmrXP3FS8=;
        b=bap5LS15RfoboS2Mnh5Q3MfwSC2pwHc2AHEnRhqVTsHEstX6XKo14NXSjoGhkVQPat
         AM5UuIEzrL/9dtguBPTh1j9/aSQSh+wD4Jq/RJMpAvvjDnjW6X/ZbHm/o2vUc+yT4WnP
         IrHa9LJSITQeBiTTTU/oY7BHRa8/rSNkeQmK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=bp/yET9wVnULuEqGGEkvUwNlxLLu7Ab7rkUgjq55YvxLACZtWnuF49wyzE0KPI6CRZ
         vTkvaC972Z4AOSGLVhNH/wQu7/8b1aNoVbsWuCzs6hlF1XsnFxcRxWuGPpJ4BjCIbjvG
         gXNt2gE+z1BmriomGJXUjfKP51BlbWjTqjqS4=
Received: by 10.142.221.11 with SMTP id t11mr72421wfg.115.1240435685357;
        Wed, 22 Apr 2009 14:28:05 -0700 (PDT)
Received: from linux.vnet (pool-71-185-49-127.phlapa.fios.verizon.net [71.185.49.127])
        by mx.google.com with ESMTPS id 29sm904165wfg.15.2009.04.22.14.28.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Apr 2009 14:28:04 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org, Teemu Likonen <tlikonen@iki.fi>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20090422193838.GA1841@linux.vnet>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117269>

An off by one error was causing octopus merges with 3 parents to not be
rendered correctly.  This regression was introduced by 427fc5.

Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
---
 graph.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/graph.c b/graph.c
index 31e09eb..b7879f8 100644
--- a/graph.c
+++ b/graph.c
@@ -852,7 +852,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct strbuf *sb)
 			graph_output_commit_char(graph, sb);
 			chars_written++;
 
-			if (graph->num_parents > 3)
+			if (graph->num_parents > 2)
 				chars_written += graph_draw_octopus_merge(graph,
 									  sb);
 		} else if (seen_this && (graph->num_parents > 2)) {
-- 
1.5.6.3
