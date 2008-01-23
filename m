From: Mike Hommey <mh@glandium.org>
Subject: Re: git filter-branch should run git gc --auto
Date: Wed, 23 Jan 2008 07:44:30 +0100
Organization: glandium.org
Message-ID: <20080123064430.GD16297@glandium.org>
References: <1200783050.5724.196.camel@brick> <20080120033737.GA7767@soma> <20080120093436.GA10924@diana.vm.bytemark.co.uk> <7vlk6k8fyp.fsf@gitster.siamese.dyndns.org> <20080121224818.GA8872@untitled> <7vr6gawvkt.fsf@gitster.siamese.dyndns.org> <20080122003911.GA16453@hand.yhbt.net> <7vtzl6vd7v.fsf@gitster.siamese.dyndns.org> <BE604744-0D26-4A39-85CE-B5C0C8C00F9E@sb.org> <7v1w89qmw3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 07:45:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHZMD-0007pl-5i
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 07:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913AbYAWGoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 01:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754789AbYAWGoi
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 01:44:38 -0500
Received: from vuizook.err.no ([85.19.215.103]:42130 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754056AbYAWGoh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 01:44:37 -0500
Received: from aputeaux-153-1-83-190.w86-205.abo.wanadoo.fr ([86.205.41.190] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JHZLt-0001Fu-Mz; Wed, 23 Jan 2008 07:44:56 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JHZLa-00056K-9X; Wed, 23 Jan 2008 07:44:30 +0100
Content-Disposition: inline
In-Reply-To: <7v1w89qmw3.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71514>

On Tue, Jan 22, 2008 at 06:46:52PM -0800, Junio C Hamano wrote:
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
> 
> But again as I said, it largely depends on what you do in your
> filter.  If you are upcasing (or convert to NFD ;-)) the
> contents of all of your blob objects, you would certainly want
> to repack every once in a while.

I wonder if it wouldn't be possible to have filter-branch use
fast-import, so that it would create a pack instead of a lot of loose
objects.

Mike
