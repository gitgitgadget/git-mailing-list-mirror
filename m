From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/6] test-lib: refactor $GIT_SKIP_TESTS matching
Date: Fri, 17 May 2013 19:02:05 +0200
Message-ID: <87sj1lbkvm.fsf@linux-k42r.v.cablecom.net>
References: <cover.1368736093.git.trast@inf.ethz.ch>
	<9b7e6a882a21b7e1734ec6fd90d3cf0208bb68f1.1368736093.git.trast@inf.ethz.ch>
	<5195C4B1.3010201@viscovery.net>
	<87y5beav7d.fsf@linux-k42r.v.cablecom.net>
	<7vfvxl1rj9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j.sixt@viscovery.net>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 19:02:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdO2w-0005SZ-I5
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 19:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756388Ab3EQRCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 13:02:18 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:4386 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756382Ab3EQRCS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 13:02:18 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 17 May
 2013 19:02:13 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (213.55.184.163) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 17 May 2013 19:02:15 +0200
In-Reply-To: <7vfvxl1rj9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 17 May 2013 09:48:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [213.55.184.163]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224706>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>
>>> Am 5/16/2013 22:50, schrieb Thomas Rast:
>>>> +match_pattern_list () {
>>>> +	arg="$1"
>>>> +	shift
>>>> +	test -z "$*" && return 1
>>>> +	for pat in $@
>>>
>>> You should have double-quotes around $@ here, but then you can just as
>>> well abbreviate to
>>>
>>> 	for pat
>>>
>>> and you don't need the 'test -z "$*' check anymore.
>>
>> Hmm, actually the quotes wouldn't help, because it currently reads
>>
>> -	for skp in $GIT_SKIP_TESTS
>> -	do
>> -		case $this_test.$test_count in
>> -		$skp)
>> -			to_skip=t
>> -			break
>> -		esac
>> -	done
[...]
>> But the 'for pat' with implicit $@ sounds nice regardless, thanks.
>
> 'for pat' is equivalent to 'for pat in "$@"', not 'for pat in $@';
> would it still be useful when you need them split at $IFS?

At this point the splitting has already happened in the caller when it
does the (refactored)

+	if match_pattern_list $this_test.$test_count $GIT_SKIP_TESTS

So $@ and "$@" is actually the same thing.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
