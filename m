Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC627C77B7F
	for <git@archiver.kernel.org>; Thu, 11 May 2023 18:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238988AbjEKSRL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 14:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238860AbjEKSRK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 14:17:10 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6E94680
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:17:08 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1925ad4953dso4138110fac.2
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683829028; x=1686421028;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vauGln/REfWdoOlqTj0q6hsfS9hUBR3GJk6oVe1SIjs=;
        b=bCiT+pjA2UTfnYPoQFYS4xJ9dT6gct1b6ZpAS4znT4J3o1ZeRQlec/JOM6Zd9jBVIV
         ZtC2MgZB9uG6fzKPDTTytSAe7ukvR/SdLBo1xyFH0GFWs6VnyoGD3FfVeTdpY9YKjgTo
         PIT9esPQJgc3T8lWn+Xz4ApU92QD8P3Gw0f969FCsUFH51uF5V+UmbUDCoTHeWnuj7nj
         eG9x0GcB4TMirarcF4JSWOBQwOxXQwCoZ8VUX7+jn9JxFepQ0iUFb9BwiJTBRBYvyOqZ
         DD8Yj3TB69lB7WdlmbGS7Fo/+i+S2axl99RMGihvEqhagt7vyyNoSdb503MfHMZEu46Q
         eulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683829028; x=1686421028;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vauGln/REfWdoOlqTj0q6hsfS9hUBR3GJk6oVe1SIjs=;
        b=bKA5VpVmscSfTJQ8i4cZ7fmPRdnR3NqhiFjty4yvHZaFFWsGA32Na7g6I2l4VvchYD
         cMAnqv05dbx1lJ+Xnd4c/vwfIw8why5YY+5ZWkmkrFrdCEtYtAJD1zWpsfJFlBI1MlOe
         OYF6a37r1Nd7vJ6uAw/u3ri18RF/6D18AdNBXCptQ5o6H4E/sOH3/OAUDmL8gMJ0XVMj
         17lt6VS+Ne91DvcPBWSVhGu2I6NxmEwiaxFz7ZULo5+/2Ve7YH7D55VcoGoDBZPDgj7g
         GksQA5tyYMza4YFLrJdmMS/Byh5B8VkxP3HmuNagfmDYA8NWwFMfS1hElQJN7V+Z53Zv
         /5RQ==
X-Gm-Message-State: AC+VfDxEtDxjQR08PAa/Ae6e50588eZknxQMwCqfP2rq2vkd9HC/iuip
        4j0zbKThoYSzpGqAMM4gLjg=
X-Google-Smtp-Source: ACHHUZ6ZwqELK8ACTgNXR7J/fozpEdvbnADLhCmO2uTjUUqx1XhmX1eHwrqV9yWJkSm1n9bp0LNfyA==
X-Received: by 2002:a05:6870:4c3:b0:17a:d44e:81b3 with SMTP id u3-20020a05687004c300b0017ad44e81b3mr10040721oam.55.1683829028066;
        Thu, 11 May 2023 11:17:08 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id y4-20020a056870e50400b001762ce27f9asm8248775oag.23.2023.05.11.11.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:17:07 -0700 (PDT)
Date:   Thu, 11 May 2023 12:17:06 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Message-ID: <645d3122bd1d2_26011a2947a@chronos.notmuch>
In-Reply-To: <xmqqwn1ewyzx.fsf@gitster.g>
References: <645c5da0981c1_16961a29455@chronos.notmuch>
 <871qjn2i63.fsf@osv.gnss.ru>
 <xmqqwn1ewyzx.fsf@gitster.g>
Subject: Re: Can we clarify the purpose of `git diff -s`?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Sergey Organov <sorganov@gmail.com> writes:
> 
> > I entirely agree with your conclusion: obviously, -s (--silent) and
> > --no-patch are to be different for UI to be even remotely intuitive, and
> > I'd vote for immediate fix of --no-patch semantics even though it's a
> > backward-incompatible change.

> While it is very clear that the intent of the author was to make it
> a synonym for "-s" and not a "feature-wise enable/disable" option,

I disgree, it's very clear the intention was to negate --patch, he
explicitely said so multiple times:

 * This follows the usual convention of having a --no-foo option to
   negate --foo.
 * to cancel the effect of `--patch`.

In particular, the purpose was to make silencing the output of `git diff`
more accessible, the cover letter makes it abundantly clear [1]:

====
  > Stefan Beller <stefanbeller@googlemail.com> writes:
  >
  >> However I sometimes also get:
  >> sb@sb:~/OSS/git$ git show --format="%ad" 0da7a53
  >> Fri Jul 12 10:49:34 2013 -0700
  >>
  >> diff --git a/Documentation/RelNotes/1.8.4.txt
  >> b/Documentation/RelNotes/1.8.4.txt
  >> index 0e50df8..4250e5a 100644
  >> --- a/Documentation/RelNotes/1.8.4.txt
  >> +++ b/Documentation/RelNotes/1.8.4.txt
  >
  > "git show" will show the diff by default. For merge commits, it shows
  > the --cc diff which is often empty, hence the behavior you see.
  >
  > You want to use "git show -s", which suppresses the patch output.

  ... and this "git show -s" is extraordinarily hard to discover, as it
  is only documented in "git log --help". Google has been my friend
  here, but we should really improve that.

  This patch series does essentially two things:

  * Add a --no-patch synonym for -s. I'm actually wondering why the
    option wasn't called this way from the beginning.

  * Reorganize the doc so that "git show" actually mentions it.
====

Making it a synonym of `-s` was a means, not an end.

> I do not think it will break established use cases too badly to fix
> the behaviour of "-s" so that it does not get stuck.  We saw an
> existing breakage in one test,

It's curious that your patch breaks one test case, while my approach
breaks *zero* cases.

> but asking the owners of scripts that make the same mistake of
> assuming "-s" gets stuck for some but not other options to fix that
> assumption based on an earlier faulty implementation is much easier.

"The users are using the interface wrong" is an euphemism for "I want to
break backwards-compatibility".

According to Linus Torvalds if your users are relying on a bug in your
interface, that bug is now a feature.

If we want to break backwards-compatibility then let's do so.

> So, no, I do not think we can immediately "fix".  I do not think
> anybody knows if it can be done "immediately" or needs a careful
> planning to transition, and I offhand do not know if it is even
> possible to transition without fallout.

I know it can be done immediately, because my patch series already did
it.

[1] https://lore.kernel.org/git/1373893639-13413-1-git-send-email-Matthieu.Moy@imag.fr/

-- 
Felipe Contreras
