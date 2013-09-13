From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Fri, 13 Sep 2013 07:26:55 -0700
Message-ID: <xmqqtxhokdao.fsf@gitster.dls.corp.google.com>
References: <523094F0.9000509@gmail.com> <20130911182921.GE4326@google.com>
	<CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
	<20130911214116.GA12235@sigill.intra.peff.net>
	<CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
	<20130912101419.GY2582@serenity.lan>
	<xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
	<20130912182057.GB32069@sigill.intra.peff.net>
	<xmqqd2odq45y.fsf@gitster.dls.corp.google.com>
	<20130912183849.GI4326@google.com>
	<CAHGBnuPejvs_zTdV52GWVCF35+Bdih2c1zNuBdHJRd_2ShcnKQ@mail.gmail.com>
	<xmqqvc25ol9n.fsf@gitster.dls.corp.google.com>
	<CAHGBnuN+HkZt48Pg2sHnYAhYW7EufWhO6rfgKpgaSOGeGA0Z4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 16:27:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKUKv-0008Nb-Ed
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 16:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279Ab3IMO1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 10:27:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47382 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932070Ab3IMO07 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 10:26:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E50F13FF24;
	Fri, 13 Sep 2013 14:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sSizCr6G/nl9A5AvZiu3PmbvBhI=; b=Dkqh/M
	F6iVvtkU2o0yaGK1hHOgKN3nUVhYfob7TfeS2BlfHWbZQ0xCsXgH34xUj+2oqN4d
	zKmmuLu86qlFhAU2idG001QZrtOMkO3YV2qmhi141hbmKc05N8ZeWARjzdUBE3mf
	l2SuFc9kW6meekNhtTt7Osqy43Oo3uSL8Ntz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qrHoXkMPUAykGQLumKOHMVrSg53oPpRD
	w8yAFyIeJ5UcZvEj98D87T7Ftuypqp0ryKbZmUkLwuPAIw3gKd1YbTb9liveFgUj
	C2dTSycvLRnRfdvZVJvAukBuS1ETziVfBP12YkQbev3tmPu+tCZsL9X6E/lMP7cA
	IvuagF1HM7U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7EA63FF23;
	Fri, 13 Sep 2013 14:26:58 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DBB13FF1E;
	Fri, 13 Sep 2013 14:26:58 +0000 (UTC)
In-Reply-To: <CAHGBnuN+HkZt48Pg2sHnYAhYW7EufWhO6rfgKpgaSOGeGA0Z4w@mail.gmail.com>
	(Sebastian Schuberth's message of "Fri, 13 Sep 2013 14:33:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8C1C554E-1C80-11E3-AE7B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234755>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Thu, Sep 12, 2013 at 10:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>> I'm not too happy with the wording either. As I see it, even on MinGW
>>> runtime version 4.0 it's not true that "string.h has _only_ inline
>>> definition of strcasecmp"; there's also "#define strncasecmp
>>> _strnicmp" which effectively provides a non-inline definition of
>>> strncasecmp aka _strnicmp.
>>
>> I do not get this part.  Sure, string.h would have definitions of
>> things other than strcasecmp, such as strncasecmp.  So what?
>
> Sorry, I mixed up "strcasecmp" and "strncasecmp".

OK.

>> Does it "effectively" provide a non-inline definition of strcasecmp?
>
> Yes, if __NO_INLINE__ is defined string.h provides non-inline
> definition of both "strcasecmp" and "strncasecmp" by defining them to
> "_stricmp" and "_strnicmp" respectively.
>
>> Perhaps the real issue is that the header file does not give an
>> equivalent "those who want to take the address of strcasecmp will
>> get the address of _stricmp instead" macro, e.g.
>>
>>         #define strcasecmp _stricmp
>>
>> or something?
>
> Now it's you who puzzles me, because the header file *does* have
> exactly the macro that you suggest.

Then why does your platform have problem with the code that takes
the address of strcasecmp and stores it in the variable?  It is not
me, but your platform that is puzzling us.

There is something else going on, like you do not have that #define
"enabled" under some condition, or something silly like that.
