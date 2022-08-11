Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9ECC19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 17:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbiHKRXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 13:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbiHKRXI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 13:23:08 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F5B15A18
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 10:22:24 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id k9-20020aa79729000000b0052d4dd3e2aeso7798989pfg.0
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 10:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:in-reply-to:date:from:to:cc;
        bh=QJTElCM4xbqIJpNc7sK35Ff/RL0+JJihH9HnYQq0z8o=;
        b=mBmY9mY3BS9/2SDiOl/XtQS1UNoYFdQFwF2QkkUiVYcb6fQy/z8uSEOWk7eb4eAaZw
         r/Q5Fe12uewdG7jBIQPku7rOhekB3BH/V7wYEHXM3HQuqPOG9sNvhe4J4QuVAoOTaBIm
         3MbnQo5Na1bCn/+zlLC//HXek3HTRTz5ONmt9+/iToLFK4iXVgw/jeU4osezXcz6Cshd
         0YOzn+tet6wggaxQwoC6ZT82wwCO8DjhMBZgS7Bnt4CXMMrOrQ/NMJ/VxgsMJRjJrsjB
         aOTPWc2YY6LafShC0LYED6OgY1Uxie0v394tNbzzP37n4ewB85Bp74nRsLfaFsCizxi/
         quxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc;
        bh=QJTElCM4xbqIJpNc7sK35Ff/RL0+JJihH9HnYQq0z8o=;
        b=YfJJ9wGEt9Fh4WEKa2jxibHs0qm+v/AGbVkEdGQ7vy1sziI2GW9aJ4YT4EeZhyZjEt
         61UsVtz9bOHv/5oBBerQ0nKh+pZ7Y37ZjCvYGNIXXsOeJW0ADQB8qBlO1aO7iJtNelWQ
         nzlNgrxDKjon3CmpPVNDQXVJb1v4FaV/q3JNotDEQs7shaswo67d23kkEPQftxfPjieK
         UYm1r4B7T+YNCA+1YAaJ1T7d9MO9tkO+1ENi7YXtqVG3cSrxQnDPTAOFNj54LMwmlpSa
         mI2is45vJSdesNbGCc83ZQ7jFAXWS2AjOuZIo4d8Esn1b4H+ga8YhnLyyC+Yc6xEkAqG
         wMFA==
X-Gm-Message-State: ACgBeo142ic12T+QTF56e7QA7h+4izZ7B+D3lC+4CouefvDe7IyXgags
        gZqEW7ycTR5UV/l9/0BOVkifNH+entSuu7M5Ua2w
X-Google-Smtp-Source: AA6agR7Azs+Q8MpzdhW9b/ChYG6lhYRqXB5D+q3GWwRwJHCqJvND+BBBMt7BP1u7FjH41PcwaYgYtb+9O9j8LcJhar3q
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:1356:0:b0:41d:8edf:8ab1 with
 SMTP id 22-20020a631356000000b0041d8edf8ab1mr99430pgt.268.1660238543710; Thu,
 11 Aug 2022 10:22:23 -0700 (PDT)
Date:   Thu, 11 Aug 2022 10:22:19 -0700
In-Reply-To: <bfa3de4485614badb4a27d8cfba99968@xiaomi.com>
Message-Id: <20220811172219.2308120-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: Re: Partial-clone cause big performance impact on server
From:   Jonathan Tan <jonathantanmy@google.com>
To:     "=?UTF-8?q?=E7=A8=8B=E6=B4=8B?=" <chengyang@xiaomi.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "=?UTF-8?q?=E4=BD=95=E6=B5=A9?=" <hehao@xiaomi.com>,
        "=?UTF-8?q?Xin7=20Ma=20=E9=A9=AC=E9=91=AB?=" <maxin7@xiaomi.com>,
        "=?UTF-8?q?=E7=9F=B3=E5=A5=89=E5=85=B5?=" <shifengbing@xiaomi.com>,
        "=?UTF-8?q?=E5=87=A1=E5=86=9B=E8=BE=89?=" <fanjunhui@xiaomi.com>,
        "=?UTF-8?q?=E7=8E=8B=E6=B1=89=E5=9F=BA?=" <wanghanji@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E7=A8=8B=E6=B4=8B <chengyang@xiaomi.com> writes:
>     3. with GIT_TRACE_PACKET=3D1. We found on big repositories (200K+refs=
, 6m+ objects). Git will sends 40k want.
>     4. And we then track our server(which is gerrit with jgit). We found =
the server is couting objects. Then we check those 40k objects, most of the=
m are blobs rather than commit. (which means they're not in bitmap)
>     5. We believe that's the root cause of our problem. Git sends too man=
y "want SHA1" which are not in bitmap, cause the server to count objects  f=
requently, which then slow down the server.
>=20
> What we want is, download the things we need to checkout to specific comm=
it. But if one commit contain so many objects (like us , 40k+). It takes mo=
re time to counting than downloading.
> Is it possible to let git only send "commit want" rather than all the obj=
ects SHA1 one by one?

On a technical level, it may be possible - at the point in the Git code
where the batch prefetch occurs, I'm not sure if we have the commit, but
we could plumb the commit information there. (We have the tree, but this
doesn't help us here because as far as I know, the tree won't be in the
bitmap so the server would need to count objects anyway, resulting in
the same problem.)

However, sending only commits as wants would mean that we would be
fetching more blobs than needed. For example, if we were to clone (with
checkout) and then checkout HEAD^, sending a "commit want" for the
latter checkout would result in all blobs referenced by the commit's
tree being fetched and not only the blobs that are different.

One idea that we (at $DAYJOB) had is to supply a commit hint so that the
server can first use bitmaps to narrow down the objects that need to be
checked. I had a preliminary patch for that [1] but as of now, no one
has continued pursuing that idea.

[1] https://lore.kernel.org/git/20201215200207.1083655-1-jonathantanmy@goog=
le.com/
