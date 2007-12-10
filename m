From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/2] pack-objects: fix threaded load balancing
Date: Sun, 9 Dec 2007 23:10:58 -0500
Message-ID: <9e4733910712092010m31043915kb6fd0867beefa8f3@mail.gmail.com>
References: <alpine.LFD.0.99999.0712080000120.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 05:11:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1ZzM-0003PQ-Dl
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 05:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbXLJELE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 23:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbXLJELD
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 23:11:03 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:44993 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbXLJELB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 23:11:01 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3097575wah
        for <git@vger.kernel.org>; Sun, 09 Dec 2007 20:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yMpn72PqLxFbsZv9i2mzlHaH0b8efsXySRJUTjVNtFA=;
        b=R9O29IOt/bTpbv3VzOnQu7MIEjPSs/w+aULx+glRXgELZbOtrH+CGFlAbqfEEDcpND002uIuixuOHigLXYPaPRKCBz9aEEG4KJcOaa2fZ8dWkZycOfmAvN33JH9ZzX4RKwawoYlsoRbisHB0nGbzR7XCpvEMJ15k5Lqt1Od2d4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dWThZsoBnVgW40ygknmn8ItshXx9JrbnueEfjkG0bJk5QLJGz08dEXGZseA3XIcuOJ+9EXlJz2OUV2mZsSdeSFLv0Hbj/kTohVOE+7Y0mlHMdMPL61IRcfgJcUPc+ogi52ggJUayHbvfa6iSeE7reAiZE3Gt5CK1D0PBsAfevxU=
Received: by 10.114.60.19 with SMTP id i19mr3110696waa.1197259858247;
        Sun, 09 Dec 2007 20:10:58 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Sun, 9 Dec 2007 20:10:58 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712080000120.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67677>

I added a couple of printfs to debug this.
Why did the thread exit when there were still 72,000 objects left?
Another one exited with 50,000 objects left.
The repack is still running, it has been proceeding on two cores for
10 minutes after the two threads exited.

jonsmirl@terra:/video/gcc$ git-repack -a -d -f --depth=250 --window=250
Counting objects: 828348, done.

 starting thread 0
Compressing objects:   0% (1/809010)
 starting thread 1

 starting thread 2

 starting thread 3
Compressing objects:  59% (478011/809010)
 victim 0x7fffc7976480 sub_size 76058

thread 0x7fffc79764f8 sub_size 76058
Compressing objects:  62% (504273/809010)
 victim 0x7fffc79764a8 sub_size 69967

thread 0x7fffc79764d0 sub_size 69967
Compressing objects:  82% (664231/809010)
 victim 0x7fffc7976480 sub_size 35308

thread 0x7fffc79764d0 sub_size 35308
Compressing objects:  91% (736690/809010)
 victim 0x7fffc79764d0 sub_size 0

thread 0x7fffc79764f8 sub_size 0
Compressing objects:  93% (758922/809010)
 victim 0x7fffc79764d0 sub_size 0

thread 0x7fffc79764a8 sub_size 0




-- 
Jon Smirl
jonsmirl@gmail.com
