From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] verify-tag: add --check-name flag
Date: Wed, 08 Jun 2016 11:43:15 -0700
Message-ID: <xmqqk2hzldx8.fsf@gitster.mtv.corp.google.com>
References: <20160607211707.GA7981@sigill.intra.peff.net>
	<xmqq37oopt28.fsf@gitster.mtv.corp.google.com>
	<20160607215536.GA20768@sigill.intra.peff.net>
	<xmqqy46gods1.fsf@gitster.mtv.corp.google.com>
	<20160607220743.GA21043@sigill.intra.peff.net>
	<CAPc5daV=gqDLeFLB2csJDvNo4fpSKW_FjoB10TyroapQiHFq=A@mail.gmail.com>
	<20160607221325.GA21166@sigill.intra.peff.net>
	<xmqqk2i0od1f.fsf@gitster.mtv.corp.google.com>
	<20160607222908.GA25631@sigill.intra.peff.net>
	<CAPc5daV9ZvHqFtdzr565vp6Mv7O66ySr-p5Vi8o6bd6=GyVELg@mail.gmail.com>
	<20160608142132.GA32299@LykOS.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Colin Walters <walters@verbum.org>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:43:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAiRn-0000yh-Gt
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 20:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423574AbcFHSnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 14:43:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56789 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161842AbcFHSnS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 14:43:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 201F520BE6;
	Wed,  8 Jun 2016 14:43:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7i00iTYxFG+x/KaodBiu8yazLeI=; b=xiZPW2
	lcbPbwfJRI3J/4o8bijuuPMSJ2H1KVqHfLYpK6BbG9EF9qVNykMtbLNbIqZDAuYQ
	JympVJUTUAjeu8SzOPhldgz5FNofHFWMSvFSZKcrvrde+FjMs4nxdzZ94d4O7GqZ
	qfl/kZri4eqChgR/MOOkaiKco5uMKVxeJL91s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lo7CaWtWsc8CcYAu7c4jqE5BGzCrFghh
	JTYSqzHT7IDzZj85YyCc1JvYVf8cEYeb4Ypa6xPU0dcYtiL7nHe37Z0vcOLmNgh3
	8tho3ZY1HSexDQepj6K+sK1vgS9yuoE4NsfDehOTlqUJEphvDqKLeDG8vB8CbSKc
	zmO7ibwESns=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1862820BE5;
	Wed,  8 Jun 2016 14:43:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 964C920BE4;
	Wed,  8 Jun 2016 14:43:16 -0400 (EDT)
In-Reply-To: <20160608142132.GA32299@LykOS.localdomain> (Santiago Torres's
	message of "Wed, 8 Jun 2016 10:21:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DD00139C-2DA8-11E6-A0A7-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296831>

Santiago Torres <santiago@nyu.edu> writes:

> Sorry I'm trying to follow this. Would it be best to then have
>
>     verify-tag [--check-name=tagname] (tag-ref|tag-name|sha1)?
>
> and
>
>     tag -v [--check-name] (tag-name)
>
> Or would --format still work better?

No matter what you do, don't call that "--check-name".  It does not
tell the users what aspect of that thing is "checked".  Avoid being
asked "Does this check tagname to make sure it does not have
non-ASCII letters?", in other words.

As a longer-term direction, I think the best one is to make what
peff@ originally suggested, i.e.

    If we do go with the "print it out and let the caller do their own
    checks" strategy, I think I'd prefer rather than "--show-tagname" to
    just respect the "--format" we use for tag-listing. That would let you
    do:

      git tag -v --format='%(tag)%n%(tagger)'

    or similar. In fact you can already do that with a separate step (modulo
    %n, which we do not seem to understand here)...

work.

Thanks.
