From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Am able to delete a file with no trace in the log
Date: Wed, 03 Jun 2009 15:38:00 -0700
Message-ID: <7vmy8p54fr.fsf@alter.siamese.dyndns.org>
References: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net>
	<20090602213439.GA7584@coredump.intra.peff.net>
	<alpine.LFD.2.01.0906021439030.4880@localhost.localdomain>
	<7vfxeidqoz.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.01.0906022000040.4880@localhost.localdomain>
	<7vtz2x6mor.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.01.0906031431100.4880@localhost.localdomain>
	<7v8wk96knh.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.01.0906031504080.4880@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Graham Perks <gperks@ausperks.net>,
	Git List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 04 00:38:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBz6D-0001av-As
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 00:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686AbZFCWiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 18:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754180AbZFCWiA
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 18:38:00 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:50830 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138AbZFCWh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 18:37:59 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090603223801.SZXQ25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Wed, 3 Jun 2009 18:38:01 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id zae11b0014aMwMQ04ae1aG; Wed, 03 Jun 2009 18:38:01 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=vab_pU7WfN8A:10 a=vn0Xwkm_Dc8A:10
 a=Z4Rwk6OoAAAA:8 a=Bw-F5B6SDSn7isechK4A:9 a=R5bpOZfdwVTqvZNp-LmZaifEF7EA:4
 a=jbrJJM5MRmoA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.LFD.2.01.0906031504080.4880@localhost.localdomain> (Linus Torvalds's message of "Wed\, 3 Jun 2009 15\:17\:49 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120656>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> For example, right now there is _no_ way to get even a "show diff relative 
> to first parent". You can do "-m", which will show it relative to _both_ 
> parents, but nobody ever wants that. And you can do "-c" or "--cc", but 
> that simplifies away all the paths that match in one. 

Actually for that "Where did my file 'x' go across the merge chain", I was
going to suggest something like

	git log --simplify-merges -m --raw -- x

> So here's a challenge: in the git repository, get a nice view of what your 
> merges looked like. The closest I can get is
>
> 	git log -c --stat --grep="Merge branch '"
>
> which is actually very non-intuitive ("-c" on its own gives no useful 
> output, but "-c --stat" gives nice diffstat against the first parent, 
> which in this case is what we want).

I think the logical place to hook that into is the --first-parent option.

I actually have very hard resisted so far the temptation to do so because
your mantra has always been "in a merge, all parents are equal."  If you
treat the first parent specially too heavily, it would go against the "I
got a pull request from you, but the resulting conflicts are too much for
me; you know the area much better than I do, so could you do the merge for
me and I'll fast forward to you later" workflow.  The "first parent is the
mainline" and "I am important, so I'll merge with --no-ff to pee in the
snow" mentality problems will become worse.
