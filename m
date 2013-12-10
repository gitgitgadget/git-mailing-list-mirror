From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] gitweb: Add a feature for adding more branch refs
Date: Tue, 10 Dec 2013 10:54:59 -0800
Message-ID: <xmqq4n6gv8n0.fsf@gitster.dls.corp.google.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
	<1386164583-14109-5-git-send-email-krzesimir@endocode.com>
	<CANQwDwe+a2P0Jxqw0k7sHWv3exdb4k+NU3jL3ogR-rcetd82TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Krzesimir Nowak <krzesimir@endocode.com>,
	git <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 19:55:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqSSd-00069X-Gf
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 19:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691Ab3LJSzG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Dec 2013 13:55:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63769 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080Ab3LJSzF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Dec 2013 13:55:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9578B598E7;
	Tue, 10 Dec 2013 13:55:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TtPtO8usNSqM
	HnxXu0L/R2ug3lA=; b=ZITtqQVvn3UIYVrxyvcYyeu7mR/AJcXnVvQPZGf0PH2R
	DlExXm/lay33NwWhEuOuxHyXGf++IZr4RKlJMlQQpTpNXFba+kwqzoUmFb5HyzgO
	KRbp8GsnXphDODRN4Ppliia8gH/9oJkn1+3Q5pXA4Fvi4XneTSlPpm32IpiiAHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=by1l9M
	ljNdFZlZZThIOqJhoruiaff3KyAKJ47nVIiozezKu2Z4bVpr84qYZLzW3N7e67Su
	iqPwbESBpeVZaMw2ThGx060q+Q7+EVyfmcLgJfo5WPvZ7WM4F460R7U5Ay3+h+j7
	cbs2M9LwXN6G7mMT8MfPC1g4ZtFswraXSb+7w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 822CF598E5;
	Tue, 10 Dec 2013 13:55:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D2DA598E2;
	Tue, 10 Dec 2013 13:55:02 -0500 (EST)
In-Reply-To: <CANQwDwe+a2P0Jxqw0k7sHWv3exdb4k+NU3jL3ogR-rcetd82TQ@mail.gmail.com>
	("Jakub =?utf-8?Q?Nar=C4=99bski=22's?= message of "Wed, 4 Dec 2013 19:06:28
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9377771A-61CC-11E3-97BF-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239147>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> With multi-valued we won't be able to override earlier / more generic
> settings... well, unless we add support for no-value, or empty-value
> as clearer, i.e.
>
>   [gitweb]
>            extrabranchrefs =3D sandbox
>            extrabranchrefs
>  # or    extrabranchrefs =3D
>            extrabranchrefs =3D wip other
>
> resulting in ('wip', 'other').

Please don't, unless you are going to change the entire config
machinery (including config.c bits that are used by the rest of the
system) to follow such a convention to "clear settings so far read".

>> ++
>> +It is an error to specify a ref that does not pass "git check-ref-f=
ormat"
>> +scrutiny. Duplicated values are filtered.
>> +
>
> Hmmm... 'snapshot' feature ignores invalid values, but in this case
> formerly valid compression schemes might get invalid via tightening
> %known_snapshot_formats, and we don't want existing config getting
> suddenly invalid.

Sorry, but what does check-ref-format have to do with "formerly
valid compression scheme that suddenly gets invalidated"???
