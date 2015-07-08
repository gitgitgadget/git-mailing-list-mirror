From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Git force push fails after a rejected push (unpack failed)?
Date: Wed, 08 Jul 2015 19:41:48 +0200
Message-ID: <559D60DC.4010304@kdbg.org>
References: <DUB120-W5049F72955243F44BB2511F6920@phx.gbl> <20150707141305.GA629@peff.net> <DUB120-W36B78FEE6DC80BDCB05D7FF6920@phx.gbl> <20150707194956.GA13792@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, X H <music_is_live_lg@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 19:47:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCtMD-00083q-KD
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 19:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759316AbbGHRmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 13:42:01 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:8303 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758553AbbGHRl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 13:41:59 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3mRSch2fQRz5tlB;
	Wed,  8 Jul 2015 19:41:56 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 1F98452BD;
	Wed,  8 Jul 2015 19:41:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150707194956.GA13792@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273697>

Am 07.07.2015 um 21:49 schrieb Jeff King:
> On Tue, Jul 07, 2015 at 09:31:25PM +0200, X H wrote:
>
>> For the moment, I'm the only one pushing to the remote, always with
>> the same user (second user is planned). I use git-for-windows which is
>> based on MSYS2. I have mounted the network share with noacl option so
>> permissions should be handled by the Windows share. I'm in a group
>> which has read/write access. I have not configured
>> core.sharedrepository, I don't think it is useful with noacl since
>> unix group are not used in this case. The permission for the folder
>> above the file with permission denied is rw, but this file is read
>> only so if git try to modify it it won't work.
>
> Ah, so this is not a push to a server, but to a share mounted on the
> local box?
>
> That is leaving my realm of expertise. I'm not sure if it could be a
> misconfiguration in your share setup, or that git is trying to do
> something that would work on a Unix machine, but not on a Windows share.
> You might want to ask on the msysgit list:
>
>    https://groups.google.com/forum/#!forum/msysgit
>
>> Why does git try to write a file with the same name? If I amend a
>> commit isn't the sha modified?
>
> Yes, but remember that git stores all of the objects for all of the
> commits. So for some reason your push is perhaps trying to send an
> object that the other side already has. Usually this does not happen
> (the receiver says "I already have these commits, do not bother sending
> their objects"), but it's possible that you have an object that is not
> referenced by any commit, or a similar situation. It's hard to say
> without looking at the repository.

After a non-fast-forward push fails, a subsequent forced push sends the 
same set of objects, which are already present at the server side, but 
are dangling objects.

Apparently, Git for Windows fails to replace the read-only files that 
live on the network file system.

I have observed this recently, as well. I haven't dug into the detailed 
failure mode, yet. In my case, I have a daily repack running on the 
server side (it's a Samba share on a Linux box), that garbage-collects 
the dangling objects. Usually, the next day the forced push is 
successful. I know this is not very helpful if you can't wait a day for 
the next push attempt...

-- Hannes
