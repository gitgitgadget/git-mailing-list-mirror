From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 14/12] Makefile: always remove .depend directories on 'make
 clean'
Date: Sun, 31 Jan 2010 15:37:25 -0600
Message-ID: <20100131213725.GB4636@progeny.tock>
References: <20100123144201.GA11903@progeny.tock>
 <7v3a1u6bfz.fsf@alter.siamese.dyndns.org>
 <20100126154357.GA4895@progeny.tock>
 <20100126155714.GM4895@progeny.tock>
 <7viqaic8gs.fsf@alter.siamese.dyndns.org>
 <20100131211429.GA4550@progeny.tock>
 <7vaavuc6f4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 22:37:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbhU6-0006Zo-EB
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 22:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616Ab0AaVh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 16:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753324Ab0AaVh2
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 16:37:28 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:64460 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab0AaVh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 16:37:28 -0500
Received: by iwn34 with SMTP id 34so341049iwn.21
        for <git@vger.kernel.org>; Sun, 31 Jan 2010 13:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NV4pUROtWbXjA7tPXC3Rsunt7F5C2+eRxj0KJ29hi6c=;
        b=RQR2kb6czIJRYJXkeBogJrhHeQeVt+IcclkGTHYT8nLbywje6nQQrdDaKpAuZuX4ck
         9tAdPA3awWynQcobB0AJeFVOyMzZmD9auvVwm9f66jzltQJardTCIjgP0g8yXmUYU8xH
         w2kcOUHvLkmMIebj/Jd4vz8uyO0hH8GsEPWOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=e1idOegenOnNHMK40NkFJnbnK4ZNQZ20fVxSmarrvHxNraMq5oN5THtyDf5zjF9HjO
         g95bIfEO6U2KoWN9sHKjpPB2zxXZFVeVf7N4o5jxqA5Wg7ttnMdOFsB4pi0seAF4DYJz
         8Y1AdOXPtFH2p5VAYyksjW6aesYhlN0oH1vag=
Received: by 10.231.79.136 with SMTP id p8mr5980287ibk.4.1264973847189;
        Sun, 31 Jan 2010 13:37:27 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm2732259iwn.13.2010.01.31.13.37.26
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Jan 2010 13:37:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vaavuc6f4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138565>

Even if COMPUTE_HEADER_DEPENDENCIES is not set, some .o.d files
might be lying around from previous builds when it was.  This
is especially likely because using the CHECK_HEADER_DEPENDENCIES
feature requires building sometimes with COMPUTE... on and
sometimes with it off.  At the end of such an exercise, to get
a blank slate, the user ought to be able to just run 'make clean'.
Make it so.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> Yes, the last one.  After playing around, with or without COMPUTE/CHECK,
> and then making a final build, it would be nice if "make distclean"
> removed all the intermediate build products without the same special
> "debug build" options (and without COMPUTE, dep_dirs is empty so nothing
> is removed).

Another good idea. :)

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index c939139..93e1a92 100644
--- a/Makefile
+++ b/Makefile
@@ -1693,9 +1693,9 @@ XDIFF_OBJS = xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o \
 OBJECTS := $(GIT_OBJS) $(XDIFF_OBJS)
 
 dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
+dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
 
 ifdef COMPUTE_HEADER_DEPENDENCIES
-dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
 $(dep_dirs):
 	mkdir -p $@
 
-- 
1.7.0.rc1
