From: Phil Susi <phillsusi@gmail.com>
Subject: git difftool and proper path escaping on windows
Date: Fri, 08 May 2015 13:31:05 -0400
Message-ID: <554CF2D9.3050608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 08 19:32:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqm8I-0008Ns-Uf
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 19:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbbEHRcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 13:32:14 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33946 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457AbbEHRcN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 13:32:13 -0400
Received: by qkgx75 with SMTP id x75so52685747qkg.1
        for <git@vger.kernel.org>; Fri, 08 May 2015 10:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=zGpVGJHL8k1UJhTluE3qVv7t+231FD82cUNRNbPeDDA=;
        b=NmhxvtiKPYghkapXzaeg3K97DRZiCiFDS0OnXpp/RdkwPiPMMw4q84qVwhmdlhw9WQ
         U21RXMa4B32PpTVcJDSoZxCO6u+38FYwMbBYksPcLJ0YfXNbpuBfqaV5n/J/Hd4QhnG2
         qV+9lrKgjMbgYqvH/NOsSRAO/zSwBbwX2mKQgIWu8t87YucLrXcdk+hqbjBRCmmgST1m
         +Q/QwVPd7Nd0VC4MMLTTchSha3TOlbBPIN5OAO/M5l//7Kqji1M021rpFcMK6T1Z30H8
         kMV5grTNlNPgGuK27gP/ArUZ5M3CMaRc78VI3x4UXk7n+Ehd3By/2h8f0ZhLgL2/l7Kj
         ey8w==
X-Received: by 10.55.22.23 with SMTP id g23mr10426190qkh.4.1431106333325;
        Fri, 08 May 2015 10:32:13 -0700 (PDT)
Received: from [10.1.1.212] (fl-67-77-88-12.sta.embarqhsd.net. [67.77.88.12])
        by mx.google.com with ESMTPSA id f9sm4011584qhe.34.2015.05.08.10.32.12
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 10:32:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268631>

I'm trying to have git difftool run winmerge to compare files, but it 
seems to be doing something silly with path translation.  My first 
attempt was:

git difftool -x /c/Program\ Files\ \(x86\)/WinMerge/WinMergeU.exe

To which it responded:

C:\Users\psusi\AppData\Local\Programs\Git/libexec/git-core\git-difftool--helper:
  eval: line 61: syntax error near unexpected token `('

C:\Users\psusi\AppData\Local\Programs\Git/libexec/git-core\git-difftool--helper:
  eval: line 61: `c:/Program Files (x86)/WinMerge/WinMergeU.exe "$LOCAL" 
"$REMOTE


My first thought was that my shell removed the backslash escapes and 
then git tried to pass the remaining command to another shell.  So I 
wrapped the path in single quotes, which should pass the escapes to git, 
which should pass them to the shell, which should then be able to parse 
the spaces in parenthesis in the path, but instead I got this:

Launch 'c:/Program/ Files/ /(x86/)/WinMerge/WinMergeU.exe'

So it appears that git is replacing backslashes with forward slashes, 
then trying to pass that to the shell, which doesn't work.  Any idea how 
to fix or workaround this bug?
