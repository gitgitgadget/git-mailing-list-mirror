Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE023C77B61
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 16:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjDJQr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 12:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjDJQrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 12:47:25 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317B81BC1
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 09:47:24 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z26so6997582lfj.11
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 09:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681145242; x=1683737242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECCNalpAR3bK4z9IO/+18sUAtSsEQKFpT6pUp1B5lTI=;
        b=Izha0l4D3x81rCbGQFkimiDmOUVtTnmFJBWwWUyWejQ+v4bvhXchwifApV+896HZQq
         MDtbq7PkUKMCSM3P2wDADNryq8v1QGiTekqkFrxkHEw/bzr8rssa00R0d0820Ny3nKt8
         gqGOc3AN3Oli3fz4fwzl/BdT5TSBM3yFL3F6cNMu6fN6wXCS40zZy//lgIH7pHGqjvfC
         fzXi7eozpd8m9rFAcuQ69E6fHkO1mF7JIhaXOZCWuRRKGvYpjCAiuDLvj6zKquogShVz
         D8/6j2RAX2j0wO9S1qbgJxn1Pn9b17sl2giwvXf7/C6zn8APrUUzdWJdftYopduy/KuG
         HWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681145242; x=1683737242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECCNalpAR3bK4z9IO/+18sUAtSsEQKFpT6pUp1B5lTI=;
        b=5DSBTEv0l4ZR3twpk5ODSoXcKpg3hXRMi8bNXB8ydPZGMgt8j9Y3emTJobSgAAD5nj
         7N6j2Intk1p0sssI0P1oMtxllGd0gkdRGzmJp+jzCKQaBYJHVpby1Vm93X97wfTFJVsD
         +lYl2gfSXnICTkMe0IQO6ezYVe1V16j84MQSEE4VE2z8QAhDIo1QJe4+WfeiHlLTOAz5
         BlIuuON6B/Th8aWLgSBwQTqnII9+D2jEBUG1zdvWLxOLjhPxYQX+6x8c4G/45P14SFnw
         xxYHtTRpmg7qUNPT1PqCtPMs0F7y8Q5JMOnQ+glog7u30wAuHmAY/8YUOvuRn394Y5qR
         lNmA==
X-Gm-Message-State: AAQBX9dDFXX6lCwm7oK2sDI5wrg5uTll/qy47m1y/8Z+KXyak0r/P2yN
        Dm+UOgtx/oeU9hE8bt2iQXlMXqcRlyZHf/OJ6eI=
X-Google-Smtp-Source: AKy350aPdJXcNkiIsCLbh7WL3zq/Vb/5hLpQdrMPqQl7bEUT8fXP1LxAZKrWMzOsfIIfjayziggwNi5FeHSLgjoD9CE=
X-Received: by 2002:a05:6512:3996:b0:4e8:4409:bb76 with SMTP id
 j22-20020a056512399600b004e84409bb76mr4692872lfu.2.1681145242430; Mon, 10 Apr
 2023 09:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <47afc6a6c8757032d9d69a2f9aaaeb427c5a003f.1680571352.git.gitgitgadget@gmail.com>
 <20230405172840.730076-1-calvinwan@google.com> <CABPp-BEurqhk32hC041kcXiVNpVXx3YzJMyzDh4E=ctBLemz8A@mail.gmail.com>
 <CAFySSZD-9Ui8v0Ki1j96zouAB=sCRT0qBWOhb5-A4TfizpOqfw@mail.gmail.com>
In-Reply-To: <CAFySSZD-9Ui8v0Ki1j96zouAB=sCRT0qBWOhb5-A4TfizpOqfw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 Apr 2023 09:47:10 -0700
Message-ID: <CABPp-BEtAVWE3voSPzdL0495cWnMxOWHECXYzwpeHCSRXA33Xg@mail.gmail.com>
Subject: Re: [PATCH v2 21/24] strbuf: move forward declarations to beginning
 of file
To:     Calvin Wan <calvinwan@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2023 at 8:52=E2=80=AFAM Calvin Wan <calvinwan@google.com> w=
rote:
>
> I do have this change in one of my series already, and since I'm
> planning on removing the declarations anyways, dropping this patch for
> now would be my recommendation.

Cool, I'll submit a reroll tonight with this patch dropped.
