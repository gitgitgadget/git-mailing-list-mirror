From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] tree_entry_interesting: make recursive mode
 default
Date: Wed, 18 Jan 2012 15:59:52 +0700
Message-ID: <20120118085951.GA704@duynguyen-vnpc.dek-tpc.internal>
References: <1326341371-16628-1-git-send-email-pclouds@gmail.com>
 <1326533003-19686-1-git-send-email-pclouds@gmail.com>
 <1326533003-19686-2-git-send-email-pclouds@gmail.com>
 <7v8vl9wtfg.fsf@alter.siamese.dyndns.org>
 <20120115100327.GA10735@do>
 <7v1uqzwaxs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 10:00:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnRNM-0000SI-RJ
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 10:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756643Ab2ARJAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 04:00:05 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63190 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756547Ab2ARJAD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 04:00:03 -0500
Received: by iagf6 with SMTP id f6so5678151iag.19
        for <git@vger.kernel.org>; Wed, 18 Jan 2012 01:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tPDwC+ymqhhZKW4hFMTtylX5jycFLUY8Aq8yT51vYNQ=;
        b=qNINB4w43neO6cDXtyUa5Gbq9SRwRo6RzdYE808ZAs2XXveCj07aw7nn/gJ8cN64Hy
         M6D6SAohcmRb7ZNPbld2GTOHVL2UNSmwMn9poQD/YA+AWawRc2fPAul8fxMLcUK6mDLB
         YaqWtk+Kkgaqc9p785pKIr83FSraVXs5+hRnw=
Received: by 10.50.178.106 with SMTP id cx10mr3596401igc.15.1326877203119;
        Wed, 18 Jan 2012 01:00:03 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id va6sm43487401igc.6.2012.01.18.00.59.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Jan 2012 01:00:00 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 18 Jan 2012 15:59:52 +0700
Content-Disposition: inline
In-Reply-To: <7v1uqzwaxs.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188742>

On Mon, Jan 16, 2012 at 02:15:59PM -0800, Junio C Hamano wrote:
> Yeah, the logic of this correction is very clear. Because diff_cache is
> about walking a flat index, the "recursive pathspec" that allows us to
> look into deeper levels in directory hierarchy should be set, and also we
> should not be limiting the depth of the match in any way by setting the
> max_depth to "unlimited".

For the record, enabling wildcard in git-log is just as simple. But I
guess you don't want more changes this late in rc cycles.

-- 8< --
diff --git a/revision.c b/revision.c
index 064e351..c426271 100644
--- a/revision.c
+++ b/revision.c
@@ -1816,6 +1816,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	if (revs->prune_data.nr) {
 		diff_tree_setup_paths(revs->prune_data.raw, &revs->pruning);
+		revs->pruning.pathspec.recursive = 1;
+		revs->pruning.pathspec.max_depth = -1;
 		/* Can't prune commits with rename following: the paths change.. */
 		if (!DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
 			revs->prune = 1;
-- 8< --

--
Duy
