From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Allow update hooks to update refs on their own
Date: Tue, 27 Nov 2007 18:40:38 -0800
Message-ID: <49EB8C6F-8100-48C1-BB2D-A8F6023BACAD@midwinter.com>
References: <20071127211730.GA11861@midwinter.com> <7v4pf7b20b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 13:36:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKwO-0004cY-N1
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:18:52 +0100
Received: from mail-mx9.uio.no ([129.240.10.39])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxCzN-0005PF-JO
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 03:49:25 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx9.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxCy8-00052N-QE
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 03:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760120AbXK1Ckk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 21:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760111AbXK1Ckk
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 21:40:40 -0500
Received: from tater.midwinter.com ([216.32.86.90]:43258 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756627AbXK1Ckj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 21:40:39 -0500
Received: (qmail 31982 invoked from network); 28 Nov 2007 02:40:39 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=n5DDeihgmSLZosqN8DoMUXZ8clCgDZCuGCCafJuFchNaP8WX/PXpWRzR7o3IYmyD  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 28 Nov 2007 02:40:39 -0000
In-Reply-To: <7v4pf7b20b.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 195FFD76B156A0E2BD831F3971E99DD49828321E
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 200 minaction 2 bait 0 mail/h: 85 total 723707 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66305>

On Nov 27, 2007, at 5:19 PM, Junio C Hamano wrote:

> How does this interact with the "pretend to have fetched back
> immediately" supported by modern git-push?


That continues to fire, but it updates the local tracking ref to point  
to the SHA1 that was pushed, which isn't the actual remote ref. So you  
have to do a real fetch to get the local tracking ref pointed to the  
right place. In other words, that feature doesn't do any good in this  
context, but it doesn't really hurt anything either.

It would of course be better if git-push could notice that it needs to  
do an actual fetch. I think it'd be sufficient to transmit the final  
remote ref SHA1 back to git-push, and if it doesn't match what was  
pushed, that's a sign that a fetch is needed. But that change wouldn't  
be mutually exclusive with this patch, I believe.

-Steve
