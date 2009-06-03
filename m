From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Am able to delete a file with no trace in the log
Date: Wed, 03 Jun 2009 14:18:28 -0700
Message-ID: <7vtz2x6mor.fsf@alter.siamese.dyndns.org>
References: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net>
	<20090602213439.GA7584@coredump.intra.peff.net>
	<alpine.LFD.2.01.0906021439030.4880@localhost.localdomain>
	<7vfxeidqoz.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.01.0906022000040.4880@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Graham Perks <gperks@ausperks.net>,
	Git List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 23:18:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBxr3-00043d-P7
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 23:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbZFCVS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 17:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbZFCVS1
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 17:18:27 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:43687 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712AbZFCVS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 17:18:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090603211829.GGBB20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 3 Jun 2009 17:18:29 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id zZJU1b00G4aMwMQ03ZJU8C; Wed, 03 Jun 2009 17:18:28 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=vab_pU7WfN8A:10 a=vn0Xwkm_Dc8A:10
 a=Z4Rwk6OoAAAA:8 a=-PCvCSRZz5A7kvd7dfQA:9 a=xzYjbD7ZnOQgDdjLw5cA:7
 a=g_uATQqdHd245c7c2997UKLI-VsA:4 a=jbrJJM5MRmoA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.LFD.2.01.0906022000040.4880@localhost.localdomain> (Linus Torvalds's message of "Tue\, 2 Jun 2009 20\:03\:31 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120644>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 2 Jun 2009, Junio C Hamano wrote:
>> 
>> Sorry, but I do not quite understand this comment.  REV_TREE_NEW can be
>> treated differently from REV_TREE_DIFFERENT but that only happens if you
>> know about --remove-empty option, and no scripted (and later converted to
>> C) Porcelain uses that option by default.
>
> It's not REV_TREE_NEW, but the other way around, ie when the commit has no 
> contents but the parent _does_ have contents, maybe we shouldn't then look 
> at another parent and say "no content", and then match that other parent 
> (resulting in no difference).
>
> IOW, we are in the situation where one parent gets REV_TREE_SAME, but gets 
> it for a totally pointless reason, namely that neither that parent nor the 
> eventual merge has anything at all in that path. In that case, we simplify 
> towards the parent that results in the smallest diff - which in this case 
> is "nothing there at all".
>
> Now, that is often the _right_ thing to do, since if it was meant to be 
> deleted in that branch, then we'll eventually hit the delete commit, and 
> see it as a nice removal. But it does make it really hard to see this case 
> of "unintentional delete"

I realize that "--simplify-merges" would show that kind of deletion.

E.g. "git log --graph --oneline -- git-clone.sh" shows that the scripted
version ceased to exist at 8434c2f (Build in clone, 2008-04-27), but with
the option, b84c343 (Merge branch 'db/clone-in-c', 2008-05-25) merged the
deletion to the mainline, but while doing so we lost two updates to the
scripted version since the "Build in clone" topic forked.
