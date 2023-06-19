Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832E8EB64DA
	for <git@archiver.kernel.org>; Mon, 19 Jun 2023 15:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjFSPNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jun 2023 11:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjFSPNo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2023 11:13:44 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2E8E42
        for <git@vger.kernel.org>; Mon, 19 Jun 2023 08:13:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f865f0e16cso2641442e87.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2023 08:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687187613; x=1689779613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=au9nlderFLJAM9WPTw9zPOI4cfFYGZP4LCMecITuzvU=;
        b=QhoOXyq9YTn9oyvWESDja98DOU3JQ5yu7foVQWpcsEIYTFYfoX7NaqhQdor4g1FSTI
         jvlZKW612EjRjREY6cw9YFA4wJoKZK17sJLzN6ZUXcqacKOvgI9nNIKwqoyYrvB5IAA4
         pYoYfWN4UIOp0rI8XDPoGI1efgxoy5l0EJctKJB9FdbCVScPRIsriKFEOnx0uJJo4fzO
         c35FSs/+VsGPgf9vNgMPXx2wOzzzDEt+Sl+rUIg/j6nwk5nHAYTvBbSyDPOmSW1kKT3+
         PGvbrhBr3fqDLxAb3lVJuXACkySRlxW8vkWb9qhovfQcRwFtDF5g6IPaEjyWLeXFCfnh
         tBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187613; x=1689779613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=au9nlderFLJAM9WPTw9zPOI4cfFYGZP4LCMecITuzvU=;
        b=DZLP9lpguHgeeaTVuy5/RXE36wQ4NyyFYLT6eoLZHRGqoxuAq+PxmcJhyL4rz/Rp5q
         qoRK2CjUQz0I1TkHCBLEC5S2I5iGVxjocxWMBLjJKmTNgSgciZgPgdNHc9vX9VxwI/G9
         OBT49NuGa3jmYmM30qSvPTPmjgm5uQLRU7Yu3Ud/cuWyfewfC6/aGeXu3TaE2k2NTLfh
         IPl6XtzFEPcoBLelZrtjXfaH6vCff3Pya/sqOtLC/yO8lQXFaKQr39lgvDPui6d7x/0u
         8tKcopOUxHPmCVAgOUGA+ulVo8reGyNB2S+APJzHGsP9TjQWdgVqEcGHgewzX082xP4y
         /v1Q==
X-Gm-Message-State: AC+VfDxyLL9fHn99po39JkB2x+ptelAJNrBRXQlL38BXKkMmUTdXiAJS
        /rI2DLubYl4gwxBoNXxE69LEPEoHPRJ+te5hRLE=
X-Google-Smtp-Source: ACHHUZ5OYeap3knPvhTKtnD+SavAXLSvdK/7j3xl8Hr08ChxrUjbJdEKya7wyf/Qg6Dm5bt+THp40VeO1T2eCPLDbgg=
X-Received: by 2002:a19:f24a:0:b0:4f7:940f:913 with SMTP id
 d10-20020a19f24a000000b004f7940f0913mr5125765lfk.50.1687187612685; Mon, 19
 Jun 2023 08:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <PH7PR07MB9467452EBAFAB2C825295C0C8C5BA@PH7PR07MB9467.namprd07.prod.outlook.com>
 <42e4373e-b700-45a6-99cc-db2f8896d5b7@app.fastmail.com> <20230616042407.GA54009@coredump.intra.peff.net>
 <CAP8UFD2JYAFv=iTDzvn4fzwYpJHt7TBLMXV0GV1-S7tXd7Bp=A@mail.gmail.com> <20230617042624.GA562686@coredump.intra.peff.net>
In-Reply-To: <20230617042624.GA562686@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 19 Jun 2023 17:13:21 +0200
Message-ID: <CAP8UFD1+SVCoRxp2wSrXvKPoNQjL_zCxix726veYPPqs3aA-PQ@mail.gmail.com>
Subject: Re: [PATCH] commit: pass --no-divider to interpret-trailers
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Christian Couder <chriscool@tuxfamily.org>,
        "eric.frederich@siemens.com" <eric.frederich@siemens.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 17, 2023 at 6:26=E2=80=AFAM Jeff King <peff@peff.net> wrote:

> Thanks for confirming. Here it is with a test and commit message.

Reviewed and it looks great. Thanks!
