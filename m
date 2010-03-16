From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Improve error messages from 'git stash show'
Date: Tue, 16 Mar 2010 09:53:58 -0700
Message-ID: <7v4okgfbrt.fsf@alter.siamese.dyndns.org>
References: <1268691590-27100-1-git-send-email-hendeby@isy.liu.se>
 <7vbpepb2e9.fsf@alter.siamese.dyndns.org> <4B9F3BAB.10608@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Tue Mar 16 17:54:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nra2C-0000Jt-GY
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 17:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759289Ab0CPQyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 12:54:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55867 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756656Ab0CPQyL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 12:54:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AEBEA2945;
	Tue, 16 Mar 2010 12:54:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J8i/0v5WBRgmttrbtuBMhitgRbU=; b=Qyt4Uv
	inebbDGO0odbK4skvU7M6MKdZeDkHsHvaNl9nMfw2rMw111hnEJ9HcGTBYFxnIBr
	FTACDGr6gUQQIEQOAyPMcY92nn7Y3YUdm0HmoM74IMKzAeqXr1CXhX76a1NfJd38
	eRlp1XdcCJzXyDMKbxSwhFaqYJHiPrvBDGBBY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hylSYX7EUhaswd36fFqezta64ccdyS8V
	yqilkJg0f/oj6YW0rcFayNDMxThUwpf3vPigRvlj2W5/312OrzvLeZpxWOJ8zZMO
	BFtEujcVO+jfNTqw/TiycaDlmQgOos7RrDz687ooEzw61nAsoK3KCUQeSUTuQkQW
	po2+aBGU4+U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 38D61A2944;
	Tue, 16 Mar 2010 12:54:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84C7EA2942; Tue, 16 Mar
 2010 12:54:00 -0400 (EDT)
In-Reply-To: <4B9F3BAB.10608@isy.liu.se> (Gustaf Hendeby's message of "Tue\,
 16 Mar 2010 09\:04\:59 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 873B01E0-311C-11DF-AAB2-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142341>

Gustaf Hendeby <hendeby@isy.liu.se> writes:

> On 03/16/2010 12:17 AM, Junio C Hamano wrote:
>> Gustaf Hendeby <hendeby@isy.liu.se> writes:
>> 
>>> The previous error message "fatal: Needed a single revision" is not
>>> very informative.
>>>
>>> Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
>>> ---
>>>  git-stash.sh |    8 ++++++--
>>>  1 files changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/git-stash.sh b/git-stash.sh
>>> index aa47e54..cf221c6 100755
>>> --- a/git-stash.sh
>>> +++ b/git-stash.sh
>>> @@ -210,14 +210,18 @@ list_stash () {
>>>  }
>>>  
>>>  show_stash () {
>>> +	have_stash || die 'No stash found'
>>> +
>>>  	flags=$(git rev-parse --no-revs --flags "$@")
>>>  	if test -z "$flags"
>>>  	then
>>>  		flags=--stat
>>>  	fi
>>>  
>>> -	w_commit=$(git rev-parse --verify --default $ref_stash "$@") &&
>>> -	b_commit=$(git rev-parse --verify "$w_commit^") &&
>>> +	w_commit=$(git rev-parse --quiet --verify --default $ref_stash "$@") &&
>>> +	b_commit=$(git rev-parse --quiet --verify "$w_commit^") ||
>>> +		die 'Stash not found'
>>> +
>> 
>> Because you checked have_stash upfront, an error detected here cannot be
>> "stash not found".  It is something else, isn't it?
>
> This case occurs when you do something like git stash foo, where foo is
> no appropriate stash to show.  Would something like this be more
> informative in the case of git stash foo:
>
> Stash entry 'foo' could not be found

That is more like "'foo' is not a stash", isn't it?
