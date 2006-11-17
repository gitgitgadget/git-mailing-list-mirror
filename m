X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/5] allow deepening of a shallow repository
Date: Fri, 17 Nov 2006 10:52:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611171050440.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0610302009390.26682@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy7qeze0q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611141150010.13772@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy7qaqw12.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 17 Nov 2006 09:53:11 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vy7qaqw12.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31684>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl0P7-0000Rf-Vt for gcvg-git@gmane.org; Fri, 17 Nov
 2006 10:53:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755634AbWKQJw7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 04:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755635AbWKQJw7
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 04:52:59 -0500
Received: from mail.gmx.de ([213.165.64.20]:54731 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1755633AbWKQJw6 (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 04:52:58 -0500
Received: (qmail invoked by alias); 17 Nov 2006 09:52:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp042) with SMTP; 17 Nov 2006 10:52:56 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Fri, 17 Nov 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Yes. Somehow, an important part of unregister_shallow() went missing (yet 
> > another proof that my poor-man's-StGit does not always work). I think that 
> > the "object->parsed = 0;" should go into unregister_shallow() like this:
> 
> That does not fly so well.  Your fetch-pack.c does this in
> find_common() and dropping the parsed flag inside unregister
> causes it to be parsed again later with its true parents, which
> defeats what the commented part of the code wanted to do.
> 
> 	if (!lookup_object(sha1))
> 		die("object not found: %s", line);
> 	/* make sure that it is parsed as shallow */
> 	parse_object(sha1);
> 	if (unregister_shallow(sha1))
> 		die("no shallow found: %s", line);
> 	continue;

Ah! _That_ was the reason I removed it from unregister_shallow().

> Although I am reasonably sure we can eventually make it work, it
> is very subtle and fragile -- somebody touching this code can
> easily break it.

I fully agree. Even the OA did not understand the code fully ;-)

How about adding "int force_reparse" to the signature of 
unregister_shallow()? (Just like we added "int cleanup" to 
get_merge_bases() to avoid pilot errors.)

Ciao,
Dscho
