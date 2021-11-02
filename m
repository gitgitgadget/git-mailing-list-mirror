Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAE0C433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD7E60F24
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbhKBPPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:15:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:41665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234629AbhKBPNs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 11:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635865859;
        bh=DDb95HAf7rXxatyWHQCeE73r2cBLVgaxIIU5pudMZDk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NdlvbcZ4aHUZiVQkjOmG9GWWQ5D9L+tdO4A2GngLNX94+8IOr80A/gcx3/bl1GFt0
         k/U/dY16p430DgCAdKHJ/JO5fZWjA8sfKaYE+k+fQzFd10NFNdW9fulXVW3nGcH+Ba
         OtO8njbI7JS7CMrmGXM+cGeULNqnIE5/pW7tZ1zk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([213.196.213.29]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Msq2E-1mSbXv07uS-00tAab; Tue, 02
 Nov 2021 16:10:59 +0100
Date:   Tue, 2 Nov 2021 16:10:57 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Matt Cooper via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matt Cooper <vtbassmatt@gmail.com>
Subject: Re: [PATCH v3 5/8] odb: teach read_blob_entry to use size_t
In-Reply-To: <xmqqwnlvfmjr.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111021601360.56@tvgsbejvaqbjf.bet>
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com> <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com> <dbef8168bc7044dbc8471c5ecc7146cf3e979263.1635515959.git.gitgitgadget@gmail.com> <xmqqwnlvfmjr.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QzvlihCl6Uorj60K5r/7BBOiB5Ztm+tiYXdznBgE5bavb0953cj
 cmxyiTW1aDohhWDB0CCYVmSYkp+Dsy+njsW1nPfLgXqAPb187sHxIlwuOHS8UaQ6bJtJvTe
 IhcPmZm9/g4LyNbidIW8SGugDfjHb3LRhkZSjzTtEGIJVaQ1JkQMMaGKMLQlbHaq8mtAg93
 SuE/Rct0zR3pcu5lteyGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0q25PFgRHm0=:3ZKSR+EkLxfb2981hZbbKh
 A9bkbWT3wnkQk8CVRyIVmp+ouMt7ZGnyv89RdzWodxf/CFfB5x8d+j8+WTw6zlRuKZP2bReEb
 Ixhjxay0g5JXOtcaGI5G3YZbGs7tfEDxtNJYk3wVd7JI7Vxc2SdJ4l2EiNmXTycXjEnKNXiFB
 cS9S3Wt+gBfBHC0t6xQYIASPmWa+ttWV3Vgspsrmttfp+xm//N7fS8MA8JYH+H+SkDLGil3cm
 1YzLNcizpsVWqrWltJm+WxhCq3j3nQwyWfdoDLe2FSJKoCmssYJn4yLmx/ALxziRV4lbay9mH
 epyAc6paQPEkG//Qr2DaP2+No6Bf5uRlbOcsJxcEtYG3hhj9nwmvPMExwOUkJU5BSw4UGeGFA
 nmKUAle31KHea2LETxG1NSsQl2oPGHoMV4NWAFYpea1AYPerXVi/3WFb0/L52m3vW3N8KMMQR
 A1OHOwYSSod8fZBXM0hAOXExViWygNjwxcwZ1IPV1IOsj7MWnQUNE2Aa5g5snQHe0r9O9pykO
 xvdw+7xykBt1HhF0i6A7IGt6S3wO+IjQabmydErGgnimMe/Toi8Mjl9LjtXXVGv8wO4m+3zg4
 QeOiNF1gwAaqo2wlg710Zz9kv6NB5VgnRei8vco4A/I6PxsrxuqsPDY8fxBZtMyqqXLjrBEb8
 yxSVSYkgl/nbWkwmoCNB0DQ/QI/BgKJlIFlDiXEPpdY9Yp6TTddmXZSbjx5ahp02wqtDGL+xM
 ERkHMEwc1g4moDD7zDu+rFIQlSj80cRgcJgC99/Rt++3XDXEaQBg2ZM/pMcHLleWnKNI6gMub
 1TFiSBUvcx/vIYDNbTV3LJzgxM9WenU0gaOTC1FBh9ur4rEp51/6xj7jHcrEV3s1Zhj8mBKGQ
 4xuG9P4gL9oiXFaAoMDnllQ+LdSz0CwCIpqyjdpipjE3FPn9zIIsxfkxax+jdy1uT9zcILQQB
 Y0oeQJiIQ4bF4xKRLki/qbuWSX6JZfr89Y3si7e4vJoqd1Z2qcIKXGSe7vTuh+/CO3GDuBK9l
 IQauKID4VGeHbJc1mX2OxkikO1WoyvTeon8Vey7BjRbqEVvfEfApfT8O9qELk8bcFx6lv03YP
 Axhvxq1SMWq1Q8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 29 Oct 2021, Junio C Hamano wrote:

> "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > -void *read_blob_entry(const struct cache_entry *ce, unsigned long *si=
ze)
> > +void *read_blob_entry(const struct cache_entry *ce, size_t *size)
> >  {
> >  	enum object_type type;
> > -	void *blob_data =3D read_object_file(&ce->oid, &type, size);
> > +	unsigned long ul;
> > +	void *blob_data =3D read_object_file(&ce->oid, &type, &ul);
> >
> > +	*size =3D ul;
>
> It is a bit curious place to draw the line; we want to make sure
> that blob_entry can hold huge data, but in this step we do not mind
> read_object_file() is not capable of going full 64-bit?

Indeed that is the case. The consideration here is: how large of a patch
series do I want to take this late in the cycle?

Here is the call tree (for full details, look no further than
https://github.com/git-for-windows/git/pull/3487#issuecomment-950727616):

    read_object_file()
        repo_read_object_file()
            read_object_file_extended()
                read_object()
                    oid_object_info_extended()
                        do_oid_object_info_extended()
                            loose_object_info()
                                parse_loose_header_extended()
                            packed_object_info()
                                cache_or_unpack_entry()
                                    unpack_entry()
                                        unpack_object_header()
                                           unpack_object_header_buffer()
                                get_size_from_delta()
                                    get_delta_hdr_size()

All three leaves have code that needs to be adjusted to use `size_t`
instead of `unsigned long`, and all of the other functions in that call
tree need to be adjusted for that. Some of the callers do not even pass an
`unsigned long` pointer around, but instead a pointer to `struct
object_info` (which, you guessed it, also has an `unsigned long` that
should have been a `size_t` from the beginning).

This is too big a change I am willing to work on, let alone accept, this
late in the cycle.

Sure, it would fix the scenario where clean/smudge filters are not even
involved (read: `git add`ing a 5GB file _directly_). But the potential for
bugs to hide!

> I guess I'll see soon enough why by reading later steps.  I can see
> that for the purpose of making write_entry() aware of the size_t,
> this is necessary at the minimum.

I fear that you won't see more about this in the later steps ;-)

Ciao,
Dscho
