From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH RESEND] Git.pm: Always set Repository to absolute path
 if autodetecting
Date: Mon, 25 May 2009 09:33:20 +0200
Message-ID: <4A1A49C0.7040102@viscovery.net>
References: <1241703688-6892-1-git-send-email-frank@lichtenheld.de> <1241703688-6892-2-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon May 25 09:34:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8UhM-0002Wu-79
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 09:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757934AbZEYHdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 03:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757910AbZEYHdq
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 03:33:46 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:61611 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757584AbZEYHdn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 03:33:43 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M8UgZ-0000Tw-7R; Mon, 25 May 2009 09:33:34 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 09EA754D; Mon, 25 May 2009 09:33:27 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1241703688-6892-2-git-send-email-frank@lichtenheld.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119893>

Frank Lichtenheld schrieb:
> From: Frank Lichtenheld <flichtenheld@astaro.com>
> 
> So far we only set it to absolute paths in some cases which lead
> to problems like wc_chdir not working.
> 
> Signed-off-by: Frank Lichtenheld <flichtenheld@astaro.com>
> ---
>  perl/Git.pm     |    2 +-
>  t/t9700/test.pl |   10 ++--------
>  2 files changed, 3 insertions(+), 9 deletions(-)
> 
> Resent unchanged. There was one comment which I've reponded too and
> argued that it didn't apply and there was no further objections.
> 
> diff --git a/perl/Git.pm b/perl/Git.pm
> index 4313db7..e8df55d 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -185,7 +185,7 @@ sub repository {
>  
>  		if ($dir) {
>  			$dir =~ m#^/# or $dir = $opts{Directory} . '/' . $dir;
> -			$opts{Repository} = $dir;
> +			$opts{Repository} = abs_path($dir);

Unfortunately, this change breaks MinGW git because the absolute path that
this produces is MSYS-style /c/path/to/repo, but git does not understand
this; it should be c:/path/to/repo. This value is ultimately assigned to
GIT_DIR, but the path name mangling that usually happens when an MSYS
program (like perl) spawns a non-MSYS program (like git) does not happen.

Your commit message is quite vague about the problems that you have seen.
I vote to revert this change.

-- Hannes
