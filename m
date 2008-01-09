From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] sideband.c: Use xmalloc() instead of variable-sized
 arrays.
Date: Wed, 09 Jan 2008 08:34:55 +0100
Message-ID: <4784791F.6090904@viscovery.net>
References: <4783A3B2.3060801@viscovery.net> <alpine.LFD.1.00.0801081154460.3054@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jan 09 08:35:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCVTB-0001D3-3y
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 08:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbYAIHe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 02:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbYAIHe6
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 02:34:58 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:14086 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbYAIHe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 02:34:57 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JCVSh-0000C1-Su; Wed, 09 Jan 2008 08:34:56 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5BCD14E4; Wed,  9 Jan 2008 08:34:55 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.LFD.1.00.0801081154460.3054@xanadu.home>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69959>

Nicolas Pitre schrieb:
> On Tue, 8 Jan 2008, Johannes Sixt wrote:
>> How come we got along with this not very portable construct for so long?
>> Probably because the array sizes were computed from the results of
>> strlen() of string constants.
> 
> Maybe because it isn't not so unportable anymore?  I doubt that 
> compilers that don't know about automatic arrays would be smart enough 
> to notice the variable was actually a constant due to the strlen() of a 
> constant string and just do like if there wasn't any variable for the 
> array size.

I just tried it with Visual Age 6, and got this:

    CC sideband.o
"sideband.c", line 22.18: 1506-195 (S) Integral constant expression with a
value greater than zero is required.
"sideband.c", line 62.51: 1506-195 (S) Integral constant expression with a
value greater than zero is required.
make: *** [sideband.o] Error 1

But before I got to this point I had to change all 'static inline' in
git-compat-util.h to plain 'static'. So this compiler is out of the game
anyway.

Having said that, I'd actually prefer to stay with variable-sized arrays
if they prove portable enough because we don't need the handful of free()s
on function exits. Junio, if you like I can resend patch 2/2 using
variable-sized arrays.

-- Hannes
