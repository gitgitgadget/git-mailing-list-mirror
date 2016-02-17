From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/12] ref-filter: use strbuf_split_str_omit_term()
Date: Tue, 16 Feb 2016 16:28:10 -0800
Message-ID: <xmqq37sskwo5.fsf@gitster.mtv.corp.google.com>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
	<1455649215-23260-3-git-send-email-Karthik.188@gmail.com>
	<20160216192231.GA16567@sigill.intra.peff.net>
	<CAPig+cTiwHs+dD+jqAp8SNkwjQ2OzDsC8yopRgF7gctrGi5uUw@mail.gmail.com>
	<20160216204954.GC27484@sigill.intra.peff.net>
	<CAPig+cQDs35Uirm5cG552tR8iCFOstNJoOzLCZiXCgnq+g7MRQ@mail.gmail.com>
	<20160216223451.GB9014@sigill.intra.peff.net>
	<CAPig+cS+i5QfpUbs8T+CqcDkC4ybaTygE9bguiqQMNgV4JhDOQ@mail.gmail.com>
	<20160216231811.GA18634@sigill.intra.peff.net>
	<xmqqbn7gkxev.fsf@gitster.mtv.corp.google.com>
	<20160217002215.GA1187@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 17 01:28:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVpyi-0002F2-D6
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 01:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933545AbcBQA2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 19:28:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64740 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933537AbcBQA2N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 19:28:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 609D14464D;
	Tue, 16 Feb 2016 19:28:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WRSRyr3nvZZGCszOF+bPteFdU2s=; b=JhaDkC
	U9NsreRvgVwXQQhx12A78JexKtHRFZdjeUqWzjVzNFZwq8JHumHl2uH90inl8IuE
	GXk8y7VLa7SGwEMrc7luhROQq/YlWajxGrAaQUtJx2PUPr7qG82hEHIfoh4P3Z1N
	XsCcOjo7BkLUz/ES/kWLG17C67GDFXhlhanWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WSyWjtndFisWxnv5kwWFycjhcli3+aXB
	UkfRXQr84HxfXzP6os+0SzuYSP6ItHGFGvcrYw4xF2CTm6sACzsl96ld/Yq29vZg
	ti4qyWY+URKx/3cUd7ZBQheefIUzKe7J/aqnY3ERamFeQQdGNR/vVm6p8SwO8sJ5
	5Avg660Y5/Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 581C44464C;
	Tue, 16 Feb 2016 19:28:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E048F4464B;
	Tue, 16 Feb 2016 19:28:11 -0500 (EST)
In-Reply-To: <20160217002215.GA1187@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 16 Feb 2016 19:22:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 53A592AA-D50D-11E5-AD0C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286466>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 16, 2016 at 04:12:08PM -0800, Junio C Hamano wrote:
>
>> > To be honest, though, I am now on the fence, considering the possible
>> > whitespace issue.
>> 
>> Certainly not having to see s[0]->buf over and over is a huge win ;-).
>> 
>> Is the "whitespace issue" a big deal?  Does it involve more than a
>> similar sibling to string_list_split() that trims the whitespace
>> around the delimiter (or allows a regexp as a delimiter "\s*,\s*")?
>
> I think that solution would work (and IMHO would actually be preferable
> to the split-then-trim that strbuf_split does). But it does mean writing
> new code.

True, but only when we decide to support trimming the whitespace,
which can come later.

I do not even know if it is wise to accept %(align:position=left, width=4)
when %(align:position=left,width=4) would do the job just fine.
