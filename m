Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017A8C77B72
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 07:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDTH3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 03:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjDTH3R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 03:29:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E8459C4
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 00:28:54 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dx24so4128306ejb.11
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 00:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681975733; x=1684567733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HyC+rbNwgNezMsGyPSJxR9vweVdmNyias1Ij1gF6Z0=;
        b=MxzjilfBQlfreWJHbaLBr7JpssDfnZH+L7m0cnBM27fItjJikvU13QNBqZBHSGtsdO
         bPUdGWAuW5i5w905AcqsHRD2RfOCF/K7ub7pV1NP+aT12sIk4te+ZzPLV7L4bPLhUFrD
         KBCQB9ZXIz322Yzl3B177QnM4gTXPNy+TGc/Wl4gVjMLExLd/yauN6WtqF0Mihpj9veT
         xunOEO9QHinKDl423/1PI/rV66xoaVusAiQ0RyQqrEmL7yZioSPxfQ+avq7a3TnX2LP7
         CGhM8vntCCw/ZgASW0yBcminqpEh3cYAEWS1jXXrxvEZ1mpYKVa6kE03t7uGrXb9mIm0
         H47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681975733; x=1684567733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HyC+rbNwgNezMsGyPSJxR9vweVdmNyias1Ij1gF6Z0=;
        b=VXBIZ4R2wXSI7Vz8CQe4OLy6cSF/bywpvae4RFDuEnpQiCsevb4hjq5LIsdC60zqFa
         BM6N/eCxK2x6uND4bY98JVBMU81MrNA6VtN7dxrXWUAwVWeTBuoQGz53aWgj8sWnfmFA
         T8xNIL17/aYXK8biHiVKzO/W6BKroEAy49p4r8VKAuFcjz899kfI5nkn1LOu8Nb7ek6g
         N//c7pEQYds+gOIKmY1vzFzR88JqJo+qOFsiXeLbBVzKTEyHDqXUXxggO0T9W9fkB43L
         nk8yjHZpjYjmRGUaSL9Vdnolwq1Qf4wCNaAXQrSDr8AcKCtyPnBsvD+txC22xmEG4pW8
         nPSg==
X-Gm-Message-State: AAQBX9f+ELuZXs10o6SUb+TPdJk5iC52Ve7Yvfmkh6jLm9edCQhi/wSz
        BYu3FxA5zb4/0leAR2BToSzE/bCufIXhIG7P0rk=
X-Google-Smtp-Source: AKy350Z80h3n9/yAf2I9L+2G7O5kTbE3yI4AnWwgstSzRWR+e6rmnoN4/7aObw7GEhFxhu3xkgH648oEV/fGWy+PKSc=
X-Received: by 2002:a17:906:6a06:b0:94a:682f:7744 with SMTP id
 qw6-20020a1709066a0600b0094a682f7744mr893619ejc.16.1681975732795; Thu, 20 Apr
 2023 00:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAAp-DqK=CPxpH0ZhA=k8GRFvSz3odoOLhOgAqfYSBpz28JK+hg@mail.gmail.com>
 <20230413190302.drmmdrkv7vfps3qg@tb-raspi4> <xmqqfs93y166.fsf@gitster.g> <CAAp-DqKzutP2JQB25kzyMG56=sqArpqZ0341-ayaV48pca4skA@mail.gmail.com>
In-Reply-To: <CAAp-DqKzutP2JQB25kzyMG56=sqArpqZ0341-ayaV48pca4skA@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Thu, 20 Apr 2023 00:28:41 -0700
Message-ID: <CAPx1GvdsH-wO64sE3k5M_KAJy+x2o=LvGHLY+-sqksD7bJ2NKg@mail.gmail.com>
Subject: Re: Git branch capitalisation bug?
To:     Ilya Kamenshchikov <ikamenshchikov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2023 at 12:08=E2=80=AFAM Ilya Kamenshchikov
<ikamenshchikov@gmail.com> wrote:
> I've recollected the history of how this issue occurred more and did
> few more tests. I'm now working with branch named "feature/git_repro":
> 1) The error first occurred when I worked with a colleague on a same
> branch, and he really used capital "Feature/branch".

The bug -- or "feature", depending on how you believe this all
*should* work -- is simple in concept and difficult in
reproduction because there are multiple moving parts.

Here's the concept:

 * In Git, branch names are always case sensitive.

 * But Git *sometimes* relies on the *OS* / file-system to
   implement this.

 * Some OSes / file-systems are case *in*sensitive.

When Git uses a case-INsensitive file-system to store a case-
sensitive branch name component, the OS / file-system loses the
case distinction. Exactly how that happens is up to the OS /
file-system, but we can see how common macOS and Windows systems
do it.

On these systems, when creating a file or directory, the *first*
creation attempt "wins". That is, if any command or process
goes to create a file or directory named "Feature", and no such
file or directory exists *now*, the file or directory is created
with precisely this set of casing. But if the file or directory
*already exists* in any casing (upper and/or lower), the system
uses the existing one: if "feature" exists, that's the name, or
if "featURE" exists, *that* is the name that is used.

So, if and when Git stores a branch name or component as a file-
system file or directory name *and* the system itself imposes this
case-folding match-some-existing-name scheme, Git's case
distinction -- the fact that Git considers "feature" and "Feature"
entirely different names -- is lost. Git is sure these are
different and will stay different, but they aren't and don't.

When Git reads these names back later, it finds the system's
names, rather than the ones Git attempted to store. Git believes
the system's names, rather than its own.

Sometimes, however, Git stores branch names in memory or in
file data, where this kind of case-folding never occurs. During
such periods, feature/git_repo and Feature/git_repo remain
different, distinct branch names.

To reproduce the problem, then, you must:

 1. mix a case-sensitive system (e.g., a typical Linux setup
    as found on GitHub) with a case-insensitive one (e.g., a
    typical Windows or macOS system);

 2. use the case-insensitive one yourself -- using the case-
    sensitive system you will see branch names as they actually
    appear, since they are never converted by the OS / file-system;

 3. set up the problem; and

 4. make sure Git stores the branch names in directories and
    files, rather than in the .git/packed-refs file.

The cure for this would be for Git to stop using the file system's
names directly, the way it does now. There are some long term
projects to make this happen, but little progress has happened
with them.

Until then, the way to avoid the problem is simple:

 A) insist that everyone use the same kind of OS, and/or
 B) be careful not to depend on case differences.

Method (A) tends to be impractical but method (B) is easy: just
make sure all users use all-lowercase all the time, at least for
branch names. It's not very nice, but it's practical.

Chris
