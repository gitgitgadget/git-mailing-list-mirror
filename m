From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: repository corruption when pushing commits to a repository running 'git gc --prune='
Date: Wed, 14 Oct 2015 16:38:37 +0200
Message-ID: <vpq4mhtbjma.fsf@grenoble-inp.fr>
References: <561E5C5B.3090207@alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Jan Smets <jan.smets@alcatel-lucent.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 16:38:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmNCZ-0003Rs-Fn
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 16:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbbJNOin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 10:38:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53160 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932189AbbJNOim (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 10:38:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t9EEcZoq025831
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 14 Oct 2015 16:38:35 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9EEcbZf030502;
	Wed, 14 Oct 2015 16:38:37 +0200
In-Reply-To: <561E5C5B.3090207@alcatel-lucent.com> (Jan Smets's message of
	"Wed, 14 Oct 2015 15:44:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 14 Oct 2015 16:38:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9EEcZoq025831
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445438316.25588@z+0KkhjzjbzDiWJ2cwPLGQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279576>

Jan Smets <jan.smets@alcatel-lucent.com> writes:

> Hi
>
> I've recently expired my reflog to prune loose objects. On a live,
> bare, repository I ran 'git gc --prune=now'
>
> All clients ended up having problems, they would report:
>  error: refs/heads/master does not point to a valid object!
> Running 'git log' on the bare repo gave : fatal: bad object HEAD
[...]
> fatal: bad object 22f0351258fa0bb4cd28984b6473510957fbce69
> fatal: bad object 22f0351258fa0bb4cd28984b6473510957fbce69
> To /tmp/test/bare
>  ! [remote rejected] master -> master (missing necessary objects)

I think this is the expected behavior. push will create new objects that
are not referenced until the ref is updated (at the very end). prune can
run concurrently since creating and deleting objects is done in a
lockless way (only the ref update needs a lock).

Still, this is not the *documented* behavior, and an easy way to corrupt
a repo should be very explicitly documented as very dangerous, and the
precautions to take when using it should be explained clearly.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
