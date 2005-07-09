From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: qgit-0.7
Date: Sat, 9 Jul 2005 08:06:21 -0700 (PDT)
Message-ID: <20050709150621.51442.qmail@web26310.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 09 17:07:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrGuY-0006Cx-GG
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 17:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVGIPG1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 11:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVGIPG1
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 11:06:27 -0400
Received: from web26310.mail.ukl.yahoo.com ([217.146.176.21]:12649 "HELO
	web26310.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261503AbVGIPGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2005 11:06:25 -0400
Received: (qmail 51444 invoked by uid 60001); 9 Jul 2005 15:06:21 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=2BbR9hHPDlkrIQJcC9I+FWVOCCEiNiIGJO/NVvyB4GYhG2TqpthfhcCeiux2XbjHMieW1CypunUNmtcEzXUt5YPFnTEo4spaWrW5riVJD+U8iU33hf8a+eK2USDhoic02b1Xc8dezz7hNrp6CNFSSTjaJ2sCcRp4BHbn7A7J4Tk=  ;
Received: from [151.42.108.207] by web26310.mail.ukl.yahoo.com via HTTP; Sat, 09 Jul 2005 08:06:21 PDT
To: wd@denx.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Wolfgang Denk ha scritto:

>Dear Marco,
>
>in message <20050709081512.33503.qmail@web26306.mail.ukl.yahoo.com> you wrote:
>
>>Here is qgit-0.7, a GUI git viewer.
>
>
>Sorry, but I cannot compile it on a Fedora Core 4 system:
>
>-> ./configure 
>+scons was found, that's excellent+
>scons: Reading SConscript files ...
>-> make
>scons -Q
>g++ -DQT_THREAD_SUPPORT -D_REENTRANT -I/usr/lib64/qt-3.3/include -c -o src/annotate.o
src/annotate.cpp
>src/annotate.cpp: In member function `QStringList Annotate::processDiff(const 
>   QString&, QStringList&, const QString&)':
>src/annotate.cpp:378: error: jump to case label
>src/annotate.cpp:373: error:   crosses initialization of `int num'
>src/annotate.cpp:387: error: jump to case label
>src/annotate.cpp:373: error:   crosses initialization of `int num'
>src/annotate.cpp:401: error: jump to case label
>src/annotate.cpp:373: error:   crosses initialization of `int num'
>scons: *** [src/annotate.o] Error 1
>make: *** [all] Error 2
>
>The following patch solves this problem:
>
>--- src/annotate.cpp.ORIG	2005-07-09 07:10:23.000000000 +0200
>+++ src/annotate.cpp	2005-07-09 16:05:09.556653902 +0200
>@@ -370,10 +370,12 @@
> 		char firstChar = line[0].latin1();
> 		switch (firstChar) {
> 		case '@':
>+		    {
> 			int num = line.section(',', 1, 1). section('+', 1, 1).toInt();
> 			// diff lines start from 1, 0 is empty file,
> 			// instead QValueList::at() starts from 0
> 			cur = (num > 0) ? newAnn.at(num - 1) : newAnn.end();
>+		    }
> 			break;
> 		case '+':
> 			if (cur != newAnn.end()) {
>
>

Thanks for your patch, applied.

What version og gcc you have? 
Mine is gcc version 4.0.1 and I don't have this compile error (of course ;-) ).

I have cc'ed to git@vger.kernel.org in case someone else have the same problem.


>With this patch, I get a lot of build errors:
>
>QSettings: error creating /.qt
>QSettings: error creating /.qt
>QSettings: error creating /.qt
>QSettings: error creating /.qt
>QSettings: error creating /.qt
>QSettings::sync: filename is null/empty
>QSettings: error creating /.qt
>QSettings::sync: filename is null/empty
>QSettings: error creating /.qt
>QSettings::sync: filename is null/empty
>QSettings: error creating /.qt
>QSettings::sync: filename is null/empty
>QSettings: error creating /.qt
>QSettings::sync: filename is null/empty
>QSettings: error creating /.qt
>QSettings::sync: filename is null/empty
>...
>
>It links and seems to run, though.
>

It's a known issue, probably due to scons setup, but I am not so familiar with scons
to find a fix, in any case should be absolutely painless.


Marco


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
