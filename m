From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] advice: extract function to print messages with
 prefix
Date: Fri, 07 Sep 2012 13:52:31 -0700
Message-ID: <7vfw6two6o.fsf@alter.siamese.dyndns.org>
References: <7vhar9ybgk.fsf@alter.siamese.dyndns.org>
 <1347044705-17268-1-git-send-email-ralf.thielow@gmail.com>
 <1347044705-17268-2-git-send-email-ralf.thielow@gmail.com>
 <7v1uidy6ga.fsf@alter.siamese.dyndns.org>
 <CAN0XMOK5QnNn8471RF4y7u_X0rfda=-J-KrCtyMsgCGHXNrwVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, worldhello.net@gmail.com, pclouds@gmail.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 22:52:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA5Xf-0005hM-U3
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 22:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755631Ab2IGUwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 16:52:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65071 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755459Ab2IGUwf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 16:52:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DD4C9D20;
	Fri,  7 Sep 2012 16:52:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K6pWtTaEFcDUeP0soZ4gbk6Zgfg=; b=cV0f+v
	0qBpYrC3U//8XXkhQWF0rS+0EOGLMbW/V489sKobaFX0oGjqiD0NslP1Fb5tuUDa
	ZfDk9gjPrFZtsakrbhFCWITgpTSqFk6rnvVqbVVv2/Ee2NES/YKho5YJL+8WYaxf
	kOAGzuQ4FEsWr+n5K/CBmxZvCjGWCd9XigDac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gL0oRmyrZjYAHcHWryKctzbK1cQrVh4g
	e6x84ia8yCCAgtrKqbVcmYCjPsC1yTpgcDW8A7XWHgUt872YcOAJVbEHWl+WavvT
	OzoRKKDLRvgWGHDnOLt31AmP9jRu2aOBsfLRLBS4H11T67YkLQMYEq57yEuWOCe9
	sTP4UYmI780=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE8399D1F;
	Fri,  7 Sep 2012 16:52:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 545219D1B; Fri,  7 Sep 2012
 16:52:33 -0400 (EDT)
In-Reply-To: <CAN0XMOK5QnNn8471RF4y7u_X0rfda=-J-KrCtyMsgCGHXNrwVw@mail.gmail.com> (Ralf
 Thielow's message of "Fri, 7 Sep 2012 21:56:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F267583E-F92D-11E1-A0DD-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204998>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> On Fri, Sep 7, 2012 at 9:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>> -             fprintf(stderr, _("hint: %.*s\n"), (int)(np - cp), cp);
>>> +             fprintf(stderr,  "%s %.*s\n", prefix, (int)(np - cp), cp);
>>
>> Hrm, naively, printf("%s: %.*s\n", _("hint"), ...) might look more
>> natural, but I vaguely recall that the current code places _()
>> around the entire "hint: %.*s\n" on purpose.  IIRC, it was to allow
>> translations that flow from RTL e.g. ".siht od t'nod :tnih".
>>
>> Doesn't this patch break it?
>
> Sorry but I don't know what you mean with "translations that flow
> from RTL e.g. ".siht od t'nod :tnih"." so I can't check this.
> As far as I can see the callers only put a simple message in it,
> e.g. advise(_("Commit your changes or stash them to proceed."));
> So I don't think that this patch would break anything.

Your patch would not allow target languages that want to put the
_("hint") at the *tail* end of each line of the message.  With the
original, with something like this:

	msgid "hint: %.*s\n"
        msgstr "%.*s :tnih\n"

you could do that if you wanted to.
