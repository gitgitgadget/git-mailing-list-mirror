From: David Kastrup <dak@gnu.org>
Subject: Re: performance on repack
Date: Thu, 16 Aug 2007 10:10:32 +0200
Message-ID: <86d4xn5287.fsf@lola.quinscape.zz>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com> <20070812103338.GA7763@auto.tuwien.ac.at> <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com> <20070814031236.GC27913@spearce.org> <alpine.LFD.0.999.0708141634160.5415@xanadu.home> <20070815053231.GJ27913@spearce.org> <9e4733910708150808x39241071j1a4012f16cd26ef8@mail.gmail.com> <20070815171152.GA15155@auto.tuwien.ac.at> <9e4733910708151138x2b267dc6w27c1bc8d948e5633@mail.gmail.com> <alpine.LFD.0.999.0708151453390.5415@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 10:11:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILaRx-0008KS-9C
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 10:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757691AbXHPILS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 04:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757824AbXHPILP
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 04:11:15 -0400
Received: from main.gmane.org ([80.91.229.2]:33703 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757691AbXHPILL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 04:11:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ILaRU-0005Bl-1j
	for git@vger.kernel.org; Thu, 16 Aug 2007 10:10:56 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Aug 2007 10:10:56 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Aug 2007 10:10:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:wujZosEG6NY0Pkd0YllBbD8ky1o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55988>

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 15 Aug 2007, Jon Smirl wrote:
>
>> On 8/15/07, Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
>> > git-pack-objects knows the order, in which it will use the objects.  A
>> > seperate thread could pre-read the next object and wait until the main
>> > thread starts processing it. After the read is complete, another
>> > thread could start computing the delta index.
>> 
>> The hope is that the new adaptive read ahead code in the kernel will
>> get this right and you won't need the second thread. Letting the
>> kernel handle the read ahead will dynamically scale as other demands
>> are made on the host. There's effectively only one read ahead cache in
>> the system, only the kernel really knows how to divide it up between
>> competing apps.
>
> No read ahead will ever help the delta search phase.

Well, the delta search phase consists of computing a delta index and
then matching against it.  If I understand correctly, delta indices
for the search window are kept, and the current file is compared
against them.  Locality might be better if just one delta index gets
calculated and then compared with all _upcoming_ delta candidates in
one go.

No idea whether it would pay off the complications.

-- 
David Kastrup
