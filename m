From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH next 2/2] Remove python 2.5'isms
Date: Thu, 10 Jun 2010 09:31:11 +0200
Message-ID: <4C1094BF.5070907@drmicha.warpmail.net>
References: <nduJYSHPH3U3cC4hTqPaVi-iLDqB7pemU3zevJMNRmyDsRKmtq_gVu-G9W-She7bPSFG9LafRk0@cipher.nrlssc.navy.mil> 	<nduJYSHPH3U3cC4hTqPaVieVkcHeedXMjA92T_KB9XTSNMZ0NeKHomHE5LPZ65BzOnHb--wYKXY@cipher.nrlssc.navy.mil> <AANLkTikmdsJwy06WuRwpLEKzZE45VZcvPDDxnW1OCb8K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	johan@herland.net, davvid@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 09:32:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMcFB-0001j0-94
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 09:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758621Ab0FJHby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 03:31:54 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:57300 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752633Ab0FJHbs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 03:31:48 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 94E4BF8946;
	Thu, 10 Jun 2010 03:31:47 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 10 Jun 2010 03:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=RJofD/6FFpPNrJ2HfTj086u6lXo=; b=hfNbT7RUutc3AH7bludf/7gplwK1jc9S5AOZA0GYPbgYzr7pTEmzJbUZSYropfTB6NdQSGgllyRYjwVTp5ysKk0uzkimi4MlNQmpOHST9+1Ndnghv5AZze6wn3liJ6bFl50LZof+tWI7MfnUS8x7HoINGcN86qZXx4h//v9x4Fg=
X-Sasl-enc: ecQgTMdjRdZJewK/wQ94QpeVZYUGlIe+StZldlbGPfrj 1276155107
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7EC164CED73;
	Thu, 10 Jun 2010 03:31:46 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100604 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <AANLkTikmdsJwy06WuRwpLEKzZE45VZcvPDDxnW1OCb8K@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148836>

Sverre Rabbelier venit, vidit, dixit 09.06.2010 23:28:
> Heya,
> 
> On Wed, Jun 9, 2010 at 23:24, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>> The following python 2.5 features were worked around:
> 
> Thanks for fixing this, although it makes me sad to see the code
> uglify the way it has :P. I guess that's the pain of backwards
> compatibility.
> 

I doesn't need to be ugly. Why not put the Popen thing in a def
somewhere? Is there any remaining uglyness besides this:

-    return any(url.startswith(i) for i in prefixes)
+    for prefix in prefixes:
+        if url.startswith(prefix):
+            return True
+    return False

Pythonish version:
-    return any(url.startswith(i) for i in prefixes)
+    return True in (url.startswith(i) for i in prefixes)

Note that due to the use of an iterator (which P2.4 has) rather than a
list or set, the expression is just as efficient, i.e. calls
startswith() only as often as necessary.

Michael
