X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: David Lang <dlang@digitalinsight.com>
Subject: Re: Average size of git bookkeeping data (related to Using git as
 a  general backup mechanism)
Date: Tue, 19 Dec 2006 17:20:08 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0612191712440.18007@qynat.qvtvafvgr.pbz>
References: <20061213193149.43284.qmail@web86909.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
NNTP-Posting-Date: Wed, 20 Dec 2006 01:37:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <20061213193149.43284.qmail@web86909.mail.ukl.yahoo.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34888>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwqOl-0003aa-D0 for gcvg-git@gmane.org; Wed, 20 Dec
 2006 02:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932918AbWLTBhc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 20:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932912AbWLTBhc
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 20:37:32 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:33481 "HELO
 warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
 id S932918AbWLTBhc (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 20:37:32 -0500
Received: from wlvims02.diginsite.com by warden.diginsite.com via smtpd (for
 vger.kernel.org [209.132.176.167]) with SMTP; Tue, 19 Dec 2006 17:37:31 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by
 wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 19
 Dec 2006 17:37:29 -0800
To: David Tweed <tweed314@yahoo.co.uk>
Sender: git-owner@vger.kernel.org

On Wed, 13 Dec 2006, David Tweed wrote:

> How big is the "metadata" or "bookeeping data" in git related to a commit? (Eg, "around x bytes per changed file"
> or "around x bytes per file being tracked (whether changed in the commit or not)" )
>
> [I'm trying to get a feel for, if I switched to git, how much overhead would come from having a cron job automatically doing
> a snapshot every hour (if anything has changed), plus manual snapshots at points where I want to feel "safeguarded".
> I'm currently using my own simple, hacked together system for combined versioning/backups that does
> this. Using naive tools that don't account for wastes space due to disk block size effects the data being
> tracked is currently just under 9 months of acitvity on  2016 filenames with
> 17457599 bytes of data (ie, compressed version of their contents at various times) and 7838546 bytes
> is "metadata", ie, 30 percent of the stored data is metadata. This is in a format using 6 bytes to associate a single blob of
> contents to a filename (whether changed since last snapshot or not).]

if nothing has changed it will take the space of the commit tag, as the tree 
will remain the same (and you should be able to script detection of this case 
and make it zero overhead)

if something has changed you will have the new tree and the changed object

in a tree each object is ~28 bytes (IIRC from what Linus mentioned in the last 
week or two)

a loose object is compressed, and if you repack it will delta against prior 
versions for even more space savings

look at the size of the mozilla tree and the kernel tree and you will see that 
when packed git is about as efficiant as any other option you have (and more 
efficiant than most)

