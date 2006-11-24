X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,BODY_URI_ONLY,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH] archive-zip: don't use sizeof(struct ...)
Date: Fri, 24 Nov 2006 08:53:57 +0000
Message-ID: <20061124085357.21541.qmail@fd76b23131eb24.315fe32.mid.smarden.org>
References: <20061123101609.1711.qmail@8b73034525b1a6.315fe32.mid.smarden.org> <45659781.5050005@lsrfire.ath.cx> <7vpsbdkhzc.fsf@assigned-by-dhcp.cox.net> <45661A7D.9070207@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 08:53:56 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <45661A7D.9070207@lsrfire.ath.cx>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32198>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnWoh-0000fc-Pr for gcvg-git@gmane.org; Fri, 24 Nov
 2006 09:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934293AbWKXIxk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 03:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934519AbWKXIxk
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 03:53:40 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:18312 "HELO
 a.mx.smarden.org") by vger.kernel.org with SMTP id S934293AbWKXIxj (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 03:53:39 -0500
Received: (qmail 21542 invoked by uid 1000); 24 Nov 2006 08:53:57 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thu, Nov 23, 2006 at 11:02:37PM +0100, Ren? Scharfe wrote:
> We can't rely on sizeof(struct zip_*) returning the sum of
> all struct members.  At least on ARM padding is added at the
> end, as Gerrit Pape reported.  This fixes the problem but
> still lets the compiler do the summing by introducing
> explicit padding at the end of the structs and then taking
> its offset as the combined size of the preceding members.
> 
> As Junio correctly notes, the _end[] marker array's size
> must be greater than zero for compatibility with compilers
> other than gcc.  The space wasted by the markers can safely
> be neglected because we only have one instance of each
> struct, i.e. in sum 3 wasted bytes on i386, and 0 on ARM. :)
> 
> We still rely on the compiler to not add padding between the
> struct members, but that's reasonable given that all of them
> are unsigned char arrays.
> 
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

