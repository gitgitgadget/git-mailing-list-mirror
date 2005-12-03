From: Marco Costalba <mcostalba@yahoo.it>
Subject: gitk does not recognizes ISO-8859-15
Date: Sat, 03 Dec 2005 17:24:24 +0100
Message-ID: <4391C6B8.7010507@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, paulus@samba.org
X-From: git-owner@vger.kernel.org Sat Dec 03 17:26:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiaCB-0001YB-KL
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 17:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVLCQY4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 11:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbVLCQYz
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 11:24:55 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:63896 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751289AbVLCQYy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2005 11:24:54 -0500
Received: (qmail 53025 invoked from network); 3 Dec 2005 16:24:42 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:Content-Type:Content-Transfer-Encoding;
  b=uCGFjUN/ussK5unskGn1QLdbQ8QZghn/1AOp2ldpYw/eU8FMKPKDKJwrsqGcx09TLnAe4tM8xkvsOPnqe2M4v4/4DXZtVeFBziGsd0MKiDWxZbgqUKfyX5Dx+JNAYr11Rt0QqsLqeOgr0dI+p8KIpf7NLYXsQJblODMzgbHi7sk=  ;
Received: from unknown (HELO ?10.0.0.13?) (mcostalba@151.56.86.36 with plain)
  by smtp104.mail.sc5.yahoo.com with SMTP; 3 Dec 2005 16:24:41 -0000
User-Agent: Mozilla Thunderbird 1.0.6-7.2.20060mdk (X11/20050322)
X-Accept-Language: it, it-it, en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13156>

Cannot use ISO-8859-15 according to IANA character-sets encoding file
(http://www.iana.org/assignments/character-sets):


[marco@costalba git]$ git-repo-config i18n.commitencoding ISO-8859-15
[marco@costalba git]$ gitk
Error in startup script: unknown encoding "ISO-8859-15"
     while executing
"fconfigure $commfd -blocking 0 -translation lf -encoding $gitencoding"
     (procedure "getcommits" line 34)
     invoked from within
"getcommits $revtreeargs"
     (file "/home/marco/bin/gitk" line 3743)
[marco@costalba git]$ git-repo-config i18n.commitencoding ISO_8859-15
[marco@costalba git]$ gitk
Error in startup script: unknown encoding "ISO_8859-15"
     while executing
"fconfigure $commfd -blocking 0 -translation lf -encoding $gitencoding"
     (procedure "getcommits" line 34)
     invoked from within
"getcommits $revtreeargs"
     (file "/home/marco/bin/gitk" line 3743)


Finally, after some trials, I found the Tcl/Tk recognized name is "iso8859-15".
This does not seems a standard name and worst ;-)  it is different from the Qt 
internal name "ISO8859-15".

I would like to use the qgit text codec selector to save the encoding in the 
repository config file (using git-repo-config i18n.commitencoding). But to do 
this I must do not break gitk.

Qt can reconize IANA names and also the following "internal" names (only the 
first part, before " --") that user can choose with codec selector combobox:

  Latin1
  Big5 -- Chinese
  Big5-HKSCS -- Chinese
  eucJP -- Japanese
  eucKR -- Korean
  GB2312 -- Chinese
  GBK -- Chinese
  GB18030 -- Chinese
  JIS7 -- Japanese
  Shift-JIS -- Japanese
  TSCII -- Tamil
  utf8 -- Unicode, 8-bit
  utf16 -- Unicode
  KOI8-R -- Russian
  KOI8-U -- Ukrainian
  ISO8859-1 -- Western
  ISO8859-2 -- Central European
  ISO8859-3 -- Central European
  ISO8859-4 -- Baltic
  ISO8859-5 -- Cyrillic
  ISO8859-6 -- Arabic
  ISO8859-7 -- Greek
  ISO8859-8 -- Hebrew, visually ordered
  ISO8859-8-i -- Hebrew, logically ordered
  ISO8859-9 -- Turkish
  ISO8859-10
  ISO8859-13
  ISO8859-14
  ISO8859-15 -- Western
  IBM 850
  IBM 866
  CP874
  CP1250 -- Central European
  CP1251 -- Cyrillic
  CP1252 -- Western
  CP1253 -- Greek
  CP1254 -- Turkish
  CP1255 -- Hebrew
  CP1256 -- Arabic
  CP1257 -- Baltic
  CP1258
  Apple Roman
  TIS-620 -- Thai


So here we arrive. I see two ways to deal with this:

1) *solution* make gitk use IANA names

2) *workaround* get from somewhere the list of Tcl/Tk recognized codec names and 
teach qgit to do the map from IANA when setting a codec with "git-repo-config 
i18n.commitencoding"


In both cases I need your help ;-)

Thanks
Marco

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
