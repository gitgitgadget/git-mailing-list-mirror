From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-init: autodetect core.ignorecase
Date: Tue, 25 Mar 2008 10:59:00 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803251056520.10660@wbgn129.biozentrum.uni-wuerzburg.de>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org> <1206428273-15926-1-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Frank <streamlake@tiscali.it>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 11:00:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je5wv-0003eU-FO
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 11:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbYCYJ7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 05:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbYCYJ7E
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 05:59:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:37222 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752686AbYCYJ7D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 05:59:03 -0400
Received: (qmail invoked by alias); 25 Mar 2008 09:59:02 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp001) with SMTP; 25 Mar 2008 10:59:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jmRxHfe5jgdVe6gc4K2+UfShwzBkjZHk+uxmaBV
	A6ZuzkFI7Mt4s+
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <1206428273-15926-1-git-send-email-dpotapov@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78167>

Hi,

On Tue, 25 Mar 2008, Dmitry Potapov wrote:

> diff --git a/builtin-init-db.c b/builtin-init-db.c
> index 79eaf8d..62f7c08 100644
> --- a/builtin-init-db.c
> +++ b/builtin-init-db.c
> @@ -254,8 +254,8 @@ static int create_default_files(const char *git_dir, const char *template_path)
>  			git_config_set("core.worktree", work_tree);
>  	}
>  
> -	/* Check if symlink is supported in the work tree */
>  	if (!reinit) {
> +		/* Check if symlink is supported in the work tree */
>  		path[len] = 0;
>  		strcpy(path + len, "tXXXXXX");
>  		if (!close(xmkstemp(path)) &&
> @@ -266,6 +266,12 @@ static int create_default_files(const char *git_dir, const char *template_path)
>  			unlink(path); /* good */
>  		else
>  			git_config_set("core.symlinks", "false");
> +
> +		/* Check if the filesystem is case-insensitive */
> +		path[len] = 0;
> +		strcpy(path + len, "CoNfIg");
> +		if (access(path, F_OK))
> +			git_config_set("core.ignorecase", "true");

Clever!

Last time I checked, the "HEAD" file on VFAT was converted to "head" when 
the repository was initialised on Win32 (IIRC) and read on Linux (IIRC).  
Maybe this problem has gone away, but if not, it should definitely be 
fixed (depending on core.ignorecase).

Ciao,
Dscho
