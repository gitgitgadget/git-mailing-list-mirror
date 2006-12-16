X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 15 Dec 2006 17:49:33 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612151747470.3849@woody.osdl.org>
References: <20061130170625.GH18810@admingilde.org> 
 <200612150007.44331.Josef.Weidendorfer@gmx.de> 
 <e7bda7770612150943j71a7362bmb509cea3b7756003@mail.gmail.com> 
 <200612152242.50472.Josef.Weidendorfer@gmx.de> 
 <e7bda7770612151543o39c9d233q91ea643a134196d3@mail.gmail.com>
 <e7bda7770612151713k418434e6gd8d565e49a766477@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 16 Dec 2006 01:50:41 +0000 (UTC)
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	"R. Steve McKown" <rsmckown@yahoo.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <e7bda7770612151713k418434e6gd8d565e49a766477@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34585>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvOh5-0005Ko-Uh for gcvg-git@gmane.org; Sat, 16 Dec
 2006 02:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030340AbWLPBuP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 20:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753219AbWLPBuP
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 20:50:15 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35343 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1753217AbWLPBuN
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 20:50:13 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBG1o7ID019131
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 15
 Dec 2006 17:50:07 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBG1o6NX008559; Fri, 15 Dec
 2006 17:50:06 -0800
To: Torgil Svensson <torgil.svensson@gmail.com>
Sender: git-owner@vger.kernel.org



On Sat, 16 Dec 2006, Torgil Svensson wrote:
> 
> 100644 blob <sha1 of blob>    README
> 100644 blob <sha1 of blob>    REPORTING-BUGS
> 100644 link <sha1 of blob>     <sha1 of commit>
> 040000 tree <sha1 of tree>    arch
> 040000 tree <sha1 of tree>    block
> 040000 link <sha1 of tree>     <sha1 of commit>

That 040000 needs to be something else.

In order for something like a git-fsck-objects to know that it's a link, 
it needs to be marked as such. 

In git, we never just randomly open an object by SHA1, and then figure out 
its type. We always open things by explicitly knowing both the type and 
the SHA1, and if the object we find has the wrong type, that's a 
consistency error in the database (or the user).

