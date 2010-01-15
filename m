From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 05/14] mingw: support waitpid with pid > 0 and WNOHANG
Date: Fri, 15 Jan 2010 23:28:28 +0100
Message-ID: <201001152328.28260.j6t@kdbg.org>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com> <1263591033-4992-6-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	"Erik Faye-Lund" <kusmabite@gmail.com>
To: "Erik Faye-Lund" <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 23:29:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVufa-0004Pc-VK
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 23:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758283Ab0AOW31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 17:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758117Ab0AOW31
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 17:29:27 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:47766 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758141Ab0AOW30 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 17:29:26 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 14AAFCDF82;
	Fri, 15 Jan 2010 23:29:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 4FC1D19F5EB;
	Fri, 15 Jan 2010 23:28:28 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1263591033-4992-6-git-send-email-kusmabite@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137142>

On Freitag, 15. Januar 2010, Erik Faye-Lund wrote:
>  static inline int waitpid(pid_t pid, int *status, unsigned options)
>  {
> +	if (pid > 0 && options & WNOHANG) {
> +		if (WAIT_OBJECT_0 != WaitForSingleObject((HANDLE)pid, 0))
> +			return 0;
> +		options &= ~WNOHANG;
> +	}
> +
>  	if (options == 0)
>  		return _cwait(status, pid, 0);
>  	errno = EINVAL;

With this change, and in particular the one in the next patch, this function 
grows too large to be 'static inline'.

-- Hannes
