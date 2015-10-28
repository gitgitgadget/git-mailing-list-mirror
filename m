From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] ref-filter: fallback on alphabetical comparison
Date: Wed, 28 Oct 2015 15:16:50 -0700
Message-ID: <xmqqy4emskod.fsf@gitster.mtv.corp.google.com>
References: <1445972456-5621-1-git-send-email-Karthik.188@gmail.com>
	<xmqq7fm8ozu9.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZSF5bJocJkMG70x0kTaU139pj0-ONypC=V2Tdnu3yQtow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 23:17:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZ1i-0002Da-VY
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 23:17:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756383AbbJ1WQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 18:16:59 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755485AbbJ1WQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 18:16:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6C07726692;
	Wed, 28 Oct 2015 18:16:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i/9SyNTDABOLhoyY59P3jOY1d30=; b=fM05Oa
	QQ68E7gpgHvWywPdnRZ+w77hGiO/KCtcyOQqeQ2H8aalqKjnNb3kVbF8GjxeyH1n
	5ieoiMfz66I0U//haplpUdkf56c9QirEnlmY6V7umv02cBN/fJji0bwvayy8JdHZ
	Kwt0OZa0vojNVVQtIKnJU5vxGdx75XC0mMjDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j0+zYpytgWF02ld7AAnsBkvOHEI48+Zp
	OaZsAvALK8pcGUppB2z9Pi8BlgCOQcuSdoML/xetNO+LWwvKIpKbph49op67MiId
	rfhT/yKZK49kxGl/z5Z6bsgkh3nFD3/++/17L1Kx8arJKwnirtIbsKRuv0bRKbTq
	MPgbfHwM3F8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6233626691;
	Wed, 28 Oct 2015 18:16:52 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DC0B12668F;
	Wed, 28 Oct 2015 18:16:51 -0400 (EDT)
In-Reply-To: <CAOLa=ZSF5bJocJkMG70x0kTaU139pj0-ONypC=V2Tdnu3yQtow@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 29 Oct 2015 00:25:27 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 96EFD636-7DC1-11E5-961F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280398>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Wed, Oct 28, 2015 at 1:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Hence, fallback to alphabetical comparison based on the refname
>>> whenever the other criterion is equal. Fix the test in t3203 in this
>>> regard.
>>
>> It is unclear what "in this regard" is.  Do you mean this (I am not
>> suggesting you to spell these out in a very detailed way in the
>> final log message; I am deliberately being detailed here to help me
>> understand what you really mean)?
>>
>>     A test in t3203 was expecting that branch-two sorts before HEAD,
>>     which happened to be how qsort(3) on Linux sorted the array, but
>>     (1) that outcome was not even guaranteed, and (2) once we start
>>     breaking ties with the refname, "HEAD" should sort before
>>     "branch-two" so the original expectation was inconsistent with
>>     the criterion we now use.
>>
>
> Exactly what you're saying, they happened to have the same objectsize.
> Hence sorting them would put them together, but since we compare the
> refname's the "HEAD" ref would come before "branch-two".
>
>>     Update it to match the new world order, which we can now depend
>>     on being stable.
>>
>> I am not sure about "HEAD" and "branch-two" in the above (it may be
>> comparison between "HEAD" and "refs/heads/branch-two", for example).
>
> It actually is, we consider "refs/heads/branch-two rather then the shortened
> version of this. It makes sense to classify refs this way, even though this
> was a side effect of this commit.

Now these are enough bits of info, that can and needs to be
condenced into an updated log message to help future readers.

Thanks.
