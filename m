From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 49/83] builtin/apply: move 'lock_file' global into 'struct apply_state'
Date: Thu, 28 Apr 2016 13:17:55 -0700
Message-ID: <xmqq1t5p4he4.fsf@gitster.mtv.corp.google.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-50-git-send-email-chriscool@tuxfamily.org>
	<CAPig+cRSe8oOjo2h6SuJQyD+he_Q7zHfF4TivZ0amhAu4HLQ+g@mail.gmail.com>
	<xmqqzishlgj1.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD1=w2D-5q9bWrYqzL3v1q7fYi9imy1UhG2OaW2vB=2ECA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 22:18:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avsNv-0003FM-Ev
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 22:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbcD1UR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 16:17:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751829AbcD1UR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 16:17:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8224A157D6;
	Thu, 28 Apr 2016 16:17:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xnXCym8/Hx3ygOX6sJaYAeCAl7w=; b=u0/P+B
	dWoL1Z7YxsBs0dZ8nYcCgGjWWBuWE9wbS/TrrkZ7z2D4hrkF+pSd7FJ5XngEIYnM
	h1Iqt9yN/SiLhdMQ4ZE6dOtpyuuuXGLzv/xJuOR6Tu4+2o1bpKN5Knnkpehn8XhF
	hNgLCGiYcb5GiHzmS2NEmM/An4gv7OYaiFp3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KBbY9iQvy3o9SkB9hpe0XfcHddd7tAUe
	3mKG449rSEsrgrqnDmV74qhXc+hC9Luhs6+xpCyWCcnZff6vY3atGV+idCYaJ9jC
	Ehwxay269R69XX1UzcHr8w/rY+gmXnrbWQ5oPB7KOc+mg5vQbwAImsxdocEwpH6X
	KdxYyrST6yQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7987D157D2;
	Thu, 28 Apr 2016 16:17:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C6D0F157D0;
	Thu, 28 Apr 2016 16:17:56 -0400 (EDT)
In-Reply-To: <CAP8UFD1=w2D-5q9bWrYqzL3v1q7fYi9imy1UhG2OaW2vB=2ECA@mail.gmail.com>
	(Christian Couder's message of "Thu, 28 Apr 2016 18:30:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4BBA7AC0-0D7E-11E6-98E3-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292950>

Christian Couder <christian.couder@gmail.com> writes:

>> I do not think you need to think about "free"ing.
>
> Yeah, lockfile.h says:
> ...
> and:
> ...

Yup, we are now on the same page.

>> Even if the libified version of the apply internal can be called
>> multiple times to process multiple patch inputs, there is no need to
>> run multiple instances of it yet.  And a lockfile, after the caller
>> finishes interacting with one file using it by calling commit or
>> rollback, can be reused to interact with another file.

lockfile.h says this about the above paragraph, which is a more
important part ;-)

 * When finished writing, the caller can:
 * ...
 * Even after the lockfile is committed or rolled back, the
 * `lock_file` object must not be freed or altered by the caller.
 * However, it may be reused; just pass it to another call of
 * `hold_lock_file_for_update()`.
