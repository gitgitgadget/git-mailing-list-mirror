From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: avoid symlinks when reusing worktree files
Date: Fri, 30 Oct 2015 09:19:10 -0700
Message-ID: <xmqqio5omirl.fsf@gitster.mtv.corp.google.com>
References: <1445981088-6285-1-git-send-email-davvid@gmail.com>
	<xmqq1tcgne4u.fsf@gitster.mtv.corp.google.com>
	<20151029015539.GA12513@gmail.com>
	<xmqq8u6lsggx.fsf@gitster.mtv.corp.google.com>
	<xmqq4mh9sfl6.fsf@gitster.mtv.corp.google.com>
	<20151030072857.GA15031@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ismail Badawi <ismail@badawi.io>,
	John Keeping <john@keeping.me.uk>,
	Tim Henigan <tim.henigan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 17:19:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsCOb-0000MP-Vm
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 17:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbbJ3QTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 12:19:14 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60881 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751355AbbJ3QTM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 12:19:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D3B1B24012;
	Fri, 30 Oct 2015 12:19:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fovzMWNhzRwha0oZyC7qYTp/tr4=; b=wSVJq3
	Z0OpDh+gWDsB91W48voVyFtC4zs/cGMDnPosTllO+9O2NuyWayyzWDln25FRZI/8
	BPN+yEPE+PPP5NGA8bs9HF7vDI3Cmsk2b7f1yJgS36tqFyhYurDqd56lsOfkrz0T
	6Ot21n/eWhxjvqXDN8Q9Qo/F7IaEPkg58CwNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jPgQx1WvBAtTcxFN2ih/QKWXxflEhDrE
	kWR5z2+qA8Y3uE8tvYNutCTGujqzIz71w12Snqu0oyqu039Gg4/jMkln5B+0ag2b
	e7OR3B6rdcApCC7Z9ubTWEceBPOCSxDZdLVyqYuXifULkVaPhGmIeJxCbjJpJ/WN
	qLEalr77gT8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C8B3F24011;
	Fri, 30 Oct 2015 12:19:11 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3F8F82400E;
	Fri, 30 Oct 2015 12:19:11 -0400 (EDT)
In-Reply-To: <20151030072857.GA15031@gmail.com> (David Aguilar's message of
	"Fri, 30 Oct 2015 00:28:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F43A5E04-7F21-11E5-849B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280492>

David Aguilar <davvid@gmail.com> writes:

>> +	if (-l "$workdir/$file" || ! -e _) {
>>  		return (0, $null_sha1);
>>  	}
>
> The "-e _" shorthand caught my eye ~ I didn't know perl could do that!
> Nice.
>
> Underline is barely mentioned in perlvar, but it's obvious what
> (I think) it means, and since Perl is DWIM, it must be right. ;-)

It is mentioned under -X (i.e. the headline for -f, -e, -d,
... tests) in perlfunc with an interesting example of doing
an explicit stat() first and then running many variants of -X
with _ as the target.
