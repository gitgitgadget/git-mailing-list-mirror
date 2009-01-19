From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Fix gitdir detection when in subdir of gitdir
Date: Sun, 18 Jan 2009 19:15:03 -0800
Message-ID: <7vy6x8rnpk.fsf@gitster.siamese.dyndns.org>
References: <1232120253-1551-1-git-send-email-szeder@ira.uka.de>
 <alpine.DEB.1.00.0901161729070.3586@pacific.mpi-cbg.de>
 <4970BA2B.7090807@viscovery.net> <4970BAE5.8080006@viscovery.net>
 <7vr63386rc.fsf@gitster.siamese.dyndns.org>
 <7vhc3wuwxb.fsf@gitster.siamese.dyndns.org> <20090119020311.GA8753@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@fzi.de>
X-From: git-owner@vger.kernel.org Mon Jan 19 04:16:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOkcv-0004K6-L2
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 04:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757733AbZASDPP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2009 22:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757595AbZASDPN
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 22:15:13 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757386AbZASDPM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jan 2009 22:15:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D4D0C91680;
	Sun, 18 Jan 2009 22:15:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C40D89167D; Sun,
 18 Jan 2009 22:15:05 -0500 (EST)
In-Reply-To: <20090119020311.GA8753@neumann> (SZEDER =?utf-8?Q?G=C3=A1bor'?=
 =?utf-8?Q?s?= message of "Mon, 19 Jan 2009 03:03:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 62294998-E5D7-11DD-9E8D-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106311>

SZEDER G=C3=A1bor <szeder@fzi.de> writes:

> Thanks.  In the meantime I was working on a patch that sets relative
> path in this case, too.

Does it make sense to use relative path in such a case?

If it is for "rev-parse --git-dir", the calling script may learn the
correct location of the GIT_DIR with either relative or absolute, but i=
f
it is for the internal consumption of git process itself and any
subprocess forked from us that look at GIT_DIR we export, the process
already runs at the repository root (because you do not chdir back) and
using relative path does not make much sense.  Exported GIT_DIR has to =
be
either "."  or the full path from the root to make sense to such a user=
, I
think.
