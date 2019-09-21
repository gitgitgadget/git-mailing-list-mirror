Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86D481F463
	for <e@80x24.org>; Sat, 21 Sep 2019 12:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407619AbfIUMhZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Sep 2019 08:37:25 -0400
Received: from mout.web.de ([212.227.15.3]:52563 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407609AbfIUMhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Sep 2019 08:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569069439;
        bh=1fwwVPAXffuVehjvi3F/fIQQARO2jTrSJzsR/WtEkas=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OO481J4Cz0NjJX7uZxDrdqfwuqdyzkPbdEfx7zyN5LKvsOYGyiV/J3y/5fu8X7/Rc
         Rf510b/IUeoJaTdNhFV/T2DRUWCuq5mYCFw1KwapHJCFtD/uhxCagCtY/pvfC06PFq
         IggcXGo6IzdC8E6TdRBwAEzRjl2QGU+ZEueaK75o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MSazE-1ib3lq3yy4-00Rbra; Sat, 21
 Sep 2019 14:37:19 +0200
Subject: Re: [PATCH 08/15] name-rev: pull out deref handling from the
 recursion
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-9-szeder.dev@gmail.com>
 <5bf3b958-8c95-ae3d-1ae5-df3d57272d8c@web.de>
 <20190920181302.GA26402@szeder.dev> <20190920181407.GB26402@szeder.dev>
 <20190921095718.GA23203@szeder.dev>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a507bbd1-88cf-6668-908e-92978fb77930@web.de>
Date:   Sat, 21 Sep 2019 14:37:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190921095718.GA23203@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NbeOfkn0lGTlKs89olwADdE6bBkH4ndYoLkng4EQIKPKGfTE3Fx
 De/lBLW8CB3aEM4MgeAZJRKT2XPTuyBgg6NcD2b8zpWbDNO6kehF8rnk1NvMdyyPCr9wk9y
 Wa5Q6KpjqKob5ZksN5fPHluRvFrL3KBB3zP3AYoGJG7EoIAx04TuY4Gjr6X47nKom06b/tE
 3i7/VqCL+8ND78Cx+RfPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xGKnbmWpF4U=:ZyfV/K0oQX5JV0m/X06ort
 lWVOn2rq67qFQzW8SEBcVLbkaUd5jkQH4OIaR1j1ZV3YQ6WaV5EafeI5fic+P7mz6HBfahhK1
 7z8xnlO4/ivCY7WsFBlqrReOf09M2v6mdavklYloVwNy1D0G5a3WjC61S6Ea2YRAZpUP9Vu3v
 8VYzazi/4NeyAsugJaIKNQHvjPPCzRcm2oCh//GOsU5LyLDiWZZfOQ2OGrfJDjPxn7P1cNfiL
 uuMzbhnf+poiqsDEkDMq5je6baE+79MVjfdLv9kmeiiBWbnXiWMCx2HJuuejUXkeJgkPcdz/e
 B4n+99RtpXm2+8PcYMTXLLH0fSvtHmHklrD07YAdtDfd2M8+/EGiV9y8EUJlUPqT/nlm2Ws0E
 UzOBi03Ylhsw8d7Yj9TjU1Nj0EaIalvlIFRF6FkR9OzCt7Im1S8Xa68Bny8aGsXwraRJX7PwQ
 w4z/g1NU207FKp1SAg0MfxgtLNUi/w4te9DtKJoFOkU3Pt9LLE2YQUs5EA8bpp26scPpyO8kz
 +r3cuUrG/71hSqV+58KcBQyUFVDXKf+M72h3Oi/eIHf/jHTnI4mH7K5Sm6lyE42f9yBtHHTNI
 cFewArSp2vMsMPyUoXQKM1o8WorYllEuyE/RINV02oJvJpzAJSngq5Ca474mmimDyTDKqzdb6
 skECqhmdyw3DnDm3SRAehlTkU3rndYRE+bewcJFnUbmNAzWdKkrDpnV55mV920uk/eiiaICpI
 Ldo3TJwUSrJy6ah9aQ6wxSTJrDVd/OTu8K3alwoC8K3bJoNVC8OzdYqCxoQi6ZLFc+7V0XBqp
 NkOhKVWCNefKRBnRhvRY7G0I78Pu0uU4NipGI1+c9OE2qV1pdmVD3eSBgY/+HJ5IqeXuT/iDz
 hrIT/BA89UpgoF/kRsdHmJXwk2ehan3qhrWIEV3/Hh5VnD8WYKFpKyFFXQdZLZqkGfa3qjarc
 r119JUUsUmFdV/xHlQnX+PF6jIi2+ixAvG2elTXmc7wHAGXtq/zZKEPtWt4Nwogy4GSkNzfcO
 5ZyhNtVK+wMUc+aD+n2N1laO9wEnUNFPYw4STz+TKdM7/OQ3oVf97NZW7ipkjdhGeUcfo4oc0
 UNjThV2MwoZn6/UGTm7cSUlrNYJl97LIfLI0WP4kFxWpTXSOGeplXTWpu/u4t5SjxrHlAuURy
 A2MSzFyufy9hNxbV/gQouCw2WA1FbvVWvG7qJUEZVi+U3ZIQETI36J2drem2uh1uKOJm65OJR
 iFMJOyDyNLThdIXFXVHt78/w32altJi/qHoScVg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.09.19 um 11:57 schrieb SZEDER G=C3=A1bor:
> On Fri, Sep 20, 2019 at 08:14:07PM +0200, SZEDER G=C3=A1bor wrote:
>> On Fri, Sep 20, 2019 at 08:13:02PM +0200, SZEDER G=C3=A1bor wrote:
>>>> If the (re)introduced leak doesn't impact performance and memory
>>>> usage too much then duplicating tip_name again in name_rev() or
>>>> rather your new create_or_update_name() would likely make the
>>>> lifetimes of those string buffers easier to manage.
>>>
>>> Yeah, the easiest would be when each 'struct rev_name' in the commit
>>> slab would have its own 'tip_name' string, but that would result in
>>> a lot of duplicated strings and increased memory usage.
>>
>> I didn't measure how much more memory would be used, though.
>
> So, I tried the patch below to give each 'struct rev_name' instance
> its own copy of 'tip_name', and the memory usage of 'git name-rev
> --all' usually increased.
>
> The increase depends on how many merges and how many refs there are
> compared to the number of commits: the fewer merges and refs, the
> higher the more the memory usage increased:
>
>   linux:         +4.8%
>   gcc:           +7.2%
>   gecko-dev:     +9.2%
>   webkit:       +12.4%
>   llvm-project: +19.0%

Is that the overall memory usage or just for struct rev_name instances
and tip_name strings?  And how much is that in absolute terms?  (Perhaps
it's worth it to get the memory ownership question off the table at
least during the transformation to iterative processing.)

> git.git is the exception with its unusually high number of merge
> commits (about 25%), and the memory usage decresed by 4.4%.

Interesting.

I wonder why regular commits even need a struct name_rev.  Shouldn't
only tips and roots need ones?  And perhaps merges and occasional
regular "checkpoint" commits, to avoid too many duplicate traversals.

That's not exactly on-topic, though, and I didn't think all that
deeply about it, but perhaps switching to a different marking
strategy could get rid of recursion as a side-effect?  *waves hands
vaguely*

>
>
>  --- >8 ---
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index 6969af76c4..62ab78242b 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -88,6 +88,7 @@ static struct rev_name *create_or_update_name(struct c=
ommit *commit,
>  		set_commit_rev_name(commit, name);
>  		goto copy_data;
>  	} else if (is_better_name(name, taggerdate, distance, from_tag)) {
> +		free((char*) name->tip_name);
>  copy_data:
>  		name->tip_name =3D tip_name;

I would have expected a xstrdup() call here.

>  		name->taggerdate =3D taggerdate;
> @@ -106,21 +107,19 @@ static void name_rev(struct commit *start_commit,
>  {
>  	struct commit_list *list =3D NULL;
>  	const char *tip_name;
> -	char *to_free =3D NULL;
>
>  	parse_commit(start_commit);
>  	if (start_commit->date < cutoff)
>  		return;
>
>  	if (deref) {
> -		tip_name =3D to_free =3D xstrfmt("%s^0", start_tip_name);
> -		free((char*) start_tip_name);
> +		tip_name =3D xstrfmt("%s^0", start_tip_name);
>  	} else
> -		tip_name =3D start_tip_name;
> +		tip_name =3D strdup(start_tip_name);

This would not be needed with the central xstrdup() call mentioned above.

>
>  	if (!create_or_update_name(start_commit, tip_name, taggerdate, 0, 0,
>  				   from_tag)) {
> -		free(to_free);
> +		free((char*) tip_name);
>  		return;
>  	}
>
> @@ -139,7 +138,6 @@ static void name_rev(struct commit *start_commit,
>  			struct commit *parent =3D parents->item;
>  			const char *new_name;
>  			int generation, distance;
> -			const char *new_name_to_free =3D NULL;
>
>  			parse_commit(parent);
>  			if (parent->date < cutoff)
> @@ -159,11 +157,10 @@ static void name_rev(struct commit *start_commit,
>  					new_name =3D xstrfmt("%.*s^%d", (int)len,
>  							   name->tip_name,
>  							   parent_number);
> -				new_name_to_free =3D new_name;
>  				generation =3D 0;
>  				distance =3D name->distance + MERGE_TRAVERSAL_WEIGHT;
>  			} else {
> -				new_name =3D name->tip_name;
> +				new_name =3D strdup(name->tip_name);

... and neither would this.

Sure the xstrfmt() result would be duplicated instead of being reused, but
that doesn't increase memory usage overall.

>  				generation =3D name->generation + 1;
>  				distance =3D name->distance + 1;
>  			}
> @@ -174,7 +171,7 @@ static void name_rev(struct commit *start_commit,
>  				last_new_parent =3D commit_list_append(parent,
>  						  last_new_parent);
>  			else
> -				free((char*) new_name_to_free);
> +				free((char*) new_name);
>  		}
>
>  		*last_new_parent =3D list;
> @@ -313,7 +310,7 @@ static int name_ref(const char *path, const struct o=
bject_id *oid, int flags, vo
>  		if (taggerdate =3D=3D TIME_MAX)
>  			taggerdate =3D commit->date;
>  		path =3D name_ref_abbrev(path, can_abbreviate_output);
> -		name_rev(commit, xstrdup(path), taggerdate, from_tag, deref);
> +		name_rev(commit, path, taggerdate, from_tag, deref);
>  	}
>  	return 0;
>  }
>
