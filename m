From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Replacing large blobs in git history
Date: Thu, 08 Mar 2012 13:22:57 -0800
Message-ID: <7vy5rabxe6.fsf@alter.siamese.dyndns.org>
References: <CAD-6W7byTiuE9MFZY1yG_ann-Ox7+wGjYduZ=Wwmw0ToF5Pynw@mail.gmail.com>
 <4F56786D.60801@gmail.com>
 <CACBZZX4hinV8vkebyNCLp_Ac6L80aNbdGOFqg1nSsCuRktFFrg@mail.gmail.com>
 <4F58D2CD.2050502@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Neal Kreitzinger <nkreitzinger@gmail.com>,
	Barry Roberts <blr@robertsr.us>, git <git@vger.kernel.org>
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Mar 08 22:23:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5knj-000317-5S
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 22:23:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379Ab2CHVXB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 16:23:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51733 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752900Ab2CHVXA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 16:23:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B4CD772C;
	Thu,  8 Mar 2012 16:22:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vEDRDndagNgs
	5LtAEqpuDOPAVQA=; b=hwS31O9uomu6IFog/W9/l2fdKw2qAbfn2awnwOC6PLJ5
	PXEm19CsBE/nlgcB6e7KPNP+VWGiInT0R4FwXKuuVVw/GE5BGM1WFDSTmfTFiFPT
	HzdpGTLPFI0wVnbaJUdmVwjQVfP2KFksgc8Q5XN86SAfPfVhHVwPeOFZaq5vorw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=g5im7c
	65aWXV8ve8AP6/lM0Syd+pZC7z/+zgA4PRwHi+FqSRHuh6KiLUeWA66Qe+kz8tUB
	P4xTaZ/3SI6IchNclRQGTUICYZ1OUrz0sVdDiwALAr+g1Y6DlhMZQEYzAqJTudQX
	ORjECjOLnovkzmBuiUYUSgTvxauiyLvzCvAcY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11F6F772B;
	Thu,  8 Mar 2012 16:22:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DCAC772A; Thu,  8 Mar 2012
 16:22:58 -0500 (EST)
In-Reply-To: <4F58D2CD.2050502@ira.uka.de> (Holger Hellmuth's message of
 "Thu, 08 Mar 2012 16:39:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0C68928-6964-11E1-9151-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192652>

Holger Hellmuth <hellmuth@ira.uka.de> writes:

> On 07.03.2012 22:27, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Does something other than git-fsck actually check whether the
>> collection of blobs you're getting from the remote when you clone ha=
ve
>> sensible sha1's?
>>
>> What'll happen if he replaces that 550MB blob with a 0 byte blob but
>> hacks the object store so that it pretends to have the same sha1?
>
> This is something I tested once because of security concerns
> (i.e. what happens if a malicious intruder just drops something else
> into the object store) and if I remember correctly only git-fsck was
> able to spot the switch. But I didn't test cloning, only a few local
> operations.

Local operation that do not have to look at such a corrupt blob will
not verify everything under the sun every time for obvious reasons.

An operation to transfer objects out of the repository (e.g. serving
as the source of "clone" from elsewhere) will notice when it has to
send such a corrupt object and you will be prevented from spreading
the damage.

The same thing for a transfer in the reverse direction. When the
other side tells us that it is giving us everything we asked, we
still look at all the objects we received to make sure.
