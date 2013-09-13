From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Fri, 13 Sep 2013 15:06:42 -0700
Message-ID: <xmqqli30idfx.fsf@gitster.dls.corp.google.com>
References: <523094F0.9000509@gmail.com> <20130911182921.GE4326@google.com>
	<CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
	<20130911214116.GA12235@sigill.intra.peff.net>
	<CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
	<20130912101419.GY2582@serenity.lan>
	<xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
	<20130912182057.GB32069@sigill.intra.peff.net>
	<CAHGBnuPzzokV7YMrx0gAL1VACcmaLwFoaB3n6bX8Y-UDHs7S8A@mail.gmail.com>
	<20130912202246.GF32069@sigill.intra.peff.net>
	<xmqqr4ctokat.fsf@gitster.dls.corp.google.com>
	<CAHGBnuOQ-y1beD_X_jiH+FrhPvLOVJqT0J=Wk988Q4NeCs1-9Q@mail.gmail.com>
	<xmqqppsckcsd.fsf@gitster.dls.corp.google.com>
	<CAHGBnuMNDJhAqNfgVRHRE-7R=UZbd+fMExYeKDWWCFjyQJYYTQ@mail.gmail.com>
	<xmqqppscij8a.fsf@gitster.dls.corp.google.com>
	<CAHGBnuM=QqLxPNNZmoL1jG+oAm2y6o=AuBtkH+FRwZ_8ahGC+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 14 00:06:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKbVr-0003FU-2T
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 00:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211Ab3IMWGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 18:06:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50490 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754990Ab3IMWGq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 18:06:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CA2041A0E;
	Fri, 13 Sep 2013 22:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7uSGV0PW6DqThE5jeHUNxG+QyEg=; b=iFHOhK
	Pk+mZfaBa2JVbUeRBiJ6W664Ne/pzCJs+pGk0iPNMSdWWZEZhhPFIEZ3lDN2DzUa
	YnsLnMiyxYZKQL1Jnx+c61yIUHiT7ilGKqYCnRP/+4DghbyJDSronk+nrewgrTjO
	tDyQy+znuRVclgV0zFcTQxIH8P5mBWaWe1oHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LtXelA5/jxUWmePY0kvJKafBA02vg/95
	V808TUAcXaMT7I1OG4mcM/9VEnF1RE6g6XRi4Y8hT/ppR5OCtQap+C2NT0f3U3iy
	z3LV2FJuMkoyBZt7KQlLtiQtHBDps7i7mNASl+v89tE8H5XOtjYk4VCwU9F2xDnK
	QjmGeJ2HY5Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 332E341A0D;
	Fri, 13 Sep 2013 22:06:45 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F73941A0B;
	Fri, 13 Sep 2013 22:06:44 +0000 (UTC)
In-Reply-To: <CAHGBnuM=QqLxPNNZmoL1jG+oAm2y6o=AuBtkH+FRwZ_8ahGC+w@mail.gmail.com>
	(Sebastian Schuberth's message of "Fri, 13 Sep 2013 22:04:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C6D92D98-1CC0-11E3-BE6B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234776>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Fri, Sep 13, 2013 at 10:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>> I don't like the idea of introducing a compat/mingw/string.h because
>>> of two reasons: You would have to add a conditional to include that
>>> string.h instead of the system one anyway,
>>
>> With -Icompat/mingw passed to the compiler, which is a bog-standard
>> technique we already use to supply headers the system forgot to
>> supply or override buggy headers the system is shipped with, you do
>> not have to change any "#include <string.h>".
>>
>> Am I mistaken?
>
> Ah, that would work I guess, but you'd still need the include_next.

You can explicitly include the system header from your compatibility
layer, i.e. 

	=== compat/mingw/string.h ===

	#define __NO_INLINE__

	#ifdef SYSTEM_STRING_H_HEADER
        #include SYSTEM_STRING_H_HEADER
        #else
        #include_next <string.h>
	#endif

and then in config.mak.uname, do something like this:

	ifneq (,$(findstring MINGW,$(uname_S)))
	ifndef SYSTEM_STRING_H_HEADER
	SYSTEM_STRING_H_HEADER = "C:\\llvm\include\string.h"
        endif

	COMPAT_CFLAGS += -DSYSTEM_STRING_H_HEADER=$(SYSTEM_STRING_H_HEADER)
	endif

People who have the system header file at different paths can
further override SYSTEM_STRING_H_HEADER in their config.mak.

That would help compilers targetting mingw that do not support
"#include_next" without spreading the damage to other people's
systems, I think.
