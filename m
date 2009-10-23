From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Subject: Re: [PATCH] tar: on extract, -o is --no-same-owner
Date: Fri, 23 Oct 2009 22:25:24 +0200
Message-ID: <20091023202524.GE4615@mx.loc>
References: <1256328943-22136-1-git-send-email-rep.dot.nop@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: busybox@busybox.net, git@vger.kernel.org
To: vda.linux@googlemail.com
X-From: git-owner@vger.kernel.org Fri Oct 23 22:25:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1QhD-00036Z-B9
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 22:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbZJWUYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 16:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbZJWUYy
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 16:24:54 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:32893 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbZJWUYx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 16:24:53 -0400
Received: by bwz27 with SMTP id 27so1128943bwz.21
        for <git@vger.kernel.org>; Fri, 23 Oct 2009 13:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=njux+573X1BGtiigwtCGuU0/hyXUdH3RaJvEP596jYI=;
        b=QG/stF59uPsfCcST4StXBJm7T/16Tpy0vCzBUuoPBR6aNskyME6n7Rq3X6OOQ2lC1W
         uDihA1aCgTw2Vz4XQ9BpFst8dYAdS+s0d3wlGEKlVh4PiInpRJ3ziH5aUNCYWen+snsI
         hFLMn1Wm4x8saxCybUJ2dIiLzACftDDW36AwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kZQhn6Dm1u6W8Uikjil1nyHFvIXluYQN0M4MNZopIsLU1CKo8nmovuTB2LblSuz4e+
         D55ersoJ1O2+Yv7lqDmaAVMX3hlxCBBqTQxZ/3hiPuP2mlv+BcPInM9BV4qFmPYbGeEm
         H9x87aQ29ktDKKtgjzYRFR5Zs+eFsYZWY4BcE=
Received: by 10.204.13.201 with SMTP id d9mr1363139bka.12.1256329496744;
        Fri, 23 Oct 2009 13:24:56 -0700 (PDT)
Received: from s42.loc (85-127-251-67.dynamic.xdsl-line.inode.at [85.127.251.67])
        by mx.google.com with ESMTPS id 14sm339166bwz.13.2009.10.23.13.24.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Oct 2009 13:24:55 -0700 (PDT)
Received: from cow by s42.loc with local (Exim 4.69)
	(envelope-from <rep.dot.nop@gmail.com>)
	id 1N1QhQ-0005qN-2f; Fri, 23 Oct 2009 22:25:24 +0200
Content-Disposition: inline
In-Reply-To: <1256328943-22136-1-git-send-email-rep.dot.nop@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131126>

On Fri, Oct 23, 2009 at 10:15:43PM +0200, Bernhard Reutner-Fischer wrote:
>GNU tar-1.22 handles 'o' as no-same-owner only on extract,
>on create, 'o' would be --old-archive.

FYI this was prompted by:

Signed-off-by: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>

diff -rdup git-1.6.5.oorig/templates/Makefile git-1.6.5/templates/Makefile
--- git-1.6.5.oorig/templates/Makefile	2009-10-11 03:42:04.000000000 +0200
+++ git-1.6.5/templates/Makefile	2009-10-23 21:43:06.000000000 +0200
@@ -50,4 +50,4 @@ clean:
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
 	(cd blt && $(TAR) cf - .) | \
-	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xfo -)
+	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) x --no-numeric-owner -f -)

Someone should try to ask the git people not to rely on getopt
permuting options.. xof would be gentle to folks who don't want
to turn on getopt_long though.

cheers,
