From: Matthias Fechner <idefix@fechner.net>
Subject: Re: Cannot push a commit
Date: Tue, 17 Jan 2012 08:35:55 +0100
Message-ID: <4F1524DB.2080009@fechner.net>
References: <4F1297E0.1060703@fechner.net> <20120116212036.GA21132@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 17 08:36:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rn3ae-0006CX-TP
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 08:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153Ab2AQHgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 02:36:16 -0500
Received: from anny.lostinspace.de ([80.190.182.2]:34347 "EHLO
	anny.lostinspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab2AQHgP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 02:36:15 -0500
Received: from server.idefix.lan (ppp-93-104-66-149.dynamic.mnet-online.de [93.104.66.149])
	(authenticated bits=0)
	by anny.lostinspace.de (8.14.5/8.14.5) with ESMTP id q0H7Zwvx001545
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Tue, 17 Jan 2012 08:36:03 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from server.idefix.lan (localhost [IPv6:::1])
	by server.idefix.lan (Postfix) with ESMTP id C327E3D3F;
	Tue, 17 Jan 2012 08:35:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at fechner.net
Received: from server.idefix.lan ([127.0.0.1])
	by server.idefix.lan (server.idefix.lan [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Y2aQYUo8y6o4; Tue, 17 Jan 2012 08:35:58 +0100 (CET)
Received: from [IPv6:2001:a60:f035:1:e0d6:af5e:7407:dc84] (unknown [IPv6:2001:a60:f035:1:e0d6:af5e:7407:dc84])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by server.idefix.lan (Postfix) with ESMTPSA id 2050F3D35;
	Tue, 17 Jan 2012 08:35:58 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <20120116212036.GA21132@sigill.intra.peff.net>
X-Enigmail-Version: 1.3.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.7 (anny.lostinspace.de [80.190.182.2]); Tue, 17 Jan 2012 08:36:04 +0100 (CET)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on anny.lostinspace.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188696>

Am 16.01.2012 22:20, schrieb Jeff King:
>   1. Something in the connection cut out but only in a half-duplex way.
>      I guess I could see ssh doing that if its input pipe closed, but
>      that would mean the local pack-objects failed, and I believe git
>      already detects and reports that case.
> 
>   2. The packfile sent indicated that it should have more bytes than it
>      does (i.e., either git indicated there were more objects than there
>      actually are, or zlib failed to give a stream-end marker in the
>      middle of an object). This is one of:
> 
>      a. A bug in git or zlib.
> 
>      b. Something in the connection corrupting the data (e.g., a
>         transport that is not 8-bit clean).
> 
> But in either 2a or 2b, I would expect us to have seen this before, and
> I don't recall seeing anything like it.
> 
> You could try generating a bundle with this pack, like:
> 
>   git bundle create foo.bundle master ^origin/master
> 
> and then shipping the resulting foo.bundle to the other side, and
> pulling from it like:
> 
>   git pull /path/to/foo.bundle master

thanks a lot for your answer.
I created a new repository which is not a bare repo to use your commands
posted above (i tested it with the normal push command from the client
and same error).

I created the bundle on the client, copied it with winscp to the server
and it was applied fine to the repository:
$ git pull ../foo.bundle master
Receiving objects: 100% (3/3), 91.63 KiB, done.
From ../foo.bundle
 * branch            master     -> FETCH_HEAD
Updating 53b9b5e..301e730
Fast-forward
 APP_UD.sch |19643
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 19643 insertions(+), 0 deletions(-)
 create mode 100644 APP_UD.sch


So the problem should be located anywhere else.
I tested now the same on a mac osx as client and there everything works
as expected, I added the file, commited it and pushed it without errors
to the server.

So the problem has something to do with windows as client. I will do
some additional test this evening.

Where can we continue to search?

Bye
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
