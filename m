From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/12] fix checking out a being-rebased branch
Date: Wed, 20 Apr 2016 11:09:18 -0700
Message-ID: <xmqqd1pkw3sh.fsf@gitster.mtv.corp.google.com>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
	<1461158693-21289-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, rethab.ch@gmail.com, rappazzo@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 20:09:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aswZ5-0001gt-FJ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 20:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbcDTSJW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 14:09:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55251 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750902AbcDTSJW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2016 14:09:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A93121358A;
	Wed, 20 Apr 2016 14:09:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3kPTXfnf6ZiX
	3p3c7h6rmMFTEv0=; b=lpd7Ql0bdnfbwgR9XZq70ULnHdeB/YuQIXQEJByLnMYT
	ZObx49dtn6Chz0f/so1RALnHfXV1J7P77Tj7WMNIxdvgrcXTwtxNGRy5ng2CaGyz
	gT59uKNTlFyYZSGoMYuS1wGVbB8GJ9k9zEYaOJaUyUoWmqLV2tL7AUonsBEfR8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Bw97+t
	c0n+gEQVNq0x2g2dujNqAmuAiBZ/IKIWLRRUkbEqeFWbfl8jLQRATbPX6eXlTzxO
	5e7KNWIW6mnekpK1Ml6zug2iO5IaPtYqH2FrrTilz5Xs+VbkoQaAYXlzW0WbSixe
	BzvUYo1bsGUm4E876e7nG4GOUqO3zttHAWXBc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F9B813589;
	Wed, 20 Apr 2016 14:09:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F22D613588;
	Wed, 20 Apr 2016 14:09:19 -0400 (EDT)
In-Reply-To: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 20
 Apr 2016 20:24:41 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 00D57C64-0723-11E6-A300-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292049>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Much happier with this version. This makes
>
>  - git checkout refuse if a branch is under rebase or bisect
>    elsewhere
>
>  - git worktree add refuse if a branch is under rebase or bisect
>
>  - git branch -D refuse if a branch is under rebase or bisect.
>    This applies for single worktree case as well.
>
>  - git branch -M refuse if a branch is under rebase or bisect
>    (single worktree case as well)

I agree that this reads much nicer than v1, especially with the
abstraction around find_shared_symref() that returns the actual
worktree.

>   [01/12] path.c: add git_common_path() and strbuf_git_common_path()
>   [02/12] worktree.c: store "id" instead of "git_dir"
>   [03/12] worktree.c: make find_shared_symref() return struct worktre=
e *
>   [04/12] worktree.c: mark current worktree
>   [05/12] path.c: refactor and add worktree_git_path()
>   [06/12] wt-status.c: split rebase detection out of wt_status_get_st=
ate()
>   [07/12] wt-status.c: make wt_status_check_rebase() work on any work=
tree
>   [08/12] worktree.c: avoid referencing to worktrees[i] multiple time=
s
>   [09/12] worktree.c: test if branch being rebased in another worktre=
e
>   [10/12] wt-status.c: split bisect detection out of wt_status_get_st=
ate()
>   [11/12] worktree.c: test if branch being bisected in another worktr=
ee
>   [12/12] branch: do not rename a branch under bisect or rebase
>
> Total 13 files changed, 335 insertions(+), 67 deletions(-)
