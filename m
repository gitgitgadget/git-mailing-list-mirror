From: Joshua Juran <jjuran@gmail.com>
Subject: Re: [RFC] Print diffs of UTF-16 to console / patches to email as UTF-8...?
Date: Fri, 22 Oct 2010 11:28:44 -0700
Message-ID: <E7645863-A3AD-4EE1-AF6B-71C50A859619@gmail.com>
References: <1287763608.31218.63.camel@drew-northup.unet.maine.edu> <20101022161851.GH9224@burratino>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Drew Northup <drew.northup@maine.edu>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 20:29:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9MMz-0005ZU-VQ
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 20:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401Ab0JVS2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 14:28:50 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44854 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065Ab0JVS2s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 14:28:48 -0400
Received: by gxk23 with SMTP id 23so669488gxk.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=CIh6U2tdsovAsVYPP/kOaJMc/zOfUvpszdrkTgF99Yk=;
        b=b+3MhboP+x7cMTsIsEfFPd/J7Xb0e28WUFCdrZx4pO/ozUbSl4BhYj/hnVgsIS+29v
         /KTcjV0R1ULg8U85exLXRx5wqkMM1gXYFHZtAreQtaeNbHc2BUERIQVjRg7HQrtU2f1m
         NolUGRRoDhdj4TlrwirSqx939nfI+PoXpHlYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=dHQmAqVAn8O37J6O6IvctH7fULfzHFoVabGdKhIMBT/WlfJropuhm8xG5Pb0KRBeVx
         ls3q+V3oPskaxghLXNth1a2TfulJmGSszF2watvyZGq+MP2NSKfHKZ31Jq/P3YlCyn6N
         DMX8E8MKKR7WLfHMubWhgt98YKV5MLakkEOiQ=
Received: by 10.150.230.14 with SMTP id c14mr6642524ybh.312.1287772127186;
        Fri, 22 Oct 2010 11:28:47 -0700 (PDT)
Received: from [192.168.1.118] (c-69-139-149-8.hsd1.md.comcast.net [69.139.149.8])
        by mx.google.com with ESMTPS id l66sm2617567yhd.20.2010.10.22.11.28.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 11:28:46 -0700 (PDT)
In-Reply-To: <20101022161851.GH9224@burratino>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159721>

On Oct 22, 2010, at 9:18 AM, Jonathan Nieder wrote:

> Drew Northup wrote:
>
>>        This is part of my ongoing work to treat UTF-16 as text (in
>> other words, the crlf options will work and .gitattributes hacks  
>> won't
>> be required to display diffs, etc).

I would like to see the same thing for MacRoman-encoded text.[1]  This  
is the encoding used by classic Mac development tools such as  
Metrowerks C/C++ (packaged as CodeWarrior) and Apple's Rez resource  
compiler (even the version in OS X).  Clearly, UTF-8 checkouts are not  
an option here.

> What's wrong with .gitattributes for this use case?  I would think a
> clean/smudge filter would produce very good behavior from most git
> commands.

I wrote a Mac<->UTF-8 converter in C++ and set it as the clean/smudge  
filter for .r (Rez) files.  Checkouts were noticeably slower (on a  
real machine, not one of my antiques).  This would be much worse if I  
also applied it to C and C++ source files (most, but not all, of which  
are ASCII anyway).

> If speed is the issue, maybe a built-in clean/smudge filter would
> address that?

While the performance cost could be overlooked, a worse problem  
occurred when I checked out a branch into which the conversion of  
files from MacRoman to UTF-8 hadn't occurred.  It automatically  
dirtied my working tree, requiring me to temporarily disable the  
filter attribute and reset --hard.  I also resorted to checkout -f a  
number of times -- a bad habit, I'm sure.

In the end I concluded that (a) these files are definitely text, and  
(b) they are natively MacRoman and should be stored that way.  There  
is no advantage to using UTF-8 since the tools can't handle it, and  
even were one to write a UTF-8-capable Rez compiler, the resources it  
outputs are still MacRoman-encoded, so no Unicode support is possible.

Finally, (c) the end-to-end principle applies.  Don't convert data en  
route, but wait until it's necessary.  Premature conversion was the  
curse of FTP; let's not repeat it.  But Git should definitely convert  
data to match the encoding of the display device; writing anything but  
valid UTF-8 to a UTF-8 terminal is in error.  The same applies in gitk.

Another issue (on which my thoughts are less clear) is the use of CR  
newlines.  CR is also native to classic Mac OS, but in contrast to  
UTF-8, Mac developer tools are generally newline-agnostic, whereas  
typical Unix programs are less forgiving in expecting LF -- so I've  
been using linefeeds in my source code.  However, it might be useful  
to retain platform-customary newlines for the purpose of guessing non- 
UTF character encodings:  Carriage returns would almost certainly  
indicate MacRoman rather than ISO-8859-1.  But a more complete and  
robust solution would be to store the encoding somewhere, possibly in  
the blob itself, or in the tree storing the filename.

Josh

[1] MacRoman is an extended ASCII character set native to classic Mac  
OS.  <http://en.wikipedia.org/wiki/Mac_OS_Roman>
