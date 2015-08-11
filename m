From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/16] Move lockfile documentation to lockfile.h and lockfile.c
Date: Tue, 11 Aug 2015 12:27:28 -0700
Message-ID: <xmqqtws5r5gf.fsf@gitster.dls.corp.google.com>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
	<c795223dcaca8e092b10673d20def4f44156ca31.1439198011.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Aug 11 21:27:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPFCx-0002hj-Fz
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 21:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbbHKT1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 15:27:31 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:32912 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbbHKT1a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 15:27:30 -0400
Received: by pabyb7 with SMTP id yb7so136375613pab.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 12:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=w+ZXwlEsfrYkYJtQfLL+1u0o49jrABdQqbnm2LpKm8Y=;
        b=NM+UYPGTALH5k1ulG8g1Em4PjZEczMb+gEqRUnne4x2AmXhn6ZIrrpRxp5hNMNAME4
         Ku/EM0l3vhpa7eqX51Cdm+fVtNvb7Opj4aKMFI4+uib54OUEIfjxwKpI/oReO7WtGooZ
         BK5jSkJ7ssN5+75zYkx+xCodIoom0TI02nr/znTVEutvjWUR2UFNZLp5V/MDsDmtj1AD
         sRdZyAFyGHSnhHqdeCOZ37DRTfWOdiczpiW0OwbIFdbXRzP9S+70XY5hUcUwO8Tklu3Z
         0rgdDun01FlNDYzYOfLLRamYGHs2H+Sh4/VixHDq/KFkZB+3TF+V/z1Rl+ANP0/ULSvS
         LXtA==
X-Received: by 10.68.202.72 with SMTP id kg8mr59590125pbc.42.1439321250321;
        Tue, 11 Aug 2015 12:27:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id f1sm3625859pdp.39.2015.08.11.12.27.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 12:27:29 -0700 (PDT)
In-Reply-To: <c795223dcaca8e092b10673d20def4f44156ca31.1439198011.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 10 Aug 2015 11:47:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275712>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Rearrange/rewrite it somewhat to fit its new environment.
> ...
> diff --git a/lockfile.h b/lockfile.h
> index b4abc61..a483cc9 100644
> --- a/lockfile.h
> +++ b/lockfile.h
> @@ -4,54 +4,103 @@
> ...
> @@ -68,16 +117,51 @@ struct lock_file {
>  #define LOCK_SUFFIX ".lock"
>  #define LOCK_SUFFIX_LEN 5
>  
> +
> +/*
> + * Flags
> + * -----
> + *
> + * The following flags can be passed to `hold_lock_file_for_update()`
> + * or `hold_lock_file_for_append()`.
> + */
> +
> +/*
> + * If a lock is already taken for the file, `die()` with an error
> + * message. If this flag is not specified, trying to lock a file that
> + * is already locked returns -1 to the caller.
> + */
>  #define LOCK_DIE_ON_ERROR 1
> +
> +/*
> + * Usually symbolic links in the destination path are resolved. This
> + * means that (1) the lockfile is created by adding ".lock" to the
> + * resolved path, and (2) upon commit, the resolved path is
> + * overwritten. However, if `LOCK_NO_DEREF` is set, then the lockfile
> + * is created by adding ".lock" to the path argument itself. This
> + * option is used, for example, when detaching a symbolic reference,
> + * which for backwards-compatibility reasons, can be a symbolic link
> + * containing the name of the referred-to-reference.
> + */
> ...

Thanks.  I really like the way these per-item descriptions explain
each item much better.  The old documentation may have contained all
the same info, but a better organization makes a big difference.
