X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git pull and merging.
Date: Wed, 6 Dec 2006 17:44:30 +0100
Message-ID: <200612061744.31213.Josef.Weidendorfer@gmx.de>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com> <Pine.LNX.4.63.0612061019350.28348@wbgn013.biozentrum.uni-wuerzburg.de> <cc723f590612060205p1fd26cd7u3c7efc723b0177de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 16:44:59 +0000 (UTC)
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.3
In-Reply-To: <cc723f590612060205p1fd26cd7u3c7efc723b0177de@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33488>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grzt7-0007VL-O9 for gcvg-git@gmane.org; Wed, 06 Dec
 2006 17:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936486AbWLFQom (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 11:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936488AbWLFQom
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 11:44:42 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:52487 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S936492AbWLFQol (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 11:44:41 -0500
Received: from dhcp-3s-49.lrr.in.tum.de (dhcp-3s-49.lrr.in.tum.de
 [131.159.35.49]) by mail.in.tum.de (Postfix) with ESMTP id 48D1A284A; Wed,  6
 Dec 2006 17:44:39 +0100 (MET)
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Sender: git-owner@vger.kernel.org

On Wednesday 06 December 2006 11:05, Aneesh Kumar wrote:
> [branch "devel"]
>         remote = origin
>         merge = devel
> 
> [....]
> Now i thought merge should be local reference. So i changed it to
> merge = remotes/origin/devel.
> 
> That also didn't work.
> 
> Then i tried the name of the branch should be indicated as
> "refs/heads/devel" . That also didn't work.
> 
> So i guess i am missing something.

See man page of git-repo-config:

 branch.<name>.merge
  When in branch <name>, it tells git fetch the default
  remote branch to be merged.

I assume that the "devel" branch on the remote repo you cloned from
is also "devel", more exactly "refs/heads/devel".

Now, instead of "git pull", git should default to

	git pull origin refs/heads/devel:refs/remotes/origin/devel

ie. it should update the local tracking branch "refs/remotes/origin/devel"
with the remote branch "refs/heads/devel".
The tracking branch "refs/remotes/origin/devel" will be merged with current
branch afterwards.

Now looking at the documentation for branch.<name>.merge, it talks
about the remote branch, which is "refs/heads/devel" in your case, ie.
the first part of the refspec of the full "git pull" command above.

So, as you already posted (without explanation, therefore this mail),
the config should be

 [branch "devel"]
         remote = origin
         merge = refs/heads/devel

However, "devel" alone should work here, as it can be matched with remote
"refs/heads/devel". Seems to be a bug, as branch.<name>.merge seems to only
being compared with the full canonical name in the implementation.

Josef
