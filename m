From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Tue, 03 Sep 2013 15:38:58 -0700
Message-ID: <xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 00:39:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGzFh-0001h8-CG
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 00:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761132Ab3ICWjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 18:39:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62656 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755766Ab3ICWjG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 18:39:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B88723F879;
	Tue,  3 Sep 2013 22:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Guw5TRgb4guPbEQDgQHblf37SI8=; b=yeinTQ
	NYiU5YJqNlarFZOaGrm8ZBe1EL1hiN76rdW+IpH4Ytu+1fMT6gfTvoOrzuGivw9e
	nrJO7jjgtzxE0g+L/1dILnR4KPhnxTCUNTdgrja+V2WH4XANjl69v4l6kaaKeRFp
	3cxRTdMOFXLtl9GjL/Y/n6rQfb4edZE7E1C6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IpG+i+7w3h2bvlKqP5KK+g8gm6+vq4Li
	+SvF7ArSywnNgoArlI9KYpTj7YZoQph6Q7ZxWurpJZQ0/+Ces2mHCeCbBu4UVtSX
	OMG/fZdxBr6O4i81G8MuDH6MKlZgeAAjuefpfmXTqs3KIDfvu9b8YycVmIzhP8aa
	EV2SfapUUXo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 031A83F873;
	Tue,  3 Sep 2013 22:39:05 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 267FF3F865;
	Tue,  3 Sep 2013 22:39:02 +0000 (UTC)
In-Reply-To: <CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 3 Sep 2013 16:50:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A1EC01B0-14E9-11E3-BECD-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233791>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Sep 3, 2013 at 12:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Junio already sent a similar patch, but I think this is simpler.
>>
>> I agree that this is simpler, but I am not sure if the behaviour is
>> necessarily better (note that this is different from saying "I think
>> the behaviour of this patch is worse").  The motivation I read from
>> the original discussion was that new people did "git pull" (no other
>> parameters) to "sync my tree with the central repository" as if it
>> were SVN, and because we are not SVN, projects that prefer rebases
>> were unhappy, and the other one was to address *only* that use case.
>> I do not personally like that special casing (i.e. "only when no
>> 'integrate with what from where' is given"), and applying the "you
>> must be explicit between rebase and merge" like this series does
>> uniformly might (or might not) be a good thing.  I dunno.
>
> As I already said; there's is essentially no difference between "git
> pull" and "git pull origin".

We know what you said earlier. That does not make it right or wrong,
but I do not think it is in line with the original discussion (that
is why John Keeping is kept on the Cc: line).

>> The difference in changes needed to the test suite is illustrative;
>> this series affects any use of "git pull" (with or without explicit
>> "what to integrate with and from where"), unlike the other one that
>> only affects the case where "git pull" was not given "what to
>> integrate with and from where".  I think an earlier draft I did for
>> the previous one did not special case "only when no 'integrate with
>> what from where' is given" and had to touch all the places in the
>> test in a similar way.
>
> Yeah, that version affects less, but it also doesn't achieve what we
> actually want.

I do not think we know what we want is to affect "git pull origin".
