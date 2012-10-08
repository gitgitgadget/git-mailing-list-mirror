From: Andreas Ericsson <ae@op5.se>
Subject: Re: Is anyone working on a next-gen Git protocol?
Date: Mon, 08 Oct 2012 11:05:01 +0200
Message-ID: <5072973D.4080703@op5.se>
References: <CACBZZX6b+3P8M+z+X13k9Pq3tvVUfs_k1=foQVreX8K801=efQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, spearce@spearce.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 11:05:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TL9HM-0006Ok-RV
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 11:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318Ab2JHJF1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2012 05:05:27 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:39716 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192Ab2JHJFH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 05:05:07 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so2769740lbo.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 02:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=ABog6TzgSIoxgKZ85gwhGoxnLM8V41Q3Tvy/THE0K9A=;
        b=PJlYR80KbZgoI72/4kBmFWErP6mSx8DD1PMuZO/U0wwTorEQEH9IXwIcXrWqoTWA/J
         PcUYwsqmuBYXLWBuxETEWnk1WzZh9qTJGtnWe6H3deM1JWUClSRgwEtKprtLxWbPCZf3
         EtD2bLhCuQ1ib6oaWnqb00SQSe41aox7rphY9M9qKcun/ImOnEAlqyXiydVGToUJcT64
         8O7DnXZezeMfqDT5awYaXl9Fu4GTdDsE2yhhJO1wC/DdiBiDRQK6h5ruxiFfvYImGAIm
         GWUz4HZ5g7QFVG8/g3xdcGmY/ej7nfKJJR3Flq3/kD6nxkHD/GqE9UhKI5hIE/WASKbk
         bcrw==
Received: by 10.152.106.15 with SMTP id gq15mr12782753lab.42.1349687106027;
        Mon, 08 Oct 2012 02:05:06 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id r8sm5190724lba.15.2012.10.08.02.05.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 08 Oct 2012 02:05:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120911 Thunderbird/15.0.1
In-Reply-To: <CACBZZX6b+3P8M+z+X13k9Pq3tvVUfs_k1=foQVreX8K801=efQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQl/OuRVSKtjLU68ddrn7bKr7AoAmP3/FzmFUV5f7om56ZoX+Ini+tamQSQ0KPDo93IEI+mu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207227>

On 10/07/2012 09:57 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
> On Wed, Oct 3, 2012 at 9:13 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>>
>>> I'm creating a system where a lot of remotes constantly fetch from =
a
>>> central repository for deployment purposes, but I've noticed that e=
ven
>>> with a remote.$name.fetch configuration to only get certain refs a
>>> "git fetch" will still call git-upload pack which will provide a li=
st
>>> of all references.
>>
>> It has been observed that the sender has to advertise megabytes of
>> refs because it has to speak first before knowing what the receiver
>> wants, even when the receiver is interested in getting updates from
>> only one of them, or worse yet, when the receiver is only trying to
>> peek the ref it is interested has been updated.
>=20
> Has anyone started working on a next-gen Git protocol as a result of
> this discussion? If not I thought I'd give it a shot if/when I have
> time.
>=20
> The current protocol is basically (S =3D Server, C =3D Client)
>=20
>   S: Spew out first ref
>   S: Advertisement of capabilities
>   S: Dump of all our refs
>   C/S: Declare wanted refs, negotiate with server
>   S: Send pack to client, if needed
>=20
> And I thought I'd basically turn it into:
>=20
>   C: Connect to server, declare what protocol we understand
>   C: Advertisement of capabilities
>   S: Advertisement of capabilities
>   C/S: Negotiate what we want
>   C/S: Same as v1, without the advertisement of capabilities, and may=
be
> don't dump refs at all
>=20
> Basically future-proofing it by having the client say what it support=
s
> to begin with along with what it can handle (like in HTTP).
>=20
> Then in the negotiation phase the client & server would go back &
> forth about what they want & how they want it. I'd planned to
> implement something like:
>=20
>      C: want_refs refs/heads/*
>      S: OK to that
>      C: want_refs refs/tags/*
>      S: OK to that
>=20
> Or:
>=20
>      C: want_refs refs/heads/master
>      S: OK to that
>      C: want_refs refs/tags/v*
>      S: OK to that
>=20

You'll want that to be a single "wants" message to avoid incurring
insane amounts of roundtrip latency with lots of refs. github and
other hosted services are quite popular, but with my 120ms ping
rtt I'd be spending half a minute just telling the other side what
I want when I fetch from a repo with 250 refs.

It's a flagday and a half to change the protocol though, so I expect
it'll have to wait for 2.0, unless the current client-side part of
it is dumb and ignores existing refs when requesting its "wants", in
which case the server can just stop advertising existing refs and
most of the speedup is already done.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
