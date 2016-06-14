From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 02/40] builtin/apply: make apply_patch() return -1 instead of die()ing
Date: Tue, 14 Jun 2016 10:50:55 -0700
Message-ID: <xmqqlh27accg.fsf@gitster.mtv.corp.google.com>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
	<20160613160942.1806-3-chriscool@tuxfamily.org>
	<xmqq37ogbswg.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD1zPUZQTY_rdMwK8vQBd7M5d8gPdTaEmfrg_Q74Y5B2Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 19:51:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCsUS-00071O-2S
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 19:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbcFNRu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 13:50:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752142AbcFNRu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 13:50:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DD733200F2;
	Tue, 14 Jun 2016 13:50:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1IoM0PM1pifPjNLMy4/oBLS6TXI=; b=ml7lzV
	7bhkmBwOT6+5LypuUcL6YkGCNmjQ28EkHQIqo75B7Kqop+jeRJN+tqCt4POoOOiK
	1akZd03FPQcZIMOCgsCEZgpk66qCc4E0GgQvA4K9ayKUSWqVbxd11M+Us3S9ROtL
	dW5YkXHPoWUMR40h0QWtZhYPNy+oWwo7JR8sM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vaH4XM2WJS8y2UYAn/gKMBmBQJucBGcM
	Qm3m9Pi2It6ffjS6MDuDK8uB4gxVaph8lm+nZwx0d4O14dLpSDp4j4jXeFUJ3AVQ
	X2uGiwEEDVsPzi2VcKgnKPzJ00bPiZCyEjqnTW6HiIC1cMgZEZ+n+W7rxIxh3X9k
	zo6gf30LeKM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D5D6C200F0;
	Tue, 14 Jun 2016 13:50:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C710200EF;
	Tue, 14 Jun 2016 13:50:57 -0400 (EDT)
In-Reply-To: <CAP8UFD1zPUZQTY_rdMwK8vQBd7M5d8gPdTaEmfrg_Q74Y5B2Ew@mail.gmail.com>
	(Christian Couder's message of "Tue, 14 Jun 2016 13:06:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8C59837E-3258-11E6-B5B8-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297312>

Christian Couder <christian.couder@gmail.com> writes:

>> Before this patch, the program said "fatal: $message" and exited
>> with status = 128.  All these changes in this step modifies the
>> external behaviour and make it say "error: $message" and exit with
>> status = 1 (at least the caller in apply_all_patches() does so).
>>
>> Will that be an issue for the calling scripts?
>
> Hopefully the scripts don't check the specific error code and message.

The error codes are designed to be a vehicle that carries
information in a robust way, so it is perfectly understandable if
the callers used it to tell hopelessly broken input that caused
"die" and an otherwise sensible patch that does not happen to
apply.  Whoever is changing the external behaviour is responsible
for making sure the existing callers are not broken.

Hope is not a sound software engineering practice.
