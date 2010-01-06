From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] Makefile: make ppc/sha1ppc.o depend on GIT-CFLAGS
Date: Wed, 6 Jan 2010 00:37:59 -0600
Message-ID: <20100106063759.GA882@progeny.tock>
References: <20091128112546.GA10059@progeny.tock>
 <20091128113323.GC10059@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 07:38:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSPX5-0005FA-FR
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 07:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639Ab0AFGiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 01:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164Ab0AFGiI
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 01:38:08 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:37835 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293Ab0AFGiC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 01:38:02 -0500
Received: by iwn32 with SMTP id 32so1406737iwn.33
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 22:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Gzj7oik/n4YTYt7L0/IaV33MY0uSODGRJwDQ4ynO2Dk=;
        b=CL/6QqoHPeMRRdeFYjeFijTkpq01SM6YcC/FF6qZRajVt7EmGQnQNkHzhUHByEJI8I
         9KZQDiFGpdyTDA6Mk0jMv0d2CObIg/tqBPF6S1rq46lcbBcAJnfcbvV+mrpuFLyJdzUG
         ZDVb7kj50UiigiWOkHaV9qKMHL+6TPHvxsHJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=t5ME2X4zkJOjtenVLM9k638Lnq3SnvylSBoaLEft1tAx/ONGEhZ7FtSG8q2bdDYBnc
         RNPcHChhTf99wS6A/P1UM0Tqw6X0mm62Xtez0f9aVdsq0bJLbLxFd055r76FWbePfJ4e
         2ro25JwGcQOBVGHD32hxJ8LrsxMTitVrPNwcg=
Received: by 10.231.147.78 with SMTP id k14mr774383ibv.11.1262759881625;
        Tue, 05 Jan 2010 22:38:01 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm19275960iwn.2.2010.01.05.22.37.59
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 05 Jan 2010 22:38:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091128113323.GC10059@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136241>

The %.o: %.S pattern rule should depend on GIT-CFLAGS to avoid
trouble when ALL_CFLAGS changes.

The pattern only applies to one file (ppc/sha1ppc.S) and that
file does not use any #ifdefs, so leaving the dependency out is
probably harmless.  Nevertheless, it is safer to include the
dependency in case future code's behavior does depend on the
build flags.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hopefully the justification is a little clearer this time.

This is not a high-priority change.  The problem it addresses is only
an aesthetic one as far as I can tell.  Still, I would be happy to see
it fixed; thanks for the reminder.

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index c11719c..015bfab 100644
--- a/Makefile
+++ b/Makefile
@@ -1635,7 +1635,7 @@ git.o git.spec \
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 %.s: %.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $<
-%.o: %.S
+%.o: %.S GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
 exec_cmd.o: exec_cmd.c GIT-CFLAGS
-- 
1.6.6.rc2
