From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] On Cygwin support both UNIX and DOS style path-names
Date: Tue, 09 Aug 2011 21:47:15 +0200
Message-ID: <4E418EC3.4070904@kdbg.org>
References: <1312560614-20772-1-git-send-email-pascal@obry.net> <1312560614-20772-3-git-send-email-pascal@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Tue Aug 09 21:47:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqsGr-0004i9-OG
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 21:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520Ab1HITrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 15:47:20 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:53355 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752384Ab1HITrS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 15:47:18 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 114C3A7EB0;
	Tue,  9 Aug 2011 21:47:15 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2C31619F3ED;
	Tue,  9 Aug 2011 21:47:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.18) Gecko/20110616 SUSE/3.1.11 Thunderbird/3.1.11
In-Reply-To: <1312560614-20772-3-git-send-email-pascal@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179044>

Am 05.08.2011 18:10, schrieb Pascal Obry:
> In fact Cygwin supports both, so make Git agree with this.
> The failing case is when a file is committed in a sub-dir of the
> repository using a log message from a file specified with a DOS
> style path-name. To reproduce:
> 
>    $ cd src
>    $ git commit -F c:\tmp\log.txt file.c
>    fatal: could not read log file 'src/c:\tmp\log.txt': No such file \
>    or directory.

Do you also want to support this:

     $ git add src\file.c

i.e., backslash in pathspec? Then you need more than this:

> +#define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
> +#define is_dir_sep(c) ((c) == '/' || (c) == '\\')

In particular, you have to enable backslash processing in
setup.c:prefix_filename(), but then you lose the ability to escape
special characters with the backslash.

-- Hannes
