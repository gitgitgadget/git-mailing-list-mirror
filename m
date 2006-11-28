X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_NXDOMAIN,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
From: Pazu <pazu@pazu.com.br>
Subject: Re: [PATCH 1.2/2 (fixed)] git-svn: fix output reporting from the delta fetcher
Date: Tue, 28 Nov 2006 13:32:56 -0200
Message-ID: <9e7ab7380611280732k4e940380tbf2a96146807d671@mail.gmail.com>
References: <loom.20061124T143148-286@post.gmane.org>
	 <20061128054448.GA396@soma> <20061128102958.GA5207@soma>
	 <20061128105017.GA20366@soma>
	 <9e7ab7380611280445r4ebe344cw69cbc18a74c6122f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 15:33:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=K66HdIxBsPOMRJ9RE0FfOJuatLHD8JNkQSU2m0XbkwF5iMDBCToqTjl2P9txF8oK2uSEJ/jp+WiRE5TQq5hgDkRq73KEvh7Dp9uDydDi5ShndmhTDBEw2ejYcrBTxf58FzWODpYgTHsArYdAdbIQ33WNxmM+q8m39jA3V1unh9g=
In-Reply-To: <9e7ab7380611280445r4ebe344cw69cbc18a74c6122f@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: dc584e5750264ee1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32538>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp4xB-0008KJ-Qv for gcvg-git@gmane.org; Tue, 28 Nov
 2006 16:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758687AbWK1Pc7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 10:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758688AbWK1Pc7
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 10:32:59 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:12006 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1758687AbWK1Pc6
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 10:32:58 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2604677nfa for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 07:32:57 -0800 (PST)
Received: by 10.49.91.6 with SMTP id t6mr4765968nfl.1164727976959; Tue, 28
 Nov 2006 07:32:56 -0800 (PST)
Received: by 10.48.216.6 with HTTP; Tue, 28 Nov 2006 07:32:56 -0800 (PST)
To: "Eric Wong" <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

On 11/28/06, Pazu <pazu@pazu.com.br> wrote:

> Error from SVN, (200003): Incomplete data: Delta source ended unexpectedly
>  at /opt/local/lib/perl5/vendor_perl/5.8.8/darwin-2level/SVN/Ra.pm line 157
> 512 at /Users/pazu/bin/git-svn line 448
>         main::fetch_lib() called at /Users/pazu/bin/git-svn line 319
>         main::fetch() called at /Users/pazu/bin/git-svn line 178

I've added some debug statements to git-svn and found more
information. Apparently, this error is happening because
SVN::Git::Fetcher is trying to open a file that hasn't been fetched by
git-svn yet. Now, *why* this is happening, I don't know. Maybe
something happened while fetching the initial revision.

Here's the output from my "debug" run:

Creating fetcher for revision 9785a6fc2d61a6f9b702bb8e2dd81b11415e6e92
Starting update on revision 11159
Opening CamelEar/config/glconfig.xml@11143
Error from SVN, (200003): Incomplete data: Delta source ended unexpectedly

Here, SVN::Git::Fetcher received a request to open
CamelEar/config/glconfig.xml, but:

mini:~/devel/camel-git pazu$ git-ls-tree
9785a6fc2d61a6f9b702bb8e2dd81b11415e6e92
040000 tree 9a02a43ec34e88d4cee64d322354a49c8f6063e2    BungeIntegrationService
040000 tree 6e0bc09356f480f8b6ec782420c4af322ed3bc0a
BungeIntegrationServiceClient
040000 tree 5da3e715525c9b436fdf9a9dfb4de2bffd8e5ff3    CamelService
040000 tree a2d36b9cc469a52aea4f2422ffab30b9a1ee67de    CamelServiceClient
040000 tree 3d550fad4dcf09a8d45c5e5808dac4883854872c    CamelServiceTests
040000 tree 1fcd2416b4c8494c066abc38051db5244ee801cd    CamelWeb
040000 tree d2e30726674b22e06b4ec07aa68b49f925609c85    Reports
040000 tree 007c4ded31cf16418a7fb0b2ffbe2b796e7ce11e    Servers
100644 blob da2d34be7d44fff5cf70702edc61fd8b6057a14a    _root.iml
100644 blob 6219148365613fd6195b8558376455c3379bbd6e    bg-cam.ipr
100644 blob 25d3fbab0971940cf2cdbe399fd2b79cb21de1b5    build.xml
100644 blob abc91fc1b268a3610a927125b88c1ad05c095d95    checkout-svn-build.sh
100644 blob 475a5dc68c8e0eaaac3a182c078c04b947825469    cvs-checkout.xml

Notice that there's no "CamelEar" directory. For some reason, it
wasn't fetched in the initial revision. Now, just to make sure this
isn't svn fault:

mini:~/devel/camel-git pazu$ svn ls -r11143
https://tech.bga.bunge.com/BungeHomeExt/GLS/trunk/java/bg-cam
.cvsignore
BungeIntegrationEar/
BungeIntegrationService/
BungeIntegrationServiceClient/
CamelEar/
CamelService/
CamelServiceClient/
CamelServiceTests/
CamelWeb/
Reports/
Servers/
Servers_W6/
_root.iml
bg-cam.ipr
build.ws.properties.example
build.xml
checkout-build.sh
checkout-svn-build.sh
cvs-checkout.xml
svn-checkout.xml

So yeah, CamelEar was supposed to exist in this revision, but for some
reason, git-svn missed it. I'll keep trying to find why that happened
-- my bets are on a broken network connection during the initial
fetch, with git-svn accepting what it got so far as the initial
revision, instead of reporting the broken connection.

