From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Bug: Pathspec parsing on Windows fails when branch specified
Date: Wed, 20 Nov 2013 23:12:37 +0100
Message-ID: <528D33D5.4090507@kdbg.org>
References: <CAM8h_A_zfX4U8hGxiw3_79zMZXmcTN3CPRUcrtsQTQdD4RaMhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Eris Belew <erisrenee@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 20 23:39:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjGQu-0002J9-So
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 23:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842Ab3KTWjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 17:39:37 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:64244 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751409Ab3KTWjg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 17:39:36 -0500
X-Greylist: delayed 1598 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Nov 2013 17:39:36 EST
Received: from bsmtp.bon.at (unknown [192.168.181.104])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 15BF4CE37F
	for <git@vger.kernel.org>; Wed, 20 Nov 2013 23:12:56 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B6DAE13004F;
	Wed, 20 Nov 2013 23:12:38 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id C9B1719F38F;
	Wed, 20 Nov 2013 23:12:37 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CAM8h_A_zfX4U8hGxiw3_79zMZXmcTN3CPRUcrtsQTQdD4RaMhQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238103>

Am 20.11.2013 22:09, schrieb Eris Belew:
> System: Windows Server 2008 R2
> Git: git version 1.8.4.msysgit.0
> Shell: Powershell V3 (No third-party modules loaded)
> 
> Summary:
>   When specifying a pathspec including a branch/commit, path separator
> characters are not translated. Since tab-completion in windows shells (ex:
> CMD, PowerShell, not unix-style shells running on windows) uses the windows
> path separator, and other git commands work fine with the windows path
> separator, the expected behavior would be to translate for me.
> 
> Reproduction:
>     git diff BRANCH:path\to\file path\to\file
> 
> Result:
>     fatal: Path 'path\to\file' does not exist in 'BRANCH'
> 
> Expected:
>     Normal diff operation
> 
> Workaround:
>     Manually convert pathspec. Examples of working command:
>         git diff BRANCH:path/to/file path\to\otherfile
>         git diff BRANCH:path/to/file path/to/otherfile

That's not a bug, it is expected behavior. "BRANCH:path/to/file" is not
"file on disk" syntax, but Git's syntax to reference a particular object
in the database. For this reason, forward-slashes are mandated; there is
no option to use backslashes in this case.

Backslashes could actually be part of directory and file names in the
database. It would be impossible to check out a tree with such names on
Windows, obviously.

-- Hannes
