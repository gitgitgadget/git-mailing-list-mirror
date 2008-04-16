From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Wed, 16 Apr 2008 11:11:01 -0500
Message-ID: <48062515.50903@nrlssc.navy.mil>
References: <200804161626.44174.brian.foster@innova-card.com> <a537dd660804160804t252d2900j33e30a01dc58979c@mail.gmail.com> <480619AE.8010506@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Brian Foster <brian.foster@innova-card.com>, git@vger.kernel.org,
	Dmitry Potapov <dpotapov@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 16 18:36:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmAEr-000153-Vn
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 18:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757890AbYDPQLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 12:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757773AbYDPQLP
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 12:11:15 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54171 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757673AbYDPQLP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 12:11:15 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m3GGB1wx031750;
	Wed, 16 Apr 2008 11:11:02 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 16 Apr 2008 11:11:01 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <480619AE.8010506@viscovery.net>
X-OriginalArrivalTime: 16 Apr 2008 16:11:01.0818 (UTC) FILETIME=[770029A0:01C89FDC]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15848003
X-TM-AS-Result: : Yes--12.533000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY2OC03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMDk3NC03MDcxMTktNzAwMDU3LTcwODI1Ny03?=
	=?us-ascii?B?MDc3NTAtNzAxNTkwLTcwMzE3OS03MDA2MzAtNzAwNjQ4LTcwMDMw?=
	=?us-ascii?B?MC03MDQ5ODAtNzA0MTAyLTEwNjQyMC03MDE2MTgtNzAwOTQyLTcw?=
	=?us-ascii?B?MDQ3Ni03MDM3NDctNzA1MTAyLTcwMzc4OC03MDIxNDMtNzAxNDYx?=
	=?us-ascii?B?LTEyMTYyNC03MDUyNjktNzAxNDU1LTcwMjA0NC03MDQ3MTItNzA3?=
	=?us-ascii?B?MjI1LTcwMTQ1MC03MTE2MTItNzAyMzc5LTcwNzEwNC0xNDgwMzkt?=
	=?us-ascii?B?MjAwNDM=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79715>

Johannes Sixt wrote:
> Brian Foster schrieb:
>>  at toplevel of a (not-bare) clone, with  info/grafts  in-place,
>>  and a happy `fsck -full' (same machine so same git version):
>>
>> 	$ git filter-branch --tag-name-filter cat -- --all  # at not-bare toplevel
>> 	Rewrite 7df30811617517bc4d5ec7c190a435667228320c (168/168)
>> 	Ref 'refs/heads/master' was rewritten
>> 	Ref 'refs/remotes/origin/HEAD' was rewritten
>> 	WARNING: Ref 'refs/remotes/origin/master' is unchanged
>> 	Ref 'refs/tags/linux-2.6.15' was rewritten
>> 	error: Ref refs/tags/linux-2.6.15 is at \
>> 		26a33413c95dfda6c70ca4a83da49cddb7b236b9 but expected \
>> 		2dcaaf2decd31ac9a21d616604c0a7c1fa65d5a4
>> 	fatal: refs/tags/linux-2.6.15: cannot lock the ref
>> 	Could not rewrite refs/tags/linux-2.6.15
>> 	$
> 
> Actually, I don't know how to overcome this situation; maybe forget about
> the tags and remove the '--tag-name-filter cat' part. They wouldn't have
> been rewritten correctly anyway (annotated tags loose the message and
> become unannotated).


I don't think the tag-name-filter section has been reached yet.

I think the problem is the --all option to rev-parse. This adds everything under
.git/refs to the list of heads to rewrite. Just a guess, but possibly the
linux-2.6.15 is an annotated tag, which is dereferenced to a commit (the oldsha1),
and then when update-ref is called with the newsha1 and the oldsha1, the oldsha1
doesn't match what is in refs/tags/linux-2.6.15 since that points to the sha1 of
the tag object.

Try --branches instead of --all. Or leave it blank if you just want to filter
the current branch.

Also, if you're interested in retaining the annotations from the tags, search the
list for '[PATCH v4] filter-branch.sh: support nearly proper tag name filtering'
or grab the patch from git's pu branch.

-brandon
