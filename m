From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] test-parse-options: --expect=<string> option to simplify tests
Date: Fri, 06 May 2016 10:34:08 -0700
Message-ID: <xmqqinyr3xbj.fsf@gitster.mtv.corp.google.com>
References: <xmqq7ff8b99q.fsf@gitster.mtv.corp.google.com>
	<20160505215056.28224-1-gitster@pobox.com>
	<20160505215056.28224-4-gitster@pobox.com>
	<CAGZ79kY+9BUjcbpSA8sAqd=qZ5niZ2CDsPeGuXhK+yqZY4hL9Q@mail.gmail.com>
	<xmqqeg9f7v1l.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZ59K5BoSVsbt4YM-Try9Q1CVdFeBW8GE5E1dJpSBWzVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 06 19:34:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayjdu-0004t2-Qn
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 19:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758298AbcEFReQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 13:34:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52053 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932215AbcEFReN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 13:34:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B75DE17646;
	Fri,  6 May 2016 13:34:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v64LrYOT4TXW2SS5DGhEGR8+RF8=; b=PtWe7X
	5Y2u3zkcTNH/z7k9MhDOY8fBVUpWyAXeSrAAKbuB+MSujQgVJ9nxXuF4NGu82E/C
	ZF3NF5ZswVsJtnWb8MIpRZRY6BMLxKneoz4hvbA7hgF9Wn0lTaQRYgsxdcTEzw8p
	TMvVOSYGsF+KIurjtCL0/G9my3mpJNkhvt9hU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ghasikts7v2aXXjKU89i+cT+L1uPz6GS
	FMoaFhnQLV36ciTkJhT8T4ThFN/BMo/M+bDICf3v3+J0NfYJzCGUbQBbvwOgLy40
	/70COs0/itWaiF1FYA1AnUtEiKJEZZYIn+bqJGwM1WkjyopzOOfM62GC5JAOcqXw
	Slu6JA3Gxu0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AD90617644;
	Fri,  6 May 2016 13:34:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 34AF617643;
	Fri,  6 May 2016 13:34:10 -0400 (EDT)
In-Reply-To: <CAGZ79kZ59K5BoSVsbt4YM-Try9Q1CVdFeBW8GE5E1dJpSBWzVA@mail.gmail.com>
	(Stefan Beller's message of "Thu, 5 May 2016 22:51:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BDE27020-13B0-11E6-92E8-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293839>

Stefan Beller <sbeller@google.com> writes:

>> +               if (!item)
>> +                       ; /* not among entries being checked */
>> +               else {
>> +                       if (strcmp((const char *)item->util, buf.buf)) {
>> +                               printf("expected '%s', got '%s'\n",
>> +                                      (char *)item->util, buf.buf);
>> +                               *status = 1;
>> +                       }
>> +               }
>> +       }
>> +       strbuf_reset(&buf);
>
> strbuf_release ?

Thanks for spotting a leak.

I originally had the buf as static, as all generated strings are
short and of similar length, in an attempt to reuse the already
allocated storage instead of allocating it from scratch every call.

>>
>>         return 0;
>
>     return ret; ? Otherwise `ret` is unused.

This, too.  Thanks.
