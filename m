From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Tue, 03 Jun 2008 00:11:05 -0700
Message-ID: <7v1w3f3sdy.fsf@gitster.siamese.dyndns.org>
References: <200806030314.03252.jnareb@gmail.com>
 <alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org>
 <7vy75n3zus.fsf@gitster.siamese.dyndns.org>
 <200806030839.58214.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 09:12:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Qh5-0001LH-EE
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 09:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbYFCHLO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jun 2008 03:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbYFCHLO
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 03:11:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbYFCHLN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jun 2008 03:11:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C8C653DC0;
	Tue,  3 Jun 2008 03:11:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E18DE3D3D; Tue,  3 Jun 2008 03:11:07 -0400 (EDT)
In-Reply-To: <200806030839.58214.jnareb@gmail.com> (Jakub Narebski's message
 of "Tue, 3 Jun 2008 08:39:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3F23CB94-313C-11DD-B001-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83622>

Jakub Narebski <jnareb@gmail.com> writes:

> On Tue, 3 June 2008, Junio C Hamano wrote:
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>=20
>>> Actually, it's trivial to convert to other SCM's, although I guess =
the=20
>>> conversion tools haven't really tried. You can always turn it into =
a=20
>>> series of multiple merges. Yes, you lose information, but it's not =
like=20
>>> you lose a huge amount.
>>=20
>> One thing to worry about is what tree object you would give to each =
of
>> these "artificially split" merge commits, though.
>
> There shouldn't be, I think, a problem if octopus merge was done usin=
g
> 'octopus' merge strategy,...

You are sort-of right.

An octopus capable history may say "This is a merge between commit A, B
and C".  A trivial/na=C3=AFve conversion to a foreign history that can =
only
express two-parent merges must say "This X is a merge between commit A =
and
B", followed by "This is a merge between X and C".  X, cross between A =
and
B, _should_ be a merge that can be reliably and trivially recreated.  T=
his
actually is the reason why "my" octopus strategy implementation refuses=
 to
record anything nontrivial.

But that's not something you should assume, as you can commit anything
with commit-tree.  Some people might even be using sg/merge-options ser=
ies
parked in 'pu' that makes what the recorded parenthood and what the use=
d
parents different even more.

A cleverer Octopus reimplementation might even try different orders in
which it performs its internal pairwise merges, and at that point the
order of recorded parents won't have any resemblance to the order their
trees were used in the internal pairwise merges.
