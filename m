From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Dealing with an upstream cherry-picked branch
Date: Tue, 16 Mar 2010 13:38:31 -0400
Message-ID: <76718491003161038u3dc567a7pb0ae558fd3b6b9c9@mail.gmail.com>
References: <76718491003142117w4fd10449j51deef27548c4d2e@mail.gmail.com>
	 <7vocipjmrg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 18:42:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nramg-00031U-FN
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 18:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759919Ab0CPRmK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Mar 2010 13:42:10 -0400
Received: from mail-px0-f198.google.com ([209.85.216.198]:55248 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939Ab0CPRmI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Mar 2010 13:42:08 -0400
Received: by pxi36 with SMTP id 36so122141pxi.21
        for <git@vger.kernel.org>; Tue, 16 Mar 2010 10:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=umkUQGuKy6i4OEvmUboVRsESifboAS8No3Nna9W21Fg=;
        b=U2KV34qXegUFipEPab3F0nKf6mwo+SBCGs7Q91ipyPjtE1lIDNbf44AuEu+ZOnl3nI
         OlHp3R3LB91d09F0CLrPXfrx+UHJWkzn0tFEdUhb92u7zh1Yhwits4vXsYqJwHTrgJTA
         L6Ia7Ke9dIfsVwpJE9u/aWQUt6pxpDYCEKiP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OJew5hHeuV/3YclWONja0xtiW6ZaxEE0F0VZBi33YBMDn0xjuVJJQC6beIy2i9ju4H
         81MRWudygavXXbFEkcCHiFrM2WzumLGJq7RI2S5TissIYLu9fhXsAfh/Z6BySgFCwY3w
         /L0ItzvDpMWPqh5lhD/HSegjl6KFgOaGaw7SU=
Received: by 10.141.23.13 with SMTP id a13mr13826rvj.209.1268761111765; Tue, 
	16 Mar 2010 10:38:31 -0700 (PDT)
In-Reply-To: <7vocipjmrg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142343>

On Mon, Mar 15, 2010 at 5:30 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> I have the following scenario:
>>
>> =C2=A0 o---o---Ma---o---o =C2=A0 =C2=A0local-master
>> =C2=A0/ =C2=A0 =C2=A0 =C2=A0 /
>> | =C2=A0 =C2=A0 =C2=A0 | .-b'------d' =C2=A0upstream-a
>> | =C2=A0 =C2=A0 =C2=A0 |/ =C2=A0: =C2=A0 =C2=A0 =C2=A0 :
>> o---o---a---b---c---d =C2=A0 upstream-master
>>
>> Local-master branched from upstream-master in distant past.
>> upstream-master periodically cuts tentative release branch upstream-=
a.
>> When they do this, that branch point (a) is merged into local-master
>> (Ma).
>>
>> Over time, upstream applies fixes to upstream-a, but does so by
>> committing the fixes to upstream-master and then cherry-picking them
>> to upstream-a.
>>
>> The question is how to best integrate the fixes on upstream-a into
>> local-master, w/o causing a headache when upstream cuts the next
>> tentative release branch, at which point upstrea-master will again
>> need to be merged into local-master (and that will also have other
>> local development). Here are two options I've considered:
>
> Is it an option not to treat "local-master" as anything but a throw-a=
way
> integration testing branch?

Our development is currently very fast paced among a smallish group of
developers, and so far the developers really prefer to all work on the
same branch (i.e, not use topic branches). So they are constantly
pushing their changes to local-master. However, I don't think that
precludes an integration branch if I just squint at your picture
below...

> Presumably upstream-master would be a stable, non-rewinding branch, a=
nd
> when they branch for their next release (i.e. at point 'a' in the
> picture), you should be able to trust up to that commit. =C2=A0So you=
 would
> arrange topics on your side to be based on commits before 'a', and ne=
ver
> let your people fork from or build directly on local-master.
>
> Rebuild local-master every time you would want to run integration tes=
ting
> with the recent upstream changes, either by starting the throw-away
> local-master at upstream-master or upstream-a depending on what
> development phase the upstream is in and what the targetted base for =
your
> own release, and merging your topics you intend to ship into it.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0your to=
pics branch from local-base, which was forked
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from th=
e last known stable point of the upstream.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
/ =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 \ =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 \ =C2=A0 \ =C2=A0merge topics for integr=
ation testing
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 \ =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...---o local-base =C2=A0x---x---x=
 local-master (throw-away)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /
> =C2=A0 =C2=A0---o---o---a---b----c----d
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0upstream-master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b'--c'--d'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 upstream-a
>
> To keep track of the set of topics you know you may want to include i=
n the
> upcoming release, you could also merge "well cooked" topics into
> local-base so that your people can build on top of other topics and t=
est
> them together.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0your to=
pics branch from (and possibly
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0merge i=
nto) local-base
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
/ \ =C2=A0 \ =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / =C2=A0=
 \ =C2=A0 x---x---x---x local-master (throw-away)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/ =C2=A0=
 =C2=A0 \ / =C2=A0 \
> =C2=A0local-base ..---o---o---o =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 /
> =C2=A0 =C2=A0---o---o---a---b---c---d
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0upstream-master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b'--c'--d'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 upstream-a

By squinting, I can pretend that all the developers pushes to
local-master are mini "well cooked" topics. And I can call my
throw-away branch something like, oh say, "next". So I will have this
picture:

                 developer pushes
                         / \
                    -----   \
                   /   / \   \
local-master ..---o---o---o---o ...    local-master
                 / \       \   \
                /   `---o---o---o---o  next
               /       /           /
       ---o---a---b---c---d---e---f upstream-master
               \
                b'--c'--d' upstream-a


The merges from upstream-master to next will happen at well-defined
times by an integration manager. The merges from local-master to next
will be done by developers themselves to give them exposure to what is
happening upstream-master.

But, it's not clear how that helps me with upstream-a, unless I also
have a "local-a" branch:

local-master ..---o---o---o---o ...    local-master
                 / \       \   \
                /   `---o---o---o---o  local-a
               /       /           /
       ---o---a---b'--c'----------d'   upstream-a


But now I'm asking for developers to:

a) commit changes to local-master
b) merge to next
c) merge to local-a

> Again, when running integration testing with the recent upstream, you=
 can
> rebuild your throw-away local-master at the tip of local-base, and me=
rge
> either upstream-master or upstream-a to make sure your changes work w=
ith
> them.
>
> Individual developers can do the same when testing their own topics i=
n
> isolation, together with recent upstream, using their own throw-away
> testing branches that merge their topic and recent upstream.

I think I'm not clear how it helps to make the integration branch
throw-away. Unless you mean something like git pu?

Let's assume I want the developers to have the benefit of seeing
what's in upstream-a and upstream-master. Let's also assume the merges
from upstream-master are typically non-trivial. If "next" in my
picture above is something each developer creates themselves, then
there is no way to share merge resolutions. That would be painful.

j.
