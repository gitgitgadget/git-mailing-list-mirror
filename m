From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCHv3 1/4] am: avoid re-directing stdin twice
Date: Sat, 06 Sep 2014 00:34:21 -0700
Message-ID: <xmqqbnqtp5he.fsf@gitster.dls.corp.google.com>
References: <1409911611-20370-1-git-send-email-judge.packham@gmail.com>
	<1409911611-20370-2-git-send-email-judge.packham@gmail.com>
	<540A1C7B.80109@kdbg.org>
	<CAFOYHZBct1CRA+NumVMvbbuELWTRoGL5FkhBfHD2Wk7QZVe1fA@mail.gmail.com>
	<xmqqoautpw1g.fsf@gitster.dls.corp.google.com>
	<xmqqk35hpvbg.fsf@gitster.dls.corp.google.com>
	<xmqqfvg5puws.fsf@gitster.dls.corp.google.com>
	<CALaEz9Xbk_sAAJ0wNCgC9Rzr=E9Ke0H3YEwGr1_4VNgv0AwYhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, GIT <git@vger.kernel.org>,
	Chris Packham <judge.packham@gmail.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:38:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAW5-0004Ge-Ue
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbaIFHeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:34:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62150 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724AbaIFHeY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2014 03:34:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CD45232DC4;
	Sat,  6 Sep 2014 03:34:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7QbfB6IBcIEf1qGHunWP3npnmRI=; b=GQuMcu
	KE0qcRULY+6y6v8M0MYTb3d1nsUxa/M1a/2IoQW5VjADK/yo3Zro/Z8Nl8weK2Pz
	WUEU1fa5KSlV0nNIRsVvKkZGAKM+xVE/uXR8uf+i7SPXhO1olkGbjM8ghgiTjLbg
	qpGgA06wsSaXAK6Lb/FmQCV5nsfwxd5/2En3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eZXdImIO0+6cwxjIfNSqY+13I7Q8717n
	DKgAP38+jkUMri39T2cYOYiFvHLW4TaeSa/GFkLtRQoQtRYMZduDOk5oxWrwfTmA
	mwWZiGlxYxf9cw6AAqJ0wh+Pv/bJh41S0FXHjZ1M4E8ul26tKx0J/yZsF5oAYj8/
	HgvZ/WE832s=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C4F9832DC3;
	Sat,  6 Sep 2014 03:34:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4E03232DC1;
	Sat,  6 Sep 2014 03:34:23 -0400 (EDT)
In-Reply-To: <CALaEz9Xbk_sAAJ0wNCgC9Rzr=E9Ke0H3YEwGr1_4VNgv0AwYhw@mail.gmail.com>
	(Stephen Boyd's message of "Fri, 5 Sep 2014 16:18:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 38DD4DCA-3598-11E4-8AAC-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256550>

Stephen Boyd <bebarino@gmail.com> writes:

>>> I see Stephen who wrote the original "Thunderbird save-as" is
>>> already on the Cc list.  How about doing it this way instead?
>
> It was so long ago I can't even remember writing that patch. But I
> googled the thread from 4.5 years ago and I see that you suggested we
> use tr because \r is not portable[1].

Hmph.  That's unfortunate that this may be one of those things that
even though it is in POSIX the real world prevents us from using it.

I wonder if things changed over the past four years, though.  Can
folks on OSX or BSD do a quick check?

Thanks.
