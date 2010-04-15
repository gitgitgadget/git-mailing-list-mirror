From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 8/9] builtin: check pager.<cmd> configuration if 
	RUN_SETUP_GENTLY is used
Date: Thu, 15 Apr 2010 10:33:55 +0200
Message-ID: <m2yfcaeb9bf1004150133te8af6155n63d620fef2be98a2@mail.gmail.com>
References: <20100413021153.GA3978@progeny.tock> <20100413023003.GH4118@progeny.tock> 
	<y2yfcaeb9bf1004130312l197983cnf92371acc88464db@mail.gmail.com> 
	<20100414050643.GB28864@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 10:34:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2KWk-00058f-RR
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 10:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757369Ab0DOIeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 04:34:17 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:36506 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757347Ab0DOIeP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 04:34:15 -0400
Received: by qw-out-2122.google.com with SMTP id 8so365851qwh.37
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 01:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=aqMBiBRild0Wbd2rHwaT8r0nwe7ZBPH2rT6q8NaqcKs=;
        b=JvZt0eI5uwZe2ym2nHhC9IRcc0oSP6GgQIkXeQLSm4VvInmeHqv5o8VGaGKYNv4C/F
         9Z7YhGqwrJJZOk4AtDAaE8fYV4PRvFEHPfEUo7MMD3tocoE7Yi9lBn8OlB5Cb+UglpTe
         erFZNa9ewr2cVdVmb+mn8zNej0+4D6eZFs7c8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=vSM4/PoCP+lONtFkV3hTvD3S9zNkN3ZiTUWinJ4Psm6mpLdVRqLImcgOUyy+BmOlbp
         gpyQV0pSU0AoHmZM0enrMesabu+/t5XJdy5Fpn4hL0Pazg5R+AP2fPBiqu0Wk/ms9tDR
         JmCV1ml7fuS95igwgYGTzhERU2z9O8ZscOedI=
Received: by 10.224.2.76 with HTTP; Thu, 15 Apr 2010 01:33:55 -0700 (PDT)
In-Reply-To: <20100414050643.GB28864@progeny.tock>
Received: by 10.224.72.34 with SMTP id k34mr3071234qaj.283.1271320455070; Thu, 
	15 Apr 2010 01:34:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144961>

On Wed, Apr 14, 2010 at 7:06 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> So here are some ideas for future work (not necessarily in order).
>
>  - Teach remaining commands that need to search for a repository to
>   use RUN_SETUP_GENTLY, with appropriate exceptions where needed
>   (for --no-index, for example).

 - Two patches "worktree setup: calculate prefix.." and "index-pack:
trust the prefix" may form a separate series. That would unblock
RUN_SETUP_GENTLY series.

>  - Introduce unset_git_directory and the RUN_UNSETUP option (yes,
>   this needs a better name).  Teach commands that work without a
>   git directory to use it (this should fix the init poisoned by
>   parent repository and aliased init problems).

 - Two patches that move enter_repo() to setup.c and fix it up can go
first. They should have no impact on system.

>
>  - Teach git_config() to ignore the repository-specific configuration
>   if have_run_setup is true but have_repository is false.
>
>  - Teach git_attr() to ignore .git/info/attributes if have_run_setup
>   is true but have_repository is false.
>
>  - Teach git_config() to optionally die if have_run_setup is not true
>   and the setup_git_dir* to optionally die if have_run_setup is true.
>   test-lib.sh would enable this option.
>

 - Introduce startup_info->prefix. I think that's a good change, but
it's independent to this series. The reason is, prefix can change
after setup_git_dir is called (i.e. setup_work_tree()).
 - The fix for "git cmd -h" can make a separate series (4 patches)
 - Finally the soft guard patch and assorted fixups to avoid warnings.

I'll reorder my tree and see if it looks good. Patches of this 9-patch
series will be untouched.
-- 
Duy
