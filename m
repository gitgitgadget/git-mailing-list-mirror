From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git diff -D: omit the preimage of deletes
Date: Sun, 03 Apr 2011 14:51:23 +0200
Message-ID: <4D986D4B.80208@drmicha.warpmail.net>
References: <7v62qzhqp4.fsf@alter.siamese.dyndns.org> <b6975fdc80a338e47c1426e8bf8450b68130b84a.1301664623.git.git@drmicha.warpmail.net> <7vbp0pg4d7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 14:51:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6MmJ-0001s7-2G
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 14:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334Ab1DCMvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 08:51:21 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:52817 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752319Ab1DCMvU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Apr 2011 08:51:20 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9EA6D20C01;
	Sun,  3 Apr 2011 08:51:19 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Sun, 03 Apr 2011 08:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=pWO67t+JoWo2PQEegp3GnxO9txY=; b=FDVrHoIFvyQZMHfNmYon2YWT0dy2xkpIDLiszskm2Ma0J0hHQPXcLFhOcQjRdNH45cRuSIQ5g9Hy7atbqE/0m1WqzvJBZVVR6PP1MGnaBt8Z37L3NbpAUl9HflQyR8JPxOAdEyINunSedFmgVcvDlVrLAq3ssvKFAY6uIRY1WG8=
X-Sasl-enc: WRCc7Ph7xx7Q8CL32Rih4YpcAsHdYoaNPdGyrK/cVT8u 1301835079
Received: from localhost.localdomain (p54858924.dip0.t-ipconnect.de [84.133.137.36])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DD10E400CAA;
	Sun,  3 Apr 2011 08:51:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7vbp0pg4d7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170688>

Junio C Hamano venit, vidit, dixit 01.04.2011 21:26:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> diff --git a/diff.c b/diff.c
>> index 5422c43..9ea1de1 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -4205,7 +4211,7 @@ void diffcore_std(struct diff_options *options)
>>  			diffcore_break(options->break_opt);
>>  		if (options->detect_rename)
>>  			diffcore_rename(options);
>> -		if (options->break_opt != -1)
>> +		if (options->break_opt != -1 && !options->irreversible_delete)
>>  			diffcore_merge_broken();
>>  	}
>>  	if (options->pickaxe)
> 
> Thanks, but this hunk looks fishy.
> 
> What happens to a path that was tentatively broken for the purpose of
> rename detection with -B -M (break to match with another file) but then
> found to be with no counterpart after all after running diffcore_rename(),
> which now needs to get merged back?  Such a path is shown as a normal
> patch when the dissimlarity between the preimage and postimage is not
> large enough and merge-broken is the step that combines such a broken but
> unmatched pair back.
> 
> I would have expected that the patch relative to jc/diff-irreversible-delete
> topic would consist only of changes to diff.c:emit_rewrite_diff(), docs
> and tests.
> 

I think I misunderstood what you intended "-B -D" to do (and I even
didn't know about -B until -D came up; my understanding of "-B" is still
fishy). I just didn't want to let this die before 1.7.5. Thanks for
taking this up and clarifying it.

Michael
