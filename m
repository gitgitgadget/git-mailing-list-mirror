From: Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: Re: [PATCH v2] Embed an application manifest on MinGW
Date: Thu, 02 Jun 2011 19:56:47 -0300
Message-ID: <4DE8152F.3010903@cesarb.net>
References: <1307010937-2894-1-git-send-email-cesarb@cesarb.net> <7vfwnsdwqf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 00:57:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSGp2-0001Nu-5V
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 00:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553Ab1FBW4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 18:56:55 -0400
Received: from smtp-02.mandic.com.br ([200.225.81.133]:51046 "EHLO
	smtp-02.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019Ab1FBW4y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 18:56:54 -0400
Received: (qmail 29284 invoked from network); 2 Jun 2011 22:56:48 -0000
Received: from unknown (HELO cesarb-inspiron.home.cesarb.net) (zcncxNmDysja2tXBptWToZWJlF6Wp6IuYnI=@[200.157.204.20])
          (envelope-sender <cesarb@cesarb.net>)
          by smtp-02.mandic.com.br (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <gitster@pobox.com>; 2 Jun 2011 22:56:48 -0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10
In-Reply-To: <7vfwnsdwqf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174985>

Em 02-06-2011 13:27, Junio C Hamano escreveu:
> Does the output from $WINDRES define any external symbol the rest of the
> code can refer to?  If so, you could throw resource.o into one of the .a
> file and make sure that the symbol is referred to from main(); perhaps the
> definition of main in compat/mingw.h can refer to it.

Unfortunately no:

$ i686-pc-mingw32-nm compat/win32/resource.o
00000000 d .rsrc

The only thing it has is the .rsrc section.

I could perhaps create a dummy C file with a dummy variable, compile it, 
and use incremental linking (ld -r) to bolt both object files together. 
I am not sure this hack wouldn't be uglier than the Makefile changes.

Another possibility would be a linker script (like /usr/lib/libc.so on 
modern distributions). This might be the most elegant option if it 
works. I will have to take a look on how it works to see if it is a 
viable alternative.

> If you can do that, you wouldn't need any change to the Makefile other
> than the rule to build compat/win32/resource.o and conditionally add that
> object to LIB_OBJS, perhaps like this (obviously untested as I do not have
> access to windows boxes).

You do not need access to Windows boxes, you can always use Wine ;-) 
(msysgit even has a script to open a shell under Wine with everything 
set up).

-- 
Cesar Eduardo Barros
cesarb@cesarb.net
cesar.barros@gmail.com
