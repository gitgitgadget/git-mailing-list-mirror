From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: git filter-branch should run git gc --auto
Date: Tue, 22 Jan 2008 18:54:08 -0800
Message-ID: <1201056848.16972.102.camel@brick>
References: <20080119123557.GA30778@diana.vm.bytemark.co.uk>
	 <20080119223249.8227.31460.stgit@yoghurt> <1200783050.5724.196.camel@brick>
	 <20080120033737.GA7767@soma>
	 <20080120093436.GA10924@diana.vm.bytemark.co.uk>
	 <7vlk6k8fyp.fsf@gitster.siamese.dyndns.org>
	 <20080121224818.GA8872@untitled>
	 <7vr6gawvkt.fsf@gitster.siamese.dyndns.org>
	 <20080122003911.GA16453@hand.yhbt.net>
	 <7vtzl6vd7v.fsf@gitster.siamese.dyndns.org>
	 <BE604744-0D26-4A39-85CE-B5C0C8C00F9E@sb.org>
	 <7v1w89qmw3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 03:54:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHVkz-0004Dm-CA
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 03:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbYAWCx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 21:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbYAWCx6
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 21:53:58 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:1631 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbYAWCx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 21:53:58 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2331470rvb.1
        for <git@vger.kernel.org>; Tue, 22 Jan 2008 18:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=bUdRX7jD/QaKmhy72+doJTN/BdyscuBFAyRTdcKXa3I=;
        b=WTfePQvafXAPrnl44yS0XpHy1XzVweCWLfj4xbfjEslasswjTSOwoRbbRGLk+ATmyvOKMMUVvGIEgcabtPnPFGzEql4gOkxzm1Ql+PtNkn0t4wEZyKW9fls5k+vX0qsRZaPlcLtQK5jCxt3RdcMSvPhhQdLwX6tqH/oab2/8Afo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=f/fIeR8WxHsD/UDw4xrSRq/t/RADWrPsHcUcBpZCXuzwGczndqa45ZjfG1klLseQKoGFm+htZ2yB5YG/hHw94SDWxzb+zLtkTlG0t00PvpT5LoMTHjba788HuPhBLq56SUKNPcvjM2JvF2PiKDOpi7U4iTe36IW61gLTZP2U+qE=
Received: by 10.140.142.4 with SMTP id p4mr5933768rvd.261.1201056836906;
        Tue, 22 Jan 2008 18:53:56 -0800 (PST)
Received: from ?192.168.1.100? ( [216.19.190.48])
        by mx.google.com with ESMTPS id b5sm3012143rva.20.2008.01.22.18.53.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Jan 2008 18:53:56 -0800 (PST)
In-Reply-To: <7v1w89qmw3.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71499>

On Tue, 2008-01-22 at 18:46 -0800, Junio C Hamano wrote:
> Kevin Ballard <kevin@sb.org> writes:
> 
> > I just glanced at git-filter-branch.sh (and I must say I was
> > incredibly surprised to find out it was a shell script) and it seems
> > it never runs git-gc or git-repack. Doesn't that end up with the same
> > problems as git-svn sans git-repack when filtering a large number of
> > commits? I was just thinking, if I were to git-filter-branch on my
> > massive repo (in fact, the same repo that started this thread, with
> > over 33000 commits in the upstream svn repo), even if I just do
> > something as simple as change the commit msg wont I end up with
> > thousands of unreachable objects? I shudder to think how many
> > unreachable objects I would have if I pruned the entire dports
> > directory off of the tree.
> >
> > Am I missing something, or does git-filter-branch really not do any
> > garbage collection? I tried reading the source, but complex bash
> > scripts are almost as bad as perl in terms of readability.
> 
> Theoretically yes, and it largely depends on what you do, but
> filter-branch goes over the objects that already exists in your
> repository, and hopefully you won't be rewriting majority of
> them.
> 
> So the impact of not repacking is probably much less painful in
> practice.

And afterwards, you'll probably want to check the rewritten history
to make sure it is acceptable before doing a git gc --prune.

Cheers,

Harvey
