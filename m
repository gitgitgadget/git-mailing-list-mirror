From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 3/3] push: add 'prune' option
Date: Wed, 22 Feb 2012 22:43:05 +0200
Message-ID: <CAMP44s3+XCM1E_AtW1yGifmGoGSkFSpSTaFbbMffz+hmUzWahw@mail.gmail.com>
References: <1329505957-24595-1-git-send-email-felipe.contreras@gmail.com>
	<1329505957-24595-4-git-send-email-felipe.contreras@gmail.com>
	<7vobsxqebz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 21:43:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0J1v-0001DL-2v
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 21:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876Ab2BVUnJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 15:43:09 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:36948 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753865Ab2BVUnH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 15:43:07 -0500
Received: by lagu2 with SMTP id u2so515447lag.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 12:43:06 -0800 (PST)
Received-SPF: pass (google.com: domain of felipe.contreras@gmail.com designates 10.152.123.68 as permitted sender) client-ip=10.152.123.68;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of felipe.contreras@gmail.com designates 10.152.123.68 as permitted sender) smtp.mail=felipe.contreras@gmail.com; dkim=pass header.i=felipe.contreras@gmail.com
Received: from mr.google.com ([10.152.123.68])
        by 10.152.123.68 with SMTP id ly4mr23962073lab.13.1329943386095 (num_hops = 1);
        Wed, 22 Feb 2012 12:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=dlTZ/1edm6eh0ZErWgytP3eSo2BhTmfhM68zD8jzMMc=;
        b=nG6r7RC7q5UmnNtRrgJR9FiZVHWALV21ssUVzNA9avCMtcP1sPxJToYvB4/om/RCbQ
         xGBQnC0OzgGeYHUV6aAlsy3YMrBGmvBXCQyh7KhcIpW9UQrcXR2vyU4EAvW2ib9q7KZw
         YBcfaDTnxvnFuLwJ1hgG7edi11xbTIeSnN+kI=
Received: by 10.152.123.68 with SMTP id ly4mr20115163lab.13.1329943385981;
 Wed, 22 Feb 2012 12:43:05 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Wed, 22 Feb 2012 12:43:05 -0800 (PST)
In-Reply-To: <7vobsxqebz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191284>

