From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GUILT] handle branches with slashes in guilt-graph
Date: Tue, 18 Oct 2011 12:12:45 -0700
Message-ID: <7v39eqglle.fsf@alter.siamese.dyndns.org>
References: <4E9D57BB.2030707@opera.com> <m2r52adu65.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Per Cederqvist <cederp@opera.com>,
	Jeff Sipek <jeffpc@josefsipek.net>, git@vger.kernel.org,
	ceder@lysator.liu.se
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Oct 18 21:12:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGF5p-0008Od-Kh
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 21:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969Ab1JRTMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 15:12:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50627 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146Ab1JRTMs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 15:12:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90DA76E4A;
	Tue, 18 Oct 2011 15:12:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lEBa2JLz2sirgGAeGkECw3qhQtw=; b=Gb5SJN
	PfkGTnEPRmL2RJGvUqvUlhV2DHFty9kwH3ixhh/o0j1sjIfV9Sz8mHpZGl+D9iNz
	7Z+RBekOkbQciSs2GKeTcSVbV/onWFhOwtJSJgo8MWcMmbxIOwjYPiNF8Z6N/Sfy
	JRJO0zX447NMevmm4z717yHn/Qnoru8DFHKcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qVpKVipb9F5QY880dNQzqFdmUdXJ83S8
	OHc+kk1xHBfBo53x8i07a4SoFP1RzU/rkSF3+xR/5qzQtPEFkHBXric3+35pmh1A
	n54RC820j4GU89El0LWupYLbJx6+j8miaogYpAxy4YVopDudHip+GFkQj+VTBHzC
	KDSdEuWcyHE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88CC86E49;
	Tue, 18 Oct 2011 15:12:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2096C6E48; Tue, 18 Oct 2011
 15:12:47 -0400 (EDT)
In-Reply-To: <m2r52adu65.fsf@igel.home> (Andreas Schwab's message of "Tue, 18
 Oct 2011 20:35:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A17C3B6-F9BD-11E0-995D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183897>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Per Cederqvist <cederp@opera.com> writes:
>
>> Avoid sed errors when the branch name contains a slash.
>>
>> Signed-off-by: Per Cederqvist <cederp@opera.com>
>>
>> --- /usr/bin/guilt-graph~	2011-01-25 20:15:50.000000000 +0100
>> +++ /usr/bin/guilt-graph	2011-10-18 12:30:31.000000000 +0200
>> @@ -37,9 +37,10 @@ disp "digraph G {"
>>
>>  current="$top"
>>
>> +safebranch=`echo "$branch"|sed 's%/%\\\\/%g'`
>>  while [ "$current" != "$base" ]; do
>>  	pname=`git show-ref | sed -n -e "
>> -/^$current refs\/patches\/$branch/ {
>> +/^$current refs\/patches\/$safebranch/ {
>
> Alternatively, you could change the delimiter to `,':
>
>   \,^$current refs/patches/$branch, {

Isn't a comma still valid character in a branch name?

The vertical var | is available, though ;-)
