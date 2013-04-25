From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] remote: add a test for extra arguments, according to docs
Date: Thu, 25 Apr 2013 08:31:32 -0700
Message-ID: <7vwqrq62zv.fsf@alter.siamese.dyndns.org>
References: <cover.1366811347.git.trast@inf.ethz.ch>
	<372aa93e4a7a3583730c02543583ce93e095ec64.1366811347.git.trast@inf.ethz.ch>
	<7vhaiva9u5.fsf@alter.siamese.dyndns.org>
	<87obd3cbux.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 25 17:31:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVO98-0005B3-GF
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 17:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758792Ab3DYPbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 11:31:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39817 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758471Ab3DYPbf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 11:31:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC9CE17CF1;
	Thu, 25 Apr 2013 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h9eJoBhvjVUgeh78vb3Jlm9UXuY=; b=cwyvCc
	54w6vNRG9tO80pRHsJ2baj9OrkqgRledNVNzfyzMjvev3jRPQZc8m+FdwrHRDtvI
	YeiTR3IKYlN2VvgI213Q+kXYy7ehZK3uxkx75Cy31v+EG/aYYXqvsHLDMgXxhzc4
	D4cmr2Br3sNlv1NbkyehL4YIVvxlja4YJ5WUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NyX84oPr5kbm96L7T0abg4omdDMLph0a
	ZDscZFEQokD+G7tVSlLAG7HKCFxpv+tKWW5k7FSEwni8nNIqDtM7RDekR6S8/atU
	MHW249h0b743qiHsC8O9CRpJmAcDbPEFkZ0L2CDrOKLRfhgseKWEkt2B+RrPHQ6J
	XyK6udJgktc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2C4917CF0;
	Thu, 25 Apr 2013 15:31:34 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16A2B17CEE;
	Thu, 25 Apr 2013 15:31:34 +0000 (UTC)
In-Reply-To: <87obd3cbux.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Thu, 25 Apr 2013 09:23:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 36019AFC-ADBD-11E2-A18F-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222387>

Thomas Rast <trast@inf.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thomas Rast <trast@inf.ethz.ch> writes:
>>
>>> +test_extra_arg () {
>>> +	expect="success"
>>> +	if test "z$1" = "z-f"; then
>>> +		expect=failure
>>> +		shift
>>> +	fi
>>> +	test_expect_$expect "extra args: $*" "
>>> +		test_must_fail git remote $* bogus_extra_arg 2>actual &&
>>> +		grep '^usage:' actual
>>> +	"
>>> +}
>>> +
>>> +test_extra_arg -f add nick url
>>> +test_extra_arg rename origin newname
>>
>> Perhaps just a taste in readability thing, but I would prefer to see
>> them more like
>>
>> 	test_extra_arg_expect failure add nick url
>> 	test_extra_arg_expect success rename origin newname
>>
>> than misunderstanding-inviting "-f" that often stands for "--force".
>
> Hmm.  I had that at first, but then the final cleanup would have had to
> touch all tests to remove the optional argument, making it noisy.

You do not need a final cleanup, as I _never_ meant failure/success
in the above illustration to be _optional_.  Being explicit reduces
mental burden when you later have to read such a custom scaffolding
each test invents in an ad-hoc manner to suit its needs.
