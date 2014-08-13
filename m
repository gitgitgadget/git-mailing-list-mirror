From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH 0/3] Re: [PATCH] unpack-tree.c: remove dead code
Date: Wed, 13 Aug 2014 08:41:26 +0200
Message-ID: <53EB0896.7060106@gmail.com>
References: <xmqqha1h60fy.fsf@gitster.dls.corp.google.com> <1407878107-22850-1-git-send-email-stefanbeller@gmail.com> <20140812235731.GD24621@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	barkalow@iabervon.org, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 08:41:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHSFY-0001CJ-So
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 08:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbaHMGl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 02:41:29 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:36315 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbaHMGl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 02:41:28 -0400
Received: by mail-wg0-f50.google.com with SMTP id n12so10973779wgh.9
        for <git@vger.kernel.org>; Tue, 12 Aug 2014 23:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ttYL5bV3by1JhZMVuS/CvD/7zsHBws6F3HrglrRTXds=;
        b=CCzl9Hz8kxYgKQG21aPqCjT3jiOTbPOsz18mZVjrc1tbnkzRYnfNLbnQY8f+1F1dsC
         57hcvSv25TBa5pBQE61unI9n7cUlzS5WV99AEjyRcpV5ADSWFtUeY2G27aolSduC9oJC
         DMfQtvs0OOHIBvGHviWHgrOwHWKlIFpwuHA5W23HIsQjSGtBn7IWOtUBMbrL0RA8rz4I
         MvcQBgeckKR0ZpHqYCpKG642aS+xU5Cz2XuVyAtO4z4A70jLcbjTC/TIdUmIZAMuS/vg
         8JyFbhV7NL4MD2LQTibyURGKZXvvjw1xM9y5EQ9eLYB3XFWH+506HeCKftujtl5SS9ql
         J5Lw==
X-Received: by 10.180.73.235 with SMTP id o11mr3101699wiv.41.1407912086867;
        Tue, 12 Aug 2014 23:41:26 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id h3sm2246239wjz.48.2014.08.12.23.41.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Aug 2014 23:41:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140812235731.GD24621@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255185>

On 13.08.2014 01:57, Jonathan Nieder wrote:
> Stefan Beller wrote:
> 
>> In line 1763 of unpack-tree.c we have a condition on the current tree
> [...]
> 
> The description is describing why the patch is *correct* (i.e., not
> going to introduce a bug), while what the reader wants to know is why
> the change is *desirable*.

Indeed. Thanks for the reminder!

> 
> Is this about making the code more readable, or robust, or suppressing
> a static analysis error, or something else?  What did the user or
> reader want to do that they couldn't do before and now can after this
> patch?

In my opinion it's making the code easier to read as there are less
lines of code with less conditionals.
The supression of a static code analysis warning is rather a desired
side effect, but not the main reason for the patch.


> 
> [...]
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -1789,15 +1789,11 @@ int twoway_merge(const struct cache_entry * const *src,
>>  			/* 20 or 21 */
>>  			return merged_entry(newtree, current, o);
>>  		}
>> +		else if (o->gently) {
>> +			return  -1 ;
>> +		}
> 
> (not about this patch) Elsewhere git uses the 'cuddled else':

Yes, I intentionally used this style, as the surrounding code was
using this style. You already added the reformatting follow up patch,
thanks!

> 
> 		if (foo) {
> 			...
> 		} else if (bar) {
> 			...
> 		} else {
> 			...
> 		}
> 
> That stylefix would be a topic for a different patch, though.
> 
>>  		else {
>> -			/* all other failures */
>> -			if (oldtree)
>> -				return o->gently ? -1 : reject_merge(oldtree, o);
>> -			if (current)
>> -				return o->gently ? -1 : reject_merge(current, o);
>> -			if (newtree)
>> -				return o->gently ? -1 : reject_merge(newtree, o);
>> -			return -1;
> 
> Does the static analysis tool support comments like
> 
> 			if (oldtree)
> 				...
> 			if (current)
> 				...
> 			...
> 
> 			/* not reached */
> 			return -1;
> 
> ?  That might be the simplest minimally invasive fix for what coverity
> pointed out.

I was looking for things like that, but either the
extensive documentation is well hidden or there is only short
tutorial-like documentation, which doesn't cover this case.


> 
> Now that we're looking there, though, it's worth understanding why we
> do the 'if oldtree exists, use it, else fall back to, etc' thing.  Was
> this meant as futureproofing in case commands like 'git checkout' want
> to do rename detection some day?
> 
> Everywhere else in the file that reject_merge is used, it is as
> 
> 	return o->gently ? -1 : reject_merge(..., o);
> 
> The one exception is
> 
> 	!current &&
> 	oldtree &&
> 	newtree &&
> 	oldtree != newtree &&
> 	!initial_checkout
> 
> (#17), which seems like a bug (it should have the same check).  Would
> it make sense to inline the o->gently check into reject_merge so callers
> don't have to care?
> 
> In that spirit, I suspect the simplest fix would be
> 
> 		else
> 			return o->gently ? -1 : reject_merge(current, o);
> 
> and then all calls could be replaced in a followup patch.
> 
> Sensible?

I need to read more code to follow.

Thanks for picking up my inital patch and improving. :)
Stefan

> 
> Thanks,
> 
> Jonathan Nieder (2):
>   unpack-trees: use 'cuddled' style for if-else cascade
>   checkout -m: attempt merge when deletion of path was staged
> 
> Stefan Beller (1):
>   unpack-trees: simplify 'all other failures' case
> 
>  unpack-trees.c | 31 ++++++++++---------------------
>  1 file changed, 10 insertions(+), 21 deletions(-)
> 
