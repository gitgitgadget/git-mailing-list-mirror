Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0DDC61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 05:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjBPF5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 00:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBPF5B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 00:57:01 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33CB2ED75
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 21:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676527003; i=tboegi@web.de;
        bh=M6zY/UjguZpUKwd2P+KX0LvSssXIgauK6yA0EjpKlh0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=QD0A62SUI818Lsd9jrP+vttVePsH5n3E5nxHmrYJT0Q6FYbpkMx7BJefg1z2tYgza
         dx9hlvr6bzoYhCUSAJhI2ZrbkhmgliobJE7Jco8mSU66Sxk187Su3ZkX1fMx/7+jmN
         U/PacMoxgun+UKgKCbqQOVdyacu4oLkDBauBo/vN/G3mbPJqfHEhIthKhIljBxSq+1
         E6fbqBoQ4Z9wKztLbW9plKVJdytj5l1nkuNO2o9NnH6v3/a4sZ6a8ooJG7+RdCoCQZ
         h94LiDS+FANeYou8jb6JYxrGSK0JKWFAPiakm5UkvrVDnr/zFZ4m7NWS8PsW+k9cvq
         7Ae5xjTLkwD0Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRW6Z-1pDu9O0MjN-00NXoG; Thu, 16
 Feb 2023 06:56:43 +0100
Date:   Thu, 16 Feb 2023 06:56:41 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] shorten_unambiguous_ref(): avoid sscanf()
Message-ID: <20230216055641.brlx3os2ucj3ywer@tb-raspi4>
References: <Y+z3MtgayoXsxaHA@coredump.intra.peff.net>
 <Y+z3RfhAxW/2iNYP@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Y+z3RfhAxW/2iNYP@coredump.intra.peff.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:tuYMhGE4dv0LH6IGUE2PhcNiZUtnTxKlzKE27QQinrVFKyBDVQm
 /GEYBmax8rwCsUQdla4e8+1klPlF1fLBvHeSWHavI/9+0Ch/Ci7eZS1tXhwVIA/F7UGzR6m
 f92LyBW6CEO/B918Ob1qtvAFqMLBJ750nJBIHC1mViw8Dk/DVqN3Pg4FiG4oLT6hL3q6SdL
 qQizvFElpRe8ycBAEY2KQ==
UI-OutboundReport: notjunk:1;M01:P0:yGF/0oYjXBk=;+tHbZWNbtcTGrmj+Zu0RMv09M8c
 iQ5FNSzZ/9puskv3JltsWjw0IYLKLI0OV+6s0uJrG0Wv0DmloCo7isAsM6Q5UugKYUW3zTnr3
 XgMGmE7Fi5QB/LFxceol7M2xMfnapNwwiQSV8b0fqdMTJdEKhTR+dtX+NHK5Q4wgayeQRR3Zi
 HvjVVb8EUff27lSLksOZ5haW40iE+vKeAbpPfsd+cyAz+YJKL/JiTwSRQyUqlk9AdIubg69uD
 eoske6vB57iXQrcfv1QivFUWCK1+JGVaegnwnVOWtTnJ3/5CvyQXUdeIt5DiHBagpTRmAB412
 v86W5jZUiIjs3LoG66qUJwybTfoRs2L1AacCjaB5KUCsKnSa5qMko7nzJJjz4X5bDiMAIBSoj
 2z4HRmVZ6MmWZCTCGunXoKHrxvcdyREBd+3eEPnl+Fal1JGTKJ7OsK/vMhpxOI/SEVfRX+dcQ
 hQwpc+mBMee3cnWjZ5bdqNMQXp4KOPUBqF41Hg891c8GXhkirOV99eg5rAFIpTF88QNMBWavU
 fHrYYBsp466Eicb3UuWoWnkvGk/zfb383U4J/15y2Hx6uWln4CkpfRyZznFwUqrryjI5nQJ8+
 wdOP7G9LeymAl7/wy8d+oFm/Fd1ywVuo+BSufC2Xtdaw+Z7w9UQsMKSo5Hl5JKGgKcuXSVxpO
 VfjIn5nRo4KAQOU4uDvcWVMHG7nYYewhITB45lknM5IbpvwNrpXXMq6UL+cEgx2wwX8GgAA/T
 R/6yOs2Gb0Ksht3fjWMfjNay7gsTrDpBliVYk1PrGxNJlM5zDzZA4XyAe0pvn/pEzxZGF2q6u
 ouQFI28RuARPakk0Uy2BRWpf5CvJ6QiKPDd/EfPQZZKY9fjkP/wWoAilKMtKr2uG20UMTJGM4
 bg4KpIQNrHV7/Cga+NW3EbKBNSej5C/GwtBGQuGbMDYsH+RWStTjygYjgmzzyM9cufMXB5492
 LRYijAG/RFiCl1QedlaEPZFSOg8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2023 at 10:16:21AM -0500, Jeff King wrote:
