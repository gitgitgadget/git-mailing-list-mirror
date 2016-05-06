From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 78/83] Move libified code from builtin/apply.c to apply.{c,h}
Date: Fri, 06 May 2016 14:07:41 -0700
Message-ID: <xmqq4maa3nfm.fsf@gitster.mtv.corp.google.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-79-git-send-email-chriscool@tuxfamily.org>
	<CACsJy8Cb20L=y_=J6S5=rngvH1n0aWvtf5eJrXP-df0aoiJyrQ@mail.gmail.com>
	<CAP8UFD3o_u48rRHP7ZOWnVH7X0O5wwM-Gk-VpH5PP_kFx19ZpQ@mail.gmail.com>
	<CACsJy8AtEv9HHOJUDVKmO=qLkWctvS2zoGdo03jtQwyy2kKzRQ@mail.gmail.com>
	<CAP8UFD0Ku_q56JMvyh9UncJ2D+QsOcB4Svyr5ZWj+KqAaHORMw@mail.gmail.com>
	<CAP8UFD0ktQyk3SHFbq=fjK8++UArNmy+3p3CCgHaDBT5WRwU6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 23:07:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aymyU-0007aT-5I
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 23:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758846AbcEFVHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 17:07:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62934 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758841AbcEFVHp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 17:07:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D97831849E;
	Fri,  6 May 2016 17:07:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3lVO8qGqV2Q8WNrzPBuGBWkhYkg=; b=hSoYPI
	dbFrHwNlW/knP2sNL+NOf88qfQZXNvkD+LpAAGUTb/x3rQxKdBsol7QskADv3BZu
	8EdgMkeFR4rHhyrGFmMSoCjUr/0N8OgRsSsijz5nG3Xka1qVdDjvLWW1Kme79IeA
	sfmbtmBwHJiHnkslWYquURPINWMjuD4Qu8/9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c5+oTMHeaQ5fREotmU6EOT02r1b0lDe+
	aMnE+1s7OjZ4UYlZ1GmUhPh7SUd5X75WwzqG9wL1hbD9FM8a6IlVL27Q6e/OX8pD
	hNHHi7oUjd2x+wr8zuT28+lF/8RPLvxGKZXf0TS45zwApc0wdO0NmSxnB5JBKkkT
	Iomz7P9HU40=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CFB551849D;
	Fri,  6 May 2016 17:07:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 37FDF1849C;
	Fri,  6 May 2016 17:07:43 -0400 (EDT)
In-Reply-To: <CAP8UFD0ktQyk3SHFbq=fjK8++UArNmy+3p3CCgHaDBT5WRwU6Q@mail.gmail.com>
	(Christian Couder's message of "Fri, 6 May 2016 22:18:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9312BB98-13CE-11E6-A743-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293861>

Christian Couder <christian.couder@gmail.com> writes:

> By the way does someone know how such a patch can be applied?

Perhaps this one?

    http://thread.gmane.org/gmane.linux.kernel/1879635
