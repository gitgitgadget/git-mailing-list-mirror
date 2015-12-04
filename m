From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Multiple fetches when unshallowing a shallow clone
Date: Fri, 04 Dec 2015 13:57:30 -0800
Message-ID: <xmqqoae5ri5x.fsf@gitster.mtv.corp.google.com>
References: <CACs8u9STLLHr3c3O9kQKGEN52DLfJ2LatjWkeaeeLA-xP=gC5Q@mail.gmail.com>
	<CAGZ79ka=RxVZ49D0wkqTRqspKb=Ce5Ay01muBt_Gk6_rDbH6KA@mail.gmail.com>
	<20151204212712.GA22493@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Jason Paller-Rzepka <jasonpr@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 04 22:57:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4yMG-0003jh-2f
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 22:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434AbbLDV5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 16:57:34 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54641 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752780AbbLDV5c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 16:57:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1DDA230AA8;
	Fri,  4 Dec 2015 16:57:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=elLmINeMcdG5ZandDzzcfPPWLbY=; b=Qny/oX
	IKLWgA/s62A6LF8yF9kq+e71h2udkaiF6oeMAMNm/5AmCu94vVWrVW+TehRvXsBu
	ug+IRBiV+447BsEgLToAuuDont8HT6atJlGuTIq1PhZ4zj3fIWS+Tb1nPhJc0Pmx
	/FLjHCwERQB1+xiTtJaLMGE0Z9vaVjR3vq+Kw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O7wTVlvpKQH8wAcD2qommjJz+nawpCP1
	IVcsVN80E0NEf6BS1UdtkK6x6Cz7C26WM4nkQs7zC0T6vwyr9YZPNsxnFoRgqmBv
	TQa2ApoVAGtQ+x3slINSk4utGuk77VioBSbhEAqHtymawtsbjMRdFpFvQnVWnWOI
	U1FjCrJpBgg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 145CD30AA6;
	Fri,  4 Dec 2015 16:57:32 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7886230AA2;
	Fri,  4 Dec 2015 16:57:31 -0500 (EST)
In-Reply-To: <20151204212712.GA22493@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 4 Dec 2015 16:27:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0490CDA8-9AD2-11E5-8A42-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282012>

Jeff King <peff@peff.net> writes:

> This seems to reproduce consistently for me:
>
>   $ git clone --depth=1 git://github.com/git/git
>   Cloning into 'git'...
>   remote: Counting objects: 2925, done.
>   remote: Compressing objects: 100% (2602/2602), done.
>   remote: Total 2925 (delta 230), reused 2329 (delta 206), pack-reused 0
>   Receiving objects: 100% (2925/2925), 6.17 MiB | 10.80 MiB/s, done.
>   Resolving deltas: 100% (230/230), done.
>
>   $ cd git
>   $ git fetch --unshallow
>   remote: Counting objects: 185430, done.
>   remote: Compressing objects: 100% (46933/46933), done.
>   remote: Total 185430 (delta 140505), reused 181589 (delta 136694), pack-reused 0
>   Receiving objects: 100% (185430/185430), 52.80 MiB | 10.84 MiB/s, done.
>   Resolving deltas: 100% (140505/140505), completed with 1784 local objects.
>   remote: Counting objects: 579, done.
>   remote: Compressing objects: 100% (579/579), done.
>   remote: Total 579 (delta 0), reused 579 (delta 0), pack-reused 0
>   Receiving objects: 100% (579/579), 266.85 KiB | 0 bytes/s, done.
>   [... fetch output ...]
>
> That looks like two packs being received for the --unshallow case.

What is puzzling is that I do not seem to see this "two fetches"
with the local transport.  I only see "deepen 2147483647" in the
protocol log.

Moreover, the only interesting lines in the output from

    $ git grep -B1 'deepen ' \*.[ch]

are

fetch-pack.c-   if (args->depth > 0)
fetch-pack.c:           packet_buf_write(&req_buf, "deepen %d", args->depth);

so I do not see how anybody would be sending "deepen 0" as Jason
saw.
