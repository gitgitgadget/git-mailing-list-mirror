X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Thu, 14 Dec 2006 22:27:26 +0100
Message-ID: <e7bda7770612141327r11368e4dtabe8077e96545040@mail.gmail.com>
References: <20061130170625.GH18810@admingilde.org>
	 <e7bda7770612021057mc9f3eb9q7fc047dd1b5c235f@mail.gmail.com>
	 <Pine.LNX.4.64.0612021114270.3476@woody.osdl.org>
	 <200612091434.15001.rsmckown@yahoo.com>
	 <e7bda7770612100347j78854d79x547084972ed14e99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 21:27:34 +0000 (UTC)
Cc: "Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HAgBlzQVAWSy+BSnQ9TpPTx7PBp8CQ2fAyG5kPFoYDzv3+q5GK5ZUx3JyXvKWkLy02t9V3sN9p4K/kLebRHixNsQdKRy1BJip0fTEtHum4o7FAFnUk8wD/laNYLKs1UagE2CftBNEeRZutrTtupRDz6gsIfnZmK/frHRl9iFiI4=
In-Reply-To: <e7bda7770612100347j78854d79x547084972ed14e99@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34404>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guy71-0002DE-PC for gcvg-git@gmane.org; Thu, 14 Dec
 2006 22:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932927AbWLNV13 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 16:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWLNV13
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 16:27:29 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:39164 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751708AbWLNV12 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 16:27:28 -0500
Received: by nf-out-0910.google.com with SMTP id o25so949588nfa for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 13:27:27 -0800 (PST)
Received: by 10.49.90.4 with SMTP id s4mr1405332nfl.1166131646869; Thu, 14
 Dec 2006 13:27:26 -0800 (PST)
Received: by 10.49.28.8 with HTTP; Thu, 14 Dec 2006 13:27:26 -0800 (PST)
To: "R. Steve McKown" <rsmckown@yahoo.com>
Sender: git-owner@vger.kernel.org

On 12/10/06, Torgil Svensson <torgil.svensson@gmail.com> wrote:
> What if we use linus "module" file concept and allow the link objects
> to track subtrees? An object may look like this:
>
> commit: <SHA1>
> link: <SHA1> /path/to/remote/tree/or/blob

> Special customer release for a specific HW platform
> ---------------------------------------------------
> "Lib1/lib1.h" -> "<lib1-commit>/headers/lib1.h"
> "Lib1/lib1.so" -> "<build-environment-commit>/i386/Lib1/lib1.so"
> "App1_binary" -> "<build-environment-commit>/i386/App1/App1_binary"

This example is somewhat complex since the build for lib1.so and the
header-file might not has gone through the same commit on the lib1
subproject.  Consider this example:


lib1 - library project (source tracking)
------------------------------------------
Blob: /src/lib1.h


app1 - application project (source tracking)
-----------------------------------------
Link: /headers/lib1.h -> <lib1-commit1>/src/lib1.h


build1 - Build project (binary build tracking)
------------------------------------
Link: /src/lib1 -> <lib1-commit2>/
Link: /src/app1 -> <app1-commit>/
Blob: /i386/lib1/lib1.so
Blob: /i386/app1/app1


Release Project (file compilation tracking)
-----------------------------------
Link: /headers/lib1.h -> <lib1-commit3>/src/lib1.h
Link: /bin/lib1.so -> <build1-commit>/i386/lib1/lib1.so
Link: /bin/app1 -> <build1-commit>/i386/app1/app1


<lib1-commit1>, <lib1-commit2> and <lib1-commit3> should be the same,
dictated by the app1 project. Can we enforce this in the modules file
or should the different supermodules fix this somehow using
scripts/hooks?

How do the super-projects in this case get access to the blobs pointed
by the links - transparent or explicit in the build-process?

