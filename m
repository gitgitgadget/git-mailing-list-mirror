X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 21 Nov 2006 14:31:57 +1300
Message-ID: <4562570D.90406@vilain.net>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <ejtc3e$tod$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 21 Nov 2006 01:32:56 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
In-Reply-To: <ejtc3e$tod$2@sea.gmane.org>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31967>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmKUf-0002wO-EC for gcvg-git@gmane.org; Tue, 21 Nov
 2006 02:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030620AbWKUBcI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 20:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030633AbWKUBcI
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 20:32:08 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:20634 "EHLO
 magnus.utsl.gen.nz") by vger.kernel.org with ESMTP id S1030620AbWKUBcF (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 20:32:05 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534) id ED51F138105;
 Tue, 21 Nov 2006 14:32:02 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7]) (using
 TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by magnus.utsl.gen.nz (Postfix) with ESMTP id 7CFCE1380EF; Tue, 21
 Nov 2006 14:31:59 +1300 (NZDT)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> I wonder if it makes sense to be able to add tag objects instead
> of commit objects to trees (depeel to tree or blob)...
>   

I'd say "as well as", and the semantics should be that to something
browsing the filesystem, a tag looks like the type of object it refers
to. eg, tag a tree, it's a tree, tag a commit, it's a sub-project/tree,
tag a blob, it's a file.

The use case I'm thinking of is semi-transparent storing of archives;
instead of storing the archive body, store a tag which contains the
"extra" information - like the gzip headers for a gz and which
compression options are needed to reproduce the same output stream. For
a tar, the per-file information such as the filestamps, owner and
permissions are recorded, and it points to a tree. A clever porcelain
could detect these file types, and make sure the uncompressed streams
are stored.

People who are using clients which don't understand these tag objects in
between will get the contents of the node checked out instead, so
instead of getting "foo.tar.gz" as a file, I got a "foo.tar.gz/" directory.

