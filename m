From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a large repo?
Date: Fri, 20 Feb 2015 13:04:30 -0800
Message-ID: <xmqqa908z44h.fsf@gitster.dls.corp.google.com>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
	<CACBZZX6A+35wGBYAYj7E9d4XwLby21TLbTh-zRX+fkSt_e2zeg@mail.gmail.com>
	<CACsJy8DkS65axQNY70FrfqR5s-49oOn8j7SAE9BTiRVNrm+ohQ@mail.gmail.com>
	<CACBZZX4T38j9YU3eiHTfkDoZKsgyJFrnJQNm5WBmb9RDenDOBg@mail.gmail.com>
	<CACBZZX45eCo6YS4EpHvMQjN32+-w5BztfoLiwh_rJTs7FydgoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Stephen Morton <stephen.c.morton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 22:04:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOukX-0002Uj-SG
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 22:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbbBTVEe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Feb 2015 16:04:34 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754303AbbBTVEd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2015 16:04:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A730E39F7A;
	Fri, 20 Feb 2015 16:04:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fNZbV+aQzLZh
	9MJfyi08iPC980A=; b=DjB34g4tsPNPyWryL1RwIcC06gQf+sn6/vPP8VIsYr5L
	WhM7Au01xu9sRZsgh4Ldok6EDslAaTBisfuyrdhtrVJVdbwS99OR3TxDeP4m9d4y
	QOkv41DSc8NCR/7V4Po5RoV226q/HV3fwZrPQ4CHpuBURHI7IPHYdalpgMswr3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QvtfOa
	mcenrJltpFhG0KRAwDt59SBom7vlhyO93HtS0VAxehQbh/xnDVMCJweGgYRfSjTT
	oeGbDdk8nn4Rz/6zwgo30WJ6Dkie1HmT08zOclBPLAj8hs1yURSQ7BvtxRBdnAT7
	hi2QCoP+xu8A3PpWOMDhBnLbP7ujKEpbDlIDI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D9C839F79;
	Fri, 20 Feb 2015 16:04:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1991F39F78;
	Fri, 20 Feb 2015 16:04:32 -0500 (EST)
In-Reply-To: <CACBZZX45eCo6YS4EpHvMQjN32+-w5BztfoLiwh_rJTs7FydgoQ@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 20 Feb
 2015 15:25:59
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 10F23782-B944-11E4-8B1B-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264186>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I actually ran this a few times while testing it, so this is a before
> and after on a hot cache of linux.git with 406 tags v.s. ~140k. I ran
> the gc + repack + bitmaps for both repos noted in an earlier reply of
> mine, and took the fastest run out of 3:
>
>     $ time (git log master -100 >/dev/null)
>     Before: real    0m0.021s
>     After: real    0m2.929s

Do you force --decorate with some config?  Or do you see similar
performance difference with "git rev-parse master", too?

>     $ time (git status >/dev/null)
>     # Around 150ms, no noticeable difference

This is understandable, as it will not look at any ref other than
HEAD.
