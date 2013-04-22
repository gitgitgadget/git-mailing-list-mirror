From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 20:18:56 +0200
Message-ID: <vpqzjwqzawf.fsf@grenoble-inp.fr>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
	<87ppxmogdv.fsf@linux-k42r.v.cablecom.net>
	<CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
	<87wqruk2pj.fsf@linux-k42r.v.cablecom.net>
	<7vk3nupltx.fsf@alter.siamese.dyndns.org>
	<CALkWK0madWxOSraZw6u8U_afVeK8tyMB_+D59n1vSBmobxGqqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 20:19:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UULKt-0003JJ-6C
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 20:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513Ab3DVSTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 14:19:14 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50311 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754496Ab3DVSTK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 14:19:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r3MIIst8021019
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 22 Apr 2013 20:18:54 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UULKK-0000th-O0; Mon, 22 Apr 2013 20:18:56 +0200
In-Reply-To: <CALkWK0madWxOSraZw6u8U_afVeK8tyMB_+D59n1vSBmobxGqqg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 22 Apr 2013 23:30:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 22 Apr 2013 20:18:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3MIIst8021019
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1367259536.65039@7lq4vpdQX9LKa1F569yxgw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222044>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Meanwhile, you're evading the issue of assuming that all trees are
> read into /, and are really representing the same project's history,
> while this is not the case.

This is fundamenally how Git works. Git works with commit objects, each
commit object points to a tree object that represent "/" at this commit.

When you do a subtree merge, you include the tree that was in "/" in a
subtree of the master project. Files used to exist as /file, and now
exist as /subtree/file. There is nothing recording that the new
/subtree/file comes from /file in its second parent. Call this a
renaming or not, but "git log subtree/file" won't show you changes
touching "/file" by default, and this is the case for the history of the
subproject you are merging.

A subtree merge is really a rename of the subproject's file plus a
merge, done in the same commit. Try doing something like

mkdir -p subproject
git mv * subproject/
git commit

in your subproject before doing a merge, you'll get the same result,
except there will be one more commit.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
