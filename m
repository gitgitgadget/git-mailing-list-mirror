From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: git difftool and proper path escaping on windows
Date: Sun, 10 May 2015 22:09:58 +0100
Organization: OPDS
Message-ID: <303F4B003829461AB3D516B1837C17E1@PhilipOakley>
References: <554CF2D9.3050608@gmail.com> <F14B985A-C968-445A-A3F7-10AE425E7029@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "David Aguilar" <davvid@gmail.com>,
	"Phil Susi" <phillsusi@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 10 23:05:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrYPF-0000mJ-EN
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 23:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbbEJVE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2015 17:04:57 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:29294 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751653AbbEJVE4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 May 2015 17:04:56 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CQFQBUx09VPMw9Flxcgw9UXoMehBu/D4V7BASBHDwRAQEBAQEBAQYBAQEBQSQbhBsFAQEBAQMIAQEZFR4BASwCAwUCAQMOBwMCAgUhAgIUAQQIEgYHAxQGARIIAgECAwEKh3wDFgmzQYZShwMNhR4cBIEhihiCTYUnL4EWBZI9cIMuhHCCeY5DgxuDVYQbPTGCRgEBAQ
X-IPAS-Result: A2CQFQBUx09VPMw9Flxcgw9UXoMehBu/D4V7BASBHDwRAQEBAQEBAQYBAQEBQSQbhBsFAQEBAQMIAQEZFR4BASwCAwUCAQMOBwMCAgUhAgIUAQQIEgYHAxQGARIIAgECAwEKh3wDFgmzQYZShwMNhR4cBIEhihiCTYUnL4EWBZI9cIMuhHCCeY5DgxuDVYQbPTGCRgEBAQ
X-IronPort-AV: E=Sophos;i="5.13,403,1427756400"; 
   d="scan'208";a="35204829"
Received: from host-92-22-61-204.as13285.net (HELO PhilipOakley) ([92.22.61.204])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 10 May 2015 22:04:54 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268749>

From: "David Aguilar" <davvid@gmail.com>
> On May 8, 2015 10:31:05 AM PDT, Phil Susi <phillsusi@gmail.com> wrote:
>>I'm trying to have git difftool run winmerge to compare files, but it
>>seems to be doing something silly with path translation.  My first
>>attempt was:
>>
>>git difftool -x /c/Program\ Files\ \(x86\)/WinMerge/WinMergeU.exe
>>
>>To which it responded:
>>
>>C:\Users\psusi\AppData\Local\Programs\Git/libexec/git-core\git-difftool--helper:
>>  eval: line 61: syntax error near unexpected token `('
>>
>>C:\Users\psusi\AppData\Local\Programs\Git/libexec/git-core\git-difftool--helper:
>>eval: line 61: `c:/Program Files (x86)/WinMerge/WinMergeU.exe "$LOCAL"
>>"$REMOTE
>>
>>
>>My first thought was that my shell removed the backslash escapes and
>>then git tried to pass the remaining command to another shell.  So I
>>wrapped the path in single quotes, which should pass the escapes to
>>git,
>>which should pass them to the shell, which should then be able to 
>>parse
>>
>>the spaces in parenthesis in the path, but instead I got this:
>>
>>Launch 'c:/Program/ Files/ /(x86/)/WinMerge/WinMergeU.exe'
>>
>>So it appears that git is replacing backslashes with forward slashes,
>>then trying to pass that to the shell, which doesn't work.  Any idea
>>how
>>to fix or workaround this bug?
>
>
> paths and executing external programs on windows is confusing and 
> error-prone for a simple unix user such as myself.
>
> I think you might be able to work around the difficulties by making 
> the tool available in your $PATH, that way you don't have to play 
> shell quoting / escaping games.
>
> I hope that helps. if you discover a different solution, I'd be happy 
> to document it so that windows users don't have to rediscover how to 
> do it in the future.
>
> let me know how it goes.
> cheers
>
A quick web browse found https://gist.github.com/shawndumas/6158524 as 
one example of a winmerge configuration.

my personal .gitconfig has
[difftool "WinMerge"]
 path = C:/Program Files/WinMerge/WinMergeU.exe
 cmd = 'C:/Program Files/WinMerge/WinMergeU.exe' /e /x /u $LOCAL $REMOTE
[mergetool "WinMerge"]
 path = C:/Program Files/WinMerge/WinMergeU.exe
 cmd = 'C:/Program Files/WinMerge/WinMergeU.exe' /e /x /u $LOCAL $REMOTE 
$MERGED
 trustExitCode = false

(excuse whitespace damage)
though I don't use it much. 
