From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit -v does not removes the patch
Date: Sat, 22 Nov 2008 14:43:30 -0800
Message-ID: <7v4p1zpejx.fsf@gitster.siamese.dyndns.org>
References: <20081110181023.GA22753@coredump.intra.peff.net>
 <adf1fd3d0811101434j658b2e8aj83d8cbe2293f5021@mail.gmail.com>
 <7vej1j40x5.fsf@gitster.siamese.dyndns.org>
 <20081111000706.GA26223@coredump.intra.peff.net>
 <adf1fd3d0811102356u6e671dcfj6491f81cf462ec2e@mail.gmail.com>
 <20081111102914.GA30330@coredump.intra.peff.net>
 <7v4p2e2nkg.fsf@gitster.siamese.dyndns.org>
 <20081112081609.GA3720@coredump.intra.peff.net>
 <20081120130851.GA17608@neumann>
 <20081120152015.GA6283@coredump.intra.peff.net>
 <20081122155541.GC6885@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>,
	Git Mailing List <git@vger.kernel.org>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Nov 22 23:45:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L41E9-0002nv-Cr
	for gcvg-git-2@gmane.org; Sat, 22 Nov 2008 23:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634AbYKVWoG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Nov 2008 17:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757412AbYKVWoF
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Nov 2008 17:44:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65459 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599AbYKVWoE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Nov 2008 17:44:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B3D591750D;
	Sat, 22 Nov 2008 17:43:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7B433173A2; Sat,
 22 Nov 2008 17:43:34 -0500 (EST)
In-Reply-To: <20081122155541.GC6885@neumann> (SZEDER =?utf-8?Q?G=C3=A1bor'?=
 =?utf-8?Q?s?= message of "Sat, 22 Nov 2008 16:55:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0C79BBA8-B8E7-11DD-B0B0-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101559>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> So, I wonder whether those '--no-verify' options are still required i=
n
> 'git rebase -i'.

The use of --no-verify there does not have anything to do with "whitesp=
ace
errors".  It is to override _any_ validation the users want to do when
using "git commit" in their interactive workflow.  It so happens that t=
he
example hook we ship demonstrates how you hunt for whitespace errors, b=
ut
you have to remember that it is just an example.

We may want to disable the checking of exit status from commit-msg hook
while still calling the hook itself, though.  The primary purpose of th=
e
hook is to allow users to reformat (say, passing "fmt -64") the message=
,
but it is allowed to interfere and that was meant to happen when using
"git commit" but we probably do not want it when rebasing.

=46urther, we also may want to make the use of --no-verify overridable =
from
the command line when running rebase.  The primary purpose of the rebas=
e
command is to transplant a sequence of commits to someplace else withou=
t
molesting its contents and message unnecessarily, and --no-verify is a
good thing to use in general for that reason, but people may sometimes
want to use it as a way to clean up the changes.
