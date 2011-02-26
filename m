From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] doc: technical details about the index file format
Date: Sat, 26 Feb 2011 20:36:39 +0700
Message-ID: <20110226133639.GA32442@do>
References: <AANLkTi=iFe=MmUiXzC_HMwueZxLJDCea+zp_-SNWvSup@mail.gmail.com>
 <1283769430-9263-1-git-send-email-pclouds@gmail.com>
 <AANLkTi=YJkk6KHChCrrazij_ziyG-Ru7kGLWc7JnUGoN@mail.gmail.com>
 <AANLkTi=hz0xRsTy5f8xhzBhu0md_iPCxvdTrEPrzYwzt@mail.gmail.com>
 <20110226100310.GA21724@do>
 <7vsjvb6qmt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	kusmabite@gmail.com, raa.lkml@gmail.com, jjuran@gmail.com,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 26 14:38:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtKLp-0002eP-Bs
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 14:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059Ab1BZNiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 08:38:20 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:46815 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab1BZNiT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 08:38:19 -0500
Received: by pxi15 with SMTP id 15so396436pxi.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 05:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=VoTwN/RGszw3h5G/BLSygrglKAc9F7vndj0IqHxoF2Y=;
        b=LHwME4tf0sE/Qx98vxNyrou2GILcMho0Rh6q1uETj6WGPLr0fVwa7IpXx/dw5lXFbJ
         j+7lirC35ZTYB6CigNzqKX+ysFC9n9zub4A6a/vtI+fqzxzN1sEZDxxT3BcVlp/cPXrA
         QZwA+sN2nfTOzGHMQWXTY4p/MktIrkbG4sOBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eK/u2hcH3RV7ibkhsu+zlrbhJAbHRS4/IBC9yTPzwVCvEGz/giwCqXFEwZ5c11JuAl
         7s1bCZB0TjRbmPaIC4DqFg8Cp5PrXdmTb25F9l2Bw/MtsqmZp9b7kjQt7i/o4EwepSkz
         lpgRwjJ0s+i0jtJwxgBMAATWcdqYrjaVGCF1E=
Received: by 10.142.135.2 with SMTP id i2mr2562524wfd.408.1298727498784;
        Sat, 26 Feb 2011 05:38:18 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id z8sm2620564wfj.1.2011.02.26.05.38.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Feb 2011 05:38:17 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 26 Feb 2011 20:36:39 +0700
Content-Disposition: inline
In-Reply-To: <7vsjvb6qmt.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167984>

On Sat, Feb 26, 2011 at 02:23:38AM -0800, Junio C Hamano wrote:
> I lack energy to come up with a succinct description right now, so here is
> an undistilled version of what I would want to see the reader of the above
> paragraph understand:
> 
>     A set of entries for a path at higher stages (i.e. the ones that
>     represent a merge conflict at the path) used to be removed from the
>     index and replaced with the result of the resolution when the conflict
>     is resolved (e.g. with "git add path").  This extension saves these
>     higher stage entries away so that "checkout -m" and other operations
>     can recreate the conflicted state, in case you botched a conflict
>     resolution and want to redo it from scratch.
> 
> The description of the data contents looked fine, except that "A number of
> entries" felt a bit unclear (it would make the reader wonder if we record
> how many we have at that location as an integer, which is not the case).

OK another try. I also add more details to tree cache. If somebody
uses this document to create a git-compatible tool, then such a tool
should behave the way git expects it.

A related note. Because we store SHA-1s in resolve undo ext. fsck
should check these for reachability as well. I see fsck checks for
cache-tree only.

--8<--
diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index 5b1d70d..2a3490c 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -117,8 +117,12 @@ GIT index format
 
 === Tree cache
 
-  Tree cache extension contains pre-computes hashes for all trees that
-  can be derived from the index
+  Tree cache extension contains pre-computed hashes for trees that can
+  be derived from the index. It helps speed up tree object generation
+  from index for a new commit.
+
+  When a path is updated in index, the path must be invalidated and
+  removed from tree cache.
 
   - Extension tag { 'T', 'R', 'E', 'E' }
 
@@ -137,8 +141,25 @@ GIT index format
 
 === Resolve undo
 
-  TODO
+  A conflict is represented in index as a set of higher stage entries.
+  When a conflict is resolved (e.g. with "git add path"), these higher
+  stage entries will be removed and a stage-0 entry with proper
+  resoluton is added.
+
+  Resolve undo extension saves these higher stage entries so that
+  conflicts can be recreated (e.g. with "git checkout -m"), in case
+  users want to redo a conflict resolution from scratch.
 
   - Extension tag { 'R', 'E', 'U', 'C' }
 
   - 32-bit size
+
+  - A number of conflict entries
+
+    NUL-terminated conflict path
+
+    Three NUL-terminated ASCII octal numbers, entry mode of entries in
+    stage 1 to 3.
+
+    At most three 160-bit SHA-1s of the entry in three stages from 1
+    to 3. SHA-1 is not saved for any stage with entry mode zero.
--8<--
-- 
Duy
