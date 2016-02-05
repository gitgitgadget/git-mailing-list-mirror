From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/8] pack-objects: produce a stable pack when --skip is given
Date: Sat, 6 Feb 2016 06:25:56 +0700
Message-ID: <CACsJy8CkQPX4zqW39gpODSkU+habM7TGTJ85MU-S0UuNPk9SCw@mail.gmail.com>
References: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
 <1454662677-15137-3-git-send-email-pclouds@gmail.com> <xmqq1t8rdmky.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 00:26:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRplo-0003Ra-9Y
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 00:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbcBEX02 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 18:26:28 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33523 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbcBEX01 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2016 18:26:27 -0500
Received: by mail-lb0-f171.google.com with SMTP id x4so58824407lbm.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 15:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=TfWh3NHB21nipql1GvFaaRUTIZcGfNqkZcSfNb3pDO0=;
        b=OKPVaoAcGsEnxeQEgg+MueeZB/cQbW9hqqVeJ6l85Nv26+XjXOcgTRWxEUf44NPFAP
         Y4yWHq+awToSmfEfqiR9uEGhk0j1GXlatHufQWlv1nljPwAwfWAkofVTwinBgJf5cXtq
         +3i7c554Yy8x7SoHzN9UNWpsS3LdaZ1DjNsL+tf67YtUADTDas6b77FakhllJSiEPYj+
         bbDH1xXjsAJzkqq6tJvjOVTcdFM5+idSoUe97Ayj+Q7WIkNQzH3fBAmIzRKNOJyi9nnR
         p00vSnWXmBQUwHDGJfeqFJ/Dev5ze5lGRPzWqPC0Sb6vukt7s9GU1sfZMFsVF9TXg3oF
         UFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=TfWh3NHB21nipql1GvFaaRUTIZcGfNqkZcSfNb3pDO0=;
        b=TPynNISFXrviGDecF93vGi5FbHxKJAoVDqfeWRTPz9q+jlCn+1ktCzRMVMEO2moan6
         7ZY61Fp3+bToHzW38uojFgolmpLnK5l+j73B1h36IP0K3RBXFo9+MDZiPjceiIW/BMTQ
         SpLyAaTJym0Na+iACAcTve2wTUxeTwlLkPJzDsBfxz+cQ+D5h0lsPCVm2P85M4H0avzI
         F4bfhAUwrxnN+flp8Vmw6smQEupoimicIyzVJoxp+nAYrCB+InPYgYpQo0lgBSyWsYac
         S9z3eZwQzGfYUQfZ/cX20L+ik2YZhHmtrDOMcgO3CSkcS1ujm6bozyd1dgX/+1+QSLqy
         +rww==
X-Gm-Message-State: AG10YOQS7SeOXK/ZgzpidQsegU0GZFCHovEXwNAVKBjyrIcYv1geYRr+2tZ8lZD6Vky6dqZzlL9KNFIK+z1fow==
X-Received: by 10.112.64.42 with SMTP id l10mr7066471lbs.137.1454714785900;
 Fri, 05 Feb 2016 15:26:25 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Fri, 5 Feb 2016 15:25:56 -0800 (PST)
In-Reply-To: <xmqq1t8rdmky.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285652>

On Sat, Feb 6, 2016 at 1:43 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> index 417c830..c58a9cb 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -2709,6 +2709,11 @@ int cmd_pack_objects(int argc, const char **a=
rgv, const char *prefix)
>>                       if (get_oid_hex(skip_hash_hex, &skip_hash))
>>                               die(_("%s is not SHA-1"), skip_hash_he=
x);
>>               }
>> +
>> +             /*
>> +              * Parallel delta search can't produce stable packs.
>> +              */
>> +             delta_search_threads =3D 1;
>>       }
>>
>>       argv_array_push(&rp, "pack-objects");
>
> A multi-threaded packing is _one_ source of regenerating the same
> pack for the same set of objects, but we shouldn't be tying our
> hands by promising it will forever be the _only_ source of it by
> doing things like this.  We may want to dynamically tweak the
> packing behaviour depending on the load of the minute and such for
> example.

You noticed that tying the behavior only happens when the user asks
for it, right? I don't expect people to do resumable fetch/clone by
default. There are tradeoffs to make and they decide it, we offer
options. So, it does not really tie our hands in the normal case.

> I think a more sensible approach for "resuming" is to attack cloning
> first.  Take a reasonable baseline snapshot periodically (depending
> on the activity level of the project, the interval may span between
> 12 hours to 2 weeks and you would want to make it configurable) to
> create a bundle, teach "clone" to check the bundle first and perform
> a resumable and bulk transfer for the stable part of the history
> (e.g. up to the latest tag or a branch that does not rewind, the set
> of refs to use as the stable anchors you would want to make
> configurable), and then fill the gap between that baseline snapshot
> and up-to-date state by doing another round of "git fetch" and then
> you'd have solved the most serious problem already.

_most_. On a troubled connection, fetch can fail as well, especially
when the repo is not uptodate. What about shallow clone? I don't think
you want to prepare snapshots for all depths (or some "popular"
depths). Cloning full then cutting it shallow locally might work, but
we're wasting bandwidth and disk space.

> This is an indication that the approach this series takes is taking
> us in a wrong direction.

The way I see it, the two approaches complement each other. Snapshots,
like pack bitmaps, helps tremendously, but it has corner cases that
can be covered by this.
--=20
Duy
