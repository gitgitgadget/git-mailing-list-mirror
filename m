From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCHv3 02/13] xread: poll on non blocking fds
Date: Tue, 22 Sep 2015 06:55:09 +0200
Message-ID: <5600DF2D.9010202@web.de>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>	<1442875159-13027-3-git-send-email-sbeller@google.com> <xmqq37y78gzt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jacob.keller@gmail.com, peff@peff.net,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 06:55:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeFcN-0000kF-Ri
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 06:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873AbbIVEzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 00:55:47 -0400
Received: from mout.web.de ([212.227.17.12]:59275 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752985AbbIVEzq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 00:55:46 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LudP2-1adfwI1agi-00zoLt; Tue, 22 Sep 2015 06:55:38
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <xmqq37y78gzt.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:rYDp8EAbTiXRItSbOxeDA+XtXTlwSg4FGMuTySt38EV9CsQ2nVn
 yfHjAVHhXdtmULGOhw6zrsH3BWau7oRNqgy6t/GH9taVWYQJcQqNKKVpNC6855R5+QJ47ER
 NMh/ef/E0fqPFpcqeLlbkH3xNsAsg2B1Z6xpqJj6gv7c0Uwz0Sb+wB6SiNc9+ma6nJYGwGB
 jcYU1oUpqvjwMVwu7RKfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UVujr770SCA=:T70p2cDJa0mKRU+2lpsu90
 XQs0eWi0MGpKHzBfWvOmFwoEr9hirW+B/pypdP2D6M3/5TpdjyBLFhlTCcRDU21V85+Lj4op0
 kftKCYG0RkhD+nkupYffUvOlDjrnMsyhDIn0LgjEM1yro7PwN5lKidLNRnC+VxRo5mj0cQRCV
 v5ZsX69I69+WhJVlAP/FIv1gfJsOr8f96lTRyolypcNvM7Df15ZO8n7IISadPIttHInL66twd
 EchFIBNGvZhJf8zd27tSJrzShhvD/NUGCewTaey3d0XUuJdeBFKpR76qQebHsymSzdsggOgrp
 Cy6T87ib6i8N1jBfzz1OaBrHmUBrUgSPLhUKw7uo9rIdOgednxWkS7/pEpsnzRl9N3OewtbE7
 9qatyqNohen/6NWCts2qy8wSBTwnLDhPb42pGFT8RkYDz4+NYkjqmdpSxQgGHqyGI4f6ye9OH
 PtGJWVh/WMCVIK9LO3I1/N4YTod9GbB79WkXjgj7hnM3FMB9iJwpchiJ7533urhrcP+Xm7h1s
 m+q+g+fhMUpCyr3oHZGNldbJhzwAuHOtVe50ALe2TeX/xXKc2oksGxc43wNCuBTe+5fUFASqF
 Np319BGJE1V1/EfBiDLmCwTbhv70pqMjP+fFW6vVQSkaP7s4xAy0mIFBz5qRWEqMUuq1amR8a
 mEdHZUeUjtOsMc5QIF3dxm3fY82fzt2q3X9Q2nBMl8VKw9NrGSsBezfh3CG/9423vvdROLzPo
 aRW7a0pW2g+D+TV+lPpuaxtxKvRSDyvaDE3vIw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278375>

On 09/22/2015 01:55 AM, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> So if we get an EAGAIN or EWOULDBLOCK error the fd must be nonblocking.
>> As the intend of xread is to read as much as possible either until the
>> fd is EOF or an actual error occurs, we can ease the feeder of the fd
>> by not spinning the whole time, but rather wait for it politely by not
>> busy waiting.
> As you said in the cover letter, this does look questionable.  It is
> sweeping the problem under the rug (the hard-coded 100ms is a good
> clue to tell that).  If the caller does want us to read thru to the
> end, then we would need to make it easier for such a caller to stop
> marking the file descriptor to be non-blocking, but this does not do
> anything to help that.  An alternative might be to automatically
> turn nonblocking off temporarily once we get EAGAIN (and turn it on
> again before leaving); that would be an approach to make it
> unnecessary to fix the caller (which has its own set of problems,
> though).
Wouldn'  that function be somewhat mis-named and/or mis-behaved?
read_in_full_with_hard_coded_timeout_and_fix_O_NONBLOCK()
could make sure that the user of this function knows what's going on
under the hood.

More seriously, if someone calls xread() with a non-blocking socket,
the caller wants to return and does want to his own timeout handling.

If we want to have a timeouted read(), we can call it

xread_timout(int fd, voxread(int fd, void *buf, size_t len, int timeout)

(Or something similar) to make clear that there is an underlying
timeout handling.
Another option could be to name the function

read_in_full_timeout().

But in any case I suggest to  xread() as it is, and not to change the 
functionality
behind the back of the users.
