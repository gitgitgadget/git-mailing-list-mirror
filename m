From: David Reitter <david.reitter@gmail.com>
Subject: git-log - hide parent (was: merging two equivalent branches)
Date: Thu, 7 Jan 2010 16:16:05 -0500
Message-ID: <DF05F91F-CBFD-458A-A99F-79E98ACA5146@gmail.com>
References: <B0543B3C-C139-4BD3-B028-58B4DA132422@gmail.com> <46d6db661001071022t79ca65foac249d948a20c328@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org, Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 22:16:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSziL-0002R8-4L
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 22:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611Ab0AGVQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 16:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753585Ab0AGVQM
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 16:16:12 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:59666 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab0AGVQK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2010 16:16:10 -0500
Received: by yxe26 with SMTP id 26so18090283yxe.4
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 13:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-type:mime-version
         :subject:from:in-reply-to:date:content-transfer-encoding:message-id
         :references:to:x-mailer;
        bh=KknzDAGaj0STs99TAC+v0ivMDv2vkOsZkfgqRP9tXBI=;
        b=gASkDu7MWkLFMKn6sfvjBaSW7BEjhSmZasDs99fmnLEuD+h/CpeJg761nqOy8EhwoA
         oILsf09J7pA5HPZ+QhxfUR5O0r8XmmSCQPp0U+rHhBXHfKePc585tYbQWgrRLR/3U2xV
         nSyn3Z0MT5Wis8Wg0n+z6jUZxAFImKi7H1S5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=Z48UGg4MsDUvgvidfO90pi7+qwQ1lSBNchaI8ZpjzBQTtqDIMu+l/8WDV4whPC8gYo
         VpEPltaKI9v3irpFvF4mKAM+PlIUnPNH9iyc3CdyBug5+lid3dvQ4kDKwGIrB2vd/GhP
         nvCWQY7XgPI1fHeWYF60UlNqRCEUDj/1KGlQU=
Received: by 10.150.48.7 with SMTP id v7mr32905546ybv.330.1262898969673;
        Thu, 07 Jan 2010 13:16:09 -0800 (PST)
Received: from cmu-365842.wv.cc.cmu.edu (CMU-365842.WV.CC.CMU.EDU [128.237.225.56])
        by mx.google.com with ESMTPS id 23sm8981078yxe.54.2010.01.07.13.16.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Jan 2010 13:16:08 -0800 (PST)
In-Reply-To: <46d6db661001071022t79ca65foac249d948a20c328@mail.gmail.com>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136387>

On Jan 7, 2010, at 1:22 PM, Christian MICHON wrote:
> I recall asking a similar question in 2008, and the answer was to look
> at "git graft" and use "git filter-branch" to recreate history.

Thanks, I've tried that and I recall that filter-branch wasn't willing to rewrite just the recent history - at least in started going over all 100k revisions at a very slow pace.  

I'm still unsure how, after the filter-branch, I would have some ancestor from the B series so that future pulls from the remote work, while having an ancestor from A, to make sure I can continue merging into C.  If history is rewritten, I'll get new revisions and lose ancestors.  
I'm beginning to thing that the cutting and pasting I'd like is conceptually impossible.

So what one would need is to specify a "silent parent" for a revision that is relevant w.r.t. future three-way merges, but indicates that the history behind the silent parent is irrelevant and shouldn't be shown in a git-log.  The runaway parent would be guaranteed to _not_ contribute any content to the tree of the child revision, as is the case with a "merge ours".

This could be implemented as a way to mark a parent as silent (checked by git-log at least), but one could also allow for an empty commit that, while having a normal parent, clears out the tree. 

Let me know if this idea is completely crazy. 