From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 18/25] setup.c: support multi-checkout repo setup
Date: Thu, 27 Feb 2014 12:28:50 -0800
Message-ID: <xmqqk3cgxptp.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-19-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 21:29:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ7Zl-0000HY-9t
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 21:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbaB0U25 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Feb 2014 15:28:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51250 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255AbaB0U24 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 15:28:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4818170B15;
	Thu, 27 Feb 2014 15:28:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=P1ZBm0zdb1XE
	1VqJhteT6zID6HU=; b=vGtNqg+lokmVllp3JK2bdJRaNSw8p9btlG9RWiPhdD0o
	6SW4VP8KMuRj1JTuwrPAgnxxskXdCNKzpVOBKENWNRz/RSvNaLrZoSlhV/wzscN8
	LcWAxXZk0E9F7HE8iK8u5AelrlmysFkXvUYa6zVsJCVPDlnwGdBePY2OiOaZCNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CF6CHT
	bUvC1YAwTulKYX6jc29M836RLhOb/eGw8X8Mflgo5CTAMW5VE4C70kUL7nNYhu8I
	prCnUAmlBR0UzZPCCukevjBcBjlqhvRplzyTnFWy5WdYQIxFpfwM82217tFqy2uA
	FSGDZlysYjxt13KLyM/ICYtsJ4l1oM7+CsH4Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E9A970B14;
	Thu, 27 Feb 2014 15:28:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E64470B13;
	Thu, 27 Feb 2014 15:28:54 -0500 (EST)
In-Reply-To: <1392730814-19656-19-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 18
 Feb 2014 20:40:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C6EB6070-9FED-11E3-B459-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242851>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The repo setup procedure is updated to detect $GIT_DIR/commondir and
> set $GIT_COMMON_DIR properly.
>
> The core.worktree is ignored when $GIT_DIR/commondir presents. This i=
s
> because "commondir" repos are intended for separate/linked checkouts
> and pointing them back to a fixed core.worktree just does not make
> sense.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/config.txt        |  3 +-
>  Documentation/git-rev-parse.txt |  3 ++
>  builtin/rev-parse.c             |  4 +++
>  cache.h                         |  1 +
>  environment.c                   |  8 ++---
>  setup.c                         | 33 +++++++++++++-----
>  t/t1501-worktree.sh             | 76 +++++++++++++++++++++++++++++++=
++++++++++
>  t/t1510-repo-setup.sh           |  1 +
>  trace.c                         |  1 +
>  9 files changed, 115 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 5f4d793..cbf4d97 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -381,7 +381,8 @@ false), while all other repositories are assumed =
to be bare (bare
> =20
>  core.worktree::
>  	Set the path to the root of the working tree.
> -	This can be overridden by the GIT_WORK_TREE environment
> +	This can be overridden by the GIT_WORK_TREE
> +	or GIT_COMMON_DIR environment
>  	variable and the '--work-tree' command line option.

During my first reading, I was guessing that the reason you changed
this is because COMMON_DIR may redirect the config file from which
core.worktree may be read.  But that is probably not what you meant.
You do not want to share core.worktree between the borrowing and the
borrowed repositories.  If the presense of GIT_COMMON_DIR _disables_
core.worktree settings without supplying an alternative value, as
opposed to GIT_WORK_TREE which does override with an alternative
value, it is very different from "can be overriden".

It needs a better phrasing.

By the way, do we need to do something special for core.bare as
well for a similar reason?
