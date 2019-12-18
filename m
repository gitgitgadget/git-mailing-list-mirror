Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7BDC43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92AAB24650
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oZzxXlKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfLRTlw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:41:52 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59296 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfLRTlw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 14:41:52 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A23AA8456;
        Wed, 18 Dec 2019 14:41:50 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=SydBphkFW2Ay4
        S1M4aw9Jc/bDwA=; b=oZzxXlKZVJ5VDk4Zrcbhd7D6WwzBnL/+05JZhrI2pMw8+
        VcFvj7ipi6A/EyFbVybpKO9UIpO87CRkZTEHg+o3qgUcxpWav1bk51ZBg0sYyGGN
        w3XUWGZCMfTZ8AZJrBm4vl6rFqtkZXCoBO3tPdiki6i0KSvCh9DjlK687pbj/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=l981xOU
        xITYE+Lbukhpl//1ME2L10vI7JQ8cZD/R+5tJMHs108ojaHSRMuS1ELeRWBJzvdM
        04wMcoSVupvxowhEdXA+u6Zn3Eq8JssoVkvf/Dd7GjHiI9ZpWJAv4+AR7cGgdIxS
        Dry401BMiM5WMjOJELGNYJaht+4LnWhQhsCg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 325C2A8455;
        Wed, 18 Dec 2019 14:41:50 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.198.29])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1C0BAA8454;
        Wed, 18 Dec 2019 14:41:47 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Wed, 18 Dec 2019 14:41:44 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     George Dunlap <george.dunlap@citrix.com>
Cc:     git@vger.kernel.org
Subject: Re: git-am doesn't strip CRLF line endings when the mbox is
 base64-encoded
Message-ID: <20191218194144.GL17681@pobox.com>
References: <c44c3958-b0eb-22bd-bc35-04982706162f@citrix.com>
 <dece7350-7b58-bf19-9fdf-4ccf8df268fb@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <dece7350-7b58-bf19-9fdf-4ccf8df268fb@citrix.com>
X-Pobox-Relay-ID: 6D842C9C-21CE-11EA-85BE-B0405B776F7B-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

George Dunlap wrote:
> On 12/18/19 11:42 AM, George Dunlap wrote:
>> Using git 2.24.0 from Debian testing.
>>=20
>> It seems that git-am will strip CRLF endings from mails before applyin=
g
>> patches when the mail isn't encoded in any way.  It will also decode
>> base64-encoded mails.  But it won't strip CRLF endings from
>> base64-encoded mails.
>>=20
>> Attached are two mbox files for two different recent series.
>> plainenc.am applies cleanly with `git am`, while base64enc.am doesn't.
>>=20
>> Poking around the man pages, it looks like part of the issue might be
>> that the CRLF stripping is done in `git mailsplit`, before the base64
>> encoding, rather than after.
>=20
> Poking around -- it looks like the CRLF stripping would be better done
> in `git mailinfo` after the decoding.
>=20
> Also, this can *almost* be worked around using hooks -- there's an
> `applypatch-msg` hook which can strip the CLRFs from the commit message=
,
> but no hook (AFAICT) corresponding `applypatch-patch` which is run on
> the patch itself before being applied.

This came up recently in <20191130180301.5c39d8a4@lwn.net>=B9.
I don't know if any of that discussion will prove useful to
you if you want to poke at this further or not.

=B9 https://lore.kernel.org/git/20191130180301.5c39d8a4@lwn.net/

--=20
Todd
