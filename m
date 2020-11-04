Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CD9C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 16:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 140ED20786
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 16:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMpAJ8lp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgKDQKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 11:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgKDQKS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 11:10:18 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90662C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 08:10:18 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id w25so11760501vsk.9
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 08:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=AbiUqZjgi5Ta3lz6Xiob/oROtRGCwIH5upgkoxUjL7k=;
        b=EMpAJ8lp1LBEcPXuGRJtHgNiNHUVBGBUAcPUwhC2iyvLo7i0EXKGta8gHschzpgdFY
         uzGVqHeVoE6e5XhBsMOmVpp7XoAjO6mFDEKHp9FPlY2VL+bAuk6Tc4nIiLXmQ25wTirX
         1HBqm3sOUOytmuUv38NAEc1Dr1BuyYAk6BPiLeYidi2VY941K7Q6lsw3tybUj1n+ZF3Q
         Z07fgrRigP9yVyZTr/gzYZ+MsKAefPAtrgx8EXw4f66YKYO+uDDv7kMRaBJutlD+ZjH5
         6qdO2dAiKhG4AwBT8ecAa+HCem2U4LJfviFJ/OY4yCQENbJXkWuBfloon6cL9lqZsCZ7
         JecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AbiUqZjgi5Ta3lz6Xiob/oROtRGCwIH5upgkoxUjL7k=;
        b=gX6+uAz5P+zL+qicg/tzXWJru6f/WQB7B53zLSYtFBm8ASAYb55fgn5EgdDhTL9J5I
         l8+S4DWnH0WFhRQtWlobkyyxbRIFQ/NZlTOdGbMRbrQaiC0ayOFTvpMXQDPkvsg+g3Yw
         bAUnIpqhQu7Q7w1IvaMJzqqI21ECo1rvkZqb4GW929ELCcTLy/bUwZIbivR5wGWb1Tve
         jl7oUjqEu5h+uIKK3BLyFTvFPRHqgMnh3H5HOH7cTwu1M1mV5RrlGvceRL8fV9t7EhN2
         b08H7RU8LNWviBM9Z4jVUTdxYz0lEtli+05ikkJ2pWQhhSsGAm/WCXNgx+BNYsPQ4MKl
         PRJg==
X-Gm-Message-State: AOAM531z8RACCDIKjb7FhBPMd2DeBycziYiSSo1bjSqfA/Cm4uVqTc9Y
        bVcmojDI9qrlDpOF4eyzQ4FPJDQAdMiDiiPN0dxcVPVxVCcevg==
X-Google-Smtp-Source: ABdhPJxrunu4w9DBiKhok4Ex+2glmB/8I6akaK7DZK1bPK9nZp6mMmZddPqzfyMrb5R1XO1iYeqpwxBlf3owf4p9emE=
X-Received: by 2002:a67:d06:: with SMTP id 6mr10220363vsn.51.1604506217526;
 Wed, 04 Nov 2020 08:10:17 -0800 (PST)
MIME-Version: 1.0
From:   Alex Marginean <alexmarginean16@gmail.com>
Date:   Wed, 4 Nov 2020 18:10:06 +0200
Message-ID: <CALG6MqwdCmwS5D_F9+q6UYzGm5ZzLL7Bi=rD7Ph2XE0uccu+xg@mail.gmail.com>
Subject: BUG
To:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000022ca1205b34a3795"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--00000000000022ca1205b34a3795
Content-Type: text/plain; charset="UTF-8"

Hey,

Github has changed the way they name branches, so now instead of the
`master` branch there is the `main` branch however, I'm having some
trouble with the naming

**Steps to replicate my problem**

1. Create a new Github repository and make sure the default branch is `main`
2. Add something to the repo, a `README.md` file should be enough
3. Instead of cloning the repo make a new directory with your repo's
name `mkdir <repo_name>` and change the directory to it `cd
<repo_name>`
4. `git init`
5. Add the remote repo with `git remote add origin <repo_link>`
6. Pull the `main` branch from the remote repo with `git pull origin main`.

After the step number 6. instead of my branch changing to `main` my
current branch is changed to `master` which has every file and change
of the branch `main`. This is a real problem because if I try to push
changes to `main` although my current branch shows up as `master` it
creates another branch called `master` on Github and the `main`
remains unchanged. Yeah sure I can `git checkout main` after that and
make my changes there but I'm not sure why it defaults to `master` and
copies `main` from Github into local branch `master`.

