From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] builtin/apply: handle parse_binary() failure
Date: Fri, 01 Apr 2016 10:16:58 -0700
Message-ID: <xmqqvb41i705.fsf@gitster.mtv.corp.google.com>
References: <1458304241-537-1-git-send-email-chriscool@tuxfamily.org>
	<CAP8UFD2vx17KDf5HgSYYZudbXiq7CYDg0=hXbJuJrLp9QDfJUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 19:17:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am2h1-0000HN-A9
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 19:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbcDARRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 13:17:03 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56006 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751251AbcDARRB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 13:17:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AFE3F4F8B3;
	Fri,  1 Apr 2016 13:17:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g1yph4qzoQRRkO6bwkjXmUSa+XA=; b=FpY8/n
	WwNUdr3XO9zGTzwQAcrBYS70djmAvWQg+FmeRl7hJaP2ieYafRCYzqvAZDHottay
	6k2SrsUjRkpdFOqP2ZYapU3GGVDbsKeyl9JRE8+MeEBPDICxKrAwbnNNSI2mMjpG
	39C4/9l+KtW9kyzsY2jIiFEB1xTdOG74rjQ+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hZweCRfeanJcp0I7zLb1j/6DgAzs8j6i
	VAh5Gpedp+pvYT792IuFUQACorrA8cVF9OZOW8qArWf9M1zOjVI5MQIoXkYleY2H
	XS1CK/lZc+UncBbTuCXv/7dQ8C0bfTuVcCnZyrAqljAR+rg9yrhYV2gdoI0egqTv
	Tlg7thaf/68=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 927094F8B2;
	Fri,  1 Apr 2016 13:17:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BB67C4F8B1;
	Fri,  1 Apr 2016 13:16:59 -0400 (EDT)
In-Reply-To: <CAP8UFD2vx17KDf5HgSYYZudbXiq7CYDg0=hXbJuJrLp9QDfJUg@mail.gmail.com>
	(Christian Couder's message of "Thu, 31 Mar 2016 18:26:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8B3B46CC-F82D-11E5-AD59-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290563>

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Mar 18, 2016 at 1:30 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> In parse_binary() there is:
>>
>>         forward = parse_binary_hunk(&buffer, &size, &status, &used);
>>         if (!forward && !status)
>>                 /* there has to be one hunk (forward hunk) */
>>                 return error(_("unrecognized binary patch at line %d"), linenr-1);
>>
>> so parse_binary() can return -1, because that's what error() returns.
>>
>> Also parse_binary_hunk() sets "status" to -1 in case of error and
>> parse_binary() does "if (status) return status;".
>>
>> In this case parse_chunk() should not add -1 to the patchsize it computes.
>> It is better for future libification efforts to make it just return -1.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> Only the title of the patch changed in this version compared to v2.
>
> It looks like this patch is not in pu. Maybe it has fallen through the cracks?

Yup, it indeed was ignored (giving priority to work towards 2.8
during the freeze) and then was forgotten.

My comment on the first one that exited mentions "your follow-up
patch", but I cannot quite tell which one, as there was no threading
in your original patches.  Does this change need to come before
something else that I already have?
