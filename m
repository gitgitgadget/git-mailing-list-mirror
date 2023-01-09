Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7750FC5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 18:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbjAISpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 13:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjAISpx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 13:45:53 -0500
X-Greylist: delayed 329 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Jan 2023 10:45:51 PST
Received: from zimbra.cs.ucla.edu (zimbra.cs.ucla.edu [131.179.128.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A77290
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 10:45:50 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 0D99E160043;
        Mon,  9 Jan 2023 10:40:21 -0800 (PST)
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ilMecndlWFjy; Mon,  9 Jan 2023 10:40:20 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.cs.ucla.edu (Postfix) with ESMTP id 38244160048;
        Mon,  9 Jan 2023 10:40:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.9.2 zimbra.cs.ucla.edu 38244160048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
        s=78364E5A-2AF3-11ED-87FA-8298ECA2D365; t=1673289620;
        bh=sPewYtI2nslfvK5V0TkcNuGYU9M7ggzvuzpTsLpmiW8=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
         Content-Transfer-Encoding;
        b=bEFcX4X9DsSGEwgVJ1w43dcGCKwvpVv0j3FPVy7UOcbDOchs1ajZ7UzGGfznQi0uF
         DJSbUmvaEVtzzS3N03J+B+qArGHZf5EaPiPO3EtgdQSFtIcI3hgKe5HJmEwwG2DSTj
         XoUm7xyk5hGPN5K7r32q1LbpVvFNfyWaIVE8LxIA=
X-Virus-Scanned: amavisd-new at zimbra.cs.ucla.edu
Received: from zimbra.cs.ucla.edu ([127.0.0.1])
        by localhost (zimbra.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5dMvSc-VXdfb; Mon,  9 Jan 2023 10:40:20 -0800 (PST)
Received: from [131.179.64.200] (Penguin.CS.UCLA.EDU [131.179.64.200])
        by zimbra.cs.ucla.edu (Postfix) with ESMTPSA id 17FEF160043;
        Mon,  9 Jan 2023 10:40:20 -0800 (PST)
Message-ID: <d6814350-10a3-55c0-68da-7e691976cd45@cs.ucla.edu>
Date:   Mon, 9 Jan 2023 10:40:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: bug#60690: [PATCH v2] grep: correctly identify utf-8 characters
 with \{b, w} in -P
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
Cc:     demerphq@gmail.com, pcre-dev@exim.org, 60690@debbugs.gnu.org,
        gitster@pobox.com, git@vger.kernel.org
References: <20230108062335.72114-1-carenas@gmail.com>
 <20230108155217.2817-1-carenas@gmail.com>
 <230109.86v8lf297g.gmgdl@evledraar.gmail.com>
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <230109.86v8lf297g.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/9/23 03:35, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> You almost never want "everything Unicode considers a digit", and if yo=
u
> do using e.g. \p{Nd} instead of \d would be better in terms of
> expressing your intent.

For GNU grep, PCRE2_UCP is needed because of examples like what Gro-Tsen=20
and Karl Petterssen supplied. If there's some diagreement about how \d=20
should behave with UTF-8 data the GNU grep hackers should let the Perl=20
community decide that; that is, GNU grep can simply follow PCRE2's lead.=20
But GNU grep does need PCRE2_UCP for \b etc.

> 	$ diff <(git -P grep -P '\d+') <(git -P grep -P '(*UCP)\d')
> 	53360a53361,53362
> 	> git-gui/po/ja.po:"- =E7=AC=AC=EF=BC=91=E8=A1=8C: =E4=BD=95=E3=82=92=E3=
=81=97=E3=81=9F=E3=81=8B=E3=80=81=E3=82=92=EF=BC=91=E8=A1=8C=E3=81=A7=E8=A6=
=81=E7=B4=84=E3=80=82\n"
> 	> git-gui/po/ja.po:"- =E7=AC=AC=EF=BC=92=E8=A1=8C: =E7=A9=BA=E7=99=BD\=
n"

Although I don't speak Japanese I have dealt with quite a bit of=20
Japanese text in a previous job, and personally I would prefer \d to=20
match those two lines as they do contain digits. So to me this=20
particular case is not a good argument that git grep should not match=20
those lines.

Of course other people might prefer differently, and there are cases=20
where I want to match only ASCII digits. I've learned in the past to use=20
[0-9] for that. I hope PCRE2 never changes [0-9] to match anything but=20
ASCII digits when searching UTF-8 text.
