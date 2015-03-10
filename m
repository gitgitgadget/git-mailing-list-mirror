From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] bundle.c: fix memory leak
Date: Tue, 10 Mar 2015 16:17:01 -0700
Message-ID: <xmqqk2yoxx1u.fsf@gitster.dls.corp.google.com>
References: <1425920304-22360-1-git-send-email-sbeller@google.com>
	<1425920304-22360-2-git-send-email-sbeller@google.com>
	<xmqq1tkwzdbj.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZ5=Q3WE6Ztr7PJ2Kv2xdKdCB2cD+_MH1GcqEDiZpU11w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 00:17:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVTOf-0005ln-7n
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 00:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbbCJXRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 19:17:05 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54518 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750810AbbCJXRD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 19:17:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1ADA33EF86;
	Tue, 10 Mar 2015 19:17:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ntx41DPBzUcYNRJbGA/AuiGXR1E=; b=A4lsEA
	iGFmTMOfHaiOt6QVWt3KYc7+vDEdyHuPyp0JyCloVYrTLSoKA1lx1HqUQfWrGt/t
	2p8ECmxi4xemJVh+ujNC10TowIzNg9yM0OZ6D7DXgV36iPAnP84DTuCSEe0e0UkC
	abLu6GSDgXsDxA1rn++/DdXlXb/Nft/yzapn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hh6leEsR9YKpTEDxOMIytlI3Bjus2Bsf
	AkT0FOY/8xrXXVCyVdKSLXesu7VBlnWHSQnYEuRpu+6Q7MmaJ0nbmytYmzMmmveT
	ylMrNhe/hXNDQ6YLtItDdw9xw+h5feY3rSoJRQSed8D1Uy8L+bVj+e4NHXsQWdlv
	kUthmlswef4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 125D43EF85;
	Tue, 10 Mar 2015 19:17:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E3783EF83;
	Tue, 10 Mar 2015 19:17:02 -0400 (EDT)
In-Reply-To: <CAGZ79kZ5=Q3WE6Ztr7PJ2Kv2xdKdCB2cD+_MH1GcqEDiZpU11w@mail.gmail.com>
	(Stefan Beller's message of "Tue, 10 Mar 2015 16:08:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8F3C3364-C77B-11E4-B8A9-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265281>

Stefan Beller <sbeller@google.com> writes:

> On Tue, Mar 10, 2015 at 3:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> The continue statements nearby also have an accompanying free(ref);
>>>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>> ---
>>
>> I wonder what happens when dwim_ref() returned 2 or more, though.
>
> That should also be fixed I guess. I'll look into it.
>
> These one liner fixes are mostly done as a side project
> having fun, just doing what the code analysis tools says,
> sorry for not catching that one.
>
> Maybe instead of the reoccuring pattern
>
>     free(ref);
>     continue;
>
> we could just have a
>
>     goto cleanup
>
> which goes to the end of the loop where we have
> the free anyway.

Yeah, I suspect that the end result may look more like that if you
cover the dwim_ref() one as well.

Thanks.
