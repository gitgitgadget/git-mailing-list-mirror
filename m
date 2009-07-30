From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Null deref in recursive merge in
 df73af5f667a479764d2b2195cb0cb60b0b89e3d
Date: Thu, 30 Jul 2009 10:00:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907300958430.4589@intel-tinevez-2-302>
References: <D5F958F92101F74D8A5683C2FE14F4200F23102F@post.corp.w3data.com> <C695A6A4.61CD9%jbenjore@whitepages.com> <7vtz0uk5z3.fsf@alter.siamese.dyndns.org> <7viqhaipg0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <frekui@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>, Git <git@vger.kernel.org>,
	Josh ben Jore <jbenjore@whitepages.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 10:01:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWQZY-0003z3-PN
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 10:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbZG3IBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 04:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbZG3IBA
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 04:01:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:50877 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750938AbZG3IA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 04:00:59 -0400
Received: (qmail invoked by alias); 30 Jul 2009 08:00:58 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp066) with SMTP; 30 Jul 2009 10:00:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+UcYwn4ZeUJZTlvw4fFoVsmpHViLtbAv1lYd6a62
	TJJ7RZrrHEuFli
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7viqhaipg0.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124450>

Hi,

On Thu, 30 Jul 2009, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > The codepath saw that one branch renamed dev-ubuntu/ stuff to dev/ at 
> > that "unmerged" path, while the other branch added something else to 
> > the same path, and decided to add that at an alternative path, and the 
> > intent of that is so that it can safely resolve the "renamed" side to 
> > its final destination.  The added update_file() call is about 
> > finishing that conflict resolution the code forgets to do.
> 
> By the way, (I am CC'ing Fredrik, the author of the merge-recursive.py,
> the original implementation, even though I haven't seen him around here
> for a long time. Two "thieves" are also CC'ed), I think the way recursive
> strategy tries to handle rename/add and rename/rename conflicts by coming
> up with a temporary pathname is fundamentally wrong.
> 
> If our branch (stage #2) added by renaming and their branch (stage #3)
> added by creating the same path, why can't we simply leave these two
> stages in unmerged state without funny "unique_path()" renaming?

AFAIR we could not leave the two in unmerged state because the "recursive" 
part of the recursive merge demands that we be able (at the intermediate 
merges) to write a tree.

But I agree that coming up with unique paths is wrong: if it is a 
rename/rename conflict, it should be

	<<<<<<<
	=======
	<file1>
	>>>>>>>

for one and

	<<<<<<<
	<file2>
	=======
	>>>>>>>

for the other rename target.

Ciao,
Dscho
