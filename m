Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40951824BD
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 22:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731709117; cv=none; b=af9aWD4Hsh0BrkaYsxEQgwAPXbVt3JJDhBU44BYO5SpTp24LR03uhWqca09yLoAlHzV7/nQWQl6T4j1cx2ZUNEHRyleei/cYrtgJfMtTq5hX0yy4+6GYcXduq35/4F/Ook+mWDvS+YrY/nYrMTCUVoTg6OMNTRCqWh0N9+PqbAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731709117; c=relaxed/simple;
	bh=F96GMd6dJkLCUESh3UOvOWuFpvVw/ujIhFy4VpAOFeM=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=greft0X8BD+puPwVgUPnNNDVsrWjNhnvpwhdknEiSEE1/EhwUleUsYEuM3N4Oe7/cCYZcV9o1n3q8663atHVyE+fBgya3dQUXdbHpM54KbGG2vKAZjwl25i4temmZFVzts6BVrGwQ/2+UdLUWqPaYYVGADM8n1tzneS4nApfSyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=dDxlTYfG; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="dDxlTYfG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=etu4WuKP1vwHiWHzfkJIGIt/9/8D/Ym/cusQYqXsvK0=;
 b=dDxlTYfGJgLHida8zimfAsr/elvVhqdXikkL0pU4hbTmVlqczxiMtefKaJR/a9aWre8SBlv4AL+I
   ea+pfSh0yXfDVeXtC4oMpxSvBgap+by2Hb24R+oAHtGv/14kTgJP4aVReJD9bGG1yVkbOGXNPYyJ
   Hhdk5JF2dcWbGeGnsqhl48bvFBDtCjc13sI91vNDnnMN4WOzjxDYX+ssahZdyOYGFr4Xzv6QjVw1
   IY7oS7eX4VNYmhOUb2i7fa13BayBTGdLGvczP28MPqhXgwKFnuZUIKIPUH0709SBd8QWU8syP/pZ
   pG2LK05+MnLO2wz0szo5JB6ROT+WK6lLupxpDw==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN00010IJAXKO50@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 15 Nov 2024 22:18:33 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Fri, 15 Nov 2024 23:18:10 +0100
Message-id: <D5N3N1RMMR9Q.28GSGYYBWZSOS@ferdinandy.com>
Subject: Re: [PATCH v12 2/8] refs: atomically record overwritten ref in
 update_symref
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>, <karthik.188@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>, <ferdinandy.bence@ttk.elte.hu>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241023153736.257733-1-bence@ferdinandy.com>
 <20241023153736.257733-3-bence@ferdinandy.com> <xmqqr07d11wt.fsf@gitster.g>
In-reply-to: <xmqqr07d11wt.fsf@gitster.g>
Reporting-Meta:
 AAH5dsURVtkRltt7fHCtA9v9yRgPK8NK+EwGIdE3brWl3hpDY6A4kL5ri9dUovbX
 3xt0SWfdG2mB2IkGsF7KaUPDX+JhLMXbvVfp5zOUXcgr7fAq5BGV13dn+vywhwzJ
 zydPdqFvWKWL/qd3qFgy+y1cA/a+YjUArlqoiEu83p1zVuxhi4HHjNi8L77j6zqa
 TYSOeZoa2GUkgAWgZz4Sj5HiiYMc8jfW1oCsfvNltikkTwDVoZvn03wAvb+/dals
 yj5FLHMZDMbqsjOjl+UWm26P+owlOtr8VoJHIia4UA/R9l1V0kwY5/7OZidH4YGj
 RRgIZqmnwSJXYDIEvsYPQ53kiMubQA2q8JzLr163IkBFu/3QNNFvzlPJS1JLFzMp
 6ju4XvAVRMU/KXYdmeWKl7pA5cykqRDwP/cT9o2WO1o1m4t4Etom74YUdn0O2ymu
 8KVGFLTDN+16xBNfS9nkIPDcSDHX44ICqKzWt1+cnFp/1k16BlTHGbk=


