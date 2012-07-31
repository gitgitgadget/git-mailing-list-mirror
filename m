From: Michael G Schwern <schwern@pobox.com>
Subject: Re: Fix git-svn for SVN 1.7
Date: Mon, 30 Jul 2012 21:30:58 -0700
Message-ID: <50175F82.7070606@pobox.com>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <20120730203844.GA23892@dcvr.yhbt.net> <5016F832.7030604@pobox.com>
 <20120730221548.GA388@dcvr.yhbt.net> <50172F10.2030402@pobox.com>
 <20120731021816.GA12640@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, jrnieder@gmail.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jul 31 06:32:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sw485-0000XC-9D
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 06:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870Ab2GaEbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 00:31:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48465 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660Ab2GaEbG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 00:31:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 464CC8DB6;
	Tue, 31 Jul 2012 00:31:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=pvs1FedJ+Ip3
	XEoaYMUdMrUaADQ=; b=VND0J6VNjWlXaJZJOmfNY2K7lApIiVTggjXyiTueEuui
	bYKBEUlqp437nIgcgLcfZdLqg/geWxz1teh2deMy/Hr2pIu/nQTHTZThw7p/tYTV
	z1F0rWF6ZV/TDDksg3eco/I+s5Y91g1P5wKXftDZdAzUPEt5VSSNOJDxSj2ayXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QW5q/7
	+xi7HthNAngbsIvOWZHiixJqyTLvoIWtt7Ml7itQdjfAQDN85/Svq2GLencU1zwB
	Sc26JC7b+HlEQgiYl5wPb7ldp+2uF5WWY1qbPTKb5NKwsBVcheH0lQ19DZKcvSxt
	S7nY+lnyiTInat3ex6e7lKhvIZtVoeqFt6TP0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32CEE8DB5;
	Tue, 31 Jul 2012 00:31:05 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2ED8D8DB4; Tue, 31 Jul
 2012 00:31:04 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120731021816.GA12640@dcvr.yhbt.net>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 8A5B43F0-DAC8-11E1-B9C0-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202629>

On 2012.7.30 7:18 PM, Eric Wong wrote:
> Michael G Schwern <schwern@pobox.com> wrote:
>> On 2012.7.30 3:15 PM, Eric Wong wrote:
>>>> Right now, canonicalization is a bug generator.  Paths and URLs have to be in
>>>> the same form when they're compared.  This requires meticulous care on the
>>>> part of the coder and reviewer to check every comparison.  It scatters the
>>>> logic for proper comparison all over the code.  Redundant logic scattered
>>>> around the code is a Bad Thing.  It makes it more likely a coder will forget
>>>> the logic, or get it wrong, and a human reviewer must be far more vigilant.
>>>
>>> <snip>  I agree completely with canonicalization.
>>
>> Sorry, I'm not sure what you're agreeing with.
> 
> That's it's a bug generator and we shouldn't have redundant logic.
> Having functions to compare objects themselves is a good thing.

That doesn't make it much better than what we have now.  One still has to
remember to pepper those special comparisons all over the code.


>>>> The only downside is when chasing down a bug related to canonicalization one
>>>> might have to realize that eq is overloaded.
>>>
>>> Having to realize eq is overloaded is a huge downside to me.
>>
>> Presumably you'd be reviewing the change which implements the overloaded
>> objects, so you'd know about it.  And it would be documented.
> 
> The change itself is easy to review.   Picking up the code a few
> months/years down the line and having to know "eq" is overloaded
> tends to bite people.

Why does a reviewer, or a reader of the code, have to know eq is overloaded?

How often would string comparing an overloaded uri/path object be the wrong
thing to do?  Just about never.  Compare that to how often it would be
incorrect to string compare a non-overloaded uri/path object.  Most of the
time.  Do you feel it would be otherwise?

If they're overloaded, somebody patching the code doesn't have to know to use
a special uri_eq() function.  It'll just happen when they naturally string
compare.  The coder doesn't have to know or do anything special.  The reviewer
doesn't have to do any special work.

If they're not overloaded, coders must know about the special URI and path
requirements.  Each string comparison is suspect and must be scrutinized by
the reviewer.  They have to think "is this actually a uri or path comparison?
 Should it be using the special comparison functions?"

Which procedure offers more opportunities for mistakes?


>> I've listed a bunch of concrete positives for using comparison overloaded
>> URI/path objects vs how it's currently being done.  How about you voice some
>> of the downsides in concrete terms?  Or an alternative that solves the current
>> problems?
> 
> Any custom comparison function would do the trick (e.g. URI::eq()).
>
> I _want_ URI/path objects.  I do not want a bare "eq" operator to
> obscure the fact it's calling URI::eq() behind-the-scenes.
>
> That said, I don't mind overloads when it's obvious an overload is being
> used (e.g. stringify).  It's things like "eq" which obscure the fact
> function calls are happening in the background.

Is that a problem?  If so, why?

If the objects stringify, but comparing them as strings is generally the wrong
thing to do (even if the object stringifies to the canonical form, you don't
know the other side of the operator is an object), isn't that asking for bugs?
 If the objects are going to act like strings, shouldn't they act like strings
completely?

Object overloading fails when the encapsulation is incomplete.


-- 
151. The proper way to report to my Commander is "Specialist Schwarz,
     reporting as ordered, Sir" not "You can't prove a thing!"
    -- The 213 Things Skippy Is No Longer Allowed To Do In The U.S. Army
           http://skippyslist.com/list/
