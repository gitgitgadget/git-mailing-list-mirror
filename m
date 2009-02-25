From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Files different for me
Date: Wed, 25 Feb 2009 09:55:19 -0800
Message-ID: <7vd4d62ygo.fsf@gitster.siamese.dyndns.org>
References: <450196A1AAAE4B42A00A8B27A59278E709E047DE@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "John Dlugosz" <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 18:57:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcO07-0002Ys-NN
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 18:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320AbZBYRz1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 12:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753630AbZBYRz1
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 12:55:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61022 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898AbZBYRz1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 12:55:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F64C120D;
	Thu, 26 Feb 2009 12:55:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D12BE120C; Thu,
 26 Feb 2009 12:55:20 -0500 (EST)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E709E047DE@EXCHANGE.trad.tradestation.com>
 (John Dlugosz's message of "Wed, 25 Feb 2009 11:11:39 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A404AAEA-042E-11DE-A35F-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111472>

"John Dlugosz" <JDlugosz@TradeStation.com> writes:

> I'm working with a group, and using git for source code.=C2=A0 I need=
 to
> change a couple files temporarily and just for me.=C2=A0 I thought, "=
that's
> easy", just don't stage them when I check in changes.=C2=A0 But, what=
 do I do
> when I pull changes from others?=C2=A0 I think it will complain that =
I have
> unsaved changes.  What's the best way to do this?

[jc: Overlong lines wrapped]

This typically happens when a configuration file of some sort that *mus=
t*
be different in each work tree is tracked.

"git pull" and "git merge" do not care when you have local changes to
paths *and* the merge does not involve them, and errors out without
touching any files in your tree when the merge needs to touch them.  Yo=
u
can safely deal with your local changes after seeing such an error.  Th=
is,
and because such a file tend to be modified much less often than the re=
al
contents, means that:

 (1) you do not usually have to worry about this issue, and can keep yo=
ur
     small local changes you do not mind losing around, and

 (2) when you have to recover, you can easily stash your changes away,
     redo the pull and unstash them.

If you want an "I do not have to think" solution, an easiest recipe to
follow would be:

    $ git stash
    $ git pull
    ... potentially resolve conflicts and make a merge commit ...
    $ git stash pop

But as described above, stash/stash pop are superfluous for most of the
time.
