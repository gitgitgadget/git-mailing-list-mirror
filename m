From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: MinGW port usable
Date: Wed, 31 Jan 2007 22:35:39 -0800
Message-ID: <45C18A3B.2070004@zytor.com>
References: <200701292320.43888.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Feb 01 07:36:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCVYB-0008Et-Bc
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 07:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161122AbXBAGf7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 01:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933383AbXBAGf7
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 01:35:59 -0500
Received: from terminus.zytor.com ([192.83.249.54]:42676 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933381AbXBAGf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 01:35:58 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l116ZdNJ000386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 31 Jan 2007 22:35:41 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
In-Reply-To: <200701292320.43888.johannes.sixt@telecom.at>
X-Virus-Scanned: ClamAV 0.88.7/2509/Wed Jan 31 16:36:58 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=0.6 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_96_XX,RCVD_IN_SORBS_DUL autolearn=no version=3.1.7
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38329>

Johannes Sixt wrote:
> 
> The README.MinGW at 
> http://repo.or.cz/w/git/mingw.git?a=blob_plain;f=README.MinGW;hb=master gives 
> an overview on the state. The transfer via native git protocol does not work 
> and cannot be made working without major surgery(*). Theoretically, using 
> netcat (nc) as GIT_PROXY_COMMAND should work, but not in my setup for some 
> reason that I still do not know.
> 
> (*) The reason is that on Windows read() and write() cannot operate on 
> descriptors created by socket(). A work-around is to implement a (threaded) 
> proxy, but that's almost the same as if netcat were used as 
> GIT_PROXY_COMMAND.
> 

Actually, I believe it can for the NT series kernels (at least 2000 or 
later, not sure about the earlier ones), but not for the DOS-based ones.

The trick is to use _open_osfhandle() to convert the file handle (a 
WinAPI construct) to a file descriptor (which in Windows is a construct 
of the C library.)

In 9x/ME, a socket isn't represented by a file handle, so 
_open_osfhandle() doesn't work on a socket object.

http://msdn.microsoft.com/library/default.asp?url=/library/en-us/vccore98/html/_crt__open_osfhandle.asp

	-hpa
