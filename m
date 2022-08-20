Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67879C25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 11:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345947AbiHTL72 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 07:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345255AbiHTL70 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 07:59:26 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0A39BB60
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 04:59:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o22so8451814edc.10
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 04:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=aNbxb0vlp9txzn5mOktKkQ1ivXtuTTiAqDJ1eWZ2t5A=;
        b=JRALEAbVeYFCJklLVknU+uJRFf4kxIUiHuudTtra2g8y8RZDtiyfk6OnY3WSClOdgg
         bS7mgJDqBxSkfREMI1Cd8VmyA4qrF2IvotWaPwBGfvcbKwFZdYP42rtZHiv/iMMqVaoW
         PMDNWAWsa8e7t8XjQbrZd8QEqNhcdSfRMWOvhwefOTE8Dn7YpdE2sfEV6EmcWOQM9stz
         vyHl1YKo2fIEtbS+wgt2pKlNJQ/Tz7deeecwePQEm3Jgr7g+s9FC0uq1mNHtthAM9DNb
         7nDEn/DBrl2gBS2gTR7kYghU5RcmRBNjWdM4c8gttffSIQjXcQIR09L6PZqJESNYCkO7
         RgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=aNbxb0vlp9txzn5mOktKkQ1ivXtuTTiAqDJ1eWZ2t5A=;
        b=1UmtzZs89nNOaRSy3wa/04bBEzeJ6aR8CENinUeuAXfiLO5HRtX26XSoKmcjXy73Jd
         FjiSXKZY0Jao50cWktSYBZAfIhWYO5eY4eEA9TDfWfbQLX/jjhmroxOR4pxtcG2jSc5d
         cWk2QY5hRQQz0ws/RB0GA5uaCY/zkKou6Hnucw/aUiAeypHWUWwZ+yB7uLHWiMugQlkx
         Yb6gEBV871CRW7JQmncPrfzPMNRL1ZFSzwWHhvzZTGv71JtV1cQFLooshDSNvkdoYHml
         qs0Q/WtxPkV5gxp/yRy7WLneMTmcIkn5UyqDezlpc8QUNPNyTi4noSUqIpg1sgRFoUkR
         zLiA==
X-Gm-Message-State: ACgBeo39riPNRuU2MnOB2a0uDGfOMbUePdTkzhXx/2lbyRPQUWhh5y1j
        hsbQFJqEl7KuYhiubSzdoWmWw4xrr4s0E1XpFV47Ubw54CsAQA==
X-Google-Smtp-Source: AA6agR40DX2Az+jF5ftv/SE+JWoRFzdZv6OpEZVmYuOu+9mHEfBFhVYfG2hvc1dX0bvEkpGPE55YtzqrE2naietAUfA=
X-Received: by 2002:a05:6402:270d:b0:43a:67b9:6eea with SMTP id
 y13-20020a056402270d00b0043a67b96eeamr9316638edd.94.1660996763247; Sat, 20
 Aug 2022 04:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <CADmGLV32OAg6HU+n1UsP2Fq-MjcyUsFFF=q0_jZCB0JEop5VUg@mail.gmail.com>
 <YwCe6ONEaeIj4SO/@coredump.intra.peff.net>
In-Reply-To: <YwCe6ONEaeIj4SO/@coredump.intra.peff.net>
From:   =?UTF-8?B?546L5bCP5bu6?= <littlejian8@gmail.com>
Date:   Sat, 20 Aug 2022 19:59:11 +0800
Message-ID: <CADmGLV2k9PGOMwS6zKwO6aY=aFJ7yvdgDkn8M2_XzPnEQkQQ0w@mail.gmail.com>
Subject: Re: git clone with basic auth in url directly returns authentication
 failure after 401 received under some git versions
To:     Jeff King <peff@peff.net>
Cc:     Daniel Stenberg <daniel@haxx.se>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you very much for your answer=EF=BC=81
Now I have a clear picture of what has been bothering me for a day.
Indeed, use an https url directly, and it works well.
Now I'm going to look into curl.

Jeff King <peff@peff.net> =E4=BA=8E2022=E5=B9=B48=E6=9C=8820=E6=97=A5=E5=91=
=A8=E5=85=AD 16:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Aug 20, 2022 at 10:51:16AM +0800, =E7=8E=8B=E5=B0=8F=E5=BB=BA wro=
te:
>
> > What's different between what you expected and what actually happened?
> >
> > When I use git v2.36.2  (docker image is alpine/git:v2.36.2) to clone
> > with basic auth in url, when receiving the 401, it directly returns
> > authentication failure, even recv head has www-authenticate: Basic
> > realm=3DRestricted,
> > and no request is send again. I think it should send request with
> > authorization: Basic header after receive 401.
> > And use git v2.34.2 (docker image is alpine/git:v2.34.1) to clone it wo=
rks well.
>
> I think the problem here is not the difference in Git versions, but
> rather in libcurl versions. I can reproduce your problem using the
> docker containers. But if I build locally, using the same version of
> curl, then I see the issue with both git versions.
>
> The problem is how curl handles cross-protocol redirects. From Git's
> perspective, we hand the credentials to libcurl, and ask it to fetch the
> requested URL, including following redirects. If it comes back with a
> 401, then we assume our credentials were bad.
>
> But what changed in curl is that it will now discard credentials during
> a redirect. And in your example, there's a redirect from http to https
> (uninteresting bits snipped from the output):
>
> > Info: Connected to xxx.xxx (xxx.xxx.xxx.xxx) port 80 (#0)
> > Send header: GET /xxx/xxx/info/refs?service=3Dgit-upload-pack HTTP/1.1
> > Recv header: HTTP/1.1 302 Found
> > Recv header: Location: https://xxx.xxx/xxx/xxx/info/refs?service=3Dgit-=
upload-pack
>
> In the older version, after the redirect we see a 401 and curl (not git)
> resends with the stored credentials.
>
> But in the newer version, we see this right after the redirect:
>
> > Info: Connection #0 to host xxx.xxx left intact
> > Info: Clear auth, redirects to port from 80 to 443
>
> So it is dropping the credential that Git gave it.
>
> The curl change seems to be from 620ea2141 (transfer: redirects to other
> protocols or ports clear auth, 2022-04-25). The goal is to avoid leaking
> credentials between ports: https://curl.se/docs/CVE-2022-27774.html
>
> So that makes sense, though I wonder if curl ought to make an exception
> for moving from 80 to 443 and http to https?
>
> I don't think there's otherwise much Git can do here. We thought we gave
> curl a username and password, but they weren't ultimately used. But Git
> won't reissue the request, because it assumes the auth was rejected.
>
> I guess we can ask curl if it saw a redirect, and assume if so that the
> auth was cleared. That feels a bit hacky. And it's subverting curl's
> attempt not to leak the credentials. In general, I'd like to defer as
> much as possible to curl's ideas of how to handle things, because
> they're much better at implementing http best practices than we are. :)
>
> Another option is to allow the user to set CURLOPT_UNRESTRICTED_AUTH,
> but that seems like a bad idea for the same reason.
>
> Hopefully that explains what's going on. The short answer for your case
> is: use an https url directly, and it should work. But there's an open
> question of whether curl ought to handle this limited redirect case more
> gracefully.
>
> -Peff
