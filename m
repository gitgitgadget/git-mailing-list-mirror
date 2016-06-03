From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] worktree.c: find_worktree() learns to identify worktrees by basename
Date: Fri, 03 Jun 2016 08:30:30 -0700
Message-ID: <xmqqoa7iqoh5.fsf@gitster.mtv.corp.google.com>
References: <20160522104341.656-1-pclouds@gmail.com>
	<20160530104939.28407-1-pclouds@gmail.com>
	<20160530104939.28407-3-pclouds@gmail.com>
	<xmqqh9de5d6e.fsf@gitster.mtv.corp.google.com>
	<CACsJy8CmdTapWsst-PuwFNH8Uy3Vgow+fKWzQ+tGYPSc=aZsXg@mail.gmail.com>
	<xmqqr3cgycjl.fsf@gitster.mtv.corp.google.com>
	<CACsJy8B+j2im7XOV==tBtki=tOCN4k3ZHz6Jp4fq4qjqarb+ew@mail.gmail.com>
	<xmqqfusvv8lq.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BF_KKXdMNW_aOs522wBbW9BQhbrZ_0hx+f2MCW-VPUzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Reto =?utf-8?Q?Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 17:30:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8r3Z-0005he-5b
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 17:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbcFCPag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 11:30:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751384AbcFCPae (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 11:30:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B814F1F31A;
	Fri,  3 Jun 2016 11:30:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uhqrMiAD9Un5nGfcIsQb0x3CnN8=; b=kHy11C
	+2oev0sCZHU03Q+IPFTq5O34HH/9Y4+xCqJw8j3tzNcrGRl0R5TLq0BGjzUocUWJ
	PodvDuy3sKzA10OFLtQoTOeqtnJaaMQsANnl5O3YPBlxUBAypX82f362hc7+6njG
	ZNopu1s/LxQY2NKBAUdsW4etis7yKMRyqloxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YmJUm+dQJ/d2ghmUu5YmUmusMx9FqMZR
	+cXLok4EXOb8U89Dh5KFvrTx9kU6zH0O4ansUzzNbBeoN3Rt2f4y5w9FQFsk8NPg
	9GJsWsCoyp0dRyGHRmWgPzDCdiIxRNF1tWOxBveaQfSmsThS2d75OE8TVZFRfyJM
	54TBdPbetpc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B00311F319;
	Fri,  3 Jun 2016 11:30:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3F0391F318;
	Fri,  3 Jun 2016 11:30:32 -0400 (EDT)
In-Reply-To: <CACsJy8BF_KKXdMNW_aOs522wBbW9BQhbrZ_0hx+f2MCW-VPUzg@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 3 Jun 2016 18:11:29 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1C010FA4-29A0-11E6-8CC0-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296336>

Duy Nguyen <pclouds@gmail.com> writes:

> basename() does (or I think so because Windows has its own version).
> worktree->path always uses '/' but the command line option can come
> with either '/' or '\'. Probably safest to accept both.

OK.  Going beyond basename() was merely "This might be an easy
nice-to-have enhancement", not "basename() is not sufficient because
of such and such issues", so the patch is fine as-is.

Thanks.
