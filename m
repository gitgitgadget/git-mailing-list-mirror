From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Remove useless if-before-free tests.
Date: Sun, 24 Feb 2008 19:15:10 +0100
Message-ID: <877igup6fl.fsf@rho.meyering.net>
References: <871w7bz1ly.fsf@rho.meyering.net> <47B995CC.2000809@gmx.ch>
	<87skznhqk6.fsf@rho.meyering.net>
	<7vzlts9ag8.fsf@gitster.siamese.dyndns.org>
	<87ir0gx5bn.fsf@rho.meyering.net>
	<7vskzk99fd.fsf@gitster.siamese.dyndns.org>
	<87tzk0tzjz.fsf@rho.meyering.net>
	<7vd4qo7fsc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jean-Luc Herren <jlh@gmx.ch>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 19:15:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTLOE-00075Y-IS
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 19:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbYBXSPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 13:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752573AbYBXSPQ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 13:15:16 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:60081 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743AbYBXSPO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 13:15:14 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id B0D6417B592
	for <git@vger.kernel.org>; Sun, 24 Feb 2008 19:15:12 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 4F1C517B619
	for <git@vger.kernel.org>; Sun, 24 Feb 2008 19:15:11 +0100 (CET)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id E1976E3E;
	Sun, 24 Feb 2008 19:15:10 +0100 (CET)
In-Reply-To: <7vd4qo7fsc.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 22 Feb 2008 15:05:55 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74950>

Junio C Hamano <gitster@pobox.com> wrote:
...
>> If you're interested in automating detection of the useless
>> tests, you might like the useless-if-before-free script in gnulib:
>> [it *does* detect brace-enclosed free statements, and has a --name=S
>>  option to make it detect free-like functions with different names]
>
> While I have your attention ;-)

Hi Jun,

No excuse required ;-)

> I am not interested in automating useless "if (x) free(x)" tests,

Yeah, that particular one is not a big deal, but whenever I take
the time to make a sweeping change, I find it's worth a little
more to automate a check to preserve the goal state.

> but one thing I recently wanted but did not know a handy
> tool for was to find all the calls to free() that free a pointer
> to an object of a particular type.
...
> I guess sparse could be hacked to do that, but do GNU folks have
> some checker like that?

A general purpose tool to do something like that would be very useful.
I thought of cscope and eclipse, but as far as I know,
neither of them can perform such a query.

This made me think of the dwarves package/paper:

    7 dwarves
    https://ols2006.108.redhat.com/2007/Reprints/melo-Reprint.pdf

This looked promising at first, but it annotates function _definitions_
for run-time data collection, while you want to look at uses, which
can be done statically:

    3.4   ctracer

    A class tracer, ctracer is an experiment in creating valid source
    code from the DWARF information.  For ctracer a method is any
    function that receives as one of its parameters a pointer to a
    specified struct. It looks for all such methods and generates
    kprobes entry and exit functions. At these probe points it
    collects information about the data structure internal state,
    saving the values in its members in that point in time, and
    records it in a relay buffer. The data is later collected in
    userspace and post-processed, generating html + CSS callgraphs.

Too bad coverity is closed-source.  I'll bet it could do this easily.

Maybe hacking sparse is the way to go, after all.