[]
> +test_expect_success 'symbolic-ref --short handles complex utf8 case' '
> +	name=3D"=E6=B5=8B=E8=AF=95-=E5=8A=A0-=E5=A2=9E=E5=8A=A0-=E5=8A=A0-=E5=
=A2=9E=E5=8A=A0" &&
> +	git symbolic-ref TEST_SYMREF "refs/heads/$name" &&
> +	# In the real world, we saw problems with this case only
> +	# when the locale includes UTF-8. Set it here to try to make things as
> +	# hard as possible for us to pass, but in practice we should do the
> +	# right thing regardless (and of course some platforms may not even
> +	# have this locale).
> +	LC_ALL=3Den_US.UTF-8 git symbolic-ref --short TEST_SYMREF >actual &&
> +	echo "$name" >expect &&
> +	test_cmp expect actual
> +'
> +

Hm, I may have 1 or two questions here.
The real world was MacOs, should that be mentioned here?

The other thing seems to be that there is a bug even with
LANG=3DC, see the response from Eric here:

$ git symbolic-ref --short HEAD | xxd
00000000: e6b5 8be8 af95 2de5 8a0a                 ......-...
$ LANG=3DC git symbolic-ref --short HEAD | xxd
00000000: e6b5 8be8 af95 2de5 8aa0 2de5 a29e e58a  ......-...-.....
00000010: a02d e58a a02d e5a2 9ee5 8aa0 0a         .-...-.......

Does it make sense to
a) Use the local locale, what ever that is
b) Re-run with LC_ALL=3Den_US.UTF-8
c) Re-run with LANG=3DC (that is where I had suspected problems when using=
 UTF-8)
d) Mention MacOs here ?

Somewhat in that style:

test_expect_success 'symbolic-ref --short handles complex utf8 case' '
	name=3D"=E6=B5=8B=E8=AF=95-=E5=8A=A0-=E5=A2=9E=E5=8A=A0-=E5=8A=A0-=E5=A2=
=9E=E5=8A=A0" &&
	git symbolic-ref TEST_SYMREF "refs/heads/$name" &&
	# In the real world, we saw problems with this case only under MacOs Vent=
ura
	# when the locale includes UTF-8. Try it here to try to make things as
	# hard as possible for us to pass, but in practice we should do the
	# right thing regardless (and of course some platforms may not even
	# have this locale).
	# Use try even the default and LANG=3DC
	git symbolic-ref --short TEST_SYMREF >actual &&
	echo "$name" >expect &&
	test_cmp expect actual &&
	LC_ALL=3Den_US.UTF-8 git symbolic-ref --short TEST_SYMREF >actual &&
	echo "$name" >expect &&
	test_cmp expect actual &&
	LANG=3DC git symbolic-ref --short TEST_SYMREF >actual &&
	echo "$name" >expect &&
	test_cmp expect actual
'
