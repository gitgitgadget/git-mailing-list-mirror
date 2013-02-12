From: Brandon Casey <bcasey@nvidia.com>
Subject: Re: [PATCH v4 05/12] sequencer.c: recognize "(cherry picked from
 ..." as part of s-o-b footer
Date: Tue, 12 Feb 2013 11:32:16 -0800
Message-ID: <511A98C0.70201@nvidia.com>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com> <1360664260-11803-6-git-send-email-drafnel@gmail.com> <7v621xgxax.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <drafnel@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"pclouds@gmail.com" <pclouds@gmail.com>,
	"jrnieder@gmail.com" <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 20:32:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Lau-0002hS-1p
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 20:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933161Ab3BLTcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 14:32:20 -0500
Received: from hqemgate04.nvidia.com ([216.228.121.35]:16747 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932213Ab3BLTcT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 14:32:19 -0500
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate04.nvidia.com
	id <B511a98b70001>; Tue, 12 Feb 2013 11:32:07 -0800
Received: from hqemhub02.nvidia.com ([172.17.108.22])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Tue, 12 Feb 2013 11:31:44 -0800
X-PGP-Universal: processed;
	by hqnvupgp07.nvidia.com on Tue, 12 Feb 2013 11:31:44 -0800
Received: from [172.17.129.251] (172.20.144.16) by hqemhub02.nvidia.com
 (172.20.150.31) with Microsoft SMTP Server id 8.3.297.1; Tue, 12 Feb 2013
 11:32:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7v621xgxax.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216177>

On 2/12/2013 11:13 AM, Junio C Hamano wrote:
> Brandon Casey <drafnel@gmail.com> writes:
> 
>> When 'cherry-pick -s' is used to append a signed-off-by line to a cherry
>> picked commit, it does not currently detect the "(cherry picked from..."
>> that may have been appended by a previous 'cherry-pick -x' as part of the
>> s-o-b footer and it will insert a blank line before appending a new s-o-b.
>>
>> Let's detect "(cherry picked from...)" as part of the footer so that we
>> will produce this:
>> ...
>> +static int is_cherry_picked_from_line(const char *buf, int len)
>> +{
>> +	/*
>> +	 * We only care that it looks roughly like (cherry picked from ...)
>> +	 */
>> +	return len > strlen(cherry_picked_prefix) + 1 &&
>> +		!prefixcmp(buf, cherry_picked_prefix) && buf[len - 1] == ')';
>> +}
> 
> Does the first "is it longer than the prefix?" check matter?  If it
> is not, prefixcmp() would not match anyway, no?

Probably not in practice, but technically we should only be accessing
len characters in buf even though buf may be longer than len.  So the
check is just making sure the function doesn't access chars it's not
supposed to.

-Brandon


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
