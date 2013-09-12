From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Thu, 12 Sep 2013 13:08:52 -0700
Message-ID: <xmqqvc25ol9n.fsf@gitster.dls.corp.google.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 22:09:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKDCH-0006MH-H6
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 22:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755554Ab3ILUI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 16:08:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53059 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752693Ab3ILUI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 16:08:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AEB141845;
	Thu, 12 Sep 2013 20:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=warXmSYIkOU0lyfvoVWlwoLNAso=; b=xHzwsr
	5tYNXSYFXdZjMqkKpyQubrqyfwj0skWHEIPykv+art5BWJLh97Gb9tPgYJ34sf7B
	UJytTxIR6y+C7Z5bszP8UitMjMZYJy+y9epCyTtmB3EfCc3i6fNccVqumoK6QX7V
	GOh7ym66zycI4xE1/cLHjC3iK58XE8j3+pf1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LwTNX5fgCxQmPhIRfApXQo8onCH1Cf1p
	pgu5f3Yhds+I7qprgcJT18Tnk2FiU54JGdnX3FgKM/9b0HFdfrzawtyvdBtpFakl
	h+TgSD7ezGx1npNyRuDt26O2zOvL9sIdN2V767x4auMvSPFfddqsqV2VO03qUR8D
	zZoNad3gY18=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04A5E41840;
	Thu, 12 Sep 2013 20:08:56 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7E6141837;
	Thu, 12 Sep 2013 20:08:54 +0000 (UTC)
In-Reply-To: <CAHGBnuPejvs_zTdV52GWVCF35+Bdih2c1zNuBdHJRd_2ShcnKQ@mail.gmail.com>
	(Sebastian Schuberth's message of "Thu, 12 Sep 2013 21:51:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 26A90804-1BE7-11E3-AF2B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234688>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> I'm not too happy with the wording either. As I see it, even on MinGW
> runtime version 4.0 it's not true that "string.h has _only_ inline
> definition of strcasecmp"; there's also "#define strncasecmp
> _strnicmp" which effectively provides a non-inline definition of
> strncasecmp aka _strnicmp.

I do not get this part.  Sure, string.h would have definitions of
things other than strcasecmp, such as strncasecmp.  So what?

Does it "effectively" provide a non-inline definition of strcasecmp?

Perhaps the real issue is that the header file does not give an
equivalent "those who want to take the address of strcasecmp will
get the address of _stricmp instead" macro, e.g.

	#define strcasecmp _stricmp

or something?
