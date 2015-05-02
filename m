From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] lock_packed_refs(): allow retries when acquiring
 the packed-refs lock
Date: Sat, 02 May 2015 23:43:33 +0200
Message-ID: <55454505.9060305@kdbg.org>
References: <1430491977-25817-1-git-send-email-mhagger@alum.mit.edu> <1430491977-25817-3-git-send-email-mhagger@alum.mit.edu> <5543A621.7010208@kdbg.org> <554448B6.6080605@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat May 02 23:43:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YofCJ-00063I-IC
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 23:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945959AbbEBVni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 17:43:38 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:37762 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752121AbbEBVni (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 17:43:38 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3lfP8Q6bXKz5tlB;
	Sat,  2 May 2015 23:43:33 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 58F1A5240;
	Sat,  2 May 2015 23:43:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <554448B6.6080605@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268239>

Am 02.05.2015 um 05:47 schrieb Michael Haggerty:
> On 05/01/2015 06:13 PM, Johannes Sixt wrote:
>> How about this:
>>
>>      test_when_finished "wait; rm -f $LOCK" &&
>>      { sleep 1 & } &&
>>      ...
>
> Thanks for pointing out this problem. Your suggestion seems good. I
> assume that you didn't intend to omit the "rm -f $LOCK" from the
> subprocess, because the whole point is for that to happen while "git
> pack-refs" is running.

I see. So, if git pack-refs works correctly, it waits for the 
sub-process, and the 'wait' in test_when_finished does not buy a lot. If 
there is breakage, the trash directory is not attempted to be removed, 
and it does not matter that a process potentially occupies it. I think 
your version is good then.

-- Hannes
