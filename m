From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: Re* How to generate pull-request with info of signed tag
Date: Wed, 21 Dec 2011 22:21:21 +0530
Message-ID: <87ipl9yik6.fsf@linux.vnet.ibm.com>
References: <874nx1korf.fsf@linux.vnet.ibm.com> <7vbor8jw0h.fsf@alter.siamese.dyndns.org> <871us3l45o.fsf@linux.vnet.ibm.com> <7viplfdlpb.fsf@alter.siamese.dyndns.org> <87iplch79e.fsf@linux.vnet.ibm.com> <7vobv4mj4r.fsf@alter.siamese.dyndns.org> <7vk45smilc.fsf@alter.siamese.dyndns.org> <87liq6xwr8.fsf@linux.vnet.ibm.com> <7vzkemh0de.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 21 17:52:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdPOd-0004jC-Dh
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 17:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949Ab1LUQv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 11:51:59 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:48338 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab1LUQv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 11:51:58 -0500
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
	Wed, 21 Dec 2011 09:51:56 -0700
Received: from d03relay03.boulder.ibm.com (9.17.195.228)
	by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	Wed, 21 Dec 2011 09:51:43 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id pBLGpV30115478
	for <git@vger.kernel.org>; Wed, 21 Dec 2011 09:51:36 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id pBLGpRvH018190
	for <git@vger.kernel.org>; Wed, 21 Dec 2011 09:51:29 -0700
Received: from skywalker.linux.vnet.ibm.com ([9.124.88.134])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id pBLGpMs9017269;
	Wed, 21 Dec 2011 09:51:25 -0700
In-Reply-To: <7vzkemh0de.fsf@alter.siamese.dyndns.org>
User-Agent: Notmuch/0.10.2+110~g3b54f44 (http://notmuchmail.org) Emacs/23.3.1 (x86_64-pc-linux-gnu)
x-cbid: 11122116-3270-0000-0000-000002B9044D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187572>

On Tue, 20 Dec 2011 23:03:57 -0800, Junio C Hamano <gitster@pobox.com> wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> 
> > Also can we make .git/config remote stanza to have something like below
> >
> >
> >      fetch = +refs/tags/*:refs/tags/abc/*
> >
> > so that one can do
> >
> >    git fetch t-remote tag-name
> >
> > and that get stored to abc/tag-name 
> 
> You can do whatever you want to your own config file without asking anybody.
> 
> Having said that, the point of the recent change to allow you to pull this
> way (notice the lack of "tag")
> 
>     $ git pull $url $signed_tag_name
> 
> is so that you do not have to contaminate your own ref namespace with tags
> that are used to leave audit trails in the history graph.
> 

With an entry like below

[remote "github"]
        fetch = +refs/tags/*:refs/tags/origin/*
        url = git://github.com/kvaneesh/QEMU.git

when i do git fetch github for-anthony i get the below error

[master@QEMU]$ git fetch github for-anthony
From git://github.com/kvaneesh/QEMU
 * tag               for-anthony -> FETCH_HEAD
[master@QEMU]$ less .git/config 

Also trying to do

[master@QEMU]$ git fetch git://github.com/kvaneesh/QEMU.git  for-anthony:aneesh/for-anthony
error: Trying to write non-commit object 12916047784615b7d8b879d9d39be6c1559e1b1b to branch refs/heads/aneesh/for-anthony
From git://github.com/kvaneesh/QEMU
 ! [new branch]      for-anthony -> aneesh/for-anthony  (unable to update local ref)
 * [new tag]         for-anthony -> for-anthony


I understand that replacing the above with below works. But we should
not be required to specify refs/tags there right ?

[master@QEMU]$ git fetch git://github.com/kvaneesh/QEMU.git  refs/tags/for-anthony:refs/tags/aneesh/for-anthony

-aneesh
