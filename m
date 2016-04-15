From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 03/16] index-helper: new daemon for caching index and related stuff
Date: Thu, 14 Apr 2016 18:31:53 -0700
Message-ID: <xmqqfuunejxy.fsf@gitster.mtv.corp.google.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
	<1459980722-4836-4-git-send-email-dturner@twopensource.com>
	<CACsJy8C5NhaAAW=wzpwkBdLvVZz8wVM7QX==n_CL5g+LLAKY=A@mail.gmail.com>
	<1460153784.5540.19.camel@twopensource.com>
	<1460417232.5540.53.camel@twopensource.com>
	<CACsJy8C2FtdetQ_NJSKR_JCZ5Ju0E3rV7Du=J4f2_kn5qrcHxg@mail.gmail.com>
	<1460482108.5540.59.camel@twopensource.com>
	<xmqqfuuqr9ca.fsf@gitster.mtv.corp.google.com>
	<CACsJy8B6o-8YJYemcYX3NwyMaY9jV666ZwKJYwfbwMSmzM-YGw@mail.gmail.com>
	<xmqqd1psgiuc.fsf@gitster.mtv.corp.google.com>
	<CACsJy8C9wA=Yig6n4evqYnpOTqOWKbH4kXH5OaYTRvS_5a+a8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w6Z2YXIgw77Ds3I=?= <aevarb@gmail.com>,
	jeffhost@microsoft.com
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 03:32:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqscr-00028B-Tb
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 03:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbcDOBcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 21:32:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752059AbcDOBcp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 21:32:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ACEB813405;
	Thu, 14 Apr 2016 21:32:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4nkHSO9K1/ZiBN4kxmFeh1bJ4eg=; b=e7kYpA
	4XIRA8z2OP/jFXqus/5S/K+EUW221dnkEmfuUHZ5IPpYI8qJSwAMFwuoosoSQLFV
	8YGGlRyCWWbFayPlHkcho3Frs4aPOemVJh08e5Vti+X9cmwoBzZracJ6S0GMcmbi
	z5fctKNoPd5MSt6lRUPjWXeRl6yCtHfDkm4ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oMCRjYNiWba9ZsOCiFMmYMLdmUEGyzCd
	goX2YubjtQsrVJ9ArDjdmQMZT2315TW6VfB64+evIkHCFjcuL/ghJaMhMt5PY497
	XLaptb4l8IvAQCMQA3Xhl0MdeKn1PDw+VpogTp0wq0/eHQQ0ChJqMz0Dg9ZqLoWq
	3K72BE72ZF0=
Received: from pb-smtp2. (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A376113403;
	Thu, 14 Apr 2016 21:32:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4496E133D5;
	Thu, 14 Apr 2016 21:31:54 -0400 (EDT)
In-Reply-To: <CACsJy8C9wA=Yig6n4evqYnpOTqOWKbH4kXH5OaYTRvS_5a+a8A@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 15 Apr 2016 07:16:03 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D5F2E34C-02A9-11E6-BCBA-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291588>

Duy Nguyen <pclouds@gmail.com> writes:

> We don't hold this memory forever though. If the daemon is idle for a
> while, it exits, releasing memory back to system. And not using
> mlock() already gives the OS more freedom in memory usage.

Yup, that is why I suspected you wanted to use something other than
mlock().
