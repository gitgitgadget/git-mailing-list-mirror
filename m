X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: how to pass ssh options to git?
Date: Thu, 2 Nov 2006 08:10:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611020801160.25218@g5.osdl.org>
References: <20061102110639.G523a966f@leonov.stosberg.net>
 <20061102112720.GA8469@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 2 Nov 2006 16:11:22 +0000 (UTC)
Cc: Dennis Stosberg <dennis@stosberg.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061102112720.GA8469@mellanox.co.il>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30759>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gff9U-0001Wl-5C for gcvg-git@gmane.org; Thu, 02 Nov
 2006 17:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751600AbWKBQKo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 11:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbWKBQKo
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 11:10:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64180 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1751552AbWKBQKn (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 11:10:43 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kA2GAEPo010909
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 2
 Nov 2006 08:10:15 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kA2GAD0f018383; Thu, 2 Nov
 2006 08:10:13 -0800
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Sender: git-owner@vger.kernel.org



On Thu, 2 Nov 2006, Michael S. Tsirkin wrote:

> Quoting r. Dennis Stosberg <dennis@stosberg.net>:
> > Subject: Re: how to pass ssh options to git?
> > 
> > Michael S. Tsirkin wrote:
> > 
> > > I know, problem is I want to use different options at different times.
> > > I could use -F configfile ssh option, but how to pass *that* to git?
> >  
> > You can set the path of the ssh executable to use with the GIT_SSH
> > environment variable.  Create a shell script like
> > 
> > #!/bin/sh
> > exec ssh --your-options-- $*
> > 
> > and make GIT_SSH point to it.
> 
> Thanks, I'll try that.

It's really better to use a ".ssh/config" file instead.

I realize that you want to use different options "dynamically", but what 
you can do is to just have different "fake hostnames". For example, you 
can do

	Host private.host.com
		User myname
		Hostname host.com
		IdentityFile /home/myname/.ssh/private-identity
	Host public.host.com
		User groupname
		Hostname host.com
		IdentityFile /home/myname/.ssh/public-identity

and now you can ssh to "host.com" using different identities by just using 
"private.host.com" and "public.host.com" respectively. You can do pretty 
much any options that way.

Very convenient, if you have just a couple of "standard" setups.

Obviously we _could_ just add support for arbitrary ssh options, but it 
gets pretty ugly pretty quickly, so I'd suggest trying to use the 
.ssh/config approach with different hostnames if that is at all possible.

