From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v3 1/2] alloc.c: remove the alloc_raw_commit_node() function
Date: Fri, 11 Jul 2014 01:33:24 +0100
Message-ID: <53BF30D4.7010105@ramsay1.demon.co.uk>
References: <53BF28A7.7000903@ramsay1.demon.co.uk> <20140711000956.GA11360@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 11 02:33:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5OmK-0004Fw-6B
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 02:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbaGKAd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 20:33:28 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:41325 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751249AbaGKAd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 20:33:28 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 689796F906E;
	Thu, 10 Jul 2014 23:58:04 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 37BA16F906D;
	Thu, 10 Jul 2014 23:58:04 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Thu, 10 Jul 2014 23:58:03 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140711000956.GA11360@sigill.intra.peff.net>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253246>

On 11/07/14 01:09, Jeff King wrote:
> On Fri, Jul 11, 2014 at 12:58:31AM +0100, Ramsay Jones wrote:
> 
>>  #define DEFINE_ALLOCATOR(name, type)				\
>> -static unsigned int name##_allocs;				\
>> +static struct alloc_state name##_state;				\
>>  void *alloc_##name##_node(void)					\
>>  {								\
>> -	static int nr;						\
>> -	static type *block;					\
>> -	void *ret;						\
>> -								\
>> -	if (!nr) {						\
>> -		nr = BLOCKING;					\
>> -		block = xmalloc(BLOCKING * sizeof(type));	\
>> -	}							\
>> -	nr--;							\
>> -	name##_allocs++;					\
>> -	ret = block++;						\
>> -	memset(ret, 0, sizeof(type));				\
>> -	return ret;						\
>> +	return alloc_node(&name##_state, sizeof(type));		\
>>  }
> 
> Yay. Not only does this solve the problem, but it gets rid of nasty
> multi-line macro. In fact, I kind of wonder if we should just do away
> with the macro entirely, and write out:
> 
>   static struct alloc_state blob_state;
>   void alloc_blob_node(void)
>   {
> 	return alloc_node(&blob_state, sizeof(struct blob));
>   }
> 
> It's more lines, but it is probably less obfuscated to a reader.

Yeah, I'm not a fan of _large_ multi-line macros myself.

Now that DEFINE_ALLOCATOR has slimmed down, I don't mind it so much.
However, I agree that doing away with the macro leads to easier to
read code. (I also don't mind the extra lines).

ATB,
Ramsay Jones
