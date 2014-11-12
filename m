From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] t1410: fix breakage on case-insensitive filesystems
Date: Wed, 12 Nov 2014 21:20:22 +0100
Message-ID: <5463C106.5090803@kdbg.org>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com> <20141109014354.GA23883@peff.net> <20141109015918.GA24736@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Michael Blume <blume.mike@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 12 21:20:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoeP3-0006I7-Fb
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 21:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbaKLUU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 15:20:29 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:48191 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248AbaKLUU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 15:20:29 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3jdHPP5GS5z5tlD;
	Wed, 12 Nov 2014 21:20:24 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1DD0D19F7AE;
	Wed, 12 Nov 2014 21:20:23 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141109015918.GA24736@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.11.2014 um 02:59 schrieb Jeff King:
>  test_expect_success 'stale dirs do not cause d/f conflicts (reflogs off)' '
> -	test_when_finished "git branch -d a || git branch -d a/b" &&
> +	test_when_finished "git branch -d one || git branch -d one/two" &&
>  
> -	git branch a/b master &&
> -	echo "a/b@{0} branch: Created from master" >expect &&
> -	git log -g --format="%gd %gs" a/b >actual &&
> +	git branch one/two master &&
> +	echo "one/two@{0} branch: Created from master" >expect &&
> +	git log -g --format="%gd %gs" one/two >actual &&
>  	test_cmp expect actual &&
> -	git branch -d a/b &&
> +	git branch -d one/two &&
>  
> -	# same as before, but we only create a reflog for "a" if
> +	# same as before, but we only create a reflog for "one" if
>  	# it already exists, which it does not
> -	git -c core.logallrefupdates=false branch a master &&
> +	git -c core.logallrefupdates=false branch one master &&
>  	: >expect &&
> -	git log -g --format="%gd %gs" a >actual &&
> +	git log -g --format="%gd %gs" one >actual &&
>  	test_cmp expect actual
>  '
>  

On Linux I observe

Deleted branch one/two (was b60a214).
warning: unable to unlink .git/logs/refs/heads/one: Is a directory
Deleted branch one (was b60a214).
ok 15 - stale dirs do not cause d/f conflicts (reflogs off)

(notice the warning) but on Windows the test fails with

Deleted branch one/two (was b60a214).
error: Unable to append to .git/logs/refs/heads/one: Permission denied
fatal: Cannot update the ref 'refs/heads/one'.
not ok 15 - stale dirs do not cause d/f conflicts (reflogs off)

On both systems, .git/logs/refs/heads/one exists as an empty directory
after the test.

I haven't dug further (will have to wait a day or two, so if you have
time or a hint where to look...)

-- Hannes