P.S. If you were to use `git fetch origin` instead of `git pull origin
<branch_name> and then manually change branch to `main` with `git
checkout main` it would work. Also, if you were to clone the Github
repo using `git clone <link>` you will get the correct current branch
that is `main`.

Sincerely,
Alex

--00000000000022ca1205b34a3795
Content-Type: text/plain; charset="US-ASCII"; name="git-bugreport-2020-11-04-1731.txt"
Content-Disposition: attachment; 
	filename="git-bugreport-2020-11-04-1731.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kh3ljcu30>
X-Attachment-Id: f_kh3ljcu30

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCgpHaXRodWIgaGFzIGNoYW5nZWQgdGhlIHdheSB0aGV5IG5hbWUg
YnJhbmNoZXMsIHNvIG5vdyBpbnN0ZWFkIG9mIHRoZSBgbWFzdGVyYCBicmFuY2ggdGhlcmUgaXMg
dGhlIGBtYWluYCBicmFuY2ggaG93ZXZlciwgSSdtIGhhdmluZyBzb21lIHRyb3VibGUgd2l0aCB0
aGUgbmFtaW5nCgoxLiBDcmVhdGUgYSBuZXcgR2l0aHViIHJlcG9zaXRvcnkgYW5kIG1ha2Ugc3Vy
ZSB0aGUgZGVmYXVsdCBicmFuY2ggaXMgYG1haW5gCjIuIEFkZCBzb21ldGhpbmcgdG8gdGhlIHJl
cG8sIGEgYFJFQURNRS5tZGAgZmlsZSBzaG91bGQgYmUgZW5vdWdoCjMuIEluc3RlYWQgb2YgY2xv
bmluZyB0aGUgcmVwbyBtYWtlIGEgbmV3IGRpcmVjdG9yeSB3aXRoIHlvdXIgcmVwbydzIG5hbWUg
YG1rZGlyIDxyZXBvX25hbWU+YCBhbmQgY2hhbmdlIHRoZSBkaXJlY3RvcnkgdG8gaXQgYGNkIDxy
ZXBvX25hbWU+YAo0LiBgZ2l0IGluaXRgCjUuIEFkZCB0aGUgcmVtb3RlIHJlcG8gd2l0aCBgZ2l0
IHJlbW90ZSBhZGQgb3JpZ2luIDxyZXBvX2xpbms+YAo2LiBQdWxsIHRoZSBgbWFpbmAgYnJhbmNo
IGZyb20gdGhlIHJlbW90ZSByZXBvIHdpdGggYGdpdCBwdWxsIG9yaWdpbiBtYWluYC4KCldoYXQg
ZGlkIHlvdSBleHBlY3QgdG8gaGFwcGVuPyAoRXhwZWN0ZWQgYmVoYXZpb3IpCgpBZnRlciBzdGVw
IDYuIEkgZXhwZWN0ZWQgdG8gYmUgc3dpdGNoZWQgdG8gYSBicmFuY2ggY2FsbGVkIGBtYWluYCB0
aGF0IHdvdWxkIGluY2x1ZGUgZXZlcnkgZmlsZSBhbmQgY2hhbmdlIGZyb20gdGhlIGBtYWluYCBi
cmFuY2ggb24gdGhlIG9yaWdpbi4gCgpXaGF0IGhhcHBlbmVkIGluc3RlYWQ/IChBY3R1YWwgYmVo
YXZpb3IpCgpBZnRlciB0aGUgc3RlcCBudW1iZXIgNi4gaW5zdGVhZCBvZiBteSBicmFuY2ggY2hh
bmdpbmcgdG8gYG1haW5gIG15IGN1cnJlbnQgYnJhbmNoIGlzIGNoYW5nZWQgdG8gYG1hc3RlcmAg
d2hpY2ggaGFzIGV2ZXJ5IGZpbGUgYW5kIGNoYW5nZSBvZiB0aGUgYnJhbmNoIGBtYWluYC4gVGhp
cyBpcyBhIHJlYWwgcHJvYmxlbSBiZWNhdXNlIGlmIEkgdHJ5IHRvIHB1c2ggY2hhbmdlcyB0byBg
bWFpbmAgYWx0aG91Z2ggbXkgY3VycmVudCBicmFuY2ggc2hvd3MgdXAgYXMgYG1hc3RlcmAgaXQg
Y3JlYXRlcyBhbm90aGVyIGJyYW5jaCBjYWxsZWQgYG1hc3RlcmAgb24gR2l0aHViIGFuZCB0aGUg
YG1haW5gIHJlbWFpbnMgdW5jaGFuZ2VkLiBZZWFoIHN1cmUgSSBjYW4gYGdpdCBjaGVja291dCBt
YWluYCBhZnRlciB0aGF0IGFuZCBtYWtlIG15IGNoYW5nZXMgdGhlcmUgYnV0IEknbSBub3Qgc3Vy
ZSB3aHkgaXQgZGVmYXVsdHMgdG8gYG1hc3RlcmAgYW5kIGNvcGllcyBgbWFpbmAgZnJvbSBHaXRo
dWIgaW50byBsb2NhbCBicmFuY2ggYG1hc3RlcmAuCgpXaGF0J3MgZGlmZmVyZW50IGJldHdlZW4g
d2hhdCB5b3UgZXhwZWN0ZWQgYW5kIHdoYXQgYWN0dWFsbHkgaGFwcGVuZWQ/CgpUaGUgbmFtZSBv
ZiB0aGUgYnJhbmNoIGFuZCB0aGUgZHVwbGljYXRpb24gb2YgdGhlIGBtYWluYCBicmFuY2ggdG8g
YSBicmFuY2ggY2FsbGVkIGBtYXN0ZXJgLgoKQW55dGhpbmcgZWxzZSB5b3Ugd2FudCB0byBhZGQ6
CgpQLlMuIElmIHlvdSB3ZXJlIHRvIHVzZSBgZ2l0IGZldGNoIG9yaWdpbmAgaW5zdGVhZCBvZiBg
Z2l0IHB1bGwgb3JpZ2luIDxicmFuY2hfbmFtZT4gYW5kIHRoZW4gbWFudWFsbHkgY2hhbmdlIGJy
YW5jaCB0byBgbWFpbmAgd2l0aCBgZ2l0IGNoZWNrb3V0IG1haW5gIGl0IHdvdWxkIHdvcmsuIEFs
c28sIGlmIHlvdSB3ZXJlIHRvIGNsb25lIHRoZSBHaXRodWIgcmVwbyB1c2luZyBgZ2l0IGNsb25l
IDxsaW5rPmAgeW91IHdpbGwgZ2V0IHRoZSBjb3JyZWN0IGN1cnJlbnQgYnJhbmNoIHRoYXQgaXMg
YG1haW5gLgoKUGxlYXNlIHJldmlldyB0aGUgcmVzdCBvZiB0aGUgYnVnIHJlcG9ydCBiZWxvdy4K
WW91IGNhbiBkZWxldGUgYW55IGxpbmVzIHlvdSBkb24ndCB3aXNoIHRvIHNoYXJlLgoKCltTeXN0
ZW0gSW5mb10KZ2l0IHZlcnNpb246CmdpdCB2ZXJzaW9uIDIuMjkuMgpjcHU6IHg4Nl82NApubyBj
b21taXQgYXNzb2NpYXRlZCB3aXRoIHRoaXMgYnVpbGQKc2l6ZW9mLWxvbmc6IDgKc2l6ZW9mLXNp
emVfdDogOApzaGVsbC1wYXRoOiAvYmluL3NoCnVuYW1lOiBEYXJ3aW4gMTkuNi4wIERhcndpbiBL
ZXJuZWwgVmVyc2lvbiAxOS42LjA6IE1vbiBBdWcgMzEgMjI6MTI6NTIgUERUIDIwMjA7IHJvb3Q6
eG51LTYxNTMuMTQxLjJ+MS9SRUxFQVNFX1g4Nl82NCB4ODZfNjQKY29tcGlsZXIgaW5mbzogY2xh
bmc6IDEyLjAuMCAoY2xhbmctMTIwMC4wLjMyLjIxKQpsaWJjIGluZm86IG5vIGxpYmMgaW5mb3Jt
YXRpb24gYXZhaWxhYmxlCiRTSEVMTCAodHlwaWNhbGx5LCBpbnRlcmFjdGl2ZSBzaGVsbCk6IC9i
aW4venNoCgoKW0VuYWJsZWQgSG9va3NdCm5vdCBydW4gZnJvbSBhIGdpdCByZXBvc2l0b3J5IC0g
bm8gaG9va3MgdG8gc2hvdwo=
--00000000000022ca1205b34a3795--
