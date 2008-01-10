From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] bundle, fast-import: detect write failure
Date: Thu, 10 Jan 2008 14:00:15 +0100
Message-ID: <87hchlhm3k.fsf@rho.meyering.net>
References: <874pdmhxha.fsf@rho.meyering.net>
	<alpine.LSU.1.00.0801101204120.31053@racer.site>
	<87myrdhnn5.fsf@rho.meyering.net>
	<alpine.LSU.1.00.0801101234580.31053@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 10 14:00:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCx1i-0001WJ-Sb
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 14:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135AbYAJNAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 08:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754170AbYAJNAS
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 08:00:18 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:35262 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753437AbYAJNAR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 08:00:17 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 1B3FC17B531
	for <git@vger.kernel.org>; Thu, 10 Jan 2008 14:00:16 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id BDC7A17B594
	for <git@vger.kernel.org>; Thu, 10 Jan 2008 14:00:15 +0100 (CET)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 84E2D589FD;
	Thu, 10 Jan 2008 14:00:15 +0100 (CET)
In-Reply-To: <alpine.LSU.1.00.0801101234580.31053@racer.site> (Johannes
	Schindelin's message of "Thu, 10 Jan 2008 12:37:56 +0000 (GMT)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70067>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Are you aware what this code does?  It writes a ".keep" file.  Whose
> purpose is to _exist_, and whose purpose is fulfilled, even if the write
> or the push-back did not succeed.

Hi,

I do see what you mean.

If the write is not necessary, then perhaps you would prefer a comment
documenting that failures of the write and following close are ignorable.
And add a '(void)' stmt prefix, to tell compilers that ignoring the
return value is deliberate.

However, even if it's not technically required to fail at that point,
if it were my choice, I'd prefer to know when a .keep file whose
contents are unimportant just happens to reside on a bad spot on my
disk.  I/O errors should never be ignored.

> I could not care less what the manual says.  What is important is if the
> defensive programming is done mindlessly, and therefore can fail so not
> gracefully.

On the other hand, if that write failure is truly ignorable,
a mindless minimalist :-) might argue that it's best just to
omit the syscall.
