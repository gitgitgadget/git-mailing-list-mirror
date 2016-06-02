From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] pathspec: allow escaped query values
Date: Thu, 02 Jun 2016 12:29:17 -0700
Message-ID: <xmqqmvn3tmnm.fsf@gitster.mtv.corp.google.com>
References: <20160601235233.21040-1-sbeller@google.com>
	<574F800D.6070107@ramsayjones.plus.com>
	<xmqqy46ouorn.fsf@gitster.mtv.corp.google.com>
	<57505105.2000801@ramsayjones.plus.com>
	<xmqqoa7jvag0.fsf@gitster.mtv.corp.google.com>
	<57507DFD.6010800@ramsayjones.plus.com>
	<CAPc5daWQYRbV_Oc-xCKE2R_O=aMBm_g_CLB=RPUam7EtbGPTgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 21:29:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8YJ4-0004YS-3E
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 21:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933097AbcFBT3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 15:29:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58802 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932378AbcFBT3V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 15:29:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C12981F8A9;
	Thu,  2 Jun 2016 15:29:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dzf3czeGWvqbNEdiZroasI8sQAg=; b=kxVnFa
	uW/NN2TJjIVdI/4NjivvUD60twgibMRNCh/sNMwYRSDjthzDpkVVjxk2rY4UtRHN
	Diq2pH/h8L03gKt5IbyrhUmCYu7U7ZluOZ02gcZ0zZiHjEuYi9SJ9PhwVVEb8hDd
	3Vgx1LucGBUxlcMlkTiKCvujyAGnbldsP2P1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pSwaFROmvebH7TOYFSY6+GS/8hpBF8yV
	MKq+2PQgy+FRkACSHlzP5uJuVp52nlF8ERyY2LnCcJExQcFoRugDL6BN5AlKgWHJ
	uWcxLiLMOU53feIdQbqHHtikIbE/o9JQiVNKljClHFXfSfUSbcCiE/Ai6YDLW6ou
	/xjuzUz/sDo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B6FC01F8A8;
	Thu,  2 Jun 2016 15:29:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 40DAE1F8A7;
	Thu,  2 Jun 2016 15:29:19 -0400 (EDT)
In-Reply-To: <CAPc5daWQYRbV_Oc-xCKE2R_O=aMBm_g_CLB=RPUam7EtbGPTgQ@mail.gmail.com>
	(Junio C. Hamano's message of "Thu, 2 Jun 2016 11:58:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4D26A024-28F8-11E6-A322-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296226>

Junio C Hamano <gitster@pobox.com> writes:

> On Thu, Jun 2, 2016 at 11:42 AM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>>
>>> That would be workable, I would think.  Before attr:VAR=VAL
>>> extention, supported pathspec <magic> were only single lowercase-ascii
>>> alphabet tokens, so nobody would have used " as a part of magic.  So
>>> quting with double-quote pair would work.
>>
>> I was thinking about both ' and ", so that you could do:
>
> Yes, I understood your suggestion as such. Quoting like shells would work
> without breaking backward compatibility for the same reason quoting with
> double-quote and backslash only without supporting single-quotes would
> work.

Having said that, "It would work" does not have to mean "Hence we
must do it that way" at all.  Quoting character pairs make the
parsing and unquoting significantly more complex.

As you said, not many people used attributes and pathspec magic, and
I do not think those who want to use the new "further limits with
attributes" magic, envisioned primarily to be those who want to give
classes to submodules, have compelling reason to name their classes
with anything but lowercase-ascii-alphabet tokens.  So for a practical
purposes, I'd rather see Stefan

 * just implement backquote-blindly-passes-the-next-byte and nothing
   more elaborate; and

 * forbid [^-a-z0-9,_] from being used in the value part in the
   attr:VAR=VAL magic.

at least for now, and concentrate more on the other more important
parts of the submodule enhancement topic.

That way, those who will start using attr:VAR=VAL magic will stick
themselves to lowercase-ascii-alphabet tokens for now (simply
because an attribut that has the forbidden characters in its value
would not be usable with the magic), and we can later extend the
magic syntax parser in a backward compatible way to allow paired
quotes and other "more convenient" syntax.


[Footnote]

*1* The reason I prefer to keep the initially allowed value
characters narrow is because I envision that something like

	:(attr:VAR=(<some expression we will come up with later>))

may become necessary, and do not want to promise users that open or
close parentheses will forever be taken literally.
