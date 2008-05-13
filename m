From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add a test for git-add --ignore-errors
Date: Tue, 13 May 2008 08:04:53 +0200
Message-ID: <20080513060453.GB3622@steel.home>
References: <20080302154154.GC2973@steel.home> <20080302154238.GD2973@steel.home> <alpine.LSU.1.00.0803021555500.22527@racer.site> <7vtzjpoye6.fsf@gitster.siamese.dyndns.org> <20080512175654.GB3128@steel.home> <20080512175745.GC3128@steel.home> <20080512175810.GD3128@steel.home> <20080512175829.GE3128@steel.home> <20080512175848.GF3128@steel.home> <7v3aomx3sp.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dirk S??sserott <newsletter@dirk.my1.cc>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 08:06:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvndy-0007no-In
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 08:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756247AbYEMGE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 02:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755669AbYEMGE5
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 02:04:57 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:24552 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418AbYEMGE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 02:04:56 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarO+BInc
Received: from tigra.home (Fab5c.f.strato-dslnet.de [195.4.171.92])
	by post.webmailer.de (klopstock mo2) (RZmta 16.34)
	with ESMTP id Z0299bk4D17GxE ; Tue, 13 May 2008 08:04:54 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 1C830277BD;
	Tue, 13 May 2008 08:04:54 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id F10FC56D28; Tue, 13 May 2008 08:04:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v3aomx3sp.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81991>


Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Junio C Hamano, Tue, May 13, 2008 05:48:22 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> > +test_expect_success 'git add --ignore-errors' '
> > +	git reset --hard &&
> > +	date >foo1 &&
> > +	date >foo2 &&
> > +	chmod 0 foo2 &&
> > +	git add --verbose --ignore-errors .
> > +	git ls-files |grep foo1
> > +'
> > +
> >  test_done
> 
> I like the fact that you added --ignore-errors and made it still error out
> when it cannot read some files.  Shouldn't we be testing it here with
> "must-fail"?

Yes. Would you mind replacing that patch with this one?

 t/t3700-add.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 287e058..17ab05a 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -179,4 +179,13 @@ test_expect_success 'git add --refresh' '
 	test -z "`git diff-index HEAD -- foo`"
 '
 
+test_expect_success 'git add --ignore-errors' '
+	git reset --hard &&
+	date >foo1 &&
+	date >foo2 &&
+	chmod 0 foo2 &&
+	test_must_fail git add --verbose --ignore-errors . &&
+	git ls-files |grep foo1
+'
+
 test_done
-- 
1.5.5.1.206.g7103c
