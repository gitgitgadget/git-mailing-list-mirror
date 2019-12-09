Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D719FC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F440206D3
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZDxTDZku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfLITT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:19:29 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60210 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfLITT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 14:19:29 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 81F269EDCE;
        Mon,  9 Dec 2019 14:19:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QBRpxyuAgn9t
        KpQsi2fVRE26bjE=; b=ZDxTDZkujT3W74QqO0ERpkw94TEI0poN4lREc3ASVMhn
        X2GTm6CCRzkwpRsuq+g1NwfYfeKKEzrN12TDYFZ7A7PnTdjGHDFMNqeWtYs/czFA
        u8KV/nLJ206+tQjzBqHyl31V2B4lQX7Ix3eJ3AI1ZaMSG3FWZVa46283qAJqy/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=cAERkZ
        eYsVHvocluiihhJzNA842AsBR1MlvR9x/1nuFgHsRZBsQxj703dPx7u8Y1IZTvRy
        47FWAlglwVGt6kdR018s3f6Ofk4zKuZw5GQAUkTg4USKiFGzrysnoVFyqlg25qgr
        2M7AffzAOWhUrxtzwseAaX7JyiteYOTIItj1E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 79C2A9EDCC;
        Mon,  9 Dec 2019 14:19:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 40B359EDC9;
        Mon,  9 Dec 2019 14:19:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        kazuhiro kato <kazuhiro.kato@hotmail.co.jp>,
        =?utf-8?B?5Yqg6Jek5LiA5Y2a?= <kato-k@ksysllc.co.jp>
Subject: Re: [PATCH] gitk: fix branch name encoding error on gitk
References: <20191207003203.9612-1-kato-k@ksysllc.co.jp>
Date:   Mon, 09 Dec 2019 11:19:19 -0800
In-Reply-To: <20191207003203.9612-1-kato-k@ksysllc.co.jp> (=?utf-8?B?Ig==?=
 =?utf-8?B?5Yqg6Jek5LiA5Y2aIidz?=
        message of "Sat, 7 Dec 2019 00:32:25 +0000")
Message-ID: <xmqqlfrlux1k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CEB95E1E-1AB8-11EA-A18F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[jc: pinging the gitk maintainer]

=E5=8A=A0=E8=97=A4=E4=B8=80=E5=8D=9A <kato-k@ksysllc.co.jp> writes:

> From: Kazuhiro Kato <kazuhiro.kato@hotmail.co.jp>

Kato-san, do you prefer this address, over ksysllc address?  Either
way, we prefer to see it match the address used on the signed-off-by
line below.

> After "git checkout -b '=E6=BC=A2=E5=AD=97'" to create a branch with UT=
F-8
> character in it, "gitk" shows the branch name incorrectly, as it
> forgets to turn the bytes read from the "git show-ref" command
> into Unicode characters.
>
> Signed-off-by: Kazuhiro Kato <kato-k@ksysllc.co.jp>
> ---
>  gitk | 4 ++++
>  1 file changed, 4 insertions(+)

Thanks.

> diff --git a/gitk b/gitk
> index abe4805..3f61a5b 100755
> --- a/gitk
> +++ b/gitk
> @@ -1780,11 +1780,15 @@ proc readrefs {} {
>      global otherrefids idotherrefs mainhead mainheadid
>      global selecthead selectheadid
>      global hideremotes
> +    global tclencoding
> =20
>      foreach v {tagids idtags headids idheads otherrefids idotherrefs} =
{
>  	unset -nocomplain $v
>      }
>      set refd [open [list | git show-ref -d] r]
> +    if {$tclencoding !=3D {}} {
> +	fconfigure $refd -encoding $tclencoding
> +    }
>      while {[gets $refd line] >=3D 0} {
>  	if {[string index $line 40] ne " "} continue
>  	set id [string range $line 0 39]
