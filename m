From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 0/11] Building up the delta parser
Date: Mon, 18 Oct 2010 12:03:31 -0500
Message-ID: <20101018170331.GB6718@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
 <20100810125317.GB3921@kytes>
 <20101011023435.GA706@burratino>
 <20101011040140.GC5649@burratino>
 <20101013091714.GA32608@burratino>
 <20101018170018.GJ22376@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 19:07:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7tB8-0003YL-SJ
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 19:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203Ab0JRRHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 13:07:10 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61905 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757445Ab0JRRHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 13:07:09 -0400
Received: by vws2 with SMTP id 2so657493vws.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 10:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Y1BVllz1DrmHuzzWQHAgTTI4RXiBKQjICdUQf+ieNVU=;
        b=SY+vtgegVE2DxkccTO4r1AUtRD9iqMi+KLuP6Ug9ypXBcPafeEVB91o633i49P0xas
         uZCwMsPtTb7TNAOuo6CXv+0ykbNlUavH0kicee0XXddAy7Rs7Pk6VO5bDqfTD6rcnbeN
         7DSkSlCllFfnKeaQJzyHXbsyzZFf6SxG1co7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GebD23KpEAaojFJ+ONHguz096Py7FLqU5hg+WZzQ7xlK6146T5lLw/wyK6mm0Dr8ny
         md8ZW3yi/aQaytWoSwlGxNMcl9ol1IayMACbdyP9arHEFulCDijDqaxbDfGjAPIWMb1J
         gPME5RQ785RjYsfP53RIPxAgdFegtI9cL4Nk8=
Received: by 10.103.191.11 with SMTP id t11mr2812167mup.2.1287421628461;
        Mon, 18 Oct 2010 10:07:08 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id a10sm331688fak.3.2010.10.18.10.07.06
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 10:07:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101018170018.GJ22376@kytes>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159267>

Ramkumar Ramachandra wrote:
> Jonathan Nieder writes:
>> Jonathan Nieder wrote:

>>> Implement an svndiff 0 interpreter
[...]
> Eager to see this go through to `master`.

I think the strbuf use breaks the contrib/svn-fe/svn-fe build
somewhere.  Probably something like the following is needed.

(moving the -I flags off of the compilation command line is
justa "while at it" thing, for consistency with the toplevel
Makefile)

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
index 360d8da..9e8f174 100644
--- a/contrib/svn-fe/Makefile
+++ b/contrib/svn-fe/Makefile
@@ -6,7 +6,7 @@ MV = mv
 
 CFLAGS = -g -O2 -Wall
 LDFLAGS =
-ALL_CFLAGS = $(CFLAGS)
+ALL_CFLAGS = $(CFLAGS) -I../../vcs-svn -I../..
 ALL_LDFLAGS = $(LDFLAGS)
 EXTLIBS =
 
@@ -38,7 +38,7 @@ svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(GIT_LIB)
 		$(ALL_LDFLAGS) $(LIBS)
 
 svn-fe.o: svn-fe.c ../../vcs-svn/svndump.h
-	$(QUIET_CC)$(CC) -I../../vcs-svn -o $*.o -c $(ALL_CFLAGS) $<
+	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
 svn-fe.html: svn-fe.txt
 	$(QUIET_SUBDIR0)../../Documentation $(QUIET_SUBDIR1) \
