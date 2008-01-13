From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: performance problem: "git commit filename"
Date: Sun, 13 Jan 2008 14:31:32 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801131416540.13593@iabervon.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org> <alpine.LNX.1.00.0801130028460.13593@iabervon.org>
 <alpine.LFD.1.00.0801130850460.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kristian H?gsberg <krh@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 13 20:32:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE8Ys-0006dK-PP
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 20:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbYAMTbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 14:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752202AbYAMTbe
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 14:31:34 -0500
Received: from iabervon.org ([66.92.72.58]:47271 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbYAMTbe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 14:31:34 -0500
Received: (qmail 4412 invoked by uid 1000); 13 Jan 2008 19:31:32 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Jan 2008 19:31:32 -0000
In-Reply-To: <alpine.LFD.1.00.0801130850460.2806@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70409>

On Sun, 13 Jan 2008, Linus Torvalds wrote:

> On Sun, 13 Jan 2008, Daniel Barkalow wrote:
> > 
> > The only issue I know about with using unpack_trees in C as a replacement 
> > for read-tree in shell is that unpack_trees leaves "deletion" index 
> > entries in memory which are not written to disk, but may surprise some 
> > code (these are used to allow -u to remove the files from the working 
> > tree).
> 
> I certainly agree that this patch should be double-checked. I'm pretty 
> sure the issue you mention wouldn't be an issue, since the end result is 
> only used for actually updating the index and writing it out as a tree 
> (both of which should handle the magic zero ce_mode case ok), but it would 
> certainly be good to walk through all cases.

Yeah, I didn't think it would be an actual problem, but verifying that 
requires looking outside of the context of the patch. It may even be worth 
putting in a comment for now, since I bet wt_status_print and run_status 
could be optimized in a way that would look perfectly reasonable (use 
the in-memory index, instead of reading a file) but would expose the 
magic case to the diff machinary, which (IIRC) doesn't handle it. But I 
agree (having now looked at the rest of builtin-commit) that the odd index 
entries can't escape, and this should be fine for 1.5.4.

	-Daniel
*This .sig left intentionally blank*
