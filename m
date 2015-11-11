From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] run-command: detect finished children by closed pipe
 rather than waitpid
Date: Wed, 11 Nov 2015 21:48:32 +0100
Message-ID: <5643A9A0.50105@kdbg.org>
References: <1446853737-19047-1-git-send-email-sbeller@google.com>
 <563DBDDA.2000106@kdbg.org>
 <CAGZ79kaZ0W5q8=iowbSTJY_mDNNYc6qdTszcWDDDCtYfZyeK_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 21:48:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwcJs-0005eL-E6
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 21:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbbKKUsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 15:48:37 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:43819 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449AbbKKUsg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 15:48:36 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3nwyns2rGJz5tlG;
	Wed, 11 Nov 2015 21:48:33 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id EA201538D;
	Wed, 11 Nov 2015 21:48:32 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kaZ0W5q8=iowbSTJY_mDNNYc6qdTszcWDDDCtYfZyeK_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281199>

Am 11.11.2015 um 21:37 schrieb Stefan Beller:
> including the list and all others this time.
>
>>>                          if (code < 0) {
>>>                                  pp->shutdown = 1;
>>> -                               kill_children(pp, SIGTERM);
>>> +                               kill_children(pp, -code);
>>
>>
>> I'll see what this means for our kill emulation on Windows. Currently, we
>> handle only SIGTERM.
>
> So currently we only pass in SIGTERM from the callers, and I certainly
> only intend
> to use that signal. I just thought special casing the SIGTERM signal
> would do no good
> in terms of design here.
>
> So maybe that was not the right thought and we do have to special case
> SIGTERM here?

I wonder why task_finish() callback gets to choose a signal. The point 
here is, IIUC, when one child dies, the others must be halted, too. 
SIGTERM seems to be the only sensible choice.

-- Hannes
