From: David Kastrup <dak@gnu.org>
Subject: Re: C standard compliance?
Date: Thu, 30 Jan 2014 01:02:20 +0100
Organization: Organization?!?
Message-ID: <877g9i5oc3.fsf@fencepost.gnu.org>
References: <87iot25y0r.fsf@fencepost.gnu.org>
	<xmqqwqhiikpg.fsf@gitster.dls.corp.google.com>
	<87eh3q5x42.fsf@fencepost.gnu.org>
	<20140129233321.GC91854@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 30 01:03:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8f5u-0001GO-IX
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 01:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbaA3ACc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 19:02:32 -0500
Received: from plane.gmane.org ([80.91.229.3]:46889 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879AbaA3ACb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 19:02:31 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1W8f5R-0000yv-Rj
	for git@vger.kernel.org; Thu, 30 Jan 2014 01:02:29 +0100
Received: from x2f43172.dyn.telefonica.de ([2.244.49.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 01:02:29 +0100
Received: from dak by x2f43172.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 01:02:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f43172.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:lgBPBwxyb06uvEvCPXBT9YcSE9o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241233>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Wed, Jan 29, 2014 at 09:52:45PM +0100, David Kastrup wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> > Hmm... if you were to implement a set of pointers in such a way that
>> > you can cheaply tell if an unknown pointer belongs to that set, you
>> > would use a hashtable, keyed with something that is derived from the
>> > value of the pointer casted to uintptr_t, I would think.
>> 
>> The types intptr_t and uintptr_t are optional in ISO/IEC 9899:1999
>> (C99).  So it would seem that I'd be covering fewer cases rather than
>> more in that manner.
>
> I think we already use uintptr_t in the codebase, and if it's not
> present, we typedef it to unsigned long.  So I think it should be fine
> (and well-defined) if instead of doing
>
>   void *p, *q;
>   ...
>   if (p < q)
>     ...
>
> you do:
>
>   void *p, *q;
>   ...
>   if ((uintptr_t)p < (uintptr_t)q)
>     ...
>
> Then on those systems where the compiler has some bizarre undefined
> behavior checking, the code will work.  On systems that don't have
> uintptr_t, the compiler is probably not smart enough to perform such a
> check anyway.

The use case is actually sorting a list such that entries pointing to
the same malloced "origin" data structure are in adjacent list
positions.  At list intptr_t seems used plentifully in Git.

-- 
David Kastrup
