From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Ignore SIGPIPE when running a filter driver
Date: Tue, 21 Feb 2012 20:20:38 +0100
Message-ID: <4F43EE86.3000307@kdbg.org>
References: <1329771217-9088-1-git-send-email-jehan@orb.com> <7vsji5jgtv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jehan Bing <jehan@orb.com>, git@vger.kernel.org, peff@peff.net,
	jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 20:20:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzvGc-0001j3-3i
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 20:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754955Ab2BUTUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 14:20:45 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:23749 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754863Ab2BUTUp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 14:20:45 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 66308130055;
	Tue, 21 Feb 2012 20:20:38 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1CC5119F675;
	Tue, 21 Feb 2012 20:20:38 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.26) Gecko/20120124 SUSE/3.1.18 Thunderbird/3.1.18
In-Reply-To: <7vsji5jgtv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191178>

Am 20.02.2012 23:11, schrieb Junio C Hamano:
> Jehan Bing <jehan@orb.com> writes:
>> @@ -360,12 +361,16 @@ static int filter_buffer(int in, int out, void *data)
>>  	if (start_command(&child_process))
>>  		return error("cannot fork to run external filter %s", params->cmd);
>>  
>> +	sigchain_push(SIGPIPE, SIG_IGN);
>> +
>>  	write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
>>  	if (close(child_process.in))
>>  		write_err = 1;
>>  	if (write_err)
>>  		error("cannot feed the input to external filter %s", params->cmd);
>>  
>> +	sigchain_pop(SIGPIPE);
>> +
> 
> Thanks.
> 
> I think this is OK on a POSIX system where this function is run by
> start_async() which is implemented with a forked child process.
> 
> I do not now if it poses a issue on Windows, though.  Johannes, any
> comments?

I do not expect the change to cause a problem on Windows.

-- Hannes
