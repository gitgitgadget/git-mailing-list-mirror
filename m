From: Mark Levedahl <mlevedahl@gmail.com>
Subject: t3032 incompatible with Cygwin/Windows
Date: Tue, 16 Jul 2013 14:33:35 -0400
Message-ID: <51E591FF.7030600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 16 20:33:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzA4G-0005f6-91
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 20:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933813Ab3GPSdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 14:33:40 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:45395 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933000Ab3GPSdj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 14:33:39 -0400
Received: by mail-qa0-f53.google.com with SMTP id g10so626081qah.12
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=FY3/bEyB/kxDKhdQsL+9y3EslpmIO1aZZbXFO5NkgNc=;
        b=MzW5PoZjOHcoMmrUtUd7Gta7v/les0NWf6kTpKMcOnhW56xbjWRdZ8B+yoVO7DvQcW
         s6IXWdOm/1DZAr9xLc/pHWrssBddQOoWPtDDd3w57jSN5e0H4az5bmkEt742LgbFTXpr
         +zOuf11ldNqze7tVe9LkCbVh+ebxWBMH5+HpOx4VMOPhM0pqVQ+QlIOTBdtOW7lQb5iK
         AekFwdTVWPkKP+S0p5jtIfvknTVPASnOmZA8VMHBsAE39+okgK6TQjlyjiS/5yJMNPY6
         WzadX4baFes2siKQPnWF8HPXQO4mGgLrd3B62Se9IQVThauWQQ+C0OdBb9Cek8cxKFnX
         TMZA==
X-Received: by 10.224.163.72 with SMTP id z8mr4938699qax.59.1373999617858;
        Tue, 16 Jul 2013 11:33:37 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id a8sm6450242qae.11.2013.07.16.11.33.36
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 11:33:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230572>

Subtests 6,7, and 9 of t3032 fail on Cygwin, and I presume will fail on 
msysgit for similar reasons. Looking at test 6, the expected result is a 
line ending with \r\n in text.txt. This line is extracted with grep 
(grep 'justice and holiness' text.txt > actual), with unavoidable result 
that on Cygwin the line ending is \n. This happens because on Cygwin, 
the text utils are compiled to open files in text mode meaning than \n 
and \r\n are both recognized as EOL markers. Thus, even though text.txt 
is an exact match for what is created on Linux, the test fails because 
\r\n cannot be distinguished by the available tools.

I'm not sure the right way forward. I did confirm that by substituting 
"q_to_tab" for "q_to_cr" in t3032, the test pass on Cygwin and on Linux. 
Perhaps t3032 should be so amended to avoid use of a non-portable line 
ending construct?

Mark
