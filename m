From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] Provide a dirname() function when NO_LIBGEN_H=YesPlease
Date: Mon, 11 Jan 2016 14:56:30 -0800
Message-ID: <xmqqtwmjvi75.fsf@gitster.mtv.corp.google.com>
References: <cover.1452270051.git.johannes.schindelin@gmx.de>
	<cover.1452536924.git.johannes.schindelin@gmx.de>
	<0bab11634c8f05751b2ed5879bc4100441bba4b9.1452536924.git.johannes.schindelin@gmx.de>
	<CAPig+cQmhc=DmptyYWy1p3z4rz7_h-3XRrtFH7XxoW77z5Mz-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 23:56:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIlOD-0003NX-II
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 23:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933657AbcAKW4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 17:56:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50467 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933349AbcAKW4d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 17:56:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6322F3B6E8;
	Mon, 11 Jan 2016 17:56:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x1lKzfqKkV/xhb2h3NK52KreOck=; b=PHvyrd
	yTrhzoLVbRec6BFnIfH96cdVjZtLI0PrKkUY3gWdQ/z/D0lWxc9KJMxtzOYJ8Upl
	TR+HgY9LeKeOO5b+/axlc2FLhSJhsUHE32eUda2fGyaGiYAl9sDMNbFrQbZ0u43G
	+EbRwLgfIG31CPKRySjtyeOp2T9CYj8suShF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=etVle/cjvIFoUdPqGLcZgs+Io6vMdYOn
	AlwoJlntZlAFSFQEJeXFHcwksD0dEet/UJHJm69EKa/XWXeyCWuO1vve8PXX52i2
	LYW/oqAETCugwoQrIo0MpCT/tX+r37Bs/I4ZWgRfxJaulc4Vw+A/jYIVNrUhiCcc
	lOqgyOvRGY4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5A79E3B6E7;
	Mon, 11 Jan 2016 17:56:32 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D52A43B6E6;
	Mon, 11 Jan 2016 17:56:31 -0500 (EST)
In-Reply-To: <CAPig+cQmhc=DmptyYWy1p3z4rz7_h-3XRrtFH7XxoW77z5Mz-A@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 11 Jan 2016 15:33:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8E7E2040-B8B6-11E5-9B07-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283732>

Eric Sunshine <sunshine@sunshineco.com> writes:

> I wonder if this would be a bit easier to follow if it was structured
> something like this:
>
>     static struct strbuf buf = STRBUF_INIT;
>
>     if ((dos_drive_prefix = skip_dos_drive_prefix(&p)) && !*p)
>         goto dot;
>
>     ...
>     if (is_dir_sep(*p)) {
>         ...
>     }
>     ...
>     while ((c = *(p++)))
>         ...
>
>     if (slash) {
>         *slash = '\0';
>         return path;
>     }
>
>     dot:
>     strbuf_reset(&buf);
>     strbuf_addf(&buf, "%.*s.", dos_drive_prefix, path);
>     return buf.buf;

I'll queue the one from Dscho as-is for today, but avoiding the
"jump back to a place where it happens to have an identical clean-up
that need to happen" and defining the clean-up path at the end like
this would probably be easier to follow.  It certainly would have
saved one comment in the previous review cycle from me.

Thanks.
