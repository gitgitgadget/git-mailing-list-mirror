From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC v2 0/16] Introduce index file format version 5
Date: Wed, 8 Aug 2012 17:30:54 +0700
Message-ID: <CACsJy8BR219A8jE=pf1dK574wG1YLkjjQJiOvUdNt1wY=q4adw@mail.gmail.com>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344263760-31191-1-git-send-email-pclouds@gmail.com> <7vehnjzzfd.fsf@alter.siamese.dyndns.org>
 <87393yz64x.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu, robin.rosenberg@dewire.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 08 12:32:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz3YX-0005ph-OE
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 12:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767Ab2HHKb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 06:31:26 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:56283 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab2HHKbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 06:31:25 -0400
Received: by qcro28 with SMTP id o28so310989qcr.19
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 03:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8lSQTjAvDiDEUs8nUUKOa1kOgZwQGDAzutVHZlJN1xQ=;
        b=NOoo3kGzfwdC1Nf/VAh0Vd1jIQz7XnwsDmHnDVTnWSNn18oq/6YUirmuElt2EUkCPf
         NClHiQYx4PfKXmda5enX4UEfwzTbcZXlBlrkHIg8JwexKG8dMyTwTNxPEcvAzOkaEqDy
         JakgMxKuoSTbTr/1F1A3YfO1lYM9r4vST3FGtY0sdyKPxAF4lP+aiQdZc7pQa/icyC0q
         34tNoSdTDs1diGq18v3WAYQkjUolZQeV7kffC0B5XTioTQHBN1sTodrreyT/b5OkBjcS
         EfpXceGLK02YiJ73TDRYag4ZcN7h7zdeRjcsGG66BVHVpNronuQ75a3fba5k3BjD1Zme
         4Egg==
Received: by 10.224.188.83 with SMTP id cz19mr28976393qab.23.1344421884848;
 Wed, 08 Aug 2012 03:31:24 -0700 (PDT)
Received: by 10.49.84.73 with HTTP; Wed, 8 Aug 2012 03:30:54 -0700 (PDT)
In-Reply-To: <87393yz64x.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203070>

On Wed, Aug 8, 2012 at 5:31 AM, Thomas Rast <trast@student.ethz.ch> wrote:
> Thomas and me -- it was mostly my bad idea -- spent some time going
> through all the loops that iterate over the index.  You can get some
> taste of it with 'git grep ce_stage', mostly because many of them either
> skip unmerged entries or specifically look for them.  There are subtle
> differences between the loops on many points: what do they do when they
> hit an unmerged entry?

Most of them ignore unmerged entries, git-add and git-update-index can
remove unmerged entries, unpack-trees (reset, merge, checkout...) can
generate them. What's the problem with it?

> Or a CE_REMOVED or CE_VALID one?

CE_VALID is assume-unchanged feature. I don't think we have problems with it.

CE_REMOVED is to say "we are going to remove this entry both in index
and worktree, but if we remove it now we would have no way to know
which file in worktree to be removed later on, so we just mark it here
as a ghost entry in index". It's only used by unpack-trees, I think.
From the index pov, CE_REMOVED entries never get written to file. It
may complicate tree building for v5.
-- 
Duy
