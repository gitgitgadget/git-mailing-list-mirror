Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD261F9EA0
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729013138; cv=none; b=kfXtt22qfUZ/4g4JYNwCCnxIeGqJTQ+k235qGeHkYk+1M8p/oQU3Kvw487y+SdADLT7560kLuXy4SxESwU9ODSR+akA3aJxUuJivLpvFKOmczm5D8Mjv8r2mhDdNRXIOXaY6p6gLWJLmKM69umYlS3qYJhc1A0DCB4tAJBUpTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729013138; c=relaxed/simple;
	bh=Qji/cellt3t+uC5GH8w4GjkkXF5uc1Ws6ews5i6dmwY=;
	h=MIME-version:Content-type:Date:Message-id:From:Subject:Cc:To:
	 References:In-reply-to; b=B6DCxdRSMorO8lnYOxHjPJf2SuDMER8ZyZ4rMszM1j8wHaZvsV33sjKUOxqn51DPN/bAmDrgCjAVAbrx5qPQJG3lY+s7oyEf0tgSIjZjCzPYyxEjkFyVJtukD23eTzoPGkGDkJs/Hvcza6NA72/n4Og3vjZULZL9IyLKOe1jQuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=cY/qdj0M; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="cY/qdj0M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=Aqg6ep62GLtqZt+p7bBTdWPVNOWgr7OGXwIbLVSPtBY=;
 b=cY/qdj0M10+p9Ec30qbszcXAnigVQ5tYlHli7myaV4iGItMsNYsNhFqzX6DuSUz4/mV8Wm0BZJ19
   /SuRnydqwmLchryyCzvVZkGygAgXilIix7u0vpWlf+CFelJPIa2eciYWPN8oBt0zgAQ8jcBAEeld
   kIxxPj+jj2LBQ4aYBOXut6M13SWR02xL7V01eAbbt9qiiLmlExHHQXydteM+kGDU1V+2sZhCMS7v
   QszdbcQPx/Zb49U8PgfheFeahDFokD/VCWVfJTmuOstH/xAQLuDzMkX377fkaeLwnOauHKIFkZOP
   Csd92bAcF7PM+K7SqdVlLSPE5WStVshe2aIjaw==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLE00KIRR2M4E20@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 15 Oct 2024 17:25:34 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Tue, 15 Oct 2024 19:25:14 +0200
Message-id: <D4WJZVALZYZ6.1FR78333KZBAL@ferdinandy.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: [PATCH v7 1/6] refs: atomically record overwritten ref in
 update_symref
Cc: "Taylor Blau" <me@ttaylorr.com>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>
To: <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>
References: <20241010133022.1733542-1-bence@ferdinandy.com>
 <20241012230428.3259229-1-bence@ferdinandy.com>
 <3c848f10-ac14-4cd7-8fbe-868da9599244@gmail.com>
 <D4UZTVHXXL1X.2KBQI9FYTAU72@ferdinandy.com>
 <a7cb48e5-d8ba-44c1-9dbe-d1e8f8a63e3c@gmail.com>
In-reply-to: <a7cb48e5-d8ba-44c1-9dbe-d1e8f8a63e3c@gmail.com>
Reporting-Meta:
 AAFCPtQWsvrvBUFHjZYINY6vpOcMsYrCgOcwz+OOugXhI2ID3H3c4Vtnzt5NeJR/
 kU9z0bg6ORCrC1GUIBO1MM89+AoyL5MyAbSRFbJvQMT3wBg33+Y2vXVhCbVcAs1X
 GTLTxCaPCrPf2rWIgQ/6TN2ZTmMH9Yo6mk/x+7kDUBeSRFazIUUvTWv9C34EXACa
 kBY/DjaLqKbeG+wIVNdQo2mSmuCbL1vmN4ywjfzMlguYCbBdwtabIAnKD71nszTV
 ownYBYNTfXG4XgucS1K8aHtiHSnacFljero9bylh26+PsWh5ZKxaUT8e45AsYiIA
 wRBaljJGPM22+6ST0d8+U8PEJ2OfwQsEFd8LcmYMMDnvZ50xcmW9kR/w5tiCLAbw
 MGILImpzmAJjdprSLrp9IMd6CukUcYuBAK3tlXL44fdCmRCv/gO4hmcy2Ebnxzxy
 88pbTMK7hAN/yjrNSpGHkWQVFxK0kXcTfrIjcjmEdHjPU+KFPYId1EI7


