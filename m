From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Cygwin has trustable filemode
Date: Tue, 16 Jul 2013 22:20:03 +0100
Message-ID: <51E5B903.9050601@ramsay1.demon.co.uk>
References: <1373818390-14451-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 23:44:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzD2W-0001se-Ng
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 23:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933678Ab3GPVoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 17:44:04 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:34273 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933648Ab3GPVoC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 17:44:02 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id F02C91280B3;
	Tue, 16 Jul 2013 22:44:00 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 163441280A0;
	Tue, 16 Jul 2013 22:44:00 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Tue, 16 Jul 2013 22:43:59 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <1373818390-14451-1-git-send-email-mlevedahl@gmail.com>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230586>

Mark Levedahl wrote:
> The supported Cygwin distribution on supported Windows versions provides
> complete support for POSIX filemodes, so enable this by default. git as
> distributed by the Cygwin project is configured this way.
> 
> This fixes one testsuite failure:
> t3300 test 17 (diff-index -M -p with mode change quotes funny filename)

Huh? How is it running that test? Does cygwin 1.7 somehow allow tabs in
filenames? For me, on cygwin 1.5, that test reports:

    $ ./t3300-funny-names.sh
    1..0 # SKIP Your filesystem does not allow tabs in filenames
    $

> Historical notes: Earlier versions of Cygwin (version 1.5 and prior) had 
> various methods for supporting posix file modes on different file systems, 
> often using extended attributes, and this support was optional.  Such 
> versions of Cygwin are not available on any public mirror and are not 
> supported by the Cygwin project. The currently available Cygwin supports 
> POSIX file modes without exception - this is not an optional 
> configuration. The support does depend upon the underlying file system 
> (neither Linux nor Cygwin can set an execute bit on a FAT file system as 
> FAT has no such support), but as this is no different than Linux, the
> default should not treat Cygwin differently than Linux.  

The motivation for the original patch had more to do with "windows people"
using win32 text editors which set the executable bit inappropriately.
(see commit c869753e).

Since I use cygwin tools (vim), I don't have this problem. :-D

> Users who desire the non-POSIX mode of operation must explicitly set 
> core.filemode=False, accepting non-interoperability with Linux.  
> 
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  config.mak.uname | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/config.mak.uname b/config.mak.uname
> index 7ac541e..779d06a 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -163,7 +163,6 @@ ifeq ($(uname_O),Cygwin)
>  	NO_THREAD_SAFE_PREAD = YesPlease
>  	NEEDS_LIBICONV = YesPlease
>  	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
> -	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
>  	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
>  	# There are conflicting reports about this.
>  	# On some boxes NO_MMAP is needed, and not so elsewhere.
> 

Should you revert commit c869753e ("Force core.filemode to false
on Cygwin.", 30-12-2006) instead?

ATB,
Ramsay Jones
