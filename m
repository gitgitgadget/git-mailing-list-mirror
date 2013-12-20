From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: RLIMIT_NOFILE fallback
Date: Fri, 20 Dec 2013 15:43:51 +0100
Message-ID: <52B457A7.4050901@web.de>
References: <xmqqy53ihwe4.fsf@gitster.dls.corp.google.com> <20131218191702.GA9083@sigill.intra.peff.net> <xmqq61qmhrb3.fsf@gitster.dls.corp.google.com> <20131218212847.GA13685@sigill.intra.peff.net> <xmqqd2kthmcr.fsf@gitster.dls.corp.google.com> <20131218214001.GA14354@sigill.intra.peff.net> <xmqqzjnxg3zz.fsf@gitster.dls.corp.google.com> <20131219001519.GB17420@sigill.intra.peff.net> <52B32D18.80400@web.de> <xmqqmwjwg2ok.fsf@gitster.dls.corp.google.com> <20131220091232.GA9637@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 20 15:44:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vu1J3-0004VO-6l
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 15:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826Ab3LTOn7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Dec 2013 09:43:59 -0500
Received: from mout.web.de ([212.227.15.3]:53282 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753726Ab3LTOn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Dec 2013 09:43:57 -0500
Received: from [192.168.37.101] ([87.146.154.55]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LbroC-1VB5dH072C-00jJ3W for <git@vger.kernel.org>;
 Fri, 20 Dec 2013 15:43:55 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20131220091232.GA9637@sigill.intra.peff.net>
X-Provags-ID: V03:K0:776sa2PKIvSA0yN+iSxRUW+nCplOpk7y8DwGQZmAVKUNvr/M8Fm
 AVZ7BM8/lh0zu2bX4f98HAhsk0z1pdGeIiOvYjWuc6eeGQVz5nrWxAedBzzwzzP7qXnkRd8
 aCa5YCVA86GB/Hlx2yDyKgxVcToqkJEZMByz0ojzl0xDiice7CEVIqjfVtnieN7hhg5xy05
 +3bGb8gwrKUCbtLJLv8Vg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239573>

On 2013-12-20 10.12, Jeff King wrote:
> On Thu, Dec 19, 2013 at 09:39:55AM -0800, Junio C Hamano wrote:
>=20
>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>
>>> Thanks for an interesting reading,
>>> please allow a side question:
>>> Could it be, that "-1 =3D=3D unlimited" is Linux specific?
>>> And therefore not 100% portable ?
>>>
>>> And doesn't "unlimited" number of files call for trouble,
>>> having the risk to starve the machine ?
>>>
>>> BTW: cygwin returns 256.
>>
>> If you look at the caller, you will see that we do cap the value
>> returned from this helper function down to a more reasonable and not
>> so selfish maximum, exactly for the purpose of avoiding the risk of
>> starving other processes.
>=20
> I am not sure you are reading the capping in the right direction. We =
do
> not cap at 25, but rather keep 25 open for "other stuff". So at
> unlimited, we are consuming a mere UINT_MAX-25 descriptors. :)
>=20
> I think that 25 is not for the benefit of the rest of the system, but
> rather for _us_ to avoid running out of descriptors for normal
> operations. I do not think we need to be careful about starving other
> processes at all. That is the job of the ulimit in the first place, a=
nd
> we respect it. If the sysadmin turns off the limit, then we are just
> following their instructions.
>=20
> In practice, I'd be shocked if git behaved reasonably above about 500
> packs anyway, so that puts a practical cap on our fd use. :)
>=20
> None of that impacts the patch under discussion, though. The only thi=
ng
> I was trying to bring up earlier is that on a system with:
>=20
>   1. No (or broken) getrlimit
>=20
>   2. No OPEN_MAX defined
>=20
>   3. sysconf that works, and returns -1 for unlimited
>=20
>   4. a sysadmin who has set the descriptor limit to "unlimited"
>=20
> We will end up at "1". Which is not great, but I am skeptical that a
> system matching the above 4 constraints actually exists. So I think t=
he
> patch is fine in practice.
>=20
> -Peff

My wrong: I was carefully reading the wrong version of the patch :-(
Sorry for the noise.
/torsten
