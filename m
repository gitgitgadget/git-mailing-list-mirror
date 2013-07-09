From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] blame: accept multiple -L ranges
Date: Tue, 09 Jul 2013 11:57:59 -0700
Message-ID: <7vtxk3v9vs.fsf@alter.siamese.dyndns.org>
References: <1373186706-19284-1-git-send-email-sunshine@sunshineco.com>
	<7vk3l26695.fsf@alter.siamese.dyndns.org>
	<CAPig+cQ9sfV+PRqn5vrL0=xOZrKDDmsKdAPiB4PsCFb=jnk4kQ@mail.gmail.com>
	<7v38rnwuvb.fsf@alter.siamese.dyndns.org>
	<87ehb7d3za.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 09 20:58:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwd71-0005YG-Er
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 20:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193Ab3GIS6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 14:58:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39606 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076Ab3GIS6B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 14:58:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C3A02F499;
	Tue,  9 Jul 2013 18:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YiVG17VozAiYQtsMxShs30oa4s4=; b=WpKTJy
	0a2ykm3RUBQSVh+maHFC9t/RHojy075iEluCI3kfb4LoyngodpXcki3Xm8uU5bJA
	LHbeaiE8eeDv0vP5ABTqrpY95oLdDdtoVuRTgMCmor2Yt1edcdWu3L80u2WufnqG
	zObE9PNzmsOgFmKla+K6rD+nO14Xwbt3wS4e0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DSbsuFneT7gO0bG8hTKrYrxkWxkN8ceb
	km/SYcAHZY9nNtA1ElEVbdZjK7Ji+/LD+chSIk2XUjAAkixseYkDskySlYw7JeAE
	i1+W0KPtNtW7keScf0zFQFD0DcHsqHLYWDnH5rWcs7sJA29nFkDbZP/LdxIauMTd
	wt2HemhjzEU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FFAB2F498;
	Tue,  9 Jul 2013 18:58:01 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2E092F497;
	Tue,  9 Jul 2013 18:58:00 +0000 (UTC)
In-Reply-To: <87ehb7d3za.fsf@hexa.v.cablecom.net> (Thomas Rast's message of
	"Tue, 9 Jul 2013 19:42:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79FFFB44-E8C9-11E2-BAD8-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229979>

Thomas Rast <trast@inf.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>  (2) In the ranges "-L <anything>,/B/ -L /C/,<anything>", the
>>      beginning of the second range is found by choosing C that comes
>>      _after_ the end of the previous range (/B/ may choose either
>>      the second or the 4th line, and the only C that comes after
>>      either of them is the 5th line and that is where the second
>>      range should begin, not at the beginning of the file).  The
>>      same for "-L 1,3 -L /C/" (only C that comes after 3 is eligible
>>      to be the beginning of the second range).
>
> So passing several -L arguments does not blame the union of what each
> argument would blame individually?  Doesn't that make it rather harder
> to explain?
>
> In any case, if you define it like that for blame, log -L should be
> changed to match.

I thought "log -L" was fundamnetally different as it is per path.
For example, -L1,100:hello.c and -L5,105:goodbye.c would not
intersect/overlap.

If you mean to coalesce -L1,100:hello.c and -L5,105:hello.c into a
single -L1,105:hello.c, then yes I think it makes sense.
