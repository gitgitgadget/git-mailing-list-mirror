From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [Annoyance] "git log .." thinks ".." is ambiguous
Date: Tue, 03 May 2011 08:33:06 +0200
Message-ID: <4DBFA1A2.6050409@drmicha.warpmail.net>
References: <7vr58glxro.fsf@alter.siamese.dyndns.org> <FB837238-9953-4FD8-BC52-5C0AB061C291@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 08:33:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QH9Aa-0005Q1-22
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 08:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051Ab1ECGdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 02:33:09 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50134 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751810Ab1ECGdI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2011 02:33:08 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 03C1420815;
	Tue,  3 May 2011 02:33:08 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 03 May 2011 02:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=oJgmkHNIGqW9C8h7JXulxGC0HKM=; b=EUAfezyNXiCsoJxPq6qQ4+AwvD8O1+Rm7CbwBMLBzmpdTjDLHcbs+sm9uh1ydWXVGM+VO3AenswU3y0Iqs2U+ZrnZmH9hJnCTv3G6UaajQG9S7NOpxu7EkAM63NF/PeZtelcqM9F2ndYLUOyuhN1QMNEKw9L6ul3GZp1CMGy2eI=
X-Sasl-enc: Bpe//yFXajadMQ+VOw+y7VF0aYRcGGngnlquxTOAAnhA 1304404387
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6480040A799;
	Tue,  3 May 2011 02:33:07 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <FB837238-9953-4FD8-BC52-5C0AB061C291@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172645>

Joshua Juran venit, vidit, dixit 03.05.2011 03:57:
> On May 2, 2011, at 12:15 PM, Junio C Hamano wrote:
> 
>> diff --git a/revision.c b/revision.c
>> index f4b8b38..26271d1 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -905,14 +905,26 @@ int handle_revision_arg(const char *arg,  
>> struct rev_info *revs,
>> 		const char *this = arg;
>> 		int symmetric = *next == '.';
>> 		unsigned int flags_exclude = flags ^ UNINTERESTING;
>> +		static const char head_by_default[] = "HEAD";
>>
>> 		*dotdot = 0;
>> 		next += symmetric;
>>
>> 		if (!*next)
>> -			next = "HEAD";
>> +			next = head_by_default;
>> 		if (dotdot == arg)
>> -			this = "HEAD";
>> +			this = head_by_default;
>> +		if (this == head_by_default && next == head_by_default &&
>> +		    !symmetric) {
> 
> Is there a reason not to write
> 
> 	const char *head_by_default = "HEAD";
> 
> or even
> 
> 	const char *const head_by_default = "HEAD";
> 
> instead?  Loading a static array and checking an init flag is a  
> pessimization versus just pointing into a read-only segment.

Because of the comparisons later on: this == "HEAD" is not the same.

Michael
