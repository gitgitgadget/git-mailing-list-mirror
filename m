From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH v3] refs: Use binary search to lookup refs faster
Date: Fri, 30 Sep 2011 09:04:02 +0100
Message-ID: <a9f3dba5f48adfa603d76b7d49111e3d@quantumfyre.co.uk>
References: <4DF6A8B6.9030301@op5.se>
 <7vvcsbqa0k.fsf@alter.siamese.dyndns.org>
 <20110929221143.23806.25666.julian@quantumfyre.co.uk>
 <201109291913.34196.mfick@codeaurora.org>
 <7vwrcqpuc7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Fick <mfick@codeaurora.org>,
	Christian Couder <christian.couder@gmail.com>,
	<git@vger.kernel.org>, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 10:04:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Y4u-0003Rw-6i
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 10:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757515Ab1I3IEI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Sep 2011 04:04:08 -0400
Received: from neutrino.quantumfyre.co.uk ([93.93.128.23]:39759 "EHLO
	neutrino.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754796Ab1I3IEG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2011 04:04:06 -0400
Received: from reaper.quantumfyre.co.uk (quantumfyre-1-pt.tunnel.tserv5.lon1.ipv6.he.net [IPv6:2001:470:1f08:1724::2])
	by neutrino.quantumfyre.co.uk (Postfix) with ESMTP id 97CC6C060C;
	Fri, 30 Sep 2011 09:04:04 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 6EDB636A8F2;
	Fri, 30 Sep 2011 09:04:04 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id dDlPoEOiHxPu; Fri, 30 Sep 2011 09:04:03 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id EF1C536940A;
	Fri, 30 Sep 2011 09:04:02 +0100 (BST)
In-Reply-To: <7vwrcqpuc7.fsf@alter.siamese.dyndns.org>
X-Sender: julian@quantumfyre.co.uk
User-Agent: Roundcube Webmail/0.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182468>

On Thu, 29 Sep 2011 20:44:40 -0700, Junio C Hamano wrote:
> Martin Fick <mfick@codeaurora.org> writes:
>
>> This works for me, however unfortunately, I cannot find any
>> scenarios where it improves anything over the previous fix
>> by Ren=C3=A9.  :(
>
> Nevertheless, I would appreciate it if you can try this _without_=20
> Ren=C3=A9's
> patch. This attempts to make resolve_ref() cheap for _any_ caller.=20
> Ren=C3=A9's
> patch avoids calling it in one specific callchain.
>
> They address different issues. Ren=C3=A9's patch is probably an=20
> independently
> good change (I haven't thought about the interactions with the topics=
=20
> in
> flight and its implications on the future direction), but would not=20
> help
> other/new callers that make many calls to resolve_ref().

It certainly helps with my test repo (~140k refs, of which ~40k are=20
branches).  User times for checkout starting from an orphaned commit=20
are:

No fix          : ~16m8s
+ Binary Search : ~4s
+ Ren=C3=A9's patch  : ~2s

(The 2s includes both patches, though the timing is the same for Ren=C3=
=A9's=20
patch alone)

--=20
Julian
