From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] environment: enable core.preloadindex by default
Date: Thu, 05 Jun 2014 15:59:55 -0700
Message-ID: <xmqqr433q7x0.fsf@gitster.dls.corp.google.com>
References: <CACbrTHdoA3UgoXOMVeB2ST_y-JzA2FZM7s8_uwG8C3D29WZK=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Steve Hoelzer <shoelzer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 01:00:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wsgdj-0007ku-Uy
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 01:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbaFEXAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 19:00:03 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55623 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083AbaFEXAC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 19:00:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 437C71E227;
	Thu,  5 Jun 2014 19:00:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=BnKXUpqXOjBmL3Wd3qfK/fbwy9Y=; b=QJRtuhL0D5x2W58+1wdP
	JP2U4WWNcMLbNAGdqTl/0KRlRbP3s6dnJYlKnd51e/h/wvzDQYmG7fuXB78HjHmD
	Jmxs2BXh0uKCToE+LHWg2cUERHlVPaN/kGx/DkTnSFHScP3p3Lc0eydYrO9nXQ67
	MI8TvVPtQ66ZbW6qalja8/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=g1H6KAo2OCpoCtDeW8rqzAPDsWAMfylBehpJY3UIjUSl5T
	kVzilgRMyGc5U6D6WQEnQ63VQzxiJLhAjTYKMowVJ6mjBM7/4eJVA/tjoEYvw6oI
	qZnEW64i+rzIvtev7fAwyBRERcDIrR0e9rgo36Su6IOqgn3/gOEt51qUYQ5tM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B7CF81E223;
	Thu,  5 Jun 2014 19:00:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 07F911E210;
	Thu,  5 Jun 2014 18:59:56 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1D1ED8FA-ED05-11E3-832D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250874>

Steve Hoelzer <shoelzer@gmail.com> writes:

> There is consensus that the default should change because it will
> benefit nearly all users (some just a little, but some a lot).
> See [1] and replies.
>
> [1]: http://git.661346.n2.nabble.com/git-status-takes-30-seconds-on-Windows-7-Why-tp7580816p7580853.html
>
> Signed-off-by: Steve Hoelzer <shoelzer@gmail.com>
> ---

The patch is whitespace damaged, and the log message was unusable
without referring to an external site.  Both locally fixed and
queued.

Thanks.

>  Documentation/config.txt | 4 ++--
>  environment.c            | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1932e9b..4b3d965 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -613,9 +613,9 @@ core.preloadindex::
>  +
>  This can speed up operations like 'git diff' and 'git status' especially
>  on filesystems like NFS that have weak caching semantics and thus
> -relatively high IO latencies.  With this set to 'true', Git will do the
> +relatively high IO latencies.  When enabled, Git will do the
>  index comparison to the filesystem data in parallel, allowing
> -overlapping IO's.
> +overlapping IO's.  Defaults to true.
>
>  core.createObject::
>   You can set this to 'link', in which case a hardlink followed by
> diff --git a/environment.c b/environment.c
> index 5c4815d..1c686c9 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -71,7 +71,7 @@ unsigned long pack_size_limit_cfg;
>  char comment_line_char = '#';
>
>  /* Parallel index stat data preload? */
> -int core_preload_index = 0;
> +int core_preload_index = 1;
>
>  /* This is set by setup_git_dir_gently() and/or git_default_config() */
>  char *git_work_tree_cfg;
