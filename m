Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74EF14F117
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731349942; cv=none; b=SAOIyOcyqD/TT6NRXz03vsXGdkhOdCUeEZfnvxtir9UHpBFoqx/pJCgJ4HGerdA7fp9kauo2z8hvKRGz4GW7t3hMlrQ/RtTrSlbHicVbpDYt5IpgvvPWN7CO04vxtwITKww/wRn2PxXty8iD1EPQxYc5o52sq16yNF6FlgsLm0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731349942; c=relaxed/simple;
	bh=OW1Bad7d1Qs0arkc9Y0GGoO3kBHrIQFYADhksZ9RPfg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d9acag4HDG1Zk59azcAZjDHPh0gkl8wZjaVVX5dNEyXeCXxlrZAbabx61MBF1j/KGZ0RwN0ZWOogS1Be+WuV6hGffVGc1EvrHDFQUFEPV8ZsOiJ39L0D7kMjchgPsGAP3Qh1tCgcBQYku761HdhzSZY6fo6f98hh5mAS5NjdpUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Kt8j25UD; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Kt8j25UD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731349935; x=1731954735;
	i=johannes.schindelin@gmx.de;
	bh=8+5eqrvkuFbLlCijVgbOoiXzLwFFOwb+rnvM5lI8H/Y=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Kt8j25UDDdo1AOh2BasLFNOt5gXe6a/+CMM2gr7hsbvzs2oSuFEU4rKTLLcX0Omk
	 dENJFVpVAHfmMUQ1/wvNKetwuWGUinNP5xiPI87h/X3+V2X2M6Rixn9BDMSA2Bixo
	 EFgmSBtDBIgd4dV0pLammcdQFY+NFn2WpCb3Gp+dKPbddlErlEgImDmC+FtAC2SXq
	 VFx3TEW5PqK0szxWS1MsyLdusnzncVEe+I7vEolZqD/cCGdUlXqmz0+uLS7OeeqL2
	 cfic96hIVyEQ2FsAL6kFohRZ20lXrX7ps9X7F96gjGWP4mz0yZN+7P2h/T5a/PCNr
	 reGYZ9PRTuD9DyKVzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.65]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvbG2-1u1yo51dLS-0164Y2; Mon, 11
 Nov 2024 19:32:15 +0100
Date: Mon, 11 Nov 2024 19:32:14 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>, 
    Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] log: --remerge-diff needs to keep around commit
 parents
In-Reply-To: <xmqq7c9ak0e9.fsf@gitster.g>
Message-ID: <b7488a36-0ba6-0847-47cb-6a5f3edec689@gmx.de>
References: <pull.1825.git.1731073435641.gitgitgadget@gmail.com> <xmqq7c9ak0e9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:EGRus1fcOd0y9EnEDd5LrjE8Z3TDP2m5JgD+sUk5hEe/LKTgjdx
 feLnG1K8zyGKdniUuF/Pcs4iMfw3U/okHcXlMiDOFyboRJn+rQmeXS/YPb/ZDSAkqQEZBaN
 F3+u3PJzfOm4JPAtCb/kzMXxdrvTfhvdbF9y5EqE5cJUVky82veqlAk3NIl7cyCIMq+TaII
 d5l3vv1juFuaZgbJqCBvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VYlbdiYIjx8=;cPNlwoHqiQDzuJRjkNXazgMx2hp
 5C/MaGhvKGj216bGKdTVnY8Xqft7v1YZ3YeZ/z6gee+hc86pgm7QL3pAnYRyjZOMpLtg5jWhN
 QiEruuGLRDqXML+zjPHGI3ahKY6jyLcNn5o+Q4cvPIFdz+r9Z+A6FwX9p7mve/OhTjnHePgIQ
 q+TTkj+7pEReMD5fqcbEWU8SQsl0ba11ebHCC0NPIRhMp6ltbkhF/OHum+E/6oGV0FOz14F8X
 f+RUsfTEiVcM7+WpoJlx9k5WTLX+RHbpCDrhuQ8TxUVpw0qtpOW0OkX9nTVMqBdNRlQmVxZkM
 hMtZNZzVu4DVVS+WA/t67KPkRC/PS8DFi3IwTfqFHG4fkqmJDLsCllAHRfCddEkDeduM6gokC
 uTGwOksKQAlOg+FeNz751zC8tOLj491iX6a/t+S8sDc1Ka+VUSQkp0qi2R4tC4FtkifCx9TnO
 oTw1LfW6fN1D9ulqWvcnWzGswAdQkZQj2YollQ6AJzB2sKA+YrVAL6TIaVOKpPPaUJjI6GkZ8
 Y2ayykHR+19LuAnJDpjyar5MgJFf/1m1f76FxAb9XfyskG26BI9XyhL3YM3c+IXPbWvASV6wN
 P0IpmgKnaKL/xXnm/W5A7ThiJ5b8fmbsdp/VMykpIWncJq4AoMOD7vhWxcpjV6EUIWNMLVd4Z
 iFKm0PyyzQunOyAiXmYcBjpAV8VrQyF4rzLLJSjC37HsFhMyKQQtGkf1djCX55ymBRMtckca7
 H8e8MHtNTYTPysRPz95ErtyagNVn9r5p4Ur770IoeDNaDApVnjy/qbo4XWeLSyAJwi2MJiqfI
 pUy0IYT9K5VgJOxv8JnM01lw==
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 11 Nov 2024, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > To show a remerge diff, the merge needs to be recreated. For that to
> > work, the merge base(s) need to be found, which means that the commits=
'
> > parents have to be traversed until common ancestors are found (if any)=
.
> >
> > However, one optimization that hails all the way back to
> > cb115748ec0d (Some more memory leak avoidance, 2006-06-17) is to relea=
se
> > the commit's list of parents immediately after showing it. This can br=
eak
> > the merge base computation.
>
> > Note that it matters more clearly when traversing the commits in
> > reverse: In that instance, if a parent of a merge commit has been show=
n
> > as part of the `git log` command, by the time the merge commit's diff
> > needs to be computed, that parent commit's list of parent commits will
> > have been set to `NULL` and as a result no merge base will be found.
>
> Ouch.
>
> I am curious about "more clearly" in the above, though.

I consider these examples less clear, but they are still affected:

	git show --remerge-diff v2.45.2^0
	vs
	git show --remerge-diff v2.44.2^0 v2.45.2^0

	git show --remerge-diff v2.45.1~1
	vs
	git log --topo-order --first-parent --remerge-diff v2.44.2 v2.45.1

Concretely, these diffs should be empty, but are not:

	git diff --no-index \
		<(git show --remerge-diff v2.45.2^0 | sed 1d) \
		<(git show --remerge-diff v2.44.2^0 v2.45.2^0 | sed 1,/^commit/d)

	and

	git diff --no-index \
		<(git show --remerge-diff v2.45.1~1 | grep -v ^commit) \
		<(git log --topo-order --first-parent -6 --remerge-diff v2.44.2 v2.45.1 =
|
		  sed '1,/^commit 1c00f92eb5ee4a48ab615eefa41f2dd6024d43bc/d;/^commit/,$=
d')

No `--reverse` required, not even clock skew.

Ciao,
Johannes
