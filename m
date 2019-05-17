Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E35381F461
	for <e@80x24.org>; Fri, 17 May 2019 07:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfEQHVJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 03:21:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37917 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbfEQHVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 03:21:09 -0400
Received: by mail-io1-f67.google.com with SMTP id x24so4709407ion.5
        for <git@vger.kernel.org>; Fri, 17 May 2019 00:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n+DLCz/GaXUr5UoXVoUU3say+LgrnO7vAWWg3yGBuxg=;
        b=DAUKwM3Yp3PV9yJkIYYyEyXryBMwhtqq3smb5OSuWvex3EmXq7xvBFkcQ3pHDyv0aA
         2CACa3Av/uJcvJVJD3hJLPF6Ngl1LOgfV3uB7a6L0Qy99IdCvBISX2dZC3JWnJum3bBq
         X/NSLHdKFjARF2TO3ixyWND9cX6qKgMnNObfofQUROded3uxxPbnnH+yG9CLgIwtBFII
         YXFqSxwKkqbPcyVusVg2WyTrJkgI7x/f0YqveBIR9HzBp6av4ePBYxq14jGpzDa+4Xm2
         e37gMqe3BZzeiaxF0o6DyjHVEjfBgDGE3wS8qsZwqHXV2e1iOoSb8HKkmqaW0tfKKn65
         YYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+DLCz/GaXUr5UoXVoUU3say+LgrnO7vAWWg3yGBuxg=;
        b=CmXwKFz4k3ds5FHxzYF6EL4Bj06agfvvKbd2dzMfVP+D2Sp6lsH6Te43SIliT0ok5B
         S1fuks11ZFyd1F+upkQtgRTlmXnGEadUi9VtiRAF+UiQpijeGt8Be/ViUDLSPv+qS4B0
         F53EEUDZ5Lo9TKxPn5Row8IMPi5bM8tdbmsZX3GDwGVjfCRO1Jb2cXiIzIkTkkRFyuvY
         4o5vL9+Ku94X9cxT9NzjmALWsRT/AyPTrJHpBTiATBBpWVUj+yh7xCgjjNE4EU9bBXPo
         kiGXvgt1S5GluWms8w0JUbvS/1je1Qh1d5HdElr4LiBbeV30rJbMnTIikI7kuOT5N8hG
         KVoQ==
X-Gm-Message-State: APjAAAUdOF34yRKyesR3sfX+tbjobaLGmKIh3u7++OCUoTbG6dttJr+s
        7KKojZ+LdBaZbAXQLLt7IB9R64LmsmbWA5MrI9w=
X-Google-Smtp-Source: APXvYqz3jui6PlGTr039OW0gQjGS7I9020rbdJxKGTE48Mp1kPi7wqFEoHkGl4v1u6EPmP8kyY8egUXeNqV5Twg0GBQ=
X-Received: by 2002:a6b:b485:: with SMTP id d127mr30199828iof.273.1558077668728;
 Fri, 17 May 2019 00:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190516214257.GD10787@sigill.intra.peff.net> <20190516231509.253998-1-jonathantanmy@google.com>
 <20190517010950.GA30146@sigill.intra.peff.net> <20190517012234.GA31027@sigill.intra.peff.net>
 <20190517043939.GA12063@sigill.intra.peff.net>
In-Reply-To: <20190517043939.GA12063@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 17 May 2019 14:20:42 +0700
Message-ID: <CACsJy8CNyug3wvZ+6ts1nzgWyPF1JqC0LceP-HzMHjqvCr2Ugw@mail.gmail.com>
Subject: Re: [PATCH 2/2] index-pack: prefetch missing REF_DELTA bases
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 17, 2019 at 12:35 PM Jeff King <peff@peff.net> wrote:
> As it turns out, index-pack does not handle these complicated cases at
> all! In the final fix_unresolved_deltas(), we are only looking for thin
> deltas, and anything that was not yet resolved is assumed to be a thin
> object. In many of these cases we _could_ resolve them if we tried
> harder. But that is good news for us because it means that these
> expectations about delta relationships are already there, and the
> pre-fetch done by your patch should always be 100% correct and
> efficient.

Is it worth keeping some of these notes in the "third pass" comment
block in index-pack.c to help future readers?
-- 
Duy
