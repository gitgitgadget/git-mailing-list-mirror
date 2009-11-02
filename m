From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fw: git-core: SIGSEGV during {peek,ls}-remote on HTTP remotes.
Date: Sun, 01 Nov 2009 20:10:16 -0800
Message-ID: <7vocnlworb.fsf@alter.siamese.dyndns.org>
References: <20091101.010702.527849118592864646._deepfire@feelingofgreen.ru>
 <7v8weq50pm.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0911010646v2043bdb7l9215f1114e9e8385@mail.gmail.com>
 <alpine.LNX.2.00.0911011504460.14365@iabervon.org>
 <fabb9a1e0911011254j316920e6y63c4f129f7df186d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>,
	Samium Gromoff <_deepfire@feelingofgreen.ru>,
	git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>,
	Mike Hommey <mh@glandium.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 05:11:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4oFy-0000ll-EU
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 05:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793AbZKBEK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 23:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753788AbZKBEK2
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 23:10:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51965 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751AbZKBEK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 23:10:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F0E13701D6;
	Sun,  1 Nov 2009 23:10:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LYDeRbMwll0xRRpY3mqw8XbsysM=; b=GDavPe
	hs/h0Ass/CxS33JzXNn+dMgPcA945O/t/VvxDq/azV8YM9C9MHSWBsDcqN3KUcev
	BLca7kQlrzBMw+712Doq+EODnouQmlHnevNEwkkfqZPdX9q8+MiAGDbLWGlm8Fjn
	HzivA5FacssaqRKmmxlgMjh9n8CJeCSdvMDLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ci555dN4ooQd13n1uv8Zi9cCMk3XgWDG
	9GsdGr8RWCIdmDEjYSHySaIQR8oiUXV6SVvrkQM/FLUzN8oPpk2IFAYPDTAfgpd1
	95tkz/Q/qF95lfo4imIE5xS6PlAAw/Rg+btw6qYkKMi6PbDgOZnGkX1Ac87q6+bB
	mE3spcvpJKo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9960C701D5;
	Sun,  1 Nov 2009 23:10:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8360E701D3; Sun,  1 Nov
 2009 23:10:17 -0500 (EST)
In-Reply-To: <fabb9a1e0911011254j316920e6y63c4f129f7df186d@mail.gmail.com>
 (Sverre Rabbelier's message of "Sun\, 1 Nov 2009 21\:54\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A5DBD1D6-C765-11DE-A240-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131895>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Sun, Nov 1, 2009 at 21:16, Daniel Barkalow <barkalow@iabervon.org> wrote:
>> If we change the ls-remote.c case, it becomes impossible for a struct
>> transport to ever have a NULL remote field. And the change to ls-remote
>> removes a special case. I'd go so far as to say that ls-remote.c should
>> provide a struct remote, and transport_get should enforce that there's a
>> struct remote.
>
> If that is the case (that we can eliminate the only special case), I
> agree that we should fix it there, where it will be the least effort.
> I got the impression from Junio's original post that there are
> multiple places that would have to be fixed, and I figured that we
> should fix it where it will be the least amount of effort :).

No, I genuinely didn't know what Daniel's intention was when a transport
has NULL in its remote field.  If it is much easier and cleaner not to
allow such a transport, then let's declare that and fix ls-remote that
should be the sole existing caller that used to use such a transport.

Thanks for looking into this, both of you.
