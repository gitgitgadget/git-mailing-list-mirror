X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] merge-recursive: configurable 'merge' program
Date: Tue, 5 Dec 2006 15:48:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612051540230.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061204235647.9BA8B139B0E@magnus.utsl.gen.nz>
 <200612051123.33210.jnareb@gmail.com> <Pine.LNX.4.63.0612051459380.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612051526.12636.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 14:48:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200612051526.12636.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33346>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grbae-00017X-RY for gcvg-git@gmane.org; Tue, 05 Dec
 2006 15:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968220AbWLEOsF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 09:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968225AbWLEOsF
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 09:48:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:36433 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S968220AbWLEOsE
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 09:48:04 -0500
Received: (qmail invoked by alias); 05 Dec 2006 14:48:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp046) with SMTP; 05 Dec 2006 15:48:01 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 5 Dec 2006, Jakub Narebski wrote:

> Hmmm... is there a way to pass merge.tool / merge.onefile program the 
> info if it is invoked in final stage (here it is nice to invoke 
> graphical merge tool to resolve conflicts in working area before 
> commiting merge result) and in recursive stage (here it would be better 
> to leave conflict markers to be resolved later)?

In a sense, you get that information: "merge" is called as

$ merge -L new1 -L orig -L new2 fnew1 forig fnew2

where few1 is the filename of the _temporary_ file, and new1 is the name 
that should be displayed instead. For every but the final stage, new1 
begins with "Temporary merge branch".

> Hmmm... would it be possible to use xdl_merge() for recursion, and 
> graphical merge tool for result? <Checks out earlier discussion>. I 
> think yes, because of exposing xdl_merge() in git-merge-onefile...

In "next", only git-merge-recursive is converted to use xdl_merge(), and 
it did not use git-merge-one-file to begin with. Since this is a shell 
script (with a different syntax than merge), it would have to be converted 
to a C builtin first. But feasible: git-merge-one-file takes 7 parameters, 
the first 3 being SHA1s or empty strings. "merge" takes 3 filenames, with 
possibly up to three "-L <name>" pairs before them.

Ciao,
Dscho
