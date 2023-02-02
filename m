Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4B9C636D3
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 19:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjBBTXx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 14:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjBBTXu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 14:23:50 -0500
Received: from out-166.mta1.migadu.com (out-166.mta1.migadu.com [IPv6:2001:41d0:203:375::a6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C56A6F700
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 11:23:48 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1675365827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C2otlsnBSALEgzaUD/5/wUpgziCWX9mHCYIo1rNvEPY=;
        b=VnyB4TKykDv289gi+yoYuwNK4MimVwoMiZ+iyZhsq9x3B+Nz1S5dV2/xxiyMS8y1uRR8Tv
        NkUJgqq1elo4YBA0ixwHzaoc44OpP7UmdClvQV3VXhd0gLtUldVnktjhdloyBfS5SRnpJ1
        qNimlgy0enUWwXLduZnei7KKUi7hc+s=
Date:   Thu, 02 Feb 2023 19:23:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
Message-ID: <de8f1e338e6ee99cd3ee06b16f1edbce@ameretat.dev>
Subject: Re: [PATCH 0/9] git archive: use gzip again by default, document
 output stabilty
To:     phillip.wood@dunelm.org.uk,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?=" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        "Eli Schwartz" <eschwartz93@gmail.com>,
        "=?utf-8?B?UmVuw6kgU2NoYXJmZQ==?=" <l.s.r@web.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>,
        "=?utf-8?B?TWljaGFsIFN1Y2jDoW5law==?=" <msuchanek@suse.de>,
        "demerphq" <demerphq@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>
In-Reply-To: <771a98ca-9540-ad4e-dfba-9d304e1dff09@dunelm.org.uk>
References: <771a98ca-9540-ad4e-dfba-9d304e1dff09@dunelm.org.uk>
 <230131.86357rrtsg.gmgdl@evledraar.gmail.com>
 <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

February 2, 2023 11:17 AM, "Phillip Wood" <phillip.wood123@gmail.com> wro=
te:=0A> Playing devil's advocate for a moment as we're not going to promi=
se that the compressed output of=0A> "git archive" will be stable in the =
future perhaps we should use this breakage as an opportunity to=0A> highl=
ight that to users and to advertize the config setting that allows them t=
o use gzip for=0A> compressing archives. Reverting the change gives the m=
isleading impression that we're making a=0A> commitment to keeping the ou=
tput stable. The focus of this thread seems to be the problems relating=
=0A> to github which they have already addressed.=0A> =0A> I think there =
is general agreement that it is not practical to promise that the compres=
sed output=0A> of "git archive" is stable so maybe it is better to make t=
hat clear now while users can work around=0A> it in the short term with a=
 config setting rather than waiting until we're faced with some security=
=0A> or other issue that forces a change to the output which users cannot=
 work around so easily.=0A=0AReverting to the behavior of "use some arbit=
rary gzip from $PATH" would=0Abe a poor decision whether or not git were =
willing to make some=0Acommitment to gzip stability, because Git does not=
 control arbitrary=0Agzips on the user's $PATH. If Git did want to promis=
e gzip stability, it =0Acould only start from something like the current =
internal implementation=0Aalong with a vendored zlib; if it doesn't, as a=
ppears to be the case, =0Athen the internal implementation is superior fo=
r the other reasons =0Aalready discussed.=0A=0AIf the user wants to depen=
d on a particular gzip executable they supply, =0Athis configuration knob=
 already exists for them.=0A=0ASince there is no guarantee of stability, =
but there has been a popular =0Amisconception that there is some such gua=
rantee (e.g., [1]), some kind =0Aof STABILITY section describing how ther=
e isn't any and suggesting ways=0Athe user can attain more stability via =
configuration seems to be a good=0Aidea.=0A=0A[1]: https://lists.reproduc=
ible-builds.org/pipermail/rb-general/2021-October/002422.html
