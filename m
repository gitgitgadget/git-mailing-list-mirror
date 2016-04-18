From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] fix checking out a being-rebased branch
Date: Mon, 18 Apr 2016 10:42:33 -0700
Message-ID: <xmqqpotm6cfq.fsf@gitster.mtv.corp.google.com>
References: <CACsJy8BOwzJSmS3PPeeRuaRwq=+kYLH8NX0i7P_wfDW9gLt6bA@mail.gmail.com>
	<1460897965-486-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, rethab.ch@gmail.com, rappazzo@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 19:42:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asDC6-0005Yf-01
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 19:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbcDRRmi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Apr 2016 13:42:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52292 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751047AbcDRRmh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2016 13:42:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DF1911317F;
	Mon, 18 Apr 2016 13:42:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qX0SkmGnbP49
	xUEgAhfISG7Ih5w=; b=t1kYD5d8Ev5rHWS2MaOFFuAjgmcxjCqrhlHbzCc1TViM
	eyTtU7jOdKyK8pzFLApSXiu933UgxwVccSIWg5CaC6h0gdD7vpRX+bVOGQYqV5b8
	Vtc1YkHG9istS5EncIHC9rEKRxMtwKrEUKyriVhEeD0GwqIh3SDwWcAxq7nSpKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cm20k5
	E36uKGPLb9Jlw4HYcYtU6+S4oYu1KlWbRFOTEgXI6K5dJQUh251ZjCEPyOHt85uG
	QM7RVHmOfmPM8n44j6Dd03LrpOkMyOcCZW8XrVRS/GplZq4FUCyMYj27ECnE17YM
	FGKHXtq4Hf17CP5oMz0Sh8M8fIGYcB7X+M+7c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D74071317D;
	Mon, 18 Apr 2016 13:42:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 03BE91317C;
	Mon, 18 Apr 2016 13:42:34 -0400 (EDT)
In-Reply-To: <1460897965-486-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpCU5n4buNYw==?= Duy"'s message of "Sun, 17
 Apr 2016 19:59:18 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EF558E58-058C-11E6-87E1-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291814>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> First cut. I need opinions on 05/07, which converts
> wt_status_get_state() to support selecting any worktree. I'm not supe=
r
> happy with leaving "TODO: not supported yet" comments, even though
> strictly speaking this series does not need it.

It is a reasonable idea to hook this to wt_status_get_state(), I
would say.

> Another option is leave wt_status_get_state() alone, factor out the
> rebase-detection code and use that for worktree/checkout. We save a
> few syscalls this way too.
>
> Comments?
>
>   [01/07] path.c: add git_common_path() and strbuf_git_common_path()
>   [02/07] worktree.c: store "id" instead of "git_dir"
>   [03/07] path.c: refactor and add worktree_git_path()
>   [04/07] worktree.c: add worktree_git_path_..._head()

I actually wondered how ky/branch-[dm]-worktree topics to avoid
"branch -d" and "branch -m" from removing or renaming a branch that
is checked out in other worktrees from screwing them up.  There may
be a missed opportunity to clean them up with using these?

>   [05/07] wt-status.c: make wt_status_get_state() support worktree
>   [06/07] worktree.c: avoid referencing to worktrees[i] multiple time=
s
>   [07/07] checkout: prevent checking out a branch being rebased in an=
other worktree
>
> Total 6 files changed, 167 insertions(+), 38 deletions(-)
