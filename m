From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: [PATCH] rebase -i: remove CHERRY_PICK_HEAD when cherry-pick failed
Date: Tue, 03 Apr 2012 19:11:25 -0400
Message-ID: <4F7B839D.2020808@sohovfx.com>
References: <CAMP44s1EAwHjQ7S2ArLvhNg5qkR05DRJ70tQmP8sXYdOP=i_zQ@mail.gmail.com> <1332106632-31882-1-git-send-email-andrew.kw.w@gmail.com> <CALkWK0nmNWaOKcyGH2N0s3B1AFD-+3vHz1BBc3U=RMEFLNuc7A@mail.gmail.com> <20120403144505.GE15589@burratino> <4F7B650C.9060800@sohovfx.com> <20120403210815.GB19858@burratino> <20120403211219.GC19858@burratino> <4F7B69FE.9010600@sohovfx.com> <20120403212650.GD19858@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 01:11:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFCsy-0000ul-49
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 01:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999Ab2DCXLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 19:11:30 -0400
Received: from smtp01.beanfield.com ([76.9.193.170]:55769 "EHLO
	smtp01.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519Ab2DCXLa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 19:11:30 -0400
X-Spam-Status: No
X-beanfield-mta01-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta01-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta01-MailScanner: Found to be clean
X-beanfield-mta01-MailScanner-ID: 1SFCsn-0007pP-Fd
Received: from [66.207.196.114] (helo=[192.168.1.112])
	by mta01.beanfield.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1SFCsn-0007pP-Fd; Tue, 03 Apr 2012 19:11:25 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101026 SUSE/3.0.10 Thunderbird/3.0.10
In-Reply-To: <20120403212650.GD19858@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194670>

On 04/03/2012 05:26 PM, Jonathan Nieder wrote:
> The current CHERRY_PICK_HELP codepath removes CHERRY_PICK_HEAD to let
> its caller take care of the appropriate "commit -c" magic for
> historical reasons.  I'd be happy to see "rebase -i" stop relying on
> that.
>   
"rebase -i" doesn't rely on "commit -c". It stores the author info
inside its state dir, so when the user does a "rebase --continue", the
author info from the state dir is used.

Also, "commit -c" does override CHERRY_PICK_HEAD for author info and
message. So having CHERRY_PICK_HEAD around shouldn't affect scripts that
rely on "commit -c".

> Unfortunately, outside scripts from before CHERRY_PICK_HEAD existed
> are also allowed to use CHERRY_PICK_HELP,so the incomplete
> implementation that leaves behind a CHERRY_PICK_HEAD when the commit
> being cherry-picked resolves into nothingness is still a bug.
>   
CHERRY_PICK_HELP was introduced as a hack to allow "rebase -i" to
override what message "cherry-pick" shows, and not as something that
affects the behavior of "cherry-pick". Since it is also not documented,
it feels more like an internal implementation detail. So I suspect not
many people know about this env var and even fewer would actually use it.
