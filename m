From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] daemon.c: mark a file-local symbol as static
Date: Mon, 22 Feb 2016 00:33:23 +0000
Message-ID: <56CA5753.9030308@ramsayjones.plus.com>
References: <56C9F4F2.1060100@ramsayjones.plus.com>
 <20160221232510.GB4094@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 01:33:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXeRW-00063N-Po
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 01:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbcBVAdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 19:33:35 -0500
Received: from avasout04.plus.net ([212.159.14.19]:57728 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbcBVAde (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 19:33:34 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout04 with smtp
	id MCZX1s0044mu3xa01CZYom; Mon, 22 Feb 2016 00:33:33 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=K//fZHiI c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=VwQbUJbxAAAA:8 a=GJtFG2W7KNLIo_G5Q4YA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <20160221232510.GB4094@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286856>



On 21/02/16 23:25, Jeff King wrote:
> On Sun, Feb 21, 2016 at 05:33:38PM +0000, Ramsay Jones wrote:
> 
>> If you need to re-roll your 'jk/tighten-alloc' branch, could you
>> please squash this into the relevant patch. (ie. "convert manual
>> allocations to argv_array").
> 
> Thanks, will do. You notice these with sparse, as I recall? I've meant
> to look into running that myself, but it looks like we are not
> warning-free with sparse currently. I see complaints like:
> 
>   connect.c:377:40: warning: incorrect type in argument 2 (invalid types)
>   connect.c:377:40:    expected union __CONST_SOCKADDR_ARG [usertype] __addr
>   connect.c:377:40:    got struct sockaddr *ai_addr
> 
> As far as I can tell, that's just noise. Do you have a ready-made recipe
> for silencing it?

Ah, I think you must be on a very old version of sparse.

I tend to run a (non-released, reasonably) up-to-date version built
directly from the sparse repo at:

    git://git.kernel.org/pub/scm/devel/sparse/sparse.git

[You just prompted me to check, I'm running version v0.5.0-30-gca3309e
which is actually a little behind master, which is v0.5.0-44-g40791b9.
This is even further behind the maintainers master branch.]

On Linux, there is a single warning, which results from a hard-coded
value (max size of memcpy et. al., used for the kernel) which should
at least be settable from the command line (I have a patch somewhere
which I have not sent upstream).

On cygwin, currently, there are several other warnings, which can be
silenced by fixups to sparse (again I have some patches ...)

(Also, static-check.pl comes in handy for these types of 'problem'.)

HTH

ATB,
Ramsay Jones
