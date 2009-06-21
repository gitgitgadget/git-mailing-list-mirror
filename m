From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t8005: Nobody writes Russian in shift_jis
Date: Sun, 21 Jun 2009 03:07:53 -0700
Message-ID: <7vfxdtsxvq.fsf@alter.siamese.dyndns.org>
References: <7vmy85m0ea.fsf@alter.siamese.dyndns.org>
	<dfYgk9RFOucTCHxtLQsMXejAeKlGJg-R15sTW_RFemcrjsjqoYD0eg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexander Gavrilov <angavrilov@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sun Jun 21 12:08:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIJxz-0007kX-D2
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 12:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbZFUKHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 06:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752890AbZFUKHw
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 06:07:52 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:41257 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbZFUKHw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 06:07:52 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090621100755.OMTE17135.fed1rmmtao104.cox.net@fed1rmimpo03.cox.net>;
          Sun, 21 Jun 2009 06:07:55 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 6a7u1c0014aMwMQ04a7uGc; Sun, 21 Jun 2009 06:07:54 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=MJEhyv7PRzEA:10 a=wyaIiRIpK6ITIGPCivMA:9
 a=_AQA1e_J4M3ESyZ0TQ2ZOLsddXoA:4
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121982>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> No change on my systems.  I can convert eucJP and SJIS from/to UTF-8, but
> I cannot convert between eucJP and SJIS.

I wonder what's different, but I suspect having lang-support-japanese
package on the box perhaps is helping me.

> So tests 2 and 3 still fail for
> me.  Nothing was broken though.  The fourth test still passes which converts
> each of the encodings to UTF-8.  So this patch is fine with me.

Yikes, so it does not really help by itself.  Taken together with
Alexander's comment that he did manage to send Russian in Shift_JIS (I
somehow do not think Alexander used Solaris for that, though; neither have
I any clue if the receiving end grokked that), perhaps the patch is
useless.

Even though I do not think if any Russian writes in KOI8-R and converts to
Shift_JIS on purpose, converting eucJP directly to SJIS is something
Japanese people who are on UNIX do quite often, or at least used to before
everybody moved to UTF-8.

Perhaps we should instead optionally help platform's iconv(3), when it
cannot convert A to B directly, by pivoting the conversion on UTF-8
(i.e. A -> UTF-8 -> B)?  That would probably help the real world use cases
while fixing the issue with this test script.
