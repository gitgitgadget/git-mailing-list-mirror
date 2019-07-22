Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D62651F461
	for <e@80x24.org>; Mon, 22 Jul 2019 14:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbfGVOQn (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jul 2019 10:16:43 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40087 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfGVOQn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jul 2019 10:16:43 -0400
Received: by mail-oi1-f195.google.com with SMTP id w196so8343511oie.7
        for <git@vger.kernel.org>; Mon, 22 Jul 2019 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=yvA664SRkCTMGGEW1M8QKut9vruOz/6lBd3iWB6gqT0=;
        b=D8Nto7oTmysXR4VQuk1vbjlbRu+t/LDbDviavnnnm+t7rN6m5DOZXsAFGUE8zTNzqx
         N3kgZ1MO3uWEDJ/3Bpz9usXPbcwccHnMBWPgwB0bezp0R2bcoZema5zAR+dIeR24zko7
         lpYsAJwsdypAdK6xtNQb1mWRavVXEDcgT4rxZvfaJO/tGts6pqlcV/dHJ0l8o21dOFsA
         3VHWt9Ex1v77h0bPmahSXBbHFPQokejs+VWQlohyoFr2LwHd2YxSY03TvgjeLISYzMJ2
         T408kA5+w1/jt90bbfa5fNo/2y0/0/orsxo/iPMJFT4dZjjIhBKyOFD5GwLEiqoFo6Mv
         rQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=yvA664SRkCTMGGEW1M8QKut9vruOz/6lBd3iWB6gqT0=;
        b=qJ5kEE6p787BK2q+0gyNQ1AZkApeofD47tv6O9mdS63d0cxzORpEJX/IWtJ29ISOEp
         mXcp+LHhftwNrH/IHLd1BkbM00yEcfV++rhVj/N6H9KIQfPgtT/8u+OWEgeSUnuTMVJV
         N8N7mNKeVUi+0kKmdji+FCYLFpfnvMgSsQspB4pzuJhfLiYOsvLqiHgkwoGE6A6x3WLU
         TDEjmkDtDGSD6VuvhV0gSTIaPapuui3JzaoDh2S1pHkETuICpKuXPmXrDze5VrUjLsa8
         y5vVpUBeC2CKx+jz9Kc5hdJoTi+iTSMaRXlVw+Da/mdNCfsldqMZ3Sq6CogbOa9ur2qd
         qvFw==
X-Gm-Message-State: APjAAAVDAy11xmZ5L7R8LPsMg1Il80hMV1LxDN2IeLkOcVKl19TD2AOY
        Uo8vO7S65xUW+RkzBYmodjMw8vwzmT1WlDUJeLP03RyzRBQ=
X-Google-Smtp-Source: APXvYqxyF7xGuggrZ/z8bec86jRpf/BLSgyML8Z4jgIFjz+UwDZfArKC9KEoUl0Ju95L0uNTHXeu5nGNQSWG7y9KjCY=
X-Received: by 2002:aca:4d8:: with SMTP id 207mr8543892oie.88.1563805001959;
 Mon, 22 Jul 2019 07:16:41 -0700 (PDT)
MIME-Version: 1.0
From:   Ibrahim El Rhezzali <ibrahim.elrhezzali@gmail.com>
Date:   Mon, 22 Jul 2019 16:16:15 +0200
Message-ID: <CACi-FhDeAZecXSM36zroty6kpf2BCWLS=0R+dUwuB96LqFKuTA@mail.gmail.com>
Subject: [RFC] Improved git signing interface
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I have been selected by the Linux Foundation to work on a summer
project. I would like to abstract the git signing interface and add
support for signatures using decentralized identifiers (DID).
Decentralized identifiers are an emerging standard [0] that allows
individuals to control their own digital identities, and is often
called self-sovereign identity (SSI). The SSIMeetup is a good place to
learn more about SSI [1] and DIDs [2].

The project=E2=80=99s current goal is to abstract the current GPG interface
into a more =E2=80=98generic=E2=80=99 API that supports the existing OpenPG=
P and X.509
functionality while creating the ability to write additional signature
drivers.

I have implemented a prototype that works and passes all tests, and in
the coming weeks I plan to submit a series of patches for your review.
I first need to clean up the Git history to make it easy to follow. I
will also ensure that people using the current approach to GPG signing
can use the proposed approach with only minor changes. The flag
=E2=80=9C--gpg-sign=E2=80=9D would evolve to =E2=80=9C---sign=E2=80=9D, tho=
ugh I would like to
preserve an alias to the old flag if possible. My prototype has
already implemented configuration aliases to ensure that the new
approach is backwards compatible with previous configuration. I am
also working to update the documentation to explain the new approach.

You can inspect my work in my fork of Git here:
https://github.com/ibrahimel/did-git-impl

I created a view model diagram to describe the intended result and the
files that would be impacted and can be viewed here:
https://github.com/ibrahimel/did-git-impl/blob/did-git-impl-signing/Documen=
tation/technical/signing-interface.png

This project is a continuation of David Huseby=E2=80=99s previous work on t=
he
subject, which can be found here:
https://github.com/dhuseby/did-git-spec

Please let me know if you have any comment on the design and the
previous work done so far. I look forward to learning from your
experience.

Thanks,
Ibrahim

[0] https://w3c-ccg.github.io/did-spec/
[1] https://ssimeetup.org/story-open-ssi-standards-drummond-reed-evernym-we=
binar-1/
[2] https://ssimeetup.org/decentralized-identifiers-did-fundamental-block-s=
elf-sovereign-identity-drummond-reed-webinar-2/
