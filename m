From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/9] strbuf: add strbuf_tolower function
Date: Thu, 22 May 2014 11:36:37 -0700
Message-ID: <xmqq38g1oe2y.fsf@gitster.dls.corp.google.com>
References: <20140521102524.GA30301@sigill.intra.peff.net>
	<20140521102742.GB30464@sigill.intra.peff.net>
	<AD42BA87-3C73-4EB2-AF88-96C4F7E6FA0C@gmail.com>
	<20140522055852.GA16587@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 22 20:37:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnXrP-00078n-BD
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 20:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbaEVSgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 14:36:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59175 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751430AbaEVSgs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 14:36:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9947A19191;
	Thu, 22 May 2014 14:36:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OtogDhzxE4tH5G8pE8BNvwDu4Eg=; b=OMXU51
	ZRM2r/PsLov921aW+aYwnbDATG1T6E3ai0cKVCMMV+yrF2cb5qGXRE6XfNO/9+id
	vg/BMYU/fC59RiaK1i3UdAGdIyFXG7GbMEzXkdKDJZoC4/ooXrNfDsPunlpP8Won
	Fq3ku2oB1vAQ+DxIm4XOp3Aoc5BjhF4NwUb+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C4lngSBu8BX+0VSFDpepDqY6PQBLEB+9
	KT3KQT91puUzn0NlDuXTfucDNY8ZfVw6VzaAAbAdX75O3XNVq7juufCA3tv3kYqE
	oYdCX8Cu7DXIID/OepCgsPCaXtVveySNaTbwsZHsJiJ/yIXAsYf8qzptTIebMs1I
	HL6zDIUNSTI=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8DE7219190;
	Thu, 22 May 2014 14:36:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 37E921918F;
	Thu, 22 May 2014 14:36:39 -0400 (EDT)
In-Reply-To: <20140522055852.GA16587@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 22 May 2014 01:58:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 031D0B96-E1E0-11E3-9698-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249930>

Jeff King <peff@peff.net> writes:

> On Wed, May 21, 2014 at 05:07:36PM -0700, Kyle J. McKay wrote:
>
>> >+void strbuf_tolower(struct strbuf *sb)
>> >+{
>> >+	size_t i;
>> >+	for (i = 0; i < sb->len; i++)
>> >+		sb->buf[i] = tolower(sb->buf[i]);
>> >+}
>> >+
>> 
>> Wouldn't a direct transfer of the lowercase function be something more like:
>> 
>> 
>> void strbuf_tolower(struct strbuf *sb)
>> {
>> 	char *p = sb->buf;
>> 	for (; *p; p++)
>> 		*p = tolower(*p);
>> }
>> 
>> That seems to me to be a bit more efficient.  According to the comments in
>> strbuf.c, "people can always assume buf is non NULL and ->buf is NUL
>> terminated even for a freshly initialized strbuf."
>
> Yes, and that would be fine with me (I actually wrote strbuf_tolower for
> my own use, and _then_ realized that we already had such a thing that
> could be replaced).

Do we forbid that sb->buf[x] for some x < sb->len to be NUL, and if
there is such a byte we stop running tolower() on the remainder?
