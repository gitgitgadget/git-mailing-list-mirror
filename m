Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA76C33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 10:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F79420720
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 10:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="MxSeoDl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgA2KfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:35:19 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:37307 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgA2KfT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 05:35:19 -0500
Received: by mail-wr1-f43.google.com with SMTP id w15so19590598wru.4
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 02:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=105+rO+X1toKA+Xuu7VFQuw67BUdOkNnV9MqFm3i0ck=;
        b=MxSeoDl8vVF7b+wrd/aoLGpOl1V3OT0HPobvrFMKfwh+kETIMPP/04zG5ggOrHVFMs
         WOBkaZAms0wZXFNl+/DyLh5BsZjcItp096+Z4wp0cCWjiakeGPos+hpIfr7dOGa+Qv/b
         16T7nIB2ZbhgFGtEo62Cw2PO74ytdUHU4I7ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=105+rO+X1toKA+Xuu7VFQuw67BUdOkNnV9MqFm3i0ck=;
        b=WjA0RBnuaiyD02rIo+a2dNGQuQ6WMwzlwjM6H8E+9+tuKfM4csP5Gwy4rMY9Z3A/TI
         9rUH+YbMghi6dtRjYyufY4+kuUnFxw1ue1JhBqIEsneJwxQykCTW/RxkYw8LjJosIapG
         NCfkA1eQiiIpq6lOKNVN4ZzRz72cFdfG5QcvplX0oMjHKnUiQgL2+f7pGMGX/8FNI85u
         oIjsLDXR5XPWGn1rYor7og59SiklmU4NudT5ftllSlpyy9OJiQpTVQqAuXlUwsrMSVW6
         7Z+Ee/VN8gxBGzKUYRkUzZPEsXfQjNr7Ez+XHcfCAVGBYCLRQ7qY7D1bh76oh1g7GcZa
         v+sQ==
X-Gm-Message-State: APjAAAWvlOduRhYhrFM4z6LmNAZ8L3rnMZfs3Rl02D4FhYYre1QrGQWZ
        rXDmopeUBcLnm0ZFUghqKi5JfOEtYVLmFB/LVlw0Ry+gMyA=
X-Google-Smtp-Source: APXvYqx74yJ8HwGQIyTK24RolQvXig1jV63oqz9nMZxHuUfdK6v9h0BXC0N87tz1Cx/Kip3Q5VzPjZk1cTsA9MDRYCI=
X-Received: by 2002:a5d:5044:: with SMTP id h4mr32885846wrt.4.1580294117196;
 Wed, 29 Jan 2020 02:35:17 -0800 (PST)
MIME-Version: 1.0
References: <CAPgZwKbZ0g+VXjnD03hGkRXfwU2DpygLhLBFG3xv1W9c8oQ1fQ@mail.gmail.com>
In-Reply-To: <CAPgZwKbZ0g+VXjnD03hGkRXfwU2DpygLhLBFG3xv1W9c8oQ1fQ@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 29 Jan 2020 10:35:06 +0000
Message-ID: <CAE5ih79j+o87yEPbj+nFR6b4rx_NU2eLJite69=+qMdpXdEidw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_git=2Dp4_cannot_use_perforce_client_created_by_p4j?=
        =?UTF-8?Q?ava_=E2=80=94_=22Expected_view_key_View1_missing=22?=
To:     Ivan Selin <ivan.selin@toptal.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 7 Jan 2020 at 15:53, Ivan Selin <ivan.selin@toptal.com> wrote:
>
> Hello!
>
> If I create a perforce client from java using p4java, it gets created
> with an extra key "ViewDepotType" in client definition. When I try to
> do `git p4 sync --use-client-spec`, git-p4 dies with message like
> "Expected view key View1 missing" =E2=80=94 because it assumes that all k=
eys
> starting with "View" are "View0", "View1" and so on.
>
> How to reproduce:
> 1) Create perforce repository;
> 2) Create a perforce client (let's name it "my-client") in said
> perforce repository using p4java; add one view mapping to the client
> on creation;
> 3) Run `P4CLIENT=3Dmy-client git p4 sync --use-client-spec`;
> 4) git p4 finishes with error "Expected view key View1 missing".
>
> Attaching hexdumped/unmarshalled examples of "regular" client
> definition and client created with p4java. Note that p4java's version
> has "ViewDepotType" key and regular client does not. Also,
> "ViewDepotType" key is not showing up in text output of `p4 client
> -o`, only in binary format (`p4 -G client -o`). And I'm attaching a
> patch that solved the issue for me.
>
> Is that information enough or should I add anything else? I'm new to
> git community, but willing to help.

I suspect the problem lies at around line 4220 of git-p4, where it does thi=
s:

     view_keys =3D [ k for k in entry.keys() if k.startswith("View") ]

I think changing that startswith to a regex match would fix this,
although I have not tried it.
Something like:

is_view =3D re.compile(r'^View\d+$')
view_keys =3D [ k for k in entry.keys() if is_view.match(k) ]


>
> Regards,
> Ivan.
