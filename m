From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] clone: --dissociate option to mark that reference is
 only temporary
Date: Wed, 15 Oct 2014 17:44:36 -0400
Message-ID: <543EEAC4.8070204@xiplink.com>
References: <xmqqa94yzap8.fsf@gitster.dls.corp.google.com>	<543E85FA.6050404@xiplink.com>	<xmqqwq81w8az.fsf@gitster.dls.corp.google.com>	<543EDE6A.7040500@xiplink.com> <xmqqsiipuifi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 23:44:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeWN4-0000U6-Tc
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 23:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbaJOVoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 17:44:34 -0400
Received: from smtp66.ord1c.emailsrvr.com ([108.166.43.66]:56293 "EHLO
	smtp66.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750792AbaJOVoe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 17:44:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp17.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 6CB60180495;
	Wed, 15 Oct 2014 17:44:33 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp17.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 363381809BC;
	Wed, 15 Oct 2014 17:44:33 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.2.13);
	Wed, 15 Oct 2014 21:44:33 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <xmqqsiipuifi.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14-10-15 05:33 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> On 14-10-15 01:29 PM, Junio C Hamano wrote:
>>
>>>     $ git clone \
>>>         --reference=/local/pool/linux.git \
>>>         --borrow=../my/neighbour/linux-hack.git \
>>>         git://git.kernel.org/...../linux.git
>>>
>>> With "do the usual --reference thing, but then dissociate the result
>>> from referents" option, there is no ambiguity and that is why I did
>>> not go with the "--borrow" option suggested in the original thread.
>>
>> I had not considered this case.  My limited imagination has a hard time
>> coming up with a scenario where more than one --reference (or
>> In this example, the --borrow seems
>> useless.  How would clone decide that it even needed objects from the
>> neighbour repo?  None of the refs on gko need any of the neighbour's unique
>> objects.
> 
> A probable scenario might go like this.
> 
>     The company-wide pool is designed for everybody's use and will
>     stay, even if it lags behind because it fetches every other day,
>     so it is safe to keep referring to via alternates.  My neighbour
>     is following the linux-next repository and has changes that are
>     meant to land "in the future" to the mainline, but it can
>     disappear without notice so I cannot afford to depend on its
>     presense forever.
> 
> Under that particular scenario, what should happen is fairly clear;
> we want to dissociate from neibour's immediately after clone is
> done, while being still dependent on the shared pool.

Yes, but we're cloning gko, not the neighbour.  Doesn't that mean that the
clone operation won't know about any of the neighbour's refs?  In order to
get any of the neighbour's refs (and its unique objects) you have to either
clone the neighbour directly or (post-clone) fetch from it, no?

		M.
