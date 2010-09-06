From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Determining commit reachability
Date: Mon, 06 Sep 2010 16:38:21 -0700
Message-ID: <7v39tmtpci.fsf@alter.siamese.dyndns.org>
References: <4C83FEC3.3040101@gmail.com>
 <7viq2jv05c.fsf@alter.siamese.dyndns.org>
 <AANLkTinDfCkkY_D6F7VepvuNAN1g1hC9UgnqRUjZn88y@mail.gmail.com>
 <AANLkTim4kxpQj_UFOBcwCaVmBFCHun4T9t3O9Zvq3w49@mail.gmail.com>
 <AANLkTinPDUeL2jaY3P17TiA959WH8eOQZ4=CeaHOYuq2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 01:38:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OslGx-000138-KB
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 01:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454Ab0IFXij convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 19:38:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45029 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab0IFXid convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 19:38:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CC863D3431;
	Mon,  6 Sep 2010 19:38:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+zGSNIU6ROyN
	EeCP3HCS8L4DvqQ=; b=NtgA1X4SySmghE+nkHuP6gjf6OhSs4DHeoXJieXX3j0i
	TQdr53lRBnE0Sr5rOWYs2fRRN5wOpu5J3F1EXBQJt95/j5H1pl1jQqo3kMJoIYRG
	8LtzBOP2jinLJ0vFZzXonN5ObwSHW3Mz2IwZz3Wby0s5hIDSPNi/MWk046B0whA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=L8QpEI
	jcPFX9nmYuepp450ZQLVnLLWZKzxHmbKSwC8Fqae7sYD3UYvW5cAyywGWQ+nnE/l
	lJxW6WMQIUxZXU29q3Z0BMGD3Ztq9FANxYN3+88asxx3NSdWf6MuKZ9TUVQDpcEp
	2IKrJGsrPc2kKkC4EmBcLJOMnqvQq+wwVFS/c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 50100D3429;
	Mon,  6 Sep 2010 19:38:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52097D3428; Mon,  6 Sep
 2010 19:38:23 -0400 (EDT)
In-Reply-To: <AANLkTinPDUeL2jaY3P17TiA959WH8eOQZ4=CeaHOYuq2@mail.gmail.com>
 (Sverre Rabbelier's message of "Mon\, 6 Sep 2010 16\:05\:59 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D9A2C144-BA0F-11DF-998A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155641>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Mon, Sep 6, 2010 at 15:53, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>> On Mon, Sep 6, 2010 at 20:45, Sverre Rabbelier <srabbelier@gmail.com=
> wrote:
>>> In case anyone else is wondering, '--with' is a hidden alias for '-=
-contains'.
>>
>> Maybe it should be documented?
>
> Junio added it that way back in "git-branch --contains=3Dcommit"
> v1.5.3.6-879-g694a577 (Nov 7 2007) when the feature was added. Junio,
> do you remember why you added "--with" as a hidden alias?

It was originally called --with.  I wrote it to help me in the exact us=
e
case in this thread, and the option was naturally named --with, as the
request I wanted to make was "Give me branches _with_ this commit, so t=
hat
I know which ones I need to rewind before reintegrating and publishing"=
=2E

Somehow people wanted to see an option with a longer name, but by that
time my fingers were well trained, so I kept "--with" but didn't bother
advertising duplicated options.
