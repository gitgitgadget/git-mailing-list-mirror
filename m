From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: Libify puzzle
Date: Tue, 7 Mar 2006 16:40:26 +0100
Message-ID: <20060307154026.GA4457@c165.ib.student.liu.se>
References: <Pine.LNX.4.63.0603071151520.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 16:41:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGeIf-0005N2-Fv
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 16:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWCGPke (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 10:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWCGPke
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 10:40:34 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:1408 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1751250AbWCGPkd
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 10:40:33 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 22F5D4100; Tue,  7 Mar 2006 16:55:54 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FGeIU-0001GI-00; Tue, 07 Mar 2006 16:40:26 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0603071151520.14200@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17339>

On Tue, Mar 07, 2006 at 12:00:02PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> I was just thinking a bit about teaching git-blame about renames, and hit 
> a problem: When rev-list stops because none of the parents has the file of 
> interest, the program should look if the parents contained a similar file 
> which got deleted. But the commit's parents were explicitely culled!
> 
> The problem seems to affect more programs when we try to libify them: What 
> used to be a pipe between two programs, can no longer just set 
> save_commit_buffer = 0 in the first stage, since the second might depend 
> on the buffer.
> 
> Would the correct solution be something like reparse_commit(commit)?
> 

I have started on the rename support for git-blame but it isn't
working code yet.

My idea is to change the revision.h interface a bit. Instead having
the pathname pruning hard-coded in try_to_simplify_commit as it is
today we could have a pointer to a function in the rev_info structure
which is called the same way as try_to_simplify_commit is called
now. Then users of the revision walking interface could populate the
rev_info structure with their own try_to_simplify_commit-like
function. In the case of git-blame that function could then do the
appropriate rename detection.

Thoughts/comments?

- Fredrik
