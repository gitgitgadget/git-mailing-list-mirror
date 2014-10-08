From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH v5] MinGW(-W64) compilation
Date: Wed,  8 Oct 2014 22:00:53 +0400
Message-ID: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRB3PX2WQQKGQEQD462LA@googlegroups.com Wed Oct 08 20:01:19 2014
Return-path: <msysgit+bncBCE7TAPITACRB3PX2WQQKGQEQD462LA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f186.google.com ([209.85.212.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRB3PX2WQQKGQEQD462LA@googlegroups.com>)
	id 1XbvY7-0003Tq-4q
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 20:01:19 +0200
Received: by mail-wi0-f186.google.com with SMTP id fb4sf627919wid.23
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 11:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=6Hl+HSd23Q6hCwVD/dGAtlrtgviZ9vg1Qe7xWzpluWY=;
        b=XNvQK4FgoqctcTCVSEAr3jMhWSKYIUX333phRjEFTZbYNffX0GLgoDk+N6vo7Aszy4
         bO0BvPbtOxRH8oephBJazJu+/0/FaI82sK4MEvTnLcQdbU8XLRbXhKYUmQznxS4CXWfp
         6kxaJKiJz+5dheitRLExP96oS3rx2UasY/kn7GB+iXCuCsB7937ne5Lz/EnCDGeNHbD2
         LB0ObiTiA2gZlT9r2kb0dL4h+/szUT2gI2Wo4EOzqJqHp6bVXvqjB+gwV69sbrOIKsh7
         4s/xZR8ha49WpCUKBpjn+VYRkK/9i1W96lZpsltAF9evdikX/MS5QOFqY3/uuRX2Jslw
         q6xw==
X-Received: by 10.152.21.228 with SMTP id y4mr22178lae.11.1412791278883;
        Wed, 08 Oct 2014 11:01:18 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.7.141 with SMTP id j13ls86543laa.5.gmail; Wed, 08 Oct 2014
 11:01:17 -0700 (PDT)
X-Received: by 10.152.4.4 with SMTP id g4mr1833712lag.2.1412791277283;
        Wed, 08 Oct 2014 11:01:17 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id p7si353526wiz.1.2014.10.08.11.01.17
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2014 11:01:17 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XbvXz-0003Rz-Do; Wed, 08 Oct 2014 22:01:11 +0400
X-Mailer: git-send-email 2.1.1
X-Original-Sender: marat@slonopotamus.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: marat@slonopotamus.org does not designate permitted sender
 hosts) smtp.mail=marat@slonopotamus.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

This patch series fixes building on modern MinGW and MinGW-W64 (including x86_64).

*Compilation* tested on:
 - MSVC
 - msysGit environment (twice)
 - Linux cross-toolchain i686-pc-mingw32
 - Linux cross-toolchain i686-w64-mingw32
 - Linux cross-toolchain x86_64-w64-mingw32

Also, this patchset is confirmed to pass msysgit testsuite.

Attention: in order to build on MinGW-W64, you need a version that has
https://sourceforge.net/p/mingw-w64/bugs/397 fixed. Otherwise, you'll get:

  compat/poll/poll.c: In function 'poll':
  compat/poll/poll.c:541:7: warning: implicit declaration of function 'MsgWaitForMultipleObjects'
  compat/poll/poll.c:542:26: error 'QS_ALLINPUT' undeclared (first use in this function)

-------

Cosmetic changes since v4:

 * Reworded 'MSVC: config.mak.uname: drop -D__USE_MINGW_ACCESS from CFLAGS'
   (added note about MinGW section)
 * Reworded 'MINGW: config.mak.uname: reorganize MinGW settings'
   (now uses gender-neutral singular 'they')
 * Reworded 'Fix pointer -> integer casts on IL32P64 systems'
   (added references to Gnulib commits)

-------

Additional note:

todays git.git/master is broken on both MSVC and MinGW-W64 because of 7559a1be + 4e6d207c:
MSVC doesn't have sigset_t at all, MinGW-W64 has it in sys/types.h, but it is only
available with -D_POSIX. I hope this can be resolved separately as a regression for MSVC.


-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