On Tue Oct 15, 2024 at 16:05, Phillip Wood <phillip.wood123@gmail.com> wrot=
e:
> Hi Bence
>
> On 13/10/2024 22:24, Bence Ferdinandy wrote:
>>=20
>> On Sun Oct 13, 2024 at 15:52, Phillip Wood <phillip.wood123@gmail.com> w=
rote:
>>> On 13/10/2024 00:03, Bence Ferdinandy wrote:
>>>> Record the value after the
>>>> ref has been locked if the caller of refs_update_symref requests it vi=
a
>>>> a new variable in the function call.
>>>
>>> To me this patch and patch 5 feel quite disruptive to all the existing
>>> callers which don't need this specialized functionality. I think it
>>> would be less disruptive over all if you used a ref transaction rather
>>> than calling refs_update_symref() in the final patch. That would enable
>>> us to keep the simpler interface for refs_update_symref().
>>=20
>> The extra parameter introduced here is actually used in two places by th=
e end
>> of the series, in remote set-head and fetch (of course you could make a =
similar
>> argument for the functionality added in 5/6 which is only used in fetch =
by the
>> final patch). To avoid code duplication I think even if we did not touch
>> refs_update_symref() it would make sense to create
>> a "refs_update_symref_extended()" and make refs_update_symref() a wrappe=
r
>> around that with a few less parameters. That would be similar to how
>> refs_update_symref() and refs_update_ref() predetermine a couple of para=
meters
>> to say transaction_update().
>>=20
>> Currently there are 15 calls to refs_update_symref() in total, of these
>> 5 do not use the complete functionality of the function (they pass NULL =
as
>> logmsg), so the current implementation would not be completely unprecede=
nted.
>
> As those figures show it's pretty unusual not to pass a reflog message=20
> when updating a ref, on the other hand it is very unusual to want the=20
> old value so I don't think the two are comparable. At a high level the=20
> two callers that want to be able to check the old value are both doing=20
> essentially the same thing so can we create a specialized function that=
=20
> encapsulates the functionality needed by --set-head and uses a ref=20
> transaction?

Ok, so let's not change the signature of refs_update_symref(). On the other
hand the best approach here is still not quite clear to me. As it is now, t=
he
series added two extra parameters to refs_update_symref(), the referent and=
 the
create_only option. Obviously any new function would also take all the
parameters refs_update_symref takes. Should I rename the current (v8)
refs_update_symref to something else (name suggestion would be welcome,
refs_update_symref_extended?, refs_update_symref_check_current? checking th=
e
currently existing symref is the common theme for the two new parameters) a=
nd
leave refs_update_symref as it is? Or is this really about just not having =
to
change all the already existing callers? Because in that case I'd just wrap=
 the
new function, something like

int refs_update_symref(struct ref_store *refs, const char *ref,
		       const char *target, const char *logmsg)
=09
	return refs_update_symref_extended(*refs, *ref, *target, *logmsg, NULL, 0)=
;

Let me know what you think, I'll hold off on a v9 until I see more clearly =
here
on what would be preferred.

>
>> (This tally did make me catch an error on my side: the logmsg in fetch's
>> set_head should be "fetch" not "remote set-head", I'll fix that in a v8)=
.
>>=20
>> Imho, even if I manage to come up with a better name than
>> "refs_update_symref_extended()" wouldn't it be more confusing to have tw=
o ways
>> to update symrefs via a function call, rather than have one, where _usua=
lly_
>> you pass two NULL-s at the end?
>>=20
>>>
>>> I'm also not sure about the proposed interface I would have thought it
>>> would be simpler to take a "char**" rather than an "struct strbuf*" if
>>> we do decide that it is useful for callers of refs_update_symref() to
>>> query the old value.
>>=20
>> refs_read_symbolic_ref requires a strbuf, so one would need to be create=
d
>> anyway and I also sort of got the feeling that the project likes to hand=
le refs
>> in strbufs (which may be wrong). Are there any downsides I'm not seeing?
>
> It's true that refs_read_symbolic_ref takes and strbuf. I'd argue that's=
=20
> a mistake for a function that is just returning a string in an "out"=20
> parameter as I think it is more continent for the caller not to have to=
=20
> initialize an strbuf just to retrieve the target of a symbolic ref. I=20
> alse think that it is inconsistent with functions like=20
> refs_resolve_refdup() that return a string.

Ok, I'll change this to use **char. On the other hand, if
refs_read_symbolic_ref is inconsistent would it make sense to change it to =
also
use a **char instead of strbuf? There's only four calls to it including the=
 one
I just added. Although I might rather do that _after_ this series is resolv=
ed :)

Thanks (to everyone) for your time!

Best,
Bence


--=20
bence.ferdinandy.com

