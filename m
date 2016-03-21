From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][Outreachy] branch -D: allow - as abbreviation of @{-1}
Date: Mon, 21 Mar 2016 11:12:40 -0700
Message-ID: <xmqqegb3n1if.fsf@gitster.mtv.corp.google.com>
References: <1458573317-15532-1-git-send-email-elena.petrashen@gmail.com>
	<vpqfuvju4km.fsf@anie.imag.fr>
	<xmqqtwjzn2nu.fsf@gitster.mtv.corp.google.com>
	<CAPig+cQNBeBaLb-znNgxOanUz++pQLae=c8vUtFXjqxOns4d-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Elena Petrashen <elena.petrashen@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 19:12:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai4Jy-0002iK-Ee
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 19:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851AbcCUSMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 14:12:44 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756223AbcCUSMn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 14:12:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6D4DB4E91C;
	Mon, 21 Mar 2016 14:12:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Gxg82JZ6GHOHP0VS/utQVJkfrrk=; b=ZSxnMarwSN4ESKELaDY4
	oUAQUvUDJby+6D2KJVWDDW4wBkEgZNBzkeCYoK9Fgpo5Om6Ap/fb1cRGstRZCQp6
	9ccPAZhBVZ7zsFwma5l3BRdWhDjsr8ANXImFa4za+RH1xlO2Yc9T2WNq2NgXtWQn
	fdJ/orgzlmbUTbe2wi9OVDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=qo1kOuiZQbg90U7l+dP84hW7rsqG3hOudc6qJqlQyMGXZs
	iCIz5Pc+Tz27BRFrPNC77Ocu/yC1EHZg9yHAFFpVP0xdsH7mms7LWc1UtE4P44x/
	+XNVPcSiSFawMZA7Mn4+nSwvdMQLVHkrtb2PFrFYaKYo9Vl3mJqCrEUAxrCiE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 63FAA4E91B;
	Mon, 21 Mar 2016 14:12:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A6BF94E918;
	Mon, 21 Mar 2016 14:12:41 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 80A02A2A-EF90-11E5-A8F9-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289432>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Mar 21, 2016 at 1:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>> But I'm not sure how often people want to delete (force-delete according
>>> to your message) the branch they just come from.
>>
>> One that I heard was this sequence:
>>
>>     $ git checkout -b work master
>>     $ work work work ...
>>     $ git checkout master
>>     $ git merge work
>>     $ git branch -d work
>>
>> where their argument was that they are done with the work branch,
>> and it no longer is needed.
>
> I frequently use throwaway branches when messing around with some idea
> or when reviewing patches submitted to the mailing list, and the
> workflow ends up being similar to the above:
>
>     $ git checkout -b throwaway master
>     $ ...work work work...
>     $ git checkout master
>     $ git branch -D throwaway
>
> So, I can see how having "git branch -D" (force-delete) recognize "-"
> could be a convenience.

I guess that it would make some sense in ancient world, but there is
detached HEAD for that workflow, so it is unlikely that I'd find it
useful myself (in my worldview, throw-away work is discardable by
default, which is why I start from detached HEAD, until I find that
the result is more interesting than I originally thought and decide
to save it to a more permanent branch with "checkout -b" from
there).

But of course people are different.

In any case, we found two plausible explanation why people may want
to do this.  I however tend to agree with Matthieu that it may be
safer not to give a short-hand access to destructive operations.
