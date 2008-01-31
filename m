From: Adam Piatyszek <ediap@users.sourceforge.net>
Subject: Re: [PATCH] gitignore(5): Allow "foo/" in ignore list to match directory
 "foo"
Date: Thu, 31 Jan 2008 23:53:52 +0100
Message-ID: <47A25180.5000903@users.sourceforge.net>
References: <6bc632150801230554l3b24e1e4lb4641bf7c16857c0@mail.gmail.com>	<47A06EF9.60704@users.sourceforge.net>	<7vprvjgi9v.fsf@gitster.siamese.dyndns.org>	<47A1733E.9040103@users.sourceforge.net>	<7vhcgue5nr.fsf_-_@gitster.siamese.dyndns.org>	<7v63xae4lf.fsf_-_@gitster.siamese.dyndns.org>	<20080131094124.GA25546@coredump.intra.peff.net>	<7vfxwecmfe.fsf@gitster.siamese.dyndns.org>	<20080131104256.GF25546@coredump.intra.peff.net>	<alpine.LSU.1.00.0801311128190.23907@racer.site>	<6bc632150801310356w1b2fa019n87d92986aed807c5@mail.gmail.com> <7vr6fxbr5a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: pradeep singh rautela <rautelap@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 00:02:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKiQr-0003HR-Cv
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 00:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636AbYAaXC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 18:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754224AbYAaXCZ
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 18:02:25 -0500
Received: from pisces.et.put.poznan.pl ([150.254.29.122]:39444 "EHLO
	pisces.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbYAaXCY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 18:02:24 -0500
Received: from hydrus.et.put.poznan.pl (hydrus.et.put.poznan.pl [150.254.11.145])
	by pisces.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id m0VMwfxX028917;
	Thu, 31 Jan 2008 23:58:43 +0100 (CET)
	(envelope-from ediap@users.sourceforge.net)
Received: from [192.168.1.3] (erh70.neoplus.adsl.tpnet.pl [83.20.101.70])
	by hydrus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id m0VMs9923859;
	Thu, 31 Jan 2008 23:54:10 +0100 (MET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071116)
In-Reply-To: <7vr6fxbr5a.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
OpenPGP: id=1F115CCB
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940, Antispam-Data: 2008.1.31.143957
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72141>

* Junio C Hamano [31 I 2008 22:51]:
> [PATCH] gitignore(5): Allow "foo/" in ignore list to match directory "foo"
> 
> A pattern "foo/" in the exclude list did not match directory
> "foo", but a pattern "foo" did.  This just strips the trailing
> slash from such input.
> 
> This makes the behaviour slightly inconsistent with that of
> pathspecs, where "foo/" only matches directory "foo" and not
> regular file "foo" and make "foo/" in the ignore list match
> regular file "foo" happily.  This may hopefully does not matter
> in practice.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

This is more or less what I suggested originally. ;-)

Anyway, even if this new behaviour is not consistent with that of 
pathspecs, it is not worse than the current behaviour of git. I.e. now 
you have to use "foo" to ignore the "foo" directory and its contents, 
but it does not protect you from masking the file "foo" in the same 
repository.

However, it is not possible to have both the "foo" directory and "foo" 
file in the same directory level of a repository at the same time. So, 
the problem with this patch might be only when one replaces the ignored 
directory "foo" with a file using the same name and forgets to remove 
the "foo/" entry from .gitignore or .git/info/exclude. But exactly the 
same situation can occur for the current implementation.

So, I tend to agree that your latest patch is a sensible solution for 
99.9% of cases.

BR,
/Adam


-- 
.:.  Adam Piatyszek (ediap)  .:.....................................:.
.:.  ediap@users.sourceforge.net  .:................................:.
