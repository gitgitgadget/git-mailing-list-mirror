From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] log: honor log.merges= option
Date: Sun, 12 Apr 2015 21:56:26 -0700
Message-ID: <xmqqoams4oed.fsf@gitster.dls.corp.google.com>
References: <1428110521-31028-1-git-send-email-koosha@posteo.de>
	<1428110521-31028-2-git-send-email-koosha@posteo.de>
	<xmqqy4m7ek9q.fsf@gitster.dls.corp.google.com>
	<5524571C.90007@posteo.de>
	<xmqq4morcq0l.fsf@gitster.dls.corp.google.com>
	<5525062A.2010905@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Mon Apr 13 06:56:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhWQV-0003UZ-Hx
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 06:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbbDME4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 00:56:30 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64639 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750845AbbDME42 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 00:56:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D86BA49E15;
	Mon, 13 Apr 2015 00:56:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iv5M91qxv22i6i3ioPZy9XYmDGs=; b=TTBM1u
	nm2ghN8QMfKM5I4+gTxWfd2kLjT8ZPsZifDRSaAUqXfcQO1vJibr/+T5VkRggj+C
	b7O879BpVkCg97jWJRAI8Q4UyUf4y2rNF8XQNpGHBmxw/HILC/H3Idc4eVCRO5nK
	zHIGz/8VAX/Bo/JPvzZ+kpSccZ4qj8UlguQZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H1simd8MbGMtUzaglPXehRGFjeGHcbwR
	3wKZz3UPPLuoSUIGlBR+80eRd3EPszlhj6JVrLkoytLo6EiErS1m9tw94oiX/8zk
	WDz9lgpoxiV5Fus1VcLIYEhTnNlNW39u3EiIlgyXxiq8D/JK4Pmak9sGwsAUMQxZ
	F2A9AOv8aU4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D24CF49E14;
	Mon, 13 Apr 2015 00:56:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5CD5E49E13;
	Mon, 13 Apr 2015 00:56:27 -0400 (EDT)
In-Reply-To: <5525062A.2010905@posteo.de> (Koosha Khajehmoogahi's message of
	"Wed, 08 Apr 2015 12:42:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 713BE0F2-E199-11E4-8CC0-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267062>

Koosha Khajehmoogahi <koosha@posteo.de> writes:

> On 04/08/2015 04:28 AM, Junio C Hamano wrote:
>
>> It is strange that you have to ask me to give you the reason why you
>> chose it that way, isn't it?
>
> AFAIK, the only other command that supports --merges and --no-merges options is
> rev-list. This new feature aims to make a default behavior for the commands
> that have these options. The command-line option is supported by the two commands.
> However, the config var is only used by git-log and rev-list ignores it. I didn't
> exclude rev-list for any particular reason. If we need, I could also handle it in
> rev-list.

As rev-list is plumbing, it shouldn't be affected by the UI level
customization knobs like this one; otherwise you will break people's
scripts when end users choose to use the new knobs.

Historically, "whatchanged" has been the way to ask for "log", with
different default output format (but not different commit selection
logic).  I would think people who are used to "whatchanged" would
expect that the command would pay attention to what "log" would.

As I already mentioned with the reason why, I do not think "show"
and "format-patch" should pay attention to it.

There may be other commands from the "log" family (i.e. what is
defined in builtin/log.c and/or uses get_revision() API to walk the
commit graph), for which similar reasoning should be done to decide
if each of them should or should not pay attention to it.

Thanks.
