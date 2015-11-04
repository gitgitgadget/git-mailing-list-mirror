From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCHv3 02/11] run-command: report failure for degraded output
 just once
Date: Wed, 4 Nov 2015 21:36:13 +0100
Message-ID: <563A6C3D.2050805@kdbg.org>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
 <1446597434-1740-3-git-send-email-sbeller@google.com>
 <xmqqd1vpbpik.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaiRKHd2RS9eNeZt_VZqqBF0HS0D=x1HbOTPXYOphu8pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 21:36:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu4n8-0002hs-PT
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 21:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965377AbbKDUgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 15:36:18 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:34157 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965365AbbKDUgR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 15:36:17 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3nrfrt3mcFz5tlD;
	Wed,  4 Nov 2015 21:36:14 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id E29835370;
	Wed,  4 Nov 2015 21:36:13 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kaiRKHd2RS9eNeZt_VZqqBF0HS0D=x1HbOTPXYOphu8pg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280881>

Am 04.11.2015 um 21:14 schrieb Stefan Beller:
> On Wed, Nov 4, 2015 at 10:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Imagine that we are running two things A and B at the same time.  We
>> ask poll(2) and it says both A and B have some data ready to be
>> read, and we try to read from A.  strbuf_read_once() would try to
>> read up to 8K, relying on the fact that you earlier set the IO to be
>> nonblock.  It will get stuck reading from A without allowing output
>> from B to drain.  B's write may get stuck because we are not reading
>> from it, and would cause B to stop making progress.
>>
>> What if the other sides of the connection from A and B are talking
>> with each other,
>
> I am not sure if we want to allow this ever. How would that work with
> jobs==1? How do we guarantee to have A and B running at the same time?

I think that a scenario where A and B are communicating is rather 
far-fetched. We are talking about parallelizing independent tasks. I 
would not worry.

-- Hannes
