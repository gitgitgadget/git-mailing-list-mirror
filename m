X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: sizeof(struct ...)
Date: Thu, 23 Nov 2006 18:57:00 +0100
Message-ID: <4565E0EC.4030709@lsrfire.ath.cx>
References: <20061123101609.1711.qmail@8b73034525b1a6.315fe32.mid.smarden.org> <45659781.5050005@lsrfire.ath.cx> <4565A46C.6090805@lsrfire.ath.cx> <4565A866.8020201@shadowen.org> <4565C205.8050300@lsrfire.ath.cx> <20061123155431.GD6581@harddisk-recovery.com> <4565C8F4.6000606@lsrfire.ath.cx> <4565CA02.20602@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 23 Nov 2006 17:57:18 +0000 (UTC)
Cc: Erik Mouw <erik@harddisk-recovery.com>,
	Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <4565CA02.20602@shadowen.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32152>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnIoy-0005vk-5X for gcvg-git@gmane.org; Thu, 23 Nov
 2006 18:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757301AbWKWR5I convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006 12:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757344AbWKWR5H
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 12:57:07 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de
 ([217.172.187.230]:57835 "EHLO neapel230.server4you.de") by vger.kernel.org
 with ESMTP id S1757301AbWKWR5E (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23
 Nov 2006 12:57:04 -0500
Received: from [10.0.1.4] (p508E51A7.dip.t-dialin.net [80.142.81.167]) by
 neapel230.server4you.de (Postfix) with ESMTP id A1D0B2C016; Thu, 23 Nov 2006
 18:57:03 +0100 (CET)
To: Andy Whitcroft <apw@shadowen.org>
Sender: git-owner@vger.kernel.org

Andy Whitcroft schrieb:
> Perhaps we can look and see what a portable application like gzip or
> bzip2 do in this situation.  They must have the same problem.

Info-ZIP's zip uses structs only for in-memory storage and has a write
function for each of them that writes the members one by one.  I find
the structs in archive-zip.c easier to read, but I might be biased. ;-)

Anyway, archive-zip.c assumes that there is no padding between unsigned
char arrays and that an unsigned char is exactly one byte wide.  The
additional current assumption -- that sizeof(struct ...) sums up the
sizes of all struct members -- is wrong on ARM, and the patches in this
thread correct this error.

So we're not as portable as Info-ZIP, but I think the assumptions above
hold true for all interesting architectures.  And we have a readable
description of the on-disk ZIP file headers.

