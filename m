From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] git-daemon wrapper to wait until daemon is ready
Date: Sun, 15 Apr 2012 19:11:52 +0200
Message-ID: <4F8B0158.4040407@kdbg.org>
References: <20120414182907.GA3915@ecki> <4F89D1C6.8090705@kdbg.org> <20120414220606.GA18137@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>, git@vger.kernel.org, gitster@pobox.com,
	Jeff King <peff@peff.net>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Apr 15 19:12:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJSza-0005wa-6n
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 19:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755942Ab2DORL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 13:11:57 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:5453 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755836Ab2DORL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 13:11:57 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 03DC410010;
	Sun, 15 Apr 2012 19:08:01 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id BE8DE19F6BA;
	Sun, 15 Apr 2012 19:11:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.28) Gecko/20120306 SUSE/3.1.20 Thunderbird/3.1.20
In-Reply-To: <20120414220606.GA18137@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195571>

Am 15.04.2012 00:06, schrieb Clemens Buchacher:
> On Sat, Apr 14, 2012 at 09:36:38PM +0200, Johannes Sixt wrote:
>> Am 14.04.2012 20:29, schrieb Clemens Buchacher:
>>> +	memset(&cat, 0, sizeof(cat));
>>> +	cat.argv = (const char **)cat_argv;
>>> +	cat.in = proc.err;
>>> +	cat.out = 2;
>>
>> Useless use of cat?
> 
> I don't see how I could avoid cat here. I have to create a pipe first so
> that I can read the first line. And then I have to terminate
> test-git-daemon in order to start the tests. So I cannot continue
> reading synchronously.

OK, I got it.

But reading the first line in this way needs a few assumptions to be true:

- git-daemon does not write an incomplete line and then waits.

- git-daemon does not write more than one line, because xread() happily
reads everything it can get. Your implementation differs from the old
version because the shell's 'read' is required to read no more than one
line, i.e., to read byte-wise from the pipe until it sees the LF.

-- Hannes
