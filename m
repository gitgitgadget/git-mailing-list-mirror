From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v3 3/3] archive.c: add basic support for submodules
Date: Fri, 23 Jan 2009 11:23:43 -0800
Message-ID: <7vzlhhu8qo.fsf@gitster.siamese.dyndns.org>
References: <1232659071-14401-1-git-send-email-hjemli@gmail.com>
 <1232659071-14401-2-git-send-email-hjemli@gmail.com>
 <1232659071-14401-3-git-send-email-hjemli@gmail.com>
 <1232659071-14401-4-git-send-email-hjemli@gmail.com>
 <alpine.DEB.1.00.0901230044300.3586@pacific.mpi-cbg.de>
 <8c5c35580901231040i380c6458x1a6103cd6f55c479@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 20:26:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQReX-0000MK-Nz
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 20:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbZAWTXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 14:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752225AbZAWTXw
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 14:23:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56265 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbZAWTXw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 14:23:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4FC641D219;
	Fri, 23 Jan 2009 14:23:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 589F11D217; Fri,
 23 Jan 2009 14:23:45 -0500 (EST)
In-Reply-To: <8c5c35580901231040i380c6458x1a6103cd6f55c479@mail.gmail.com>
 (Lars Hjemli's message of "Fri, 23 Jan 2009 19:40:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5DB56B4E-E983-11DD-97CE-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106905>

Lars Hjemli <hjemli@gmail.com> writes:

>>> The plan is to fix these limitations by extending --submodules to allow
>>> certain flags/options:
>>> a|c|r     include any|checked out|registered submodules
>>> H         resolve submodule HEAD to decide which tree to include

What do you mean by "decide"?  If HEAD exists (iow, the submodule is
checked out), the tree of the commit recorded in the superproject's
gitlink entry is included in the result?

As I already said before, I doubt it makes much sense in the context of
the current git-archive to base the choise on checkout status.

Unless you are extending git-archive and giving it an ability to write out
the superproject index or the work tree as an archive, that is.

Just like git-grep lets you grep in the work tree files (limited to paths
that appear in the index), or grep in the contents registered to the index
when run with --cached, git-archive could make an archive out of your work
tree files or your index contents.  Such an extension to git-archive may
be quite useful with or without submodules.

In such mode of operation, because you are dealing with the work tree when
run without --cached, it would make sense to say "Ah, the superproject
index wants v1.0 of the submodule, but the work tree has v2.0 of it
checked out, and we are writing out the work tree, so let's include v2.0
instead", and as a side effect of deciding which commit's tree to include
from each submodule, it naturally makes sense to exclude submodules that
are not checked out.

But otherwise I am not so sure what the point of H option would be.
