From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] reachable: only mark local objects as recent
Date: Fri, 27 Mar 2015 12:00:05 -0700
Message-ID: <xmqqa8yyw9je.fsf@gitster.dls.corp.google.com>
References: <20150327113240.GA7781@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 27 20:00:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbZUX-0006II-Em
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 20:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbbC0TAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 15:00:11 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56186 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751212AbbC0TAK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 15:00:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1343B4238F;
	Fri, 27 Mar 2015 15:00:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q56TODOAkEkSL9tPJPSPz165qnU=; b=wN88oE
	A5RtAX0gaaz4uXvY4lpEzSRO40Afa7NuOlvEn77NT1NTGw7xZyGtT0O0tEpmmKJm
	r/ckFaeDhpRGponDTUjy65u4evN/PLLCBmSYf7KVNfz32IblllhxixVbqjT7/oUa
	x5x89kZvCAUIAEylWUT0TQulqL0cX3uaCARn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JZzwpYR1LWWyosPQPajX0cxPyEqHo47X
	srePb7CmfhNbbxTXglCj5BtDJnN8TrjyMdgIEHuM4Zm4MssURtlfReub8nNB3Z1L
	M4N7dsf9VybYxUz3CbBLCyqj1ZlQRla9OTRXY5P5td/EKoQSsnmYIuEJTJLUd0nw
	KEzrSCplEU4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 02D8B4238E;
	Fri, 27 Mar 2015 15:00:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7003A42389;
	Fri, 27 Mar 2015 15:00:07 -0400 (EDT)
In-Reply-To: <20150327113240.GA7781@peff.net> (Jeff King's message of "Fri, 27
	Mar 2015 07:32:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7C2131F4-D4B3-11E4-AC4C-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266379>

Jeff King <peff@peff.net> writes:

> It is possible that we may drop an object that is depended
> upon by another object in the alternate. For example,
> imagine two repositories, A and B, with A pointing to B as
> an alternate. Now imagine a commit that is in B which
> references a tree that is only in A. Traversing from recent
> objects in B might prevent A from dropping that tree. But
> this case isn't worth covering. Repo B should take
> responsibility for its own objects. It would never have had
> the commit in the first place if it did not also have the
> tree, and assuming it is using the same "keep recent chunks
> of history" scheme, then it would itself keep the tree, as
> well.

In other words, if you have a loop in dependency chain among
alternate repositories, your set-up is broken by definition.

Which makes sense to me.

Thanks.
