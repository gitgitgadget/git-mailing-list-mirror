From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 1.7.9, libcharset missing from EXTLIBS
Date: Fri, 10 Feb 2012 12:25:46 -0800
Message-ID: <7vd39mph9x.fsf@alter.siamese.dyndns.org>
References: <4F3472F4.4060605@aegee.org>
 <7v1uq3toyq.fsf@alter.siamese.dyndns.org>
 <CACBZZX45=mr=FMqFF+Pw4KPaDAtvs-ePLbFATpyFA93vSfZatw@mail.gmail.com>
 <4F34EF9D.8030509@aegee.org> <7vipjer0yn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: <dilyan.palauzov@aegee.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 21:25:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvx2Y-0001zw-0r
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 21:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437Ab2BJUZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 15:25:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41928 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932419Ab2BJUZs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 15:25:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BE5A6F0D;
	Fri, 10 Feb 2012 15:25:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q/4U2s5Ksn01kyUEIgHmCtcm1Ks=; b=W0/7zl
	3h9G71IRusmXCFVzyLcuGfBhDyT09/3nXV6vjAIQQi0P+4b/sJltq/9sQcKNccaM
	w2i9UKojnyHR5VepGXG/rQP1Gv7YvzY29d7S2rPnWMfzAW5rLbgNDzmXsGXE80hz
	ROMP3lbw0JY2yrkG5wJDavbfi2jSnpG7BGAN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f8VHFogqfYhOn/292K6TIW+cDv2WkVld
	F0TERui+c+SK7scE+fRN9d8+ueKWvFJrUwUq9SauOAbAiZ+jwAPxH6A6tcgw2rL1
	VXubPuasHCi9N/8iupH6Qiugsjg1kXAS6g0N4j/6oxfzjNJ2wBH1GF2tvcmWjGed
	DeQk1cWDt2g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C3406F0C;
	Fri, 10 Feb 2012 15:25:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C939D6F08; Fri, 10 Feb 2012
 15:25:47 -0500 (EST)
In-Reply-To: <7vipjer0yn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 10 Feb 2012 10:35:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6AB148EE-5425-11E1-ACB0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190451>

Junio C Hamano <gitster@pobox.com> writes:

> Дилян Палаузов <dilyan.palauzov@aegee.org> writes:
>
>>>> What I am wondering is there are systems that need to include the header,
>>>> but locale_charset() does not live in /lib/libcharset.a, in which case we
>>>> cannot make HAVE_LIBCHARSET_H imply use of -lcharset.
>>
>> I do not understand this.  If you want to use a function from
>> libcharset, you have to use both #include <libcharset.h> and
>> -lcharset.
>
> You are mistaken.
>
> The only constraint is that you have to "#include <libcharset.h>" and need
> to link with the library that has locale_charset() defined.

I think the follow-ups in this thread already demonstrated why it is an
insufficient solution to make HAVE_LIBCHARSET_H imply -lcharset.

We would instead need:

	ifeq ($(uname_S),MyHomeBrewLinux)
        	HAVE_LIBCHARSET_H = YesPlease
                EXTLIBS += -lcharset
	endif

or

	# Define NEEDS_CHARSETLIB if you use HAVE_LIBCHARSET_H and
        # need to link with -lcharset
	NEEDS_CHARSETLIB =

	ifeq ($(uname_S),MyHomeBrewLinux)
        	HAVE_LIBCHARSET_H = YesPlease
		NEEDS_CHARSETLIB = YesPlease
	endif

	ifdef NEEDS_CHARSETLIB
        	EXTLIBS += -lcharset
	endif        

or something like that, I guess.