On Sat, Feb 18, 2012 at 12:34 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> This will allow us to remove refs from the remote that have been rem=
oved
>> locally.
>
> Can you enhance this a bit more to summarize the gist of what the sem=
antic
> of this new feature is, perhaps like this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0After pushing refs, "git push --prune" wil=
l remove refs from the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0remote that existed before the push and wo=
uld have been pushed
> =C2=A0 =C2=A0 =C2=A0 =C2=A0from us if we had some local refs that wou=
ld have matched the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0refspecs used. =C2=A0For example,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ git push --prune remote refs/hea=
ds/*:refs/remotes/repo1/*
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0will push all local branches in our reposi=
tory to refs with
> =C2=A0 =C2=A0 =C2=A0 =C2=A0corresponding names under refs/remotes/rep=
o1/ at the remote, and
> =C2=A0 =C2=A0 =C2=A0 =C2=A0removes remote's refs in refs/remotes/repo=
1/ that no longer have
> =C2=A0 =C2=A0 =C2=A0 =C2=A0corresponding local branches in our reposi=
tory. =C2=A0The refs at the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0remote outside refs/remotes/repo1/ are not=
 affected.
>
> In order to alley the worries raised in the previous discussion, some=
thing
> to the effect of the last sentence above is crucial to have, I would =
think.

OK.

>> --- a/builtin/push.c
>> +++ b/builtin/push.c
>> @@ -261,6 +261,8 @@ int cmd_push(int argc, const char **argv, const =
char *prefix)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_BIT('u', "set-u=
pstream", &flags, "set upstream for git pull/status",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 TRANSPORT_PUSH_SET_UPSTREAM),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_BOOLEAN(0, "pro=
gress", &progress, "force progress reporting"),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_BIT('p', "prune", &f=
lags, "prune locally removed refs",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 TRANSPORT_PUSH_PRUNE),
>
> Please refrain from squatting on a short-and-sweet one letter option
> before this new feature proves to be popular and useful in a few cycl=
es,
> especially when there already is a long option that begins with 'p'.

OK.

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_END()
>> =C2=A0 =C2=A0 =C2=A0 };
>>
>> diff --git a/remote.c b/remote.c
>> index 019aafc..0900bb5 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -1111,7 +1111,7 @@ static int match_explicit_refs(struct ref *src=
, struct ref *dst,
>> =C2=A0}
>>
>> =C2=A0static char *check_pattern_match(const struct refspec *rs, int=
 rs_nr, struct ref *ref,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int send_mirror, const s=
truct refspec **ret_pat)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int send_mirror, int dir=
, const struct refspec **ret_pat)
>
> Can we name this a bit better? =C2=A0I first thought "Huh? directory?=
", and had
> to scratch my head, wondering if it is an offset into refs/heads/* st=
ring
> or something....

OK.

>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 const struct refspec *pat;
>> =C2=A0 =C2=A0 =C2=A0 char *name;
>> @@ -1126,7 +1126,12 @@ static char *check_pattern_match(const struct=
 refspec *rs, int rs_nr, struct ref
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rs[i].pattern) =
{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 const char *dst_side =3D rs[i].dst ? rs[i].dst : rs[i].src;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (match_name_with_pattern(rs[i].src, ref->name, dst_side, &name))=
 {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 int match;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (dir =3D=3D 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 match =3D match_name_with_pattern(rs[i]=
=2Esrc, ref->name, dst_side, &name);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 match =3D match_name_with_pattern(dst_s=
ide, ref->name, rs[i].src, &name);
>
> ....until the code told us that it is some sort of direction of the
> matching. =C2=A0A symbolic constant or two would be even better.
>
> Originally this funcion was fed a list of refs in the source (i.e. on=
 our
> end, as this is only used in 'push') and matched them against the sou=
rce
> side of the refspec, rs[i].src, to see under what name the destinatio=
n
> side will store it (i.e. give dst_side as value to find out the resul=
t in
> &name). =C2=A0This patch adds a new caller, who feeds a list of refs =
in the
> destination (i.e. on the remote end) to find out how they map to the =
names
> on our end (i.e. source). =C2=A0So "direction" is not necessarily inc=
orrect; it
> is the direction this function maps the names (either src-to-dst for =
the
> original caller, or dst-to-src for the new caller).
>
> Perhaps "enum map_direction { SRC_TO_DST, DST_TO_SRC }" or something?

I think only FROM_SRC, FROM_DST is more than enough to figure it out.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (match) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 matching_refs =3D i;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
>
> So what is the updated semantics of this function? =C2=A0Is it still
> appropriate to name it "check_pattern_match()"?
>
> It seems that by now this does a lot more than just "check if a patte=
rn
> matches". =C2=A0Since your patch 2/3, it is a function that finds out=
 the
> refname in the remote that the given one refspec would try to update,=
 and
> with this patch, it can also map in the reverse direction, given the =
list
> of remote refs, finding out which local ref a refspec would use to up=
date
> them.
>
> At the same time, to reduce risk of future breakage, we probably shou=
ld
> rename this function to make it clear that this function is to be onl=
y
> used by the push side.
>
> Perhaps rename this to "map_push_refs()" or something in the patch 2/=
3?

I think get_ref_match() would be more appropriate because we are
acting on a specific (singular) ref, and the primary thing we care
about is getting the peer name, based on the refspec match, which we
might want as a return value.

>> @@ -1173,6 +1178,7 @@ int match_push_refs(struct ref *src, struct re=
f **dst,
>> =C2=A0 =C2=A0 =C2=A0 struct refspec *rs;
>> =C2=A0 =C2=A0 =C2=A0 int send_all =3D flags & MATCH_REFS_ALL;
>> =C2=A0 =C2=A0 =C2=A0 int send_mirror =3D flags & MATCH_REFS_MIRROR;
>> + =C2=A0 =C2=A0 int send_prune =3D flags & MATCH_REFS_PRUNE;
>> =C2=A0 =C2=A0 =C2=A0 int errs;
>> =C2=A0 =C2=A0 =C2=A0 static const char *default_refspec[] =3D { ":",=
 NULL };
>> =C2=A0 =C2=A0 =C2=A0 struct ref *ref, **dst_tail =3D tail_ref(dst);
>> @@ -1193,7 +1199,7 @@ int match_push_refs(struct ref *src, struct re=
f **dst,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ref->peer_ref)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 continue;
>>
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dst_name =3D check_patte=
rn_match(rs, nr_refspec, ref, send_mirror, &pat);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dst_name =3D check_patte=
rn_match(rs, nr_refspec, ref, send_mirror, 0, &pat);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!dst_name)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 continue;
>>
>> @@ -1220,6 +1226,23 @@ int match_push_refs(struct ref *src, struct r=
ef **dst,
>> =C2=A0 =C2=A0 =C2=A0 free_name:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(dst_name);
>> =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 if (send_prune) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* check for missing ref=
s on the remote */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (ref =3D *dst; ref; =
ref =3D ref->next) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 char *src_name;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (ref->peer_ref)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* We're already sending something to t=
his ref. */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 src_name =3D check_pattern_match(rs, nr_refspec, ref, send_mirror, =
1, NULL);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (src_name) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!find_ref_by_name(src, src_name))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ref->peer_r=
ef =3D try_explicit_object_name("");
>
> Yuck. =C2=A0You do not want it to "try" as its name says. =C2=A0You j=
ust want to
> trigger its "delete" codepath.
>
> Please extract the body of "if (!*name) { ... }" block out of that
> function into a separate helper function, i.e.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0static struct ref *deleted_ref(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ref *re=
f =3D alloc_ref("(delete)");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hashclr(ref->n=
ew_sha1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ref;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> then update try_explicit_...() to call it, and call the same helper h=
ere.
>
> This is not for runtime efficiency; feeding a constant to a function =
that
> says try_foo() or check_bar() that makes decision on the parameter on=
ly to
> trigger a partial codepath hurts readability.

All right.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(src_name);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 if (errs)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> diff --git a/remote.h b/remote.h
>> index b395598..341142c 100644
>> --- a/remote.h
>> +++ b/remote.h
>> @@ -145,7 +145,8 @@ int branch_merge_matches(struct branch *, int n,=
 const char *);
>> =C2=A0enum match_refs_flags {
>> =C2=A0 =C2=A0 =C2=A0 MATCH_REFS_NONE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 0,
>> =C2=A0 =C2=A0 =C2=A0 MATCH_REFS_ALL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D (1 << 0),
>> - =C2=A0 =C2=A0 MATCH_REFS_MIRROR =C2=A0 =C2=A0 =C2=A0 =3D (1 << 1)
>> + =C2=A0 =C2=A0 MATCH_REFS_MIRROR =C2=A0 =C2=A0 =C2=A0 =3D (1 << 1),
>> + =C2=A0 =C2=A0 MATCH_REFS_PRUNE =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D (1 <=
< 2),
>> =C2=A0};
>>
>> =C2=A0/* Reporting of tracking info */
>> diff --git a/transport.c b/transport.c
>> index cac0c06..c20267c 100644
>> --- a/transport.c
>> +++ b/transport.c
>> @@ -1028,6 +1028,8 @@ int transport_push(struct transport *transport=
,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 match_flags |=3D MATCH_REFS_ALL;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (flags & TRANSPO=
RT_PUSH_MIRROR)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 match_flags |=3D MATCH_REFS_MIRROR;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (flags & TRANSPORT_PU=
SH_PRUNE)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 match_flags |=3D MATCH_REFS_PRUNE;
>
> Does it make sense to specify --prune when --mirror is in effect? =C2=
=A0If so,
> how would it behave differently from a vanilla --mirror? =C2=A0If not=
, should
> it be detected as an error?

Probably doesn't make sense, should be an error.

> I couldn't infer from the context shown in the patch, but how in gene=
ral
> does this new feature interact with the codepath for --mirror?
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (match_push_refs=
(local_refs, &remote_refs,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 refspec_nr, refspec, =
match_flags)) {
>> diff --git a/transport.h b/transport.h
>> index 059b330..5d30328 100644
>> --- a/transport.h
>> +++ b/transport.h
>> @@ -101,6 +101,7 @@ struct transport {
>> =C2=A0#define TRANSPORT_PUSH_MIRROR 8
>> =C2=A0#define TRANSPORT_PUSH_PORCELAIN 16
>> =C2=A0#define TRANSPORT_PUSH_SET_UPSTREAM 32
>> +#define TRANSPORT_PUSH_PRUNE 64
>> =C2=A0#define TRANSPORT_RECURSE_SUBMODULES_CHECK 64
>
> Hrm...?

Probably some rebase mistake =3D/

Cheers.

--=20
=46elipe Contreras
