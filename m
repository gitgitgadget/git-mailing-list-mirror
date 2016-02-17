From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/12] ref-filter: use strbuf_split_str_omit_term()
Date: Tue, 16 Feb 2016 16:12:08 -0800
Message-ID: <xmqqbn7gkxev.fsf@gitster.mtv.corp.google.com>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
	<1455649215-23260-3-git-send-email-Karthik.188@gmail.com>
	<20160216192231.GA16567@sigill.intra.peff.net>
	<CAPig+cTiwHs+dD+jqAp8SNkwjQ2OzDsC8yopRgF7gctrGi5uUw@mail.gmail.com>
	<20160216204954.GC27484@sigill.intra.peff.net>
	<CAPig+cQDs35Uirm5cG552tR8iCFOstNJoOzLCZiXCgnq+g7MRQ@mail.gmail.com>
	<20160216223451.GB9014@sigill.intra.peff.net>
	<CAPig+cS+i5QfpUbs8T+CqcDkC4ybaTygE9bguiqQMNgV4JhDOQ@mail.gmail.com>
	<20160216231811.GA18634@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 17 01:12:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVpj5-0005zR-DT
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 01:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933423AbcBQAMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 19:12:12 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933243AbcBQAMK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 19:12:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E8465442D6;
	Tue, 16 Feb 2016 19:12:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8ngHSom0Qq056F2v7U+m2D9Csmw=; b=jcHZV6
	9J9u/KWZVUnHQz8mTALeMXCG+TYh1k5IqVWO7Wr1xGwlEdyoXATQ8OnLuzl+qNb7
	i6xDcgfhhuqKTk162+Q5phwtkLC0IFxboM+qApT8gp+KZVO+t6E6Oplky7ytJl0f
	l501BapUB/wmbu6HvjcwsTxaEJL3auI27o2bc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FH06sbmi9aiYHkZj6rgdoQ/3XQzVVz5o
	ZUI39fhEdDUO81Ak7b/KMDLYlNfDv3pLzS89cyQKIIuOvrAW/lDP5Z8G8p7EtZcl
	ZRaClJq1nHI8tk6bTq6F91H4u+C5pNVYrAxNfwMlgyFBWEqSFZNG2PZRuuBqH04G
	nwXmDbNBeFk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF60E442D5;
	Tue, 16 Feb 2016 19:12:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 66947442D4;
	Tue, 16 Feb 2016 19:12:09 -0500 (EST)
In-Reply-To: <20160216231811.GA18634@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 16 Feb 2016 18:18:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 15F4525E-D50B-11E5-B93E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286463>

Jeff King <peff@peff.net> writes:

>> > Should we? Or perhaps: might we? If the answer is yes, we are likely
>> > better off with strbuf_split, because then we are only a strbuf_trim()
>> > away from making that work.
>> 
>> I also considered the issue of embedded whitespace very early on when
>> reading your initial proposal, but didn't mention anything about it
>> due to a vague recollection from one of the early reviews (or possibly
>> a review of one of Karthik's other patch series) of someone (possibly
>> Junio) saying or implying that embedded whitespace would not be
>> supported. Unfortunately, I can't locate that message (assuming it
>> even exists and wasn't a figment of my imagination).
>
> Yeah, I could not find any relevant reference (though I didn't spend all
> that long digging).
>
> For reference, I rebuilt Karthik's series on top of my proposal, and the
> changes are fairly minor. I pushed it to:
>
>   git://github.com/peff/git.git jk/tweaked-ref-filter
>
> The tbdiff is below. Hopefully having that done makes it easier to
> decide based on the outcome, rather than the pain of rebasing. :)
>
> To be honest, though, I am now on the fence, considering the possible
> whitespace issue.

Certainly not having to see s[0]->buf over and over is a huge win ;-).

Is the "whitespace issue" a big deal?  Does it involve more than a
similar sibling to string_list_split() that trims the whitespace
around the delimiter (or allows a regexp as a delimiter "\s*,\s*")?
