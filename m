From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Introduce %<branch> as shortcut to the tracked branch
Date: Fri, 20 Mar 2009 11:02:33 -0700
Message-ID: <7vwsakgjie.fsf@gitster.siamese.dyndns.org>
References: <200903181448.50706.agruen@suse.de>
 <20090318182603.GM8940@machine.or.cz>
 <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de>
 <7vr60ubgul.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de>
 <20090320004029.GX23521@spearce.org> <20090320004450.GY23521@spearce.org>
 <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0903201714020.10279@pacific.mpi-cbg.de>
 <7v7i2ki0sw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, B.Steinbrink@gmx.de,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 19:04:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkj4v-0001Z6-63
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 19:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503AbZCTSCr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 14:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754026AbZCTSCr
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 14:02:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59308 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815AbZCTSCq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 14:02:46 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5AEFAA1E8C;
	Fri, 20 Mar 2009 14:02:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7CB58A1E82; Fri,
 20 Mar 2009 14:02:35 -0400 (EDT)
In-Reply-To: <7v7i2ki0sw.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 20 Mar 2009 10:03:43 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4FDA3898-1579-11DE-B461-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113986>

Junio C Hamano <gitster@pobox.com> writes:

> Just be honest and say "You may have a branch whose name begins with =
a '%'
> and you cannot refer to it anymore in certain contexts.  Too bad.  Do=
n't
> do it next time you create a new branch".  I _can_ buy that argument.
>
> It however asks for a sane escape hatch.  You cannot "fix" such branc=
h
> names in most obvious ways (if you could, that would be a bug in this=
 %
> feature).
>
>  (1) git branch -m %master percent-master
>
>      We would end up renaming what master tracks to new name.
>
>  (2) git branch percent-master refs/heads/%master; git branch -d %mas=
ter
>
>      The first part is a good try, but the latter deletes what master
>      tracks.
>
> "git update-ref -d refs/heads/%master" needs to replace the second st=
ep of
> the latter.

A na=C3=AFve question.

Has nobody suggested to use a really illegal characters such as ':'
instead?  After all, we are not talking something that you can use in
refspecs but another way to spell branch names.

Alternatively, '~master' may have a nice connotation that means "where
master calls its home".

I haven't looked at the patch deeply yet, but what does the failure cas=
e
do?  I think we should die() if %master is asked for and master is not
merging from anywhere by default (similarly, if @{-4} is asked and we
haven't switched that many times, we should die(), although I do not
remember how I coded that codepath---I presume it's the same codepath y=
ou
are touching with this round).
