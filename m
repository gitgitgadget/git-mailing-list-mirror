From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix off by one error in prep_exclude.
Date: Mon, 28 Jan 2008 08:12:30 +0100
Message-ID: <479D805E.3000209@viscovery.net>
References: <47975FE6.4050709@viscovery.net>	<1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com>	<alpine.LSU.1.00.0801272043040.23907@racer.site>	<7v3asiyk2i.fsf@gitster.siamese.dyndns.org>	<20080128003404.GA18276@lintop> <7vodb6wtix.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 08:13:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJOBE-0007Jh-DV
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 08:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbYA1HMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 02:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbYA1HMh
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 02:12:37 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:21760 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbYA1HMg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 02:12:36 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JJOAE-0002AY-44; Mon, 28 Jan 2008 08:12:18 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DFD17546; Mon, 28 Jan 2008 08:12:28 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vodb6wtix.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71854>

Junio C Hamano schrieb:
> Shawn Bohrer <shawn.bohrer@gmail.com> writes:
> 
>> Nope the problem Johannes Sixt was having was that he mistakenly ran
>>
>> git clean -n /*foo
>>
>> Now that isn't what he meant to do, but I figured it might be possible
>> that someone has their whole filesystem in a git repository, or maybe
>> is using some sort of chroot on their repository.  Your malformed
>> paths guess is probably much more likely to occur.
> 
> That is not a user error from the syntax point of view (although
> it might be from the semantics point of view).  I think the
> caller of the excluded() function (that is probably somewhere in
> builtin-clean.c -- I did not check) is responsible for not
> supplying such a path to the called function.

The "problem" is not only with git-clean, but also in others, like
git-ls-files. Try this in you favorite repository:

   $ git ls-files -o /*bin

The output does not make a lot of sense. (Here it lists the contents of
/bin and /sbin.) Not that it hurts with ls-files, but

   $ git clean -f /

is basically a synonym for

   $ rm -rf /

-- Hannes
