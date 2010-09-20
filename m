From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git performance after directory copy
Date: Mon, 20 Sep 2010 12:54:23 +0200
Message-ID: <4C973D5F.4080807@drmicha.warpmail.net>
References: <C5A8FDEFF7647F4C9CB927D7DEB307730F33B7C9@ahr075s.basler.corp> <vpq62y0hh63.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Gaer\, A." <Andreas.Gaer@baslerweb.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 20 12:54:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxe11-0005nc-RR
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 12:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755851Ab0ITKyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 06:54:16 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48173 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755570Ab0ITKyQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 06:54:16 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id AF531583C;
	Mon, 20 Sep 2010 06:54:15 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 20 Sep 2010 06:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=zM/OFciMsb9rG/xjzBIoV74VwjI=; b=dHDOl3zhdygdI7ogmk6Jdb9kELeLmeiXDV/nj82FlpkiVhiX0Bmf0uN0LbPB2Q47FlhpQHsC4sYkU0M+aWfT3uim9uDoH014FKpWWuSCXMqgZUc6cefmPPN83ZGcJ2khuXTkUlMarvvbZ+FdNdQBQHe9Pa2pTW1NawOTlN92UdU=
X-Sasl-enc: bu9oLdkQFyRNC39fCKY7GCR/9HmRrcuL7y/KCX/fgHQ7 1284980055
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1C5B35E6F33;
	Mon, 20 Sep 2010 06:54:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100907 Fedora/3.1.3-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <vpq62y0hh63.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156612>

Matthieu Moy venit, vidit, dixit 20.09.2010 11:56:
> "Gaer, A." <Andreas.Gaer@baslerweb.com> writes:
> 
>> On a copied source directory "git status" seems to be about
>> 3 times slower than on the original directory.
> 
> It is expected that the first "git status" be slower. It will most
> likely have to actually re-diff the files and update the index
> stat-cache.
> 
> But I'm surprised that the next "git status" are still slow. Other
> people may get a better explanation, but this very much looks like a
> bug.

In the OP's case, the inode/dev info differs (after copying, or after
moving across FS boundaries). I don't think "git status" updates these.
I noticed (and reported) something like this a while ago when, after a
reboot, I would get warnings about crossing FS boundaries. Only a "rm
.git/index && git reset --hard" was able to refresh the index properly.
This case seems to be similar, although a simple "git reset --hard"
appears to suffice.

Michael
