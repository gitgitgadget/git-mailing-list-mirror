From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reverting an uncommitted revert
Date: Wed, 20 May 2009 23:16:17 -0700
Message-ID: <7vk54bc766.fsf@alter.siamese.dyndns.org>
References: <4A136C40.6020808@workspacewhiz.com>
	<alpine.LFD.2.00.0905192300070.3906@xanadu.home>
	<20090520032139.GB10212@coredump.intra.peff.net>
	<alpine.LFD.2.00.0905192328310.3906@xanadu.home>
	<025225A0-FACC-4A29-A747-40201A7FBA19@wincent.com>
	<alpine.LFD.2.00.0905200853010.3906@xanadu.home>
	<20090520141709.GO30527@spearce.org>
	<7vab57zmd8.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.00.0905201406280.3906@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>, Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu May 21 08:16:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M71Zq-0007dq-LL
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 08:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbZEUGQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 02:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbZEUGQR
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 02:16:17 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:37339 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbZEUGQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 02:16:16 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090521061617.OUZP20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Thu, 21 May 2009 02:16:17 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id u6GH1b00D4aMwMQ046GHMn; Thu, 21 May 2009 02:16:18 -0400
X-Authority-Analysis: v=1.0 c=1 a=6VC1-P1-AAAA:8 a=uy3BJzjmVHgcyDdf62kA:9
 a=7StXrWUCn8xhnnql1LZgP6WDuecA:4 a=LRnQQUT8V1QA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.LFD.2.00.0905201406280.3906@xanadu.home> (Nicolas Pitre's message of "Wed\, 20 May 2009 14\:19\:09 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119657>

Nicolas Pitre <nico@cam.org> writes:

>>  (1) When would you "auto" write-tree?  When you do "git add" or anything
>>      that adds new contents to the index?  Or immediately before you do
>>      something destructive like "git reset"?  Or perhaps both?
>
> Delaying any IO until it is clear that something is to be discarded is 
> the best approach performance wise.  So perhaps not on the first 'git 
> add' but certainly on the second one with an already cached path for 
> which new (different) content is going to replace previous content.

I hope that you are not forgetting that it costs cycles to determine "it
is clear that something is to be discarded".

The "diff-index --cached" optimization I did today may help, as it would
allow you to check with the last trash-log more cheaply, but it certainly
is not free.
