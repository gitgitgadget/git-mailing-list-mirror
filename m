Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31B4EB64DD
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 11:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjHILK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 07:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjHILK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 07:10:56 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E4F1FCE
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 04:10:54 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d5fdb29b7d3so103845276.0
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 04:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691579453; x=1692184253;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=1tmgl3LlRE5TeAx0li91HzsM7mxnCWbld31o+zqaiJQ=;
        b=Zo2yM2XQZyMuODEb0FNqB9uw1ryQfbdbcUfQjoonVkkmwd/ahgGVcxQrDwatnM91SV
         +zunEVVDkFEC0bzX4+znn4nquFcLUueZg06zUdv5Gx/kk01k7DuPAeDNk37MOgOicwlZ
         MNmVdLWnsdaLqar5O1Exy6d7cr8AtErvcK1dFwKNQ+ih9kvPWHVLSBztfOEGdcW+GAAD
         x3Ff8NtY+20XYv8G28HP5F9/Ce6o5nbms4AmPe6mk8OwhGeK1/cRDK2jUfaGxGQcktCT
         wq7c79Riu7QmHxNWdSjV2/T0SW0Yr2RZhbedUYzhK9lZdBe92jup10UQk8UcKmPnuEYh
         qfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691579453; x=1692184253;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tmgl3LlRE5TeAx0li91HzsM7mxnCWbld31o+zqaiJQ=;
        b=jvhcxoZ0Ov+BXoSoqIjKMxj7+AHbKuQoFNYjSkPOVLZfo7Gjx+WiuEEqFHd4tO+LoF
         aK3tDulgDG+3PErEYsIv3ELKgfRm8CZuiWt56ldQNNP0zDG1DbRptFgO/sQ8exf3lbJs
         Yb62QvDloqLrd7O8Be4sq8ksJdI8+BbzSZDYeCY12MPm1DT60334+6GFqKfVYw5gQPkO
         oa9kVjvlZhuWv6u43sTgK639Hu3xPz1zz5a0SjBy3JmUVRfs7q/7Rs26SL/gC9WZvHNg
         g9z2U5q/dVteTm1Kpy4vNffbDd4ddB1sq4VLRsIU9iW/jYTZJcEiyHu+XxuzpRns9TYE
         Sw4Q==
X-Gm-Message-State: AOJu0Yz6jgQ2z5+i75BjLHtLoROb0enp1f2iZxUS3bed4/JG2Mn8iUrD
        UsdjMdq4BiIfp61ZqQ5LG2pY6smoJ8Y=
X-Google-Smtp-Source: AGHT+IENEw3rt0GX0fXPP3a0EUII1p7Gt7u2k+dAlzpDfSO1yYuJ9hzr34k12AOIcMMhm1Ax/aMB0Q==
X-Received: by 2002:a25:68c1:0:b0:d0f:a9b7:e7d1 with SMTP id d184-20020a2568c1000000b00d0fa9b7e7d1mr1055435ybc.5.1691579453030;
        Wed, 09 Aug 2023 04:10:53 -0700 (PDT)
Received: from epic96565.epic.com ([2620:72:0:6480::18f])
        by smtp.gmail.com with ESMTPSA id j131-20020a255589000000b00d0bad22d652sm3322495ybb.36.2023.08.09.04.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 04:10:52 -0700 (PDT)
References: <676330b6-720a-e262-d583-9012e549bba7@opperschaap.net>
User-agent: mu4e 1.11.1; emacs 29.1
From:   Sean Allred <allred.sean@gmail.com>
To:     Wesley <wesleys@opperschaap.net>
Cc:     git@vger.kernel.org
Subject: Re: git pre-push hook not getting the lines from STDIN
Date:   Wed, 09 Aug 2023 06:00:32 -0500
In-reply-to: <676330b6-720a-e262-d583-9012e549bba7@opperschaap.net>
Message-ID: <m0wmy4lbd0.fsf@epic96565.epic.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Wesley <wesleys@opperschaap.net> writes:

> Hello list,
>
> I'm trying to figure out how I can check which branches are used in a
> git push action while using the pre-push hook.

> ----< The pre-push script
>
> #!/usr/bin/env zsh
> #
> set -x
>
> remote="$1"
> url="$2"
>
> success=128
>
> z40=0000000000000000000000000000000000000000
> IFS=' '
>
> read LOCAL_REF LOCAL_SHA REMOTE_REF REMOTE_SHA
>
> echo $LOCAL_REF
> echo $LOCAL_SHA
> echo $REMOTE_REF
> echo $REMOTE_SHA
>
> # deletion of remote branch
> [ "$LOCAL_REF" = $z40 ] && exit $success
> # git 2.40 at least does not have $z40 as a delete
> [ "$LOCAL_REF" = '(delete)' ] && exit $success
>
> exit $success

Have you looked at simplifying this script to the bare minimum to
identify the issue? I might suggest starting by just slurping stdin and
writing that to a file:

    #!/bin/sh
    echo "$@" >pre-push.$$.args
    cat >>pre-push.$$.stdin
    exit 1

(The 'exit 1' here is to unconditionally prevent the push from actually
going through during testing. Likely similar to your '128' value, since
actual success of course should be exit code '0'.)

From here, you can test your pre-push hook by using that file as stdin:

    ./my-hook $(cat pre-push.$$.args) <pre-push.12345.stdin

I'm not familiar with the particulars of Zsh scripting, but I suspect
there is a bug in your script. Zsh works with my script, too, so it
doesn't appear to be a problem with Zsh itself.

--
Sean Allred
