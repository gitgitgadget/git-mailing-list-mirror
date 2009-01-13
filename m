From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/6] Refactor git_set_argv0_path() to git_extract_argv0_path()
Date: Tue, 13 Jan 2009 20:37:35 +0100
Message-ID: <200901132037.35096.j6t@kdbg.org>
References: <1231595452-27698-1-git-send-email-prohaska@zib.de> <1231595452-27698-2-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steve Haslam <shaslam@lastminute.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Jan 13 20:39:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMp6M-0006vf-6n
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 20:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756794AbZAMThi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 14:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756621AbZAMThh
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 14:37:37 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:21108 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756240AbZAMThg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 14:37:36 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4C2BA2C400A;
	Tue, 13 Jan 2009 20:37:35 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 27B4558275;
	Tue, 13 Jan 2009 20:37:35 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <1231595452-27698-2-git-send-email-prohaska@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105521>

On Samstag, 10. Januar 2009, Steffen Prohaska wrote:
> @@ -63,9 +63,19 @@ const char *system_path(const char *path)
>  	return path;
>  }
>
> -void git_set_argv0_path(const char *path)
> +const char *git_extract_argv0_path(const char *argv0)
>  {
> -	argv0_path = path;

Please insert the 'if (argv0 && *argv0)' here to simplify the call sites.
Or you could introduce this check later in 4/6 because the call site in
this patch (main() of git.c) is simpler if it keeps the check.

> +	const char *slash = argv0 + strlen(argv0);
> +
> +	while (argv0 <= slash && !is_dir_sep(*slash))
> +		slash--;
> +
> +	if (slash >= argv0) {
> +		argv0_path = xstrndup(argv0, slash - argv0);
> +		return slash + 1;
> +	}
> +
> +	return argv0;
>  }

-- Hannes
