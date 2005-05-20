From: Ingo Molnar <mingo@elte.hu>
Subject: Re: gitk-1.0 released
Date: Fri, 20 May 2005 13:22:29 +0200
Message-ID: <20050520112229.GA5606@elte.hu>
References: <17036.36624.911071.810357@cargo.ozlabs.ibm.com> <20050519132411.GA29111@elte.hu> <17037.5109.556362.904185@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 13:22:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZ5Ze-0000ex-2b
	for gcvg-git@gmane.org; Fri, 20 May 2005 13:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVETLWo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 07:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVETLWo
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 07:22:44 -0400
Received: from mx2.elte.hu ([157.181.151.9]:18620 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261417AbVETLWl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 07:22:41 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id ABF1031C8C8;
	Fri, 20 May 2005 13:20:33 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 1D9711FC2; Fri, 20 May 2005 13:22:36 +0200 (CEST)
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
In-Reply-To: <17037.5109.556362.904185@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Paul Mackerras <paulus@samba.org> wrote:

> > (and the biggest missing feature of GIT right now is author + 
> > last-commit annotated file viewing which could be integrated into gitk 
> > a'ka BK's revtool: selecting a given line of the file would bring one to 
> > that commit, etc.)
> 
> Yes, indeed.  I'll have to think about how to do it in a responsive 
> fashion, since getting the necessary information involves reading all 
> the commits and all the tree objects back to the beginning of time, 
> AFAICS. [...]

i guess so. A possible solution seems to be to read every object 
starting at the oldest one (assuming it's possible to get a list of 
object IDs that are predecessors), and to split the oldest object up 
into 'line' objects, attaching the (same) object ID to every line. Then 
the algorithm would go forward in time and would process every diff from 
that point on, and would add/remove line objects, attaching the new 
object IDs as new lines get added. The resulting set of lines then 
contain all the metadata needed (== object ID they originate from).

i dont think other SCMs can do this much faster: you need to go back to 
the last (still relevant) version and have to process the deltas from 
that point on. Delta-based formats would be somewhat faster and easier 
to process, but probably not that much faster in terms of IO overhead.

	Ingo
