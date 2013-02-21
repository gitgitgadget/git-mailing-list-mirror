From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] format-patch: --inline-single
Date: Thu, 21 Feb 2013 15:41:12 -0800
Message-ID: <7v7gm1teuf.fsf@alter.siamese.dyndns.org>
References: <1361282783-1413-1-git-send-email-git@adamspiers.org>
 <1361282783-1413-2-git-send-email-git@adamspiers.org>
 <7v1ucc6vgd.fsf@alter.siamese.dyndns.org>
 <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com>
 <7v1ucc5b7n.fsf_-_@alter.siamese.dyndns.org>
 <20130220020046.GC7860@pacific.linksys.moosehall>
 <7vppzv3dd8.fsf@alter.siamese.dyndns.org>
 <20130220104720.GD7860@pacific.linksys.moosehall>
 <7vehg9v2xj.fsf@alter.siamese.dyndns.org>
 <7v4nh5v2fl.fsf_-_@alter.siamese.dyndns.org>
 <20130221231328.GA19808@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Adam Spiers <git@adamspiers.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 00:41:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8flk-0008Ca-Mq
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 00:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681Ab3BUXlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 18:41:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64149 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753212Ab3BUXlP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 18:41:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62C9BB849;
	Thu, 21 Feb 2013 18:41:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e+Hok/zO48GrGLUZBFpGCv0GJPg=; b=amcKNx
	LIlj2I1yc5lmWJzZ9rCywlsmJJwfxB9YDfI8MIiUKJr49zcDtF4T7fW/4anFS9k2
	5rXzk4LUtIWtZOWg2edbPd9XJdzSr15qdVUe5iKUGGo63ngCgdWtYvAlBEBnjgy4
	l4ALEt6U26GHftIQAuDXAAhR0aWJ6ty/hKDrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S4/OKNYQFDOvaTKalANMq3BDrb3VBi96
	YZDYt2RIbFi333XJTmTkbgkYBczuqpPxG1Jshkfc+SWJvBy7XBBEYxR3XoXFe+Nq
	v/G0k6/f104gEvit5wFqlR51PAIuAUYxfzyVZeI+g6+4CtXe+T2yNA1yeB9Zl3/f
	bUfKfNNTXAs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 586C2B848;
	Thu, 21 Feb 2013 18:41:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC6BCB847; Thu, 21 Feb 2013
 18:41:13 -0500 (EST)
In-Reply-To: <20130221231328.GA19808@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 21 Feb 2013 18:13:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2DAC267E-7C80-11E2-80B3-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216810>

Jeff King <peff@peff.net> writes:

>> @@ -421,6 +443,9 @@ void pp_user_info(const struct pretty_print_context *pp,
>>  	if (pp->mailmap)
>>  		map_user(pp->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
>>  
>> +	if (pp->inline_single && is_current_user(pp, mailbuf, maillen, namebuf, namelen))
>> +		return;
>> +
>>  	strbuf_init(&mail, 0);
>>  	strbuf_init(&name, 0);
>
> This makes sense to suppress the user line when it is not necessary. But
> we should probably always be suppressing the Date line, as it is almost
> always useless.

When I (figuratively) am sending my patch in a discussion, saying
"You could do it this way", on the other hand, I agree that the date
is uninteresting.

I however think I would prefer to keep the Date: line when I am
relaying somebody else's work during a discussion.  It is more like
"Yeah, Peff already did that with this commit; here it is for
reference". The fact that I have _your_ patch makes it more "done",
than the case I send out my own patch.

Besides, removing an extra line in the MUA editor is far easier than
having to type what the tool "helpfully" omitted, guided by an "it
is almost always useless" that is not backed by the user preference.
I'd rather err on the side of giving extra than omitting too much.

> I also wonder if we should suppress the subject-prefix in such a case,
> as it is not adding anything (it is not the subject of the email, so it
> does not need to grab attention there, and it will not make it into the
> final commit).

If the user does not want to waste too much space in the message,
not passing the --subject-prefix=foo from the command line, or
editing it out in the editor buffer if for some reason the user ran
the command with the option, are both easy things to do.  I do not
think extra lines to excise subject prefix is not worth it, and who
knows what the user's preferences are.

But there is something more important.

We should make sure that we disable MIMEy stuff (i.e. MIME-Version,
C-T-E: 8bit/quoted-printable, Content-type, etc.) when producing the
output to be appended to the body, which should be just a straight
8-bit text.  I do not think the posted patch tries to do anything to
that effect.
