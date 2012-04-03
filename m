From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: [PATCH] rebase -i: remove CHERRY_PICK_HEAD when cherry-pick failed
Date: Tue, 03 Apr 2012 17:22:06 -0400
Message-ID: <4F7B69FE.9010600@sohovfx.com>
References: <CAMP44s1EAwHjQ7S2ArLvhNg5qkR05DRJ70tQmP8sXYdOP=i_zQ@mail.gmail.com> <1332106632-31882-1-git-send-email-andrew.kw.w@gmail.com> <CALkWK0nmNWaOKcyGH2N0s3B1AFD-+3vHz1BBc3U=RMEFLNuc7A@mail.gmail.com> <20120403144505.GE15589@burratino> <4F7B650C.9060800@sohovfx.com> <20120403210815.GB19858@burratino> <20120403211219.GC19858@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:22:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFBBB-0000yG-VM
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 23:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273Ab2DCVWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 17:22:12 -0400
Received: from smtp04.beanfield.com ([76.9.193.173]:63151 "EHLO
	smtp04.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684Ab2DCVWM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 17:22:12 -0400
X-Spam-Status: No
X-beanfield-mta04-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta04-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta04-MailScanner: Found to be clean
X-beanfield-mta04-MailScanner-ID: 1SFBB1-0007J2-NZ
Received: from [66.207.196.114] (helo=[192.168.1.112])
	by mta04.beanfield.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1SFBB1-0007J2-NZ; Tue, 03 Apr 2012 17:22:07 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101026 SUSE/3.0.10 Thunderbird/3.0.10
In-Reply-To: <20120403211219.GC19858@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194649>

On 04/03/2012 05:12 PM, Jonathan Nieder wrote:
> Jonathan Nieder wrote:
>   
>> Cherry-pick does the merge, so it is what notices the merge conflict.
>> If you search for CHERRY_PICK_HELP in builtin/revert.c, the relevant
>> code should show up.
>>     
> I was looking at an older git version.  In newer gits, the code path
> in question lives at print_advice() in sequencer.c.
>   
Yes, the code has been moved into sequencer now.

But what I meant was, regardless of who's calling "cherry-pick", if
"cherry-pick" runs into an error and needs to stop, it needs to save a
state so that it can do a "--continue". And this behavior should stay
the same regardless of who the caller is. And that means its callers
(e.g. "rebase -i") should know about this and do a cleanup when
"cherry-pick" failed.
