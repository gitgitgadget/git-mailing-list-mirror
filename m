Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F91C77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 23:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbjELXHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 19:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239142AbjELXHx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 19:07:53 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF516A64
        for <git@vger.kernel.org>; Fri, 12 May 2023 16:07:52 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-39212bf4ff0so5629175b6e.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 16:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683932871; x=1686524871;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jb44WExNcbg0NaQ3u2/fIx1E/kO7fzqtQhMWzEwej9U=;
        b=cEuZlDkbSmrKv0AkEWITvB3RRw0IKqj1W25/92Fs5tp7QtcaQFQN56iSoYZouJUVPX
         ojT1lM66ibu0HWhwWOZxmbbnsN6kO+l0+lKgBuilmQF9HFbbpscFP5Ikq0Y3jp2i10kj
         nHWr5NCoBUEbo2wLfhikz+CqsgIlZvEyBDliezDNkZniScbMG9aiJNXAS3/TT/1Qy0PD
         ++2k372MQiSQHXL6NuWyCWhuHh3h47GsU/sOfnf9PhSUuxGJa1jpzl0tdbx+FcBRbhsK
         gogM5AaBheWvyIluFmVylQiQQKS/pSqLYoKZmWwkRTHRpo6IbP0pn2iER4qA8H6Zf0MS
         gJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683932871; x=1686524871;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jb44WExNcbg0NaQ3u2/fIx1E/kO7fzqtQhMWzEwej9U=;
        b=CNyJ8EzFgdIeFXBdR6vcUXtfsIVnaMIHp7gpzplEbsjMeIme+rVYbx4dzw3NGI0oZL
         r9/nwJv5k/gz8wpX13x5huEs6B5sw6JnsK3AgchVfOAHelvQJVX/krjn3G4NISPXw+Ra
         p3d4DYN/JwUQgrRjFGv5Q6rI/2dt1UDqIp2WB41AEnSpPSK5XvjTSvHANg7WbZ9yZuLd
         GpE6XWs3aXnt/MFBiWd5VaPwF7e9nfivziKVGi/3eTTT87ggNU1LInbKVJqmCCmBaKIa
         F6dHLXXllgHMBnDpGBUXVuG+/wzZugU7Sjsride4kHPpvKHOh4MaQpoRRmk5Cr2DriO2
         6OqA==
X-Gm-Message-State: AC+VfDxXOg20Mee+E+z9PpGuTD8T+MZkwJYdVjuTKuoRiHUgsSrPmvCi
        qIawkzm2RZANSG8NhH57NHI=
X-Google-Smtp-Source: ACHHUZ5E6+Kl6G4uHWzrPsnSEeDYCPCkQxLrgEjFcLox6LFadxEEee+RHkRDq66uZAMgjx87T5s+qQ==
X-Received: by 2002:a05:6808:2983:b0:38b:d115:e6c7 with SMTP id ex3-20020a056808298300b0038bd115e6c7mr6843665oib.8.1683932871519;
        Fri, 12 May 2023 16:07:51 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id r204-20020acadad5000000b0038bf8c6151fsm5127872oig.6.2023.05.12.16.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 16:07:50 -0700 (PDT)
Date:   Fri, 12 May 2023 17:07:50 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <645ec6c64bbd7_21cbbf294bf@chronos.notmuch>
In-Reply-To: <877ctdi5wp.fsf@osv.gnss.ru>
References: <645c5da0981c1_16961a29455@chronos.notmuch>
 <871qjn2i63.fsf@osv.gnss.ru>
 <5bb24e0208dd4a8ca5f6697d578f3ae0@SAMBXP02.univ-lyon1.fr>
 <4f713a29-1a34-2f71-ee54-c01020be903a@univ-lyon1.fr>
 <xmqqo7mpqy6g.fsf@gitster.g>
 <87h6shif6q.fsf@osv.gnss.ru>
 <xmqqv8gxpd8r.fsf@gitster.g>
 <645ea15eca6fa_21989f294f5@chronos.notmuch>
 <xmqq1qjlp98j.fsf@gitster.g>
 <877ctdi5wp.fsf@osv.gnss.ru>
Subject: Re: Can we clarify the purpose of `git diff -s`?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> >
> >> So your rationale to reject a perfectly logical behavior that *everyone* agrees
> >> with is that it might break a hypothetical patch?
> >
> > Everyone is an overstatement, as there are only Sergey and you,
> 
> Sorry, do you actually expect there is anybody here who disagrees that
> --no-patch logical behavior is to disable --patch? I thought you, in
> particular, have already agreed it's exactly "perfectly logical
> behavior". So there are at least 3 of us who explicitly agreed it is,
> and nobody who stated his disagreement. No?

Matthieu Moy as well, so it's 4 versus 0.

> I do have at least some experience in this field beyond Git, and I do
> sympathize the conservatism in this field, and only argue about practical
> thresholds.

I do have experience as well, as I was the one who proposed the preventive
warning on changing the default of `git pull`, also changing the default of
init.defaultbranch, and for the record I also warned against the move from
`git-foo` to `git foo` without warning back in v1.6, which resulted in a debacle.

If anything I would argue I've been more conscious of breaking
backwards-compatibility for *actual* git users.

This is an ad hominem red herring.

> > I am *not* shutting the door for "--no-patch";
> 
> That apparently confirms that you still do consider it "the perfectly
> logical behavior".
> 
> > I am only saying that it shouldn't be done so hastily.
> 
> I won't even try to insist on immediate fix, though I still don't see
> why shouldn't we just do it while we are at the issue, and be done with
> it.

I as well.

I could write yet another patch that throws a warning about a future change
instead of doing the change.

But I'm reasonably certain Junio will ignore that proposal as well.

> > Indeed "--silent" or "--squelch" is one of the things that I plan to
> > suggest when we were to go with "--no-patch is no longer -s" topic.
> 
> While we are at this, may I vote against "--squelch", please? For me
> it'd be undiscoverable, as it's the first time I ever hear this word in
> such context.

Also agree. I've never heard the word "squelch" outside of the git context, and
I'm pretty sure my English vocabulary is not small. Multiple people have
suggested "silent" and no one has suggested "squelch" (other than Junio).

Cheers.

-- 
Felipe Contreras
