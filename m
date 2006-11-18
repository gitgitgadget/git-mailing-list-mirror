X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [WISH] Store also tag dereferences in packed-refs
Date: Sat, 18 Nov 2006 10:15:12 +0100
Message-ID: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 18 Nov 2006 09:15:33 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Dej9ijx4N3wZHgwRsczJ9aa33N19SSqSsewPc9WmvZ40PkE/mYFBcShyk4tOv3tEuTUsvgRk8YS85AJWZFEZ9XnNqT+SZL9gIoypCwS9TMYz2DKUGExW1LnWiT7ULM19lbZGaoJ9BpDfitzUKrgbaIEhdHrp3A8pVsh9FG6clfQ=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31766>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlMII-0003Rd-Gf for gcvg-git@gmane.org; Sat, 18 Nov
 2006 10:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756249AbWKRJPO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 04:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756251AbWKRJPO
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 04:15:14 -0500
Received: from wx-out-0506.google.com ([66.249.82.227]:21957 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1756249AbWKRJPN
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 04:15:13 -0500
Received: by wx-out-0506.google.com with SMTP id s7so1222566wxc for
 <git@vger.kernel.org>; Sat, 18 Nov 2006 01:15:12 -0800 (PST)
Received: by 10.70.15.15 with SMTP id 15mr4911803wxo.1163841312469; Sat, 18
 Nov 2006 01:15:12 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Sat, 18 Nov 2006 01:15:12 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Time needed to execute git-peek-remote in my box with cold cache currently is:

- git tree 2.347 ms
- linux tree 2.144 ms

And refs are *already* packed in both repos.

Looking at packed-refs file, it contains something like:

d9b0f913ce0508fcc83e642e0241f373428368e5 refs/tags/v1.4.3
4314f5982d2aac08001a977fc0b1b611e858e025 refs/tags/v1.4.3-rc1

while I would need something like git-peek-remote output,

d9b0f913ce0508fcc83e642e0241f373428368e5        refs/tags/v1.4.3
e0b0830726286287744cc9e1a629a534bbe75452        refs/tags/v1.4.3^{}
4314f5982d2aac08001a977fc0b1b611e858e025        refs/tags/v1.4.3-rc1
1965efb1599f59b8e3380335d1fa395e2008a30b        refs/tags/v1.4.3-rc1^{}

Because the sha value a tag points to is needed to match against
git-rev-list output so to identify tagged revisions.

Would be possible to store in packed-refs also the dereferenced tag
info, so that cold opening of a repository would be much faster?

Just to give an idea, with warmed up cache, refs reading times are:

- git tree 43 ms
- linux tree 28 ms

Thanks
Marco

P.S: In case it's not clear I don't suggest to read directly the
packed-refs file with the added info, but always to use
