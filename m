From: Phil Hord <hordp@cisco.com>
Subject: Re: Copying Git repository from Linux to Windows.
Date: Mon, 20 Jun 2011 15:57:00 -0400
Message-ID: <4DFFA60C.1070006@cisco.com>
References: <4DF87B42.1020004@st.com> <BANLkTik+oUb1QpVTwJfB30_8FsW=4ZVTxA@mail.gmail.com> <4DF89F56.3060200@st.com> <201106151614.06529.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: viresh kumar <viresh.kumar@st.com>,
	"kusmabite@gmail.com" <kusmabite@gmail.com>, ae@op5.se,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 21:57:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYkas-00018a-W1
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 21:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578Ab1FTT5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 15:57:04 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:45093 "EHLO
	ams-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136Ab1FTT5C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 15:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1893; q=dns/txt;
  s=iport; t=1308599822; x=1309809422;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=9nGWJoifyQ4bYzE0aXMyceyB8A+EFYSc8PZp2K9Phgk=;
  b=WMkyHnf2hesQZ5Id8DUtZY9JYKsmG1Asol9neQN22c8LbigAy3q3wc8Q
   MrWsK1yX3JYaJy0hoIvyQ71WsKMWIR+7ilsBga8MDUygIZCqq6DrWz6EP
   dusDcO/CBpTCrY7Z58IQblScb8irFm1sl4+nEmoA/FbGqpDJkt0umfgDU
   s=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAHel/01Io8UQ/2dsb2JhbABTpmV3qleeFIYqBJFehGCLPQ
X-IronPort-AV: E=Sophos;i="4.65,396,1304294400"; 
   d="scan'208,217";a="95003517"
Received: from bgl-core-1.cisco.com ([72.163.197.16])
  by ams-iport-1.cisco.com with ESMTP; 20 Jun 2011 19:56:58 +0000
Received: from [64.100.104.120] (dhcp-64-100-104-120.cisco.com [64.100.104.120])
	by bgl-core-1.cisco.com (8.14.3/8.14.3) with ESMTP id p5KJutEY021313;
	Mon, 20 Jun 2011 19:56:56 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <201106151614.06529.jnareb@gmail.com>
X-Enigmail-Version: 1.1.2
X-TagToolbar-Keys: D20110620155659942
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176090>

On 06/15/2011 10:14 AM, Jakub Narebski wrote:
>
> core.ignorecase::
>         If true, this option enables various workarounds to enable
>         git to work better on filesystems that are not case sensitive,
>         like FAT. For example, if a directory listing finds
>         "makefile" when git expects "Makefile", git will assume
>         it is really the same file, and continue to remember it as
>         "Makefile".
>
> 	The default is false
>
> But that wouldn't unfortunately help when there are two files which
> filename differs only in case.
>
> You would have to do tricks with `git update-index` and its 
> --assume-unchanged bit (though perhaps `core.ignorecase` would be
> enough) and `--cacheinfo <mode> <object> <path>` together with
> `git hash-object -w`... 
>
> Or perhaps delete file which you have in working area, checkout
> one file, add it, checkout other file, add it, use 'git commit'
> and not 'git commit -a'.
>
> But that are only possible solutions; I have sane filesystem.
>
> Can't you work on NTFS, and use USB stick only for transport of
> either tarred repository, or bundle?

FWIW - NTFS likely does not help here because even though NTFS supports
unique-cased filenames, Windows and Win32-apps do not. 
http://support.microsoft.com/kb/100625

For example,

cmd.exe:
  C:\> touch makefile
  C:\> copy makefile Makefile
  The file cannot be copied onto itself.
          0 file(s) copied.

cygwin/bash:
  $ touch makefile
  $ cp makefile Makefile
  cp: `makefile' and `Makefile' are the same file

Linux (on NTFS volume):
  mnt/NTFS:  touch makefile
  mnt/NTFS:  cp makefile Makefile
  mnt/NTFS:  ls *akefile
  makefile  Makefile


Mac's "HFS Plus" filesystem supports unique-on-case, but it is not safe
to enable it on a boot disk.
http://support.apple.com/kb/TA21400?viewlocale=en_US

Phil
