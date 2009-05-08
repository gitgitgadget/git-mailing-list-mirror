From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [JGIT PATCH 2/2] Make Repository.isValidRefName compatible with Git 1.6.3
Date: Thu, 07 May 2009 17:32:51 -0700
Message-ID: <7vprekbfik.fsf@alter.siamese.dyndns.org>
References: <1241708714-20326-1-git-send-email-spearce@spearce.org>
	<1241708714-20326-2-git-send-email-spearce@spearce.org>
	<200905080102.44053.robin.rosenberg@dewire.com>
	<alpine.LFD.2.01.0905071620240.4983@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 08 02:34:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2E2s-00013y-2Q
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 02:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764112AbZEHAcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 20:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764434AbZEHAcw
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 20:32:52 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:32929 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763019AbZEHAcv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 20:32:51 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090508003252.HNLW25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Thu, 7 May 2009 20:32:52 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id ooYr1b00Y4aMwMQ04oYrwZ; Thu, 07 May 2009 20:32:51 -0400
X-Authority-Analysis: v=1.0 c=1 a=Hwtzs_DYo44A:10 a=QdEgTBmxRvwA:10
 a=Z4Rwk6OoAAAA:8 a=Tn-16uqiWoX9ne6tAiAA:9 a=CGut7lS5zO_y0qaBYsUA:7
 a=_w4e9DVTkx_s6oADGoe-noMFArwA:4 a=jbrJJM5MRmoA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.LFD.2.01.0905071620240.4983@localhost.localdomain> (Linus Torvalds's message of "Thu\, 7 May 2009 16\:29\:21 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118549>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 8 May 2009, Robin Rosenberg wrote:
>> 
>> In 3e262b95c509 I taught C Git to disallow refs whose names end in
>> ".lock".
>
> Btw, I think we should revert that, and instead change our naming for 
> lock-files.
>
> It's a silly limitation, and for a stupid reason, I think. I can well 
> imagine people using a branch naming policy of using '.' instead of 
> spaces, and then It makes perfect sense to call a branch "fix.vm.lock" 
> when you have a VM locking issue you want to fix.
>
> So I think we should remove that stupid "*.lock" rule from the C version 
> (and then obviously from the JGIT one too).
>
> Now, that leaves what we _should_ call the lock-files, and the only sane 
> thing to do is to pick a sequence that is already invalid for other 
> reasons. We could make the lockfile end in "..lock", for example (".." is 
> not legal in names due to the confusion with the "a..b" range notation), 
> or just end or begin with a "." (same issue, except "..." now).
>
> Or just make it end in '~' which is also invalid for similar reasons.

I was tempted to go for the tilde, but then realized that

	.git/config~

is a common thing to have in a repository owned by an Emacs user, and we
do create with O_CREAT, so it is not such a good idea.

'..lck' may be a good name to use here.