On Fri Nov 15, 2024 at 06:50, Junio C Hamano <gitster@pobox.com> wrote:
> Bence Ferdinandy <bence@ferdinandy.com> writes:
>
>>  int refs_update_symref(struct ref_store *refs, const char *ref,
>>  		       const char *target, const char *logmsg)
>> +{
>> +	return refs_update_symref_extended(refs, ref, target, logmsg, NULL);
>> +}
>
> OK.  As the enhanced and renamed function is also external, we do
> not have to worry about reordering the old one to come after the new
> one.

I guess this also decides that the name "_extended" is fine :)

>
>> +int refs_update_symref_extended(struct ref_store *refs, const char *ref=
,
>> +		       const char *target, const char *logmsg,
>> +		       struct strbuf *referent)
>>  {
>>  	struct ref_transaction *transaction;
>>  	struct strbuf err =3D STRBUF_INIT;
>> @@ -2122,13 +2129,20 @@ int refs_update_symref(struct ref_store *refs, c=
onst char *ref,
>> =20
>>  	transaction =3D ref_store_transaction_begin(refs, &err);
>>  	if (!transaction ||
>> -	    ref_transaction_update(transaction, ref, NULL, NULL,
>> +		ref_transaction_update(transaction, ref, NULL, NULL,
>
> An unwanted patch noise?
>
>>  				   target, NULL, REF_NO_DEREF,
>>  				   logmsg, &err) ||
>> -	    ref_transaction_commit(transaction, &err)) {
>> +		ref_transaction_prepare(transaction, &err)) {
>
> Likewise, but the noise distracts from the real change made on this
> line, which is even worse.

Mea culpa, I'll get this cleaned up.

>
> The real change here is to only call _prepare(), which also asks the
> transaction hook if we are OK to proceed.  If we fail, we stop here
>
>>  		ret =3D error("%s", err.buf);
>> +		goto cleanup;
>
> This is also a real change.  We could instead make the additional
> code below into the else clause (see below).
>
>>  	}
>> +	if (referent)
>> +		refs_read_symbolic_ref(refs, ref, referent);
>
> And if we were asked to give the value of the symbolic ref, we make
> this call.  What should this code do when reading fails (I know it
> ignores, as written, but I am asking what it _should_ do)?

I think this should do _nothing_ if it fails (although should it stay this =
way,
I guess it should be marked with a comment that this is on purpose). My
reasoning is that running `git fetch` will be running this part of the code=
,
which means that should reading the symbolic ref fail for any reason, a `fe=
tch`
that previously ran without error would now fail. We now pass up an empty
string as the previous which does mask that there was an error here. What
I think we could maybe do is pass up a special string that means there was =
an
error? Something that for sure cannot be a valid value for an existing
reference? I'm not sure how much sense that makes.

>
>> +	if (ref_transaction_commit(transaction, &err))
>> +		ret =3D error("%s", err.buf);
>
> And then we commit, or we fail to commit.
>
>> +cleanup:
>
> We could write the whole thing as a single "do these and leave as
> soon as we see any failure" ||-cascade,
>
> 	if (!(transaction =3D ref_store_transaction_begin(refs, &err)) ||
>
> 	    ref_transaction_update(transaction, ref, NULL, NULL,
> 				   target, NULL, REF_NO_DEREF,
> 				   logmsg, &err) ||
>
> 	    ref_transaction_prepare(transaction, &err)) ||
>
> 	    (referent
> 	    ? refs_read_symbolic_ref(refs, ref, referent)
> 	    : 0) ||
>
> 	    ref_transaction_commit(transaction, &err)) {
> 		if (!err.len)
> 			... stuff default error message to err ...;
> 		ret =3D error("%s", err.buf);
> 	}
>
> which may not necessarily easier to follow (and in fact it is rather
> ugly), but at least, the resulting code does not have to special
> case the "optionally peek into the symref" step.

As I said above, I don't think we actually want to fail the update even if =
the
symbolic ref reading fails, so I think the special casing should stay. I'll
wait here to see more clearly on what to do here.


