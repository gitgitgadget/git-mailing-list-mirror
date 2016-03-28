From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3/GSoC 2/5] path.c: implement xdg_runtime_dir()
Date: Mon, 28 Mar 2016 10:03:13 -0700
Message-ID: <xmqqd1qezga6.fsf@gitster.mtv.corp.google.com>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
	<1458728005-22555-2-git-send-email-huiyiqun@gmail.com>
	<20160325095923.GB8880@sigill.intra.peff.net>
	<CAKqreux8FHdJoKDishjQkbi9g1oUc265EUK4nOJ_sgeFivGSNA@mail.gmail.com>
	<20160325175947.GC10563@sigill.intra.peff.net>
	<CAKqreuzNeY7HryZvMgLKpPAbXOQ_qLfX63YOj57Wo+KrHJbtMA@mail.gmail.com>
	<xmqq60w61wsp.fsf@gitster.mtv.corp.google.com>
	<CAKqreuxJ7Rz2G_hmnAOH7W4rBBKr=CX3pjbzJkkK1ZhN=3_o-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Your friend <pickfire@riseup.net>
To: =?utf-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 19:03:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akaZb-0005gh-Da
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 19:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226AbcC1RDS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2016 13:03:18 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51804 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754580AbcC1RDQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2016 13:03:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9B9BB4F666;
	Mon, 28 Mar 2016 13:03:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=K/T6/aU8rDT5
	mmNSy2tme49p0fM=; b=rhPeuz8Jg28XWisDynt8H6ej3kL31CI/wSM8JQLEqfvg
	A/RukxO2IaFrzYQWH8xPTZqOX1p6Gd60C+9KaGE6OgjTgj1QAXFKIJl3JAVRhhkh
	gyy92y0GDbbguCeptWRecP43qLGqReqXeLMcrVbAPhdyWxtPjQ7bTRKVDIN/yQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CcjDVJ
	AKV7poG4TDfyuIHUYVwR7HUZk80NLPVlvp4XVao7o6q8glFpZjeWd6czsT+nTeLj
	3KoERgS7yJMx3WDVeHvnKPF8gqmgSWx7JJLJeRp0rf7IiamfBC/Suex1gdWTp2wV
	uwgiXvOtXdO4Km5xbHR4IaEuQmLH6k8QtfMYU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 92D2B4F665;
	Mon, 28 Mar 2016 13:03:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 097744F663;
	Mon, 28 Mar 2016 13:03:14 -0400 (EDT)
In-Reply-To: <CAKqreuxJ7Rz2G_hmnAOH7W4rBBKr=CX3pjbzJkkK1ZhN=3_o-w@mail.gmail.com>
	(=?utf-8?B?IuaDoOi9tue+pCIncw==?= message of "Mon, 28 Mar 2016 23:00:53
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F6010E1C-F506-11E5-A3C8-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290049>

=E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> writes:

> For example:
>
>     const char *enter_repo(const char *path, int strict)
>     {
>         static struct strbuf validated_path =3D STRBUF_INIT;
>         static struct strbuf used_path =3D STRBUF_INIT;
>
>         if (!path)
>             return NULL; // no need to release, right?
>         ...
>     }

Correct.
