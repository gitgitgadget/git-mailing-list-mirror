From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/11] builtin/pack-objects.c: change check_pbase_path() to use ALLOC_GROW()
Date: Mon, 03 Mar 2014 10:23:40 -0800
Message-ID: <xmqq61nvrvir.fsf@gitster.dls.corp.google.com>
References: <530FA3E7.8020200@yandex.ru> <531056E7.3010305@yandex.ru>
	<53105995.3010001@yandex.ru>
	<CACsJy8C2h13JFqh=CKvR=3TByHkxWCNR-XhK-WxA+DOE3GmvAQ@mail.gmail.com>
	<CACsJy8AmQeVb-i6Sn0BH-_ikEXPHTdtKnQRyzChX1WfD9Lj4Jw@mail.gmail.com>
	<53109B19.8070103@alum.mit.edu>
	<xmqqfvn3ukjs.fsf@gitster.dls.corp.google.com>
	<20140301070758.GE20397@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Duy Nguyen <pclouds@gmail.com>,
	"Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 03 19:23:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKXWp-00065w-Q7
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 19:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754352AbaCCSXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 13:23:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46073 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753986AbaCCSXp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 13:23:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0593570E13;
	Mon,  3 Mar 2014 13:23:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CDpzNhJfLXzVLBnJ6RY0LMuPplM=; b=JypBjd
	icgvNKuYiL/LAwM0JXfcQORY6Pwn/qC0FpIGc2P+pCwTw0f1QV6zZMeiY9r3b/WS
	0HG+W2a/9Qp5VLd5Sqieo1fHaQBhbWclatjFFwNUULkx9gGtC0MwffzK+rsu0i1Q
	p864kBr54j1AMWE0mJBkmxHpmSBRbIWFrNTP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MVu6fsAd67EtPfknsz7U+luoB0L+f18D
	6khkGDAmN+LVtBGm7hSqkI1htzs2Z0DlLUOmqxgEwIlhdw5I+TTV/h2IhDnyi5vt
	P6bolpr6HudyrEoGzyOps9+B9fZhA6ePifYqHcSxUbrX/JHPhuXtjawEljEGGMGr
	4J184zzt9vk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD92170E12;
	Mon,  3 Mar 2014 13:23:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 172F770E11;
	Mon,  3 Mar 2014 13:23:42 -0500 (EST)
In-Reply-To: <20140301070758.GE20397@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 1 Mar 2014 02:07:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F37401CC-A300-11E3-8DCF-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243245>

Jeff King <peff@peff.net> writes:

> I realize that I just bikeshedded on subject lines for half a page, and
> part of me wants to go kill myself in shame. But I feel like I see the
> technique misapplied often enough that maybe some guidance is merited.

Thanks.  What I queued read like these:

$ git shortlog ..dd/use-alloc-grow

Dmitry S. Dolzhenko (11):
      builtin/pack-objects.c: use ALLOC_GROW() in check_pbase_path()
      bundle.c: use ALLOC_GROW() in add_to_ref_list()
      cache-tree.c: use ALLOC_GROW() in find_subtree()
      commit.c: use ALLOC_GROW() in register_commit_graft()
      diff.c: use ALLOC_GROW() instead of inline code
      diffcore-rename.c: use ALLOC_GROW() instead of inline code
      patch-ids.c: use ALLOC_GROW() in add_commit()
      replace_object.c: use ALLOC_GROW() in register_replace_object()
      reflog-walk.c: use ALLOC_GROW() instead of inline code
      dir.c: use ALLOC_GROW() in create_simplify()
      attr.c: use ALLOC_GROW() in handle_attr_line()

but I tend to agree with you that we can just stop at "use ALLOC_GROW"
after the filename.
