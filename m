From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10] ls-files: add eol diagnostics
Date: Tue, 12 Jan 2016 09:50:37 -0800
Message-ID: <xmqqd1t6vg9e.fsf@gitster.mtv.corp.google.com>
References: <1452446203-20693-1-git-send-email-tboegi@web.de>
	<xmqq8u3wxb0i.fsf@gitster.mtv.corp.google.com>
	<56949C53.5030605@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 12 18:50:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ35o-0007ZW-0R
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 18:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763840AbcALRur convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jan 2016 12:50:47 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61440 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1763834AbcALRup convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jan 2016 12:50:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5283A38FB9;
	Tue, 12 Jan 2016 12:50:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/6jCAJZTBe8N
	+MpBYoKEFBnpNuo=; b=sN2y0geNQ0KIlxPO5dXmpL71bJszrWnN7BjIYsFcx8QA
	YU2R+9tH1tPuE2aL/dlxEDcIr6k7iXHEXck2Eg1iHoKGn7EQh/pj5j1bj36YyKof
	4MGPAMgQ+rW3YyWKGyA664BlKGc71uWj9gtdaFeAyAWASVI+OGvvlZF3DBjIiUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oB/FRV
	t36IZvX+7CGa6VI35k67unVH5fcrbO8iXJI9tmBZX8UDBW0ZrGhZbplDZp27iVnL
	+BzIk4gqtjr8nCXgJ3qR+uR05gijPw9dgv9m2eMxfA3mVRkQrPV7cDUNfw6CDshz
	XimvqfYAb9XI9VhG5mAJcsjf2Qp69OXIbUWn4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4AEF638FB6;
	Tue, 12 Jan 2016 12:50:39 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C04D538FB5;
	Tue, 12 Jan 2016 12:50:38 -0500 (EST)
In-Reply-To: <56949C53.5030605@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 12 Jan 2016 07:25:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FD9DAE7A-B954-11E5-83E3-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283827>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 01/11/2016 06:48 PM, Junio C Hamano wrote:
>
> Thanks for comments
>>> +		if (line_terminator =3D=3D '\n')
>>> +			printf("i/%-6s w/%-6s attr/%-9s ", i_txt, w_txt, a_txt);
>> Can we do something better than these hard-coded constants?  Why
>> can't the "one HT between each" approach be used for both?
> v11 will make more clear, that currently "eol=3Dcrlf" is the same as
> "text eol=3Dcrlf".
> The shortest attr is then "", the longest "text eol=3Dcrlf".
> Using '\t' as a separator makes the output cluttered for a human read=
er.
>
> When parsing the output, the '\t' is much more convenient (and that's
> what t0027 wil use).
> Is there any chance to have a selection between human-friendly and
> script-friendly ?
> Would an option -e (eol info using spaces) vs --eol (eol info with
> TABs) make sence ?

I do not think so; what you have in v10 is infinitely better.

What I found disturbing the most was these hardcoded numbers 6,6,9
in the printf format.
