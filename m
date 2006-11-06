X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: git bug? + question
Date: Mon, 06 Nov 2006 09:53:58 +0000
Message-ID: <454F0636.1060406@shadowen.org>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <20061103162422.b0bf105e.seanlkml@sympatico.ca> <20061104050305.GA9003@spearce.org> <200611041852.23867.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 6 Nov 2006 09:55:00 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, Sean <seanlkml@sympatico.ca>,
	Junio C Hamano <junkio@cox.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org,
	=?ISO-8859-1?Q?Karl_?= =?ISO-8859-1?Q?Hasselstr=F6m?= 
	<kha@treskal.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
In-Reply-To: <200611041852.23867.Josef.Weidendorfer@gmx.de>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31004>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh1BR-0005YH-Od for gcvg-git@gmane.org; Mon, 06 Nov
 2006 10:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423682AbWKFJyW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 04:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423684AbWKFJyW
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 04:54:22 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:6410 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S1423682AbWKFJyV
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 04:54:21 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1Gh1AP-0005VM-Cs; Mon, 06 Nov 2006 09:53:21 +0000
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Josef Weidendorfer wrote:
> On Saturday 04 November 2006 06:03, Shawn Pearce wrote:
>> After reading your reply you are probably correct.  I can see there
>> may be workflows that want every remote branch also created as a
>> local branch.
>>
>> I could certainly live with a command line option to clone, e.g.:
>>
>> 	git clone --only vmdvt,vmtip user@host:/path...
> 
> Still missing here: What branch should be checked out after
> cloning?

Does any need to be checked out?  Or perhap I should put it another way,
when we make a virgin repository we default to master checked out but
its not joined to the DAG.  Perhaps we can just init-db and fetch the
specified branches and we are done.  The user will then checkout things
as they need and if they do not need master they can lose it.

> 
> Perhaps it is better to extend git-checkout to allow to do the
> correct thing when the user specifies a read-only branch from
> refs/remotes. E.g. with refs/remotes/origin/vmdvt,
> 
>  	git checkout origin/vmdvt
> 
> should create a new local branch refs/heads/vmdvt which forks
> from remotes/origin/vmdvt (and abort with
> error if refs/heads/vmdvt already exists without being the local
> development branch for remotes/origin/vmdvt), add to .git/config
> 
> [branch "vmdvt"]
> 	remote = origin
> 	merge = remotes/origin/vmdvt
> 
> and switch to this new created branch.
> 
> Given this addition to git-checkout, the implicit default
> action after cloning with --use-separate-remote should be
> 
> 	git checkout origin/master
> 
> where "master" can be changed on the git-clone command line
> to another branch, e.g. "--checkout vmdvt".
> 
> IMHO, this addition to git-checkout would make it a lot
> easier to work with --use-separate-remote, as there,
> every branch other the master is read-only.
> 
> And if you have two remote repositories with a master branch
> each, and you want to develop locally on both, this could
> be accomplished with
> 
> 	git checkout -b othermaster remotes/otherrepo/master

-apw
