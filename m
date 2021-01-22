Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A8CC433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3C1223AAC
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbhAVWwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:52:46 -0500
Received: from mail2.pdinc.us ([67.90.184.28]:35888 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbhAVWwC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 17:52:02 -0500
Received: from lovegrove (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 10MMp1st024924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jan 2021 17:51:01 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 10MMp1st024924
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1611355861; bh=EqQltOxsftxUPAloiaTBctNxJ7bn3yoj1I2LKnf5LYY=;
        h=Reply-To:From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=G5PYhAgKPw709tQ+3XFP0iJWO1xJtQCFGSHT1nukDpfiQVy4gsVX+84qR3GJwbLB9
         JZPqgE1EHigp+I5CKRpOAlgFE401IbS8213MCU+i7uGbb65LkE4Cu7tVfuH94uHJgO
         YyNos54t7HNL0KH8/h+zntAEesX3b8t8zPR86jpFRtjXMUz0C4/ht/OOrJipsdnm+v
         txvOMFQN7nyf5vWzpge8ZhfL7OAlhmEQbnrJ2viva9IP3alefLakTFNbq5DySrF6zW
         fXoUckJscw0E7BfJYHdJfkg8IooZrHhH+EczwvwKSTzgAKFKi93DsVOaAWA53QjZTU
         vKQlQF+utztDQ==
Reply-To: "Junio C Hamano" <gitster@pobox.com>,
          =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "=?UTF-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>
References: <043f01d6f0fe$d6ad7660$84086320$@pdinc.us>  <cef51cd3-c6b5-ed24-f695-83be3a6743b4@web.de> <xmqqsg6s61x2.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsg6s61x2.fsf@gitster.c.googlers.com>
Subject: RE: git archive setting user and group
Date:   Fri, 22 Jan 2021 17:51:11 -0500
Message-ID: <078701d6f111$14d304c0$3e790e40$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQHBx3N2zV0SHJfdC165O07jxI29BQN7dRGLAZldu3qqNedSgA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Junio C Hamano
> Sent: Friday, January 22, 2021 5:29 PM
>=20
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
> > Am 22.01.21 um 21:40 schrieb Jason Pyeron:
> > ...
> >>         xsnprintf(header->uid, sizeof(header->uid), "%07o", 0);
> >>         xsnprintf(header->gid, sizeof(header->gid), "%07o", 0);
> >>         strlcpy(header->uname, "root", sizeof(header->uname));
> >>         strlcpy(header->gname, "root", sizeof(header->gname));
> >
> > Adding support for using a custom user and group should be easy.  Is
> > this just a cosmetic thing?  Regular users would ignore the user =
info in
> > the archive, and root should not be used for extracting, and on =
systems
> > that don't have a logwatch user this wouldn't make a difference =
anyway,
> > right?
>=20
> I am not particularly interested in cosmetics, but it probably is OK
> to make uname/gname overridable.  I do not see any point in uid/gid
> numeric values overridable, though.  Just like user names and group

Interesting. So logwatch(0) vs logwatch(1100) ? I guess it is as good as =
any value, but tar never uses 0.

On a system without the logwatch user/group tar behaves as follows:

$ tar czf /tmp/logwatch.tgz --owner=3Dlogwatch --group=3Dlogwatch .

$ tar tvzf /tmp/logwatch.tgz | head -n 1
drwxrwxr-x logwatch/logwatch 0 2020-03-14 15:01 ./

$ tar tvzf /tmp/logwatch.tgz --numeric-owner | head -n 1
drwxrwxr-x 1049681/1049088   0 2020-03-14 15:01 ./

$ id
uid=3D1049681(myuser) gid=3D1049088(mygroup) groups=3Dno one cares...

but when the user / group is known...

$ tar czf /tmp/logwatch.tgz --owner=3DGuest --group=3DUsers .

$ tar tvzf /tmp/logwatch.tgz | head -n 1
drwxrwxr-x Guest/Users       0 2020-03-14 15:01 ./

$ tar tvzf /tmp/logwatch.tgz --numeric-owner | head -n 1
drwxrwxr-x 1049077/545       0 2020-03-14 15:01 ./

$ getent passwd Guest | cut -f 3 -d :
1049077

$ getent group Users | cut -f 3 -d :
545


> names do not name the same user and group on every machine, uid/gid
> are even less so.
>=20
>=20


