From: Panagiotis Issaris <takis@issaris.org>
Subject: Re: [BUG] make test (t3600-rm.sh) fails
Date: Fri, 24 Mar 2006 13:05:02 +0100
Message-ID: <4423E06E.9090004@issaris.org>
References: <4423C681.3000302@issaris.org>	<7v7j6k16g2.fsf@assigned-by-dhcp.cox.net>	<df33fe7c0603240245o516095b5m@mail.gmail.com> <7vy7z0yuav.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 13:06:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMl2b-0001ct-Ol
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 13:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbWCXMFK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 07:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422702AbWCXMFK
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 07:05:10 -0500
Received: from alpha.uhasselt.be ([193.190.2.30]:971 "EHLO alpha.uhasselt.be")
	by vger.kernel.org with ESMTP id S1422634AbWCXMFI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 07:05:08 -0500
Received: from localhost (datastorage.uhasselt.be [193.190.2.17])
	by alpha.uhasselt.be (Postfix) with ESMTP id 4B1E21AB17E;
	Fri, 24 Mar 2006 13:05:03 +0100 (CET)
Received: from [172.18.16.239] (edm-006.edm.uhasselt.be [193.190.10.6])
	by alpha.uhasselt.be (Postfix) with ESMTP id 9FEEA1AB185;
	Fri, 24 Mar 2006 13:05:02 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7z0yuav.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by Amavisd antivirus & antispam cluster at uhasselt.be
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17914>

Hi,

Junio C Hamano wrote:

>...
>But that does not mean fakeroot is buggy.  Fakeroot is doing
>what it is designed to do.
>
>That does not mean running our tests under fakeroot is stupidity
>on your part.  We do not advertise that the tests should not be
>run as root.
>
>The test is buggy -- it tries to make sure the command fails
>when underlying rm fails, but is not aware that "chmod u-w ."
>is not a good way to make ./foo undeletable if you run it as
>root.  At least it should skip those two tests if it is run by
>root.
>  
>
Something like this?


diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index d1947e1..52a1e99 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -56,6 +56,7 @@ test "$test_tabs" = y && test_expect_suc
     "git-rm -f 'space embedded' 'tab   embedded' 'newline
 embedded'"

+if test `whoami` != "root"; then
 if test "$test_tabs" = y; then
 chmod u-w .
 test_expect_failure \
@@ -63,6 +64,7 @@ test_expect_failure \
     'git-rm -f baz'
 chmod u+w .
 fi
+fi

 test_expect_success \
     'When the rm in "git-rm -f" fails, it should not remove the file from the index' \
