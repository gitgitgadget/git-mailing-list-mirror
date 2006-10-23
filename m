From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: git bisect with history manipulation
Date: Mon, 23 Oct 2006 17:21:37 +0100
Message-ID: <tnxlkn73svi.fsf@arm.com>
References: <a425f86c0610230718i556537dei9a4b2a5fa8d7f003@mail.gmail.com>
	<a425f86c0610230722r2a0ae473o467d303f915b6c1e@mail.gmail.com>
	<BAYC1-PASMTP01856E85F8D54BE3CBF69EAE000@CEZ.ICE>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kalle Pokki" <kalle.pokki@iki.fi>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 18:22:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc2Z7-00078D-VF
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 18:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWJWQWE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 12:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbWJWQWD
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 12:22:03 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:59023 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1751765AbWJWQWA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 12:22:00 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k9NGLdQb026078;
	Mon, 23 Oct 2006 17:21:39 +0100 (BST)
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Mon, 23 Oct 2006 17:21:39 +0100
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP01856E85F8D54BE3CBF69EAE000@CEZ.ICE> (seanlkml@sympatico.ca's
 message of "Mon, 23 Oct 2006 11:47:38 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 23 Oct 2006 16:21:39.0225 (UTC) FILETIME=[51720090:01C6F6BF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29842>

Sean <seanlkml@sympatico.ca> wrote:
> On Mon, 23 Oct 2006 17:22:41 +0300
> "Kalle Pokki" <kalle.pokki@iki.fi> wrote:
>
>> So is there any way to insert a few patches to an arbitrary point
>> backwards in time and start bisecting from that to the present time?
>> Or am I thinking this somehow all wrong?
[...]
> You could use the Stacked Git utility (which is a Quilt like clone
> built on top of Git) to help you along in this process.  Actually,
> you may be able to do the same thing with Quilt itself, but i don't
> know i've never used it.

It's on my todo list to actually add bisect support to StGIT (someone
suggested it on the mailing list) but I can't give any estimates about
when this would be done. The idea is that it will only bisect the base
and push the patches on top of the new tree (at a first though, it
doesn't look difficult at all).

Otherwise, use StGIT to manage the patches and the following sequence
for bisecting:

$ git bisect start
$ stg init
$ stg pick <patch@branch>
$ stg pick <patch@branch>
$ ...
$ stg pop -a
$ git bisect good v2.6.x
$ git bisect bad
$ stg push -a
$ ... test ...
$ stg pop -a
$ git bisect good|bad
$ stg push -a
$ ...

-- 
Catalin
