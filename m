Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C54AC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 08:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A3B206DB
	for <git@archiver.kernel.org>; Wed,  6 May 2020 08:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4UaCF7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgEFI4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 04:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgEFI4r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 04:56:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF3EC061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 01:56:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l18so1202741wrn.6
        for <git@vger.kernel.org>; Wed, 06 May 2020 01:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iCdZp/1IKWTCAk4b0pGOgD/Bh3oCEY8ThEtcCIOuaBU=;
        b=V4UaCF7z2hpAlaO+GuX019T49u8jAh+zTM7cvcoavwifiGmUsgVMcQDG9XBaRRbqTQ
         xAlHnD7pwAxfn7HB6VBNgmZ6b5PcBwaVQ+/H1q4fmKGTK6NnjaW55NjcZB7lZQhqFFh5
         HkfqvKx3cM5OpIl5uZiuUrNoy+UJ3VWNCooSwn5i/mDAvC2dEFuFAFbdj533m7uJoZI1
         cmMjQuKVdIedWgeDbifkzrucU/8hmCaLgPMVBWeNXO9T9gx9FVwj1JhQShyHWp35IAUy
         enIo/rXZYpJVAjQD//+7ct24NOkH4dfjA/6m0NbY6SECkmLovLAktRZnDlX3n+VVH90M
         /BmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iCdZp/1IKWTCAk4b0pGOgD/Bh3oCEY8ThEtcCIOuaBU=;
        b=QCYixIap+F3L8pZrYPRU8WCyXZqS8yAyFcGhUVjNO0TnfzwV4N3gojZmfnCWArG6Wl
         glwHIF+zsC3nvoN6sE+UzDGsHbxIfXxxeYddwobEWrRlLSgANPVPPG/k4YjobDRPWNC/
         jJFQv7AWijsk7s67J+49WokjjiJC2jid+pAazj+hu3Wo2zbAo8HN+t5kH1CMrrMqMPnH
         xUFf/JJHljZrq+oa4H1oEUxSAwgymHqXQKJ8IACL46NVPiHen9amhQjGrr0QxbSKwvKr
         7suLTCRbS87Q539wcMYgWPTFUBxhqM208ZO2qusfKqkyVSzFigm/+9FaYVR3wYXsEBpy
         0BAA==
X-Gm-Message-State: AGi0PuarmJyaIqzy1y8Z8DlpwLaq7wRwrTANgKYrteJGgLuSlj4IDzCT
        2K6Qfhx6xcpPOUvk5K0vbmuYwf+U
X-Google-Smtp-Source: APiQypJx0RlXlIreYi74d72brvGxRvKmaIoIMb+MpNn4BdL2hap5Rkf+lFa72ZoYwioSNwU3a17tIw==
X-Received: by 2002:adf:c38c:: with SMTP id p12mr8872408wrf.357.1588755405313;
        Wed, 06 May 2020 01:56:45 -0700 (PDT)
Received: from ?IPv6:2a02:a210:ca2:9c00:4c05:518a:3ad9:8dba? ([2a02:a210:ca2:9c00:4c05:518a:3ad9:8dba])
        by smtp.gmail.com with ESMTPSA id b22sm10303526wmj.1.2020.05.06.01.56.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2020 01:56:44 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] midx: apply gitconfig to midx repack
From:   Son Luong Ngoc <sluongng@gmail.com>
In-Reply-To: <74A7FE73-6B5F-4DCF-9A57-AD11306CFAF8@gmail.com>
Date:   Wed, 6 May 2020 10:56:43 +0200
Cc:     Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E80AD11E-4151-4B6D-988C-B91D8A93F6B6@gmail.com>
References: <pull.626.git.1588684003766.gitgitgadget@gmail.com>
 <8bd91a14-75dc-76e2-31b4-54eff5bea8dd@gmail.com>
 <74A7FE73-6B5F-4DCF-9A57-AD11306CFAF8@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

> On May 5, 2020, at 18:03, Son Luong Ngoc <sluongng@gmail.com> wrote:
>> On May 5, 2020, at 15:50, Derrick Stolee <stolee@gmail.com> wrote:
>>> +	if (write_bitmaps > 0)
>>> +		argv_array_push(&cmd.args, "--write-bitmap-index");
>>> +	else if (write_bitmaps < 0)
>>> +		argv_array_push(&cmd.args, =
"--write-bitmap-index-quiet");
>>=20
>> These make less sense. Unless --batch-size=3D0 and there are no .keep
>> packs (with the patch below) I'm not sure we _can_ write bitmap =
indexes
>> here. The pack-file is not necessarily closed under reachability. Or,
>> will supplying these arguments to 'git pack-objects' actually do that
>> closure?
>>=20
>> I would be happy to special-case these options to the =
"--batch-size=3D0"
>> situation and otherwise ignore them. This then gets into enough
>> complication that we should update the documentation as in the patch
>> below.
>=20
> You make a great point here.=20
> I completely missed this as I have been largely testing with repacking =
only 2 packs,
> effectively with --batch-size=3D0.
>=20
> I think having the bitmaps index is highly desirable in =
`--batch-size=3D0` case.
> I will try to include that in V2 (with Documentation).

Hmm, I just realized that there is a check for `--all` is being passed =
on pack-objects side.

	if (batch_size =3D=3D 0) {
		argv_array_push(&cmd.args, "--all");
		if (write_bitmaps > 0)
			argv_array_push(&cmd.args, =
"--write-bitmap-index");
		else if (write_bitmaps < 0)
			argv_array_push(&cmd.args, =
"--write-bitmap-index-quiet");
	}

If I do something like this, the midx repack will become tremendously =
slow as I think pack-objects
needs to scan for all revs (fed from midx) and all refs.
Perhaps special exception needed to be made on pack-objects side to =
trust that midx is feeding it
everything there is?

I think adding `write_bitmaps` support would be a bit out of my hand for =
now, so I will settle with
the delta configs and Derrick's patch for V2. (sending it later today)

>> Thanks,
>> -Stolee
>=20
> Cheers,
> Son Luong
>=20

