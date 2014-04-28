From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: default to -lcurl when no CURL_CONFIG or CURLDIR
Date: Mon, 28 Apr 2014 14:04:36 -0700
Message-ID: <xmqqtx9dnp23.fsf@gitster.dls.corp.google.com>
References: <1398714653-1050-1-git-send-email-dborowitz@google.com>
	<20140428200550.GO9218@google.com>
	<CAD0k6qR766hrgUtyiGzZ9KM5woknfsyUm3Mf1-Pm3M-LrL2Zhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 23:04:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WesjQ-0003hU-Np
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 23:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757104AbaD1VEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 17:04:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47968 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757097AbaD1VEl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 17:04:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FA5D810CD;
	Mon, 28 Apr 2014 17:04:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BY3c4WWkzBIYlaED4dXKDtxbvB8=; b=kJxt5Q
	YveaSjYsKYn7N4dvWw6DCA5f2suu45vWwDwZleDT12jKmagLRADyueyKdZwpsROQ
	1q/EIspc5s9avwuWmORLL44TMYaAfiBWYxK+E1nV91EeFPINrifMDpAkHHealIHN
	PRM+/MpYYU/diJguaXH8DHXVD/txfeULgZsk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GS0zJEtsBgDtDZsKXsTjKxJk6lwHFj1h
	ZDXGx0GOPHDLh5+oPVZHMGlvsPsvgYS/KDto4GI8U3sdw8RJwOlaZGnq/vfTuK+B
	VQStJkk1cLyMCY2i5xC2mQsc85BwoFuXFtxtVuJiRo21VrfABiVLw4xW85mqf+Hf
	IwMUPljn9Ag=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85D2E810CB;
	Mon, 28 Apr 2014 17:04:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFF2A810C3;
	Mon, 28 Apr 2014 17:04:37 -0400 (EDT)
In-Reply-To: <CAD0k6qR766hrgUtyiGzZ9KM5woknfsyUm3Mf1-Pm3M-LrL2Zhg@mail.gmail.com>
	(Dave Borowitz's message of "Mon, 28 Apr 2014 13:46:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B5537780-CF18-11E3-BE46-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247452>

Dave Borowitz <dborowitz@google.com> writes:

> On Mon, Apr 28, 2014 at 1:05 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Dave Borowitz wrote:
>>
>>> Instead, if CURL_CONFIG is empty or returns an empty result (e.g. due
>>> to curl-config being missing), use the old behavior of falling back to
>>> -lcurl.
>>> ---
>>>  Makefile | 36 +++++++++++++++++++++++++-----------
>>>  1 file changed, 25 insertions(+), 11 deletions(-)
>>
>> Sign-off?
>
> Oops.

Will forge your sign-off while queuing ;-)

>
> How about:
> "If CURL_CONFIG is unset or points to a binary that is not found,
> defaults to the CURLDIR behavior. If CURLDIR is not set, this means
> using -lcurl with no additional library detection (other than
> NEEDS_*_WITH_CURL).

... with this rephrasing.

>>> -                             $(error libcurl not detected; try setting CURLDIR)
>>> +                                $(error libcurl not detected or not compiled with static support)
>>
>> Whitespace damage.
>
> Yes, but intentional, because Makefile parsing is weird.

Thanks.
