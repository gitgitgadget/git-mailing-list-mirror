From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Microproject idea: new OPT_* macros for PARSE_OPT_NONEG
Date: Fri, 07 Mar 2014 11:20:12 -0800
Message-ID: <xmqqzjl1u87n.fsf@gitster.dls.corp.google.com>
References: <CACsJy8CBVVJN3V8N_djLF4XKfTbxvdcJCnWmZJxVZOwy8AMQWA@mail.gmail.com>
	<531977AF.4060907@alum.mit.edu>
	<CACsJy8AUhHE8=Yaj6_G46V6w5ZbA3z403GkBfsbZL7MxgeA3RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 20:20:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM0Jm-0005SA-8M
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 20:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbaCGTUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 14:20:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41783 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972AbaCGTUV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 14:20:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23C41723C4;
	Fri,  7 Mar 2014 14:20:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XimG9dHBNTu8zM/IzD62+yQJZjI=; b=PnKguA
	2PAYs7+mHUK3mGFywHc0xsN9O40KQARUjp+ton328PyXYQkT8/lKvQL2f3ru3vv8
	A/z8jOqIe9OMtBIbw/LcMtGL/D1RuiJ7o7mfxSFSkiqBMFYJwLbUgzN1QEY8AW+l
	OgckKKnQFBm7sBrMEradSbf4XlDSt+07mMKdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gDcXQnZYmqeUHFOb9/SSDcjASFK6FAdb
	NjocHeuaI9mShYHDZSsQ0X2wQCv9k4Si3MK8ODEiEYaXIxR+Zu5+SFIakzwiU98q
	wZ7kYs0oAPlRwF9neElv/dVbvVGHkaoR+OYLorHhR0FabjwLila5VFWI8UAixDTq
	nAFtMIrNDy4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DBA6723C3;
	Fri,  7 Mar 2014 14:20:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B5E2723BF;
	Fri,  7 Mar 2014 14:20:14 -0500 (EST)
In-Reply-To: <CACsJy8AUhHE8=Yaj6_G46V6w5ZbA3z403GkBfsbZL7MxgeA3RQ@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 7 Mar 2014 14:54:12 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 826338B0-A62D-11E3-A1B5-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243624>

Duy Nguyen <pclouds@gmail.com> writes:

> I don't know the scope of these microprojects, but yes I think it'll
> take a few hours for this. By the way, a bit more thought on the idea:
> instead of making OPT_BOOL_NONEG() that sets NONEG, we could make
> OPT_BOOL_FLAGS(..., NONEG), which is more flexible.

What does a boolean that can never be set to false achieve, by the
way?  If you have

    [alias]
        foo = bar --frotz

then you may want to be able to say "git foo --no-frotz" to
countermand the frotz option, and by marking the boolean frotz
option to be a NONEG, you can forbid such a usage.  That is the only
"use case" I can think of, and that particular use case does not
sound like a valid one.

Looking at "git grep -B3 OPT_NONEG" output, it seems that NONEG is
associated mostly with OPTION_CALLBACK and OPTION_SET_INT in the
existing code.

Perhaps OPT_SET_INT should default to not just OPT_NOARG but also
OPT_NONEG?

I have a suspition that most users of other OPT_SET_<TYPE>
short-hands may also want them to default to NONEG (and the rare
ones that want to allow "--no-value-of-this-type=Heh" for some
reason to use the fully spelled form).  IIRC NONEG is relatively a
new addition, and many existing OPT_STRING() may predate it.

So I am not sure if doubling the number of OPT_<type> macros as your
micro suggestion proposes is the right solution to the problem.
