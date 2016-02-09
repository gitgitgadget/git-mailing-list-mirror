From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv9 1/6] submodule-config: keep update strategy around
Date: Tue, 09 Feb 2016 14:29:31 -0800
Message-ID: <xmqqk2md1pro.fsf@gitster.mtv.corp.google.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
	<1455051274-15256-2-git-send-email-sbeller@google.com>
	<xmqqh9hh382i.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYm79C7tLECeJCrS3JoCudUT-8geovoMpT8qoHpYBjUAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 23:29:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTGmw-00034q-2f
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 23:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933063AbcBIW3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 17:29:34 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55902 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932434AbcBIW3e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 17:29:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 55545424E0;
	Tue,  9 Feb 2016 17:29:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6X72nja8ykAFfRc0WnPQ93F242s=; b=yTA3pg
	EDdFY1w+yzKftSykeUcsPTfOh5FK9O9wDEVBUqA6BTXt+R7VysD3h8ZZH8DAeAHJ
	mK+BNND98BnMH/4vsRgYySyq/VuO5WTMFjcfxtpFkmMsvKfqwWNlGyBfOUsXAdX/
	SoaniW0s5aRQLWgDG1fVMlVFmG3t9YEwHteCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pwqtzXd+//LaDMaOD0osdtaceA+/mS0Y
	o/DJ7EEsAaE9G6GHsCm30vT3K9QueVmV7MeGFtCA0wemCqQZsRORbyQdMFtpClxM
	sM95fnawWiyHMxq+LmbLma8wUfILi/v8u67er9A8RQwo1TqxBb38bAhL22eWtgcZ
	cBuV0MP+5A4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4C8C3424DC;
	Tue,  9 Feb 2016 17:29:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B084B424DB;
	Tue,  9 Feb 2016 17:29:32 -0500 (EST)
In-Reply-To: <CAGZ79kYm79C7tLECeJCrS3JoCudUT-8geovoMpT8qoHpYBjUAg@mail.gmail.com>
	(Stefan Beller's message of "Tue, 9 Feb 2016 14:19:42 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 976C6522-CF7C-11E5-827E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285878>

Stefan Beller <sbeller@google.com> writes:

> On Tue, Feb 9, 2016 at 1:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> +     } else if (!strcmp(item.buf, "update")) {
>>> +             if (!value)
>>> +                     ret = config_error_nonbool(var);
>>> +             else if (!me->overwrite &&
>>> +                 submodule->update != SM_UPDATE_UNSPECIFIED)
>>
>> Funny indentation here (locally fixable).
>
> I looked through the code base and reread our CodingGuidelines
> to find out what is considered correct. (I assumed we had a gnu-ish
> coding style w.r.t. breaking overly long lines in conditions, which is
> having the next line be indented with 4 spaces.)
>
> So I assume by funny you mean "the next line doesn't start below the
> opening parenthesis"?

I think we typically do one of the two:

        if (A &&
            B && C && ...)

or

        if (A &&
                B && C && ...)

That is, the second line may align just inside the open paren on the
first line, or even deeper, but never shallower.
