From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: add NO_CLOCK_GETTIME check
Date: Wed, 03 Sep 2014 13:58:33 -0700
Message-ID: <xmqqsik8whdy.fsf@gitster.dls.corp.google.com>
References: <1409771687-5597-1-git-send-email-reubenhwk@gmail.com>
	<xmqqwq9kwkrg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, karsten.blees@gmail.com
To: Reuben Hawkins <reubenhwk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 22:58:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPHdY-00033c-N8
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 22:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbaICU6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 16:58:36 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61134 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389AbaICU6g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 16:58:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 718203746B;
	Wed,  3 Sep 2014 16:58:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p8XWA8l+UjP56ClHr2gtvdO7kWU=; b=VUm7V5
	fkt76DS+qoyKV7FbT5F49jmZYbL1GFMgvoqlknwGGHv8iYtrHm0j+Q9CSeOFCCkm
	1hHt33zF7rZS52E31bi/Tqn1IykvO/5l12xPL+oisfdw/24xrOtKKR0KEHe24uPg
	6cii3GgWTXPZ+XYjX2D2VUgsdDfWes2ylmDgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cxuuJ7JDGR9TmT9jhWgZBunAzrNH5dla
	Q0NEWQ6ZarLcMcSPQ2MADBZhqDuxAFg7cSnaznNrgNr0PZeccM+mvG6hWAtSw0Ay
	+4z0pdOgsRaPOnxOF4zTc2rTis0ilruwSPE81Yj1cQV3fabCZdTpcwj4tGa7Ttll
	5ST7AHsrpk8=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 648053746A;
	Wed,  3 Sep 2014 16:58:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D879037468;
	Wed,  3 Sep 2014 16:58:34 -0400 (EDT)
In-Reply-To: <xmqqwq9kwkrg.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 03 Sep 2014 12:45:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 11CDC3DC-33AD-11E4-BF12-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256411>

Junio C Hamano <gitster@pobox.com> writes:

>> +ifndef NO_CLOCK_GETTIME
>>  ifdef HAVE_CLOCK_GETTIME
>>  	BASIC_CFLAGS += -DHAVE_CLOCK_GETTIME
>>  	EXTLIBS += -lrt
>>  endif
>> +endif
>
> I am not sure why you even need this change.  Wouldn't you get
> exactly the same result if you did not define HAVE_CLOCK_GETTIME
> when building?

That is, doing something like:

    $ make HAVE_CLOCK_GETTIME= V=1

would show lines like:

    cc -o credential-store.o -c -MF ./.depend/credential-store.o.d
    -MQ credential-store.o -MMD -MP  -O2 -Wall -Wvla
    -Wdeclaration-after-statement -Wno-format-zero-length -g
    -I. -DHAVE_ALLOCA_H  -DHAVE_PATHS_H -DHAVE_DEV_TTY
    -DXDL_FAST_HASH -DSHA1_HEADER='"block-sha1/sha1.h"'
    -DNO_STRLCPY -DNO_MKSTEMPS -DSHELL_PATH='"/bin/sh"'  credential-store.c

that does not have -DHAVE_CLOCK_GETTIME on the command line, no?
