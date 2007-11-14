From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git and Scmbug integration
Date: Tue, 13 Nov 2007 17:27:42 -0800
Message-ID: <7vk5olpqep.fsf@gitster.siamese.dyndns.org>
References: <1194980792.4106.6.camel@localhost>
	<ee77f5c20711131500h6ee067ffv3e488ac7bde1d22c@mail.gmail.com>
	<1194998142.4106.24.camel@localhost>
	<ee77f5c20711131602m5b9042fx72689af53e24ddd2@mail.gmail.com>
	<1194999404.4106.40.camel@localhost>
	<ee77f5c20711131627q329d45aepe48102728cf2778c@mail.gmail.com>
	<7vprydpr5o.fsf@gitster.siamese.dyndns.org>
	<ee77f5c20711131716l6dd1dccjcb3ff5f3a54c9359@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kristis Makris" <kristis.makris@asu.edu>, jnareb@gmail.com,
	git@vger.kernel.org, scmbug-users@lists.mkgnu.net
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 02:28:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is731-0000DH-Lz
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 02:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbXKNB1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 20:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752622AbXKNB1v
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 20:27:51 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56449 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbXKNB1u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 20:27:50 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A5F772F0;
	Tue, 13 Nov 2007 20:28:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0F70395859;
	Tue, 13 Nov 2007 20:28:05 -0500 (EST)
In-Reply-To: <ee77f5c20711131716l6dd1dccjcb3ff5f3a54c9359@mail.gmail.com>
	(David Symonds's message of "Wed, 14 Nov 2007 12:16:47 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64939>

"David Symonds" <dsymonds@gmail.com> writes:

> Reading HEAD would be fine. I guess it just seems a sensible and more
> direct path to passing that information so that the hook has less to
> do. It seems quite a simple thing that would be very helpful to hook
> writers, with zero impact on everyone else.

You cannot just say "The hook did not get any parameter, nobody
would have cared, this does not regress."

Some anal people could have checked and checked "test $# = 0" at
the beginning to make sure their hooks do not get broken by
random interface changes on the git side.  Now their carefully
written script errors out as designed.  Also some people seem to
use different version of git on the same repository (e.g. NFS
mounted across hosts that run different versions of git).

I would 80% agree with you if the post-comit hook interface were
written in the way your patch does from day one.  Unfortunately
that is not the case.

The remaining 20%?  If we _were_ to change the hook interface, I
would also pass which branch the commit is added to, in addition
to what commit it is.

Both are easily obtainable by reading HEAD (you need to read
HEAD twice, though) but would be handy.
