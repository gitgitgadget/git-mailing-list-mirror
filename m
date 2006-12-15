X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Fri, 15 Dec 2006 19:45:32 +0100
Message-ID: <e5bfff550612151045q5782e1f2j8686ccab24dbf566@mail.gmail.com>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>
	 <200612112128.06485.Josef.Weidendorfer@gmx.de>
	 <Pine.LNX.4.64.0612111238560.3515@woody.osdl.org>
	 <200612112154.56166.Josef.Weidendorfer@gmx.de>
	 <Pine.LNX.4.64.0612111258050.3515@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 15 Dec 2006 18:45:42 +0000 (UTC)
Cc: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>,
	"Junio C Hamano" <junkio@cox.net>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Shawn Pearce" <spearce@spearce.org>,
	"Linus Torvalds" <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cz+ozliJG/YlIBt11UkzXSF06ZikubBQ5N9Ui1c1RPtCDAB45MJZpVtN/YIS1XOdm3e7rFeNSSdTthd2yO7gEd4Gk3zsqz332tzintAeX4DY2ZYTi8ahp0i+/p/nVgqrWY1miY8Gs1HI4qbAQRsYKb0RnNH8sEcmkQ87S/b8Gns=
In-Reply-To: <Pine.LNX.4.64.0612111258050.3515@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34540>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvI3t-0005rS-7R for gcvg-git@gmane.org; Fri, 15 Dec
 2006 19:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753034AbWLOSpe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 13:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753163AbWLOSpe
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 13:45:34 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:54626 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1753034AbWLOSpd (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 13:45:33 -0500
Received: by py-out-1112.google.com with SMTP id a29so486439pyi for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 10:45:33 -0800 (PST)
Received: by 10.35.40.10 with SMTP id s10mr2119568pyj.1166208332700; Fri, 15
 Dec 2006 10:45:32 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Fri, 15 Dec 2006 10:45:32 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

On 12/11/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> So I don't think there is a right answer here. I suspect QProcess does ok.
>

I have just pushed a patch (wiil be available in few hours I suspect)
to easily choose the data exchange facility with git-rev-list.

Default its temporary file based, but after uncommenting the
USE_QPROCESS define in dataloader.cpp and compile again, qgit will use
a QProcess based approach to connect with git-rev-list.

Only the low level connection is different in the two cases, _all_ the
rest, expecially data storing and parsing, is the same. If you take a
look at src/dataloader.cpp you will see that the difference between
QProcess and temp file code is minumum.

I've also tried to clearly report in comments the different approaches
and the data copy involved in both cases. I've searched a little bit
in QProcess sources too to get some additional info.


And finally these are mine warm and cold cache tests.

Load time test on Linux tree (44557 revs, 32167KB)
CPU Mobile Pentium 4 set at 1.2GHZ

To set data read interval in ms use (src/dataloader.cpp):
#define GUI_UPDATE_INTERVAL 500

Warmed-up cache
QProcess 7632ms (500ms data read interval)
QProcess 7972ms (100ms data read interval)

Temporary file 4408ms (500ms data read interval)
Temporary file 4591ms (100ms data read interval)


Cold cache
QProcess 25611ms (500ms data read interval)

File 22399ms (500ms data read interval)


