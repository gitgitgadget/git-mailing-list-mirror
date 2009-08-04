From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Fix compiler warning by properly initialize failed_errno
Date: Tue, 04 Aug 2009 20:51:56 +0200
Message-ID: <4A78834C.20002@kdbg.org>
References: <1249241675-77329-1-git-send-email-sn_@gmx.net> <7vmy6g6rj1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Soria Parra <sn_@gmx.net>, git@vger.kernel.org,
	David Soria Parra <dsp@php.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 20:52:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYP7e-0001Th-Q8
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 20:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933286AbZHDSwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 14:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933266AbZHDSwI
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 14:52:08 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:37090 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933262AbZHDSwH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 14:52:07 -0400
Received: from [77.119.171.106] (77.119.171.106.wireless.dyn.drei.com [77.119.171.106])
	by bsmtp.bon.at (Postfix) with ESMTP id 9421BA7EAE;
	Tue,  4 Aug 2009 20:52:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7vmy6g6rj1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124802>

Junio C Hamano schrieb:
> David Soria Parra <sn_@gmx.net> writes:
> 
>> From: David Soria Parra <dsp@php.net>
>>
>> Initilize failed_error in start_command to avoid compiler warnings
>>
>> Signed-off-by: David Soria Parra <dsp@php.net>
>> ---
>>  run-command.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/run-command.c b/run-command.c
>> index dc09433..510349b 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -19,7 +19,7 @@ int start_command(struct child_process *cmd)
>>  {
>>  	int need_in, need_out, need_err;
>>  	int fdin[2], fdout[2], fderr[2];
>> -	int failed_errno;
>> +	int failed_errno = 0;
>>  
>>  	/*
>>  	 * In case of errors we must keep the promise to close FDs
> 
> We would want to be able to distinguish between a workaround for a
> compiler that is not clever/careful enough, and a necessary
> initialization.  In this particular case, it is the former, and we should
> say
> 
> 	int failed_errno = failed_errno;
> 
> instead.

Frankly, I prefer the initialization with 0; this is not a performance 
critical place and micro-optimization is not appropriate here.

(If this were C++ then I *know* that int x = x; is undefined behavior, 
strictly speaking; I don't know whether it is the same with C.)

Nevertheless, for both versions:

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
