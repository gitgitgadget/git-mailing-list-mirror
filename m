From: Brandon Casey <bcasey@nvidia.com>
Subject: Re: [PATCH v4 05/12] sequencer.c: recognize "(cherry picked from
 ..." as part of s-o-b footer
Date: Tue, 12 Feb 2013 11:49:47 -0800
Message-ID: <511A9CDB.9060008@nvidia.com>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com> <1360664260-11803-6-git-send-email-drafnel@gmail.com> <7v621xgxax.fsf@alter.siamese.dyndns.org> <511A98C0.70201@nvidia.com> <7vtxphfhoq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <drafnel@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"pclouds@gmail.com" <pclouds@gmail.com>,
	"jrnieder@gmail.com" <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 20:50:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Lrr-00023t-0W
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 20:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933407Ab3BLTtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 14:49:51 -0500
Received: from hqemgate03.nvidia.com ([216.228.121.140]:5627 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933153Ab3BLTtv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 14:49:51 -0500
Received: from hqnvupgp08.nvidia.com (Not Verified[216.228.121.13]) by hqemgate03.nvidia.com
	id <B511a9df40000>; Tue, 12 Feb 2013 11:54:28 -0800
Received: from hqemhub02.nvidia.com ([172.17.108.22])
  by hqnvupgp08.nvidia.com (PGP Universal service);
  Tue, 12 Feb 2013 11:46:03 -0800
X-PGP-Universal: processed;
	by hqnvupgp08.nvidia.com on Tue, 12 Feb 2013 11:46:03 -0800
Received: from [172.17.129.251] (172.20.144.16) by hqemhub02.nvidia.com
 (172.20.150.31) with Microsoft SMTP Server id 8.3.297.1; Tue, 12 Feb 2013
 11:49:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7vtxphfhoq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216180>

On 2/12/2013 11:36 AM, Junio C Hamano wrote:
> Brandon Casey <bcasey@nvidia.com> writes:
> 
>>>> +	return len > strlen(cherry_picked_prefix) + 1 &&
>>>> +		!prefixcmp(buf, cherry_picked_prefix) && buf[len - 1] == ')';
>>>> +}
>>>
>>> Does the first "is it longer than the prefix?" check matter?  If it
>>> is not, prefixcmp() would not match anyway, no?
>>
>> Probably not in practice, but technically we should only be accessing
>> len characters in buf even though buf may be longer than len.  So the
>> check is just making sure the function doesn't access chars it's not
>> supposed to.
> 
> Sorry, I do not follow.  Isn't caller's buf terminated with LF at buf[len],
> which would never match cherry_picked_prefix even if len is shorter
> than the prefix?

Heh, I almost pointed that out in my reply.  Yes, buf will be terminated
with LF at buf[len].  And yes, that means that we will never get a false
positive from prefixcmp even if the comparison overruns buf+len while
doing its comparison.  That's why the check doesn't matter in practice,
i.e. based on the way that is_cherry_picked_from_line is being called
right now and the content of cherry_picked_prefix.

But, hasn't is_cherry_picked_from_line entered into a contract with the
caller and said "I will not access more than len characters"?

It's ok with me if you think it reads better without the check.

-Brandon


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
