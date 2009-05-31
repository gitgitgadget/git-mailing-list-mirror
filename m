From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] http*: cleanup slot->local after fclose
Date: Sun, 31 May 2009 13:21:53 -0700
Message-ID: <7vws7xqazi.fsf@alter.siamese.dyndns.org>
References: <49F1EA6D.8080406@gmail.com> <20090530091755.GA13578@localhost>
	<be6fef0d0905300231k5167f3efle9a450419bdfa1cb@mail.gmail.com>
	<20090530093717.GA22129@localhost>
	<be6fef0d0905300352o33694420m9c988daa554420a3@mail.gmail.com>
	<20090530230153.527532b0.rctay89@gmail.com>
	<20090531000955.953725d9.rctay89@gmail.com>
	<7vy6sdssnk.fsf@alter.siamese.dyndns.org>
	<20090531175413.962a55c3.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 22:22:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MArXd-0002Xh-PE
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 22:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbZEaUVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 16:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbZEaUVx
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 16:21:53 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:47289 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbZEaUVw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 16:21:52 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090531202155.ORQK17135.fed1rmmtao104.cox.net@fed1rmimpo03.cox.net>;
          Sun, 31 May 2009 16:21:55 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id yLMt1b00j4aMwMQ04LMtpK; Sun, 31 May 2009 16:21:54 -0400
X-Authority-Analysis: v=1.0 c=1 a=n6gMUD2reQ4A:10 a=OUZzaqIY_TkA:10
 a=pGLkceISAAAA:8 a=4dcVyFbS_mEAgN_YMrMA:9 a=RmA7pLP9Syz_LwwsadLgTbCAQooA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <20090531175413.962a55c3.rctay89@gmail.com> (Tay Ray Chuan's message of "Sun\, 31 May 2009 17\:54\:13 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120429>

Tay Ray Chuan <rctay89@gmail.com> writes:

> I tested this on top of the first 4 patches in 'rc/http-push' in 'pu',
> applied on 'maint'. [1] I wonder if this should instead be queued for
> 'pu' [2], since the issue only occurs there, although, conceivably, it
> *could* happen without those patches in 'pu'.

That "*could*" leaves me puzzled even more.  Could you clarify?

Do you mean "earlier, nobody tried to fclose(slot->local) twice, but with
the four patches there are codepaths that do so, which triggered the bug
reported by Clemens"?  But then the issue couldn't have happened without
those patches.

If existing code always knew when slot->local is and is not valid without
having to rely on its NULLness, and that was the reason why nobody tried
to fclose(slot->local) twice, then I'd agree that it is a bug waiting to
happen, and stuffing NULL to slot->local after the code fclose() it would
be a good clean-up.
