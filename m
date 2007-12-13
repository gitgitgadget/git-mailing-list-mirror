From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit RFC] Make "stg branch -l" faster by getting all git config information in one call
Date: Thu, 13 Dec 2007 17:08:55 +0100
Message-ID: <87bq8ur2zs.fsf@lysator.liu.se>
References: <20071213133653.13925.89254.stgit@krank>
	<b0943d9e0712130604r6daf05d5n7afbadfe23831839@mail.gmail.com>
	<87lk7yr7ib.fsf@lysator.liu.se>
	<b0943d9e0712130738s18ad303fu17a8412097377900@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 17:09:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2qcR-0002rO-SN
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 17:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850AbXLMQIm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Dec 2007 11:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753218AbXLMQIm
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 11:08:42 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:45074 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbXLMQIk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Dec 2007 11:08:40 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 788F6200A1F8;
	Thu, 13 Dec 2007 17:08:39 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 27945-01-37; Thu, 13 Dec 2007 17:08:38 +0100 (CET)
Received: from krank (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 0BAE8200A1ED;
	Thu, 13 Dec 2007 17:08:37 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 233417B4077; Thu, 13 Dec 2007 17:08:55 +0100 (CET)
In-Reply-To: <b0943d9e0712130738s18ad303fu17a8412097377900@mail.gmail.com> (Catalin Marinas's message of "Thu\, 13 Dec 2007 15\:38\:32 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68166>

"Catalin Marinas" <catalin.marinas@gmail.com> writes:

> BTW, have you run stg-prof to check where it spends most of the time?
> Is it caused by Python object creation or GIT calls invoked during th=
e
> Series objects initialisation. If the latter, we can turn some
> variables into properties and access them lazily.

I ran with STG_SUBPROCESS_LOG=3Ddebug and noticed that there were four
invokations of git for each branch it listed, in addition to the ten
invokation before it even starts to list the branches.

So I focused on replacing those 4xN invokations with 2 invokations,
and it helped a lot.  But I'm sure there are still lots of things to
improve.

Actually, I didn't know about stg-prof.

--=20
David K=C3=A5gedal
