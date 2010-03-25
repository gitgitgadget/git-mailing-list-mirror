From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] send-email: lazily assign editor variable
Date: Thu, 25 Mar 2010 09:03:18 +0100
Message-ID: <4BAB18C6.6010202@drmicha.warpmail.net>
References: <20100322145947.GA1709@pengutronix.de> <eb0d92cf28820eb9783e789a8c4c62c3af4dd0d0.1269274203.git.git@drmicha.warpmail.net> <7vaatxobef.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 09:06:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nui53-0001Rz-Vo
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 09:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277Ab0CYIGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 04:06:11 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:55490 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750906Ab0CYIGI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Mar 2010 04:06:08 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C5EBDE78FA;
	Thu, 25 Mar 2010 04:06:07 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 25 Mar 2010 04:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=i05kqeRW/BOzflaJjXtYGc0Hhdg=; b=EeKFaG0CC4mOhWVTpBtS9t4vmgpOol1guvPF63OwlSgewPrCTp/nQnkFj1LIZvcl9GryouQqNNrOs6WBnoohKC5bGbt7eQLpO+1g5IVRhVJFfarHHN3BWq1dzi0NgCuCKR9d1Jo0ZtIZFosEIqXuFWNaQhicuBA0ojBEImLs0y4=
X-Sasl-enc: ZFiyfg5hX02LUBwjr0VdxWgZo4JkoB9j3d9alqyC2vLu 1269504367
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E65A94BC1DC;
	Thu, 25 Mar 2010 04:06:06 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <7vaatxobef.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143168>

Junio C Hamano venit, vidit, dixit 24.03.2010 18:52:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> b4479f0 (add -i, send-email, svn, p4, etc: use "git var GIT_EDITOR",
>> 2009-10-30) introduced the use of git var GIT_EDITOR which may lead to
>> problems when send-mail is used without a tty.
> 
> We would want to describe what kind of problems they are better than "may
> lead to problems", though.  Something like this?
> 
>     b4479f0 (add -i, send-email, svn, p4, etc: use "git var GIT_EDITOR",
>     2009-10-30) introduced the use of "git var GIT_EDITOR" to obtain the
>     preferred editor program, instead of reading environment variables
>     themselves.
> 
>     However, "git var GIT_EDITOR" run without a tty (think "cron job") would

Also think "hook" ;)

>     give a fatal error "Terminal is dumb, but EDITOR unset".  This is not a
>     problem for add-i, svn, p4 and callers of git_editor() defined in
>     git-sh-setup, as all of these call it just before launching the editor.
>     At that point, we know the caller wants to edit, and they cannot without a
>     tty.
> 
>     But send-email ran this near the beginning of the program, even if it is
>     not going to use any editor (e.g. run without --compose).  Fix this by
>     calling the command only when we edit a file.
> 
> 

Yep, I'm fine with this.

Cheers,
Michael
