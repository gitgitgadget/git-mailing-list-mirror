From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: How to update a cloned git repository
Date: Wed, 12 Sep 2012 10:52:37 +0200
Message-ID: <vpqtxv34o8a.fsf@bauges.imag.fr>
References: <k2n4v2$88t$1@ger.gmane.org> <vpq7gs0es4f.fsf@bauges.imag.fr>
	<006f01cd900e$fce59a60$f6b0cf20$@schmitz-digital.de>
	<vpqy5kgdctm.fsf@bauges.imag.fr>
	<007001cd9016$8f980f80$aec82e80$@schmitz-digital.de>
	<vpq4nn4d968.fsf@bauges.imag.fr>
	<7v1ui8k0in.fsf@alter.siamese.dyndns.org>
	<007401cd903c$f425fc20$dc71f460$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
	"'git'" <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Sep 12 10:53:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBihC-00040d-1z
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 10:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888Ab2ILIxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 04:53:08 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36086 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751607Ab2ILIxG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 04:53:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q8C8mBGd013676
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 12 Sep 2012 10:48:11 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TBigX-0007V7-TR; Wed, 12 Sep 2012 10:52:37 +0200
In-Reply-To: <007401cd903c$f425fc20$dc71f460$@schmitz-digital.de> (Joachim
	Schmitz's message of "Tue, 11 Sep 2012 18:46:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 12 Sep 2012 10:48:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8C8mBGd013676
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1348044491.47333@fz1RuMGDgvc4fTkwtC4EkQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205269>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

>> I think it is the-merge-commit^2; contrib/git-resurrect.sh might be
>> of interest, too.
>
> Sorry you lost me, this is greek to me...

A commit is an object that contain pointers to its parents. The root
commit has no parent. For ordinary commits, there is one parent which is
the commit on top of which it was created. For merge commits, there are
N commits, the first is the one on top of which the merge was created,
and the N-1 next ones are the commits being merged.

commit^ => first parent of commit
commit^1 => same
commit^2 => second parent, i.e. the one merged in commit.

See in git.git:

$ git show cb10ae9433126ef <---------------------------- one commit to study
commit cb10ae9433126efbc4dcc46779d7ef2fe6b1f597
Merge: 13b608a 9aeaab6   <------------------------------- list of parents
Author: Junio C Hamano <gitster@pobox.com>
Date:   Tue Sep 11 15:57:04 2012 -0700

    Merge branch 'jc/maint-blame-no-such-path' into pu
    
    * jc/maint-blame-no-such-path:
      blame: allow "blame file" in the middle of a conflicted merge

$ git show cb10ae9433126ef^1 <-------------------- "previous commit" in origin/pu
commit 13b608a063ce861929322e6bb3862b5364f3fbcf
Merge: fa17a26 bdee397
Author: Junio C Hamano <gitster@pobox.com>
Date:   Tue Sep 11 11:50:44 2012 -0700

    Merge branch 'dg/run-command-child-cleanup' into pu
    
    * dg/run-command-child-cleanup:
      run-command.c: fix broken list iteration in clear_child_for_cleanup

$ git show cb10ae9433126ef^2 <----------------- commit being merged by cb10ae9433126ef
commit 9aeaab6811dce596b4f6141d76f5300359bfd009
Author: Junio C Hamano <gitster@pobox.com>
Date:   Tue Sep 11 14:30:03 2012 -0700

    blame: allow "blame file" in the middle of a conflicted merge
[...]

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
