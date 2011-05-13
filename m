From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Question about git-cherry and the rev list it's using
Date: Fri, 13 May 2011 13:13:24 +0200
Message-ID: <4DCD1254.4050008@drmicha.warpmail.net>
References: <BANLkTinMfVE=s+TouyxE-ucf7MHGf1m7HA@mail.gmail.com>	<4DCB826F.5020406@drmicha.warpmail.net>	<BANLkTi=qRbpBG_PDPjO_TVEe+nWqrFQ28w@mail.gmail.com> <BANLkTi=d+gDhgnmOzUDfHhGJP76JuLHJ2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 13:13:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKqJJ-0007sV-3O
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 13:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387Ab1EMLN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 07:13:28 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36737 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932213Ab1EMLN1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2011 07:13:27 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 396BA206D7;
	Fri, 13 May 2011 07:13:26 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 13 May 2011 07:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=4gwxtvp4srgRnjtyJyOZAmjtT/k=; b=gv1Bg5ukIwjOOKL7Dw3uz+z7NxgxiX51jkwcN5qlQsQ79xD9ez7ULg1Ble65x+IcDne6SWAwUKy2NA2nLnMGnzh8qM/p4oPTDxIu2ajlMiyCdFLVyE/kVFrevoqPKqYzF3rRr9ylv7qpxGeUkiKBXlxr4OUtUXgipG4g9nHZBOA=
X-Sasl-enc: 7e1udh9QJWL4efc56EM41vPe2wmrBhcabIOWAdQ+7neW 1305285205
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B6338443251;
	Fri, 13 May 2011 07:13:25 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <BANLkTi=d+gDhgnmOzUDfHhGJP76JuLHJ2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173528>

Francis Moreau venit, vidit, dixit 13.05.2011 09:02:
> On Fri, May 13, 2011 at 8:54 AM, Francis Moreau <francis.moro@gmail.com> wrote:
>> [ resending to the mailing list too ]
>>
>> On Thu, May 12, 2011 at 8:47 AM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Francis Moreau venit, vidit, dixit 11.05.2011 18:11:
>>>> Hello,
>>>>
>>>> I'm using "git cherry old master base" to see if all commits between
>>>> master and base have been applied in my 'old' branch.
>>>>
>>>> So I expect that git cherry is using a list of commits given by : "git
>>>> rev-list --no-merges base..master".
>>>
>>> Not really.
>>>
>>> For each commit in "--no-merges old..master ^base" (i.e. "--no-merges
>>> master ^old ^base"), "git cherry" checks whether there is a patch
>>> equivalent commit in "--no-merges master..old", and outputs it with + or -.
>>>
>>
>> oh you're right, I missed the case when old has been merged in master.
>>
> 
> BTW, can't it be convenient for users if git-cherry also displays the
> sha1 of the commits which have been merged upstream (the ones with the
> '-' sign) ?

(I assume you mean the sha1 of the commit as it is in upstream.)

Well, in general the map "sha1 to patchid" is not one-to-one and may not
even be two-to-one. So we possibly would have to list more than one sha1
along with the -1. Anyways, with the current implementation you can't do
that, and it is not simple to change (because we may traverse *a lot* of
commits if base and upstream are far apart or disconnected).

Note that "git cherry -v" gives you the subjects so that you can grep
for those in case they match in your work flow. Same with "git log
--cherry --oneline" etc..

Michael
