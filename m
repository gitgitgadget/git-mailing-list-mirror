From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] compat/cygwin.c - Use cygwin's stat if core.filemode == true
Date: Sun, 12 Oct 2008 17:39:34 +0400
Message-ID: <20081012133934.GB21650@dpotapov.dyndns.org>
References: <7v1vymke85.fsf@gitster.siamese.dyndns.org> <1223765806-3332-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, spearce@spearce.org, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 15:41:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp1CS-000175-Hq
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 15:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbYJLNjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 09:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbYJLNjl
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 09:39:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:7954 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbYJLNjk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 09:39:40 -0400
Received: by fg-out-1718.google.com with SMTP id 19so909875fgg.17
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 06:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=CigLqhuEvP/VMp5WYe0Z41+cdI0pgytKig4oAAxFxqc=;
        b=HlCmSAsnERphpOxnNRyl9q9dCbV2DEf9QzoAIIXVSWGnIIjhymCtjEfYbn4x2YQuuH
         BZBKmg8CE0f/ydgJphnlceBrqxwfriqvZU6nwj/CSCybtuWSSCa6ra9GGuYu4DDSXEku
         U9XalpL5QMynDhxPwBOdcZmNjlRb81hgDHhoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=k0TLYEnWO73aByIdLYgpGIHY60k2E96j6HfEsL1Wtn2Y8LuPlu7BNSWR/VEQi6wg3q
         s2T1MI4UcaYa4Ut0CACzEHB35rW2mFtF3487FpVAYXrNd7ZRS0YFhXQYBhvwpWxp+KDr
         Zyl6queFLGRQ/0R3wfrDiXw6zqXaTqqmd5hOA=
Received: by 10.86.28.2 with SMTP id b2mr3943450fgb.31.1223818778547;
        Sun, 12 Oct 2008 06:39:38 -0700 (PDT)
Received: from localhost (ppp85-141-237-231.pppoe.mtu-net.ru [85.141.237.231])
        by mx.google.com with ESMTPS id l19sm5473310fgb.7.2008.10.12.06.39.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Oct 2008 06:39:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1223765806-3332-1-git-send-email-mlevedahl@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98019>

On Sat, Oct 11, 2008 at 06:56:46PM -0400, Mark Levedahl wrote:
> diff --git a/compat/cygwin.c b/compat/cygwin.c
> index 423ff20..1fed265 100644
> --- a/compat/cygwin.c
> +++ b/compat/cygwin.c
> @@ -91,13 +91,20 @@ static int cygwin_stat(const char *path, struct stat *buf)
>   * functions should be used. The choice is determined by core.ignorecygwinfstricks.
>   * Reading this option is not always possible immediately as git_dir may be
>   * not be set yet. So until it is set, use cygwin lstat/stat functions.
> + * However, if core.filemode is true, we *must* use the Cygwin posix stat as
> + * the Windows stat fuctions do not determine posix filemode.
>   */
>  static int native_stat = 1;
> +static int core_filemode = 0;

Is it a reason to add a new variable instead of using trust_executable_bit?
And if so, why its default value is different? I know that this default does
not matter usually, because core.filemode is always stored in .git/config,
but still I don't like this discrapency.

Otherwise, I don't have any objection to this patch.

Dmitry
