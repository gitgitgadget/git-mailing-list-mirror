From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug report about symlinks
Date: Mon, 04 Aug 2014 09:34:49 -0700
Message-ID: <xmqqbns0tdqu.fsf@gitster.dls.corp.google.com>
References: <web-416867478@relay1.vsu.ru> <53DABD69.7010004@web.de>
	<xmqqppgkw55g.fsf@gitster.dls.corp.google.com>
	<53DCF14D.8040705@web.de>
	<xmqqk36ptrs6.fsf@gitster.dls.corp.google.com>
	<53DEBEE7.6070009@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nikolay Avdeev <avdeev@math.vsu.ru>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 04 18:35:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XELEA-00082X-1O
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 18:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbaHDQfF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Aug 2014 12:35:05 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53653 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509AbaHDQfE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Aug 2014 12:35:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 400BD2D28E;
	Mon,  4 Aug 2014 12:34:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=e982jvQ6BLDo
	89a6QGdNDPpm12Q=; b=pBX4q8dUV0Kwhg3rlHglbq2ZUIG584+zZ45K5ipFrd4D
	i+GWSNwj6CaFMf1i8ocfHjc47bTnLX+pp+YrJBU8amTx1mPQbXdWMa9dmj3UKh6w
	57j935vIDZdKyFBVKDiKOeFArP+bhIwrKDraNDChGKMpYtA7riUn63W3H1nH7ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GIjW8R
	53XDBYAQ2ZMYJpfW+5ec5vf5wydUnrUwHSjLHAMzOFjwq33Jb3H7SmKI23ThhBxa
	+6dPPVcXejEq+C3oONJLb27hhmY8QcGUcBRKSdFduJlnyR2FAByyH7ZDY8CBipJJ
	2KxTq/bIs20n5CYRty90kg7qKwIT9B8auMWgc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2D6E22D28D;
	Mon,  4 Aug 2014 12:34:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AE5912D274;
	Mon,  4 Aug 2014 12:34:50 -0400 (EDT)
In-Reply-To: <53DEBEE7.6070009@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Mon, 04
	Aug 2014 00:59:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4177B20C-1BF5-11E4-BD5B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254743>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 03.08.2014 um 19:19 schrieb Junio C Hamano:
>
>>> And do we need to use the threaded_ variant of the function here?
>>
>> Hmmm, this is a tangent, but you comment made me wonder if we also
>> need to adjust preload_thread() in preload-index.c somehow, but we
>> do not touch CE_UPTODATE there, so it probably is not necessary.
>
> The function calls ce_mark_uptodate(), which does set CE_UPTODATE.  I=
t
> calls threaded_has_symlink_leading_path() before lstat() already,
> however.  (Since f62ce3de: Make index preloading check the whole path
> to the file.)

Yeah, by "we do not touch", I meant "for paths that is beyond a
symlink, we do not touch" (i.e. we have that "continue" before
lstat-match-then-mark sequence).

>> The caller of refresh_cache_ent() is walking an array of sorted
>> pathnames aka istate->cache[] in a single-threaded fashion, possibly
>> with a pathspec to limit the scan.
>
> There are two direct callers (refresh_index(), refresh_cache_entry())
> and several indirect ones.  Do we have a way to detect unsynchronized
> parallel access to the has_symlink_leading_path()-cache?  Checking th=
e
> full callers-of-callers tree manually looks a bit scary to me.

The threaded variant is not used anybody outside preload-index, so
currently we should be OK, I would think.
