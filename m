From: Wayne Scott <wsc9tt@gmail.com>
Subject: git-diff-tree rename detection bug
Date: Wed, 14 Sep 2005 11:47:56 -0500
Message-ID: <59a6e583050914094777c4fe96@mail.gmail.com>
Reply-To: wsc9tt@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Sep 14 18:52:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFaQr-0007F5-1f
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 18:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbVINQsD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 12:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbVINQsC
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 12:48:02 -0400
Received: from xproxy.gmail.com ([66.249.82.195]:32749 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030275AbVINQsA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 12:48:00 -0400
Received: by xproxy.gmail.com with SMTP id h27so94312wxd
        for <git@vger.kernel.org>; Wed, 14 Sep 2005 09:47:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nD15cUe9U58e8kooOoYc2JoizgUn2EtNy8gZbEApjC6kUzyKikqxVf11u9eBmcnOW5kpr9GSl1uDG+/c1fXSQSzCpZ322ww4eKGETeHSpUMZT19l8wEfF7KQMt8VqSKNcW+v1ijX2+2Ljb/c9hAhAatmvFj4ddHAwH4SQV/fR44=
Received: by 10.70.22.19 with SMTP id 19mr453660wxv;
        Wed, 14 Sep 2005 09:47:56 -0700 (PDT)
Received: by 10.70.7.3 with HTTP; Wed, 14 Sep 2005 09:47:56 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8541>

Look at the diffs between ad6571a78ac74e9fa27e581834709067dba459af and
it's parent with and without rename detection enabled.  (In linux-2.6
git tree)

(formated for narrow screens)
$ REV=ad6571a78ac74e9fa27e581834709067dba459af
$ git-diff-tree -r  $REV^1 $REV | grep termios.h
:000000 100644 0000000000000000000000000000000000000000
   237533bb0e9f1a3e640c4906d8b350deafd315b9 A      include/asm-powerpc/termios.h
:100644 000000 97c6287a6cbaa5903ee1a5934a5553e9e485d8e7
   0000000000000000000000000000000000000000 D      include/asm-ppc/termios.h
:100644 000000 02c3d283aa62bc1b4d7c5d1b22ce03ee4b8771eb
   0000000000000000000000000000000000000000 D      include/asm-ppc64/termios.h

$ git-diff-tree -r  -M $REV^1 $REV | grep termios.h
:000000 100644 0000000000000000000000000000000000000000
   237533bb0e9f1a3e640c4906d8b350deafd315b9 A      include/asm-powerpc/termios.h
:100644 000000 97c6287a6cbaa5903ee1a5934a5553e9e485d8e7
   0000000000000000000000000000000000000000 D      include/asm-ppc/termios.h

Notice how the the fact that include/asm-ppc64/termios.h is deleted gets lost?
Looks broken to me.

-Wayne
