Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC7FC77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 23:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240588AbjELXVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 19:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjELXVj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 19:21:39 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5CB2720
        for <git@vger.kernel.org>; Fri, 12 May 2023 16:21:38 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-54fd5aae4e7so2955797eaf.2
        for <git@vger.kernel.org>; Fri, 12 May 2023 16:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683933696; x=1686525696;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ye9geh7lOV5hByxxONXqV9/O9K+xXKDrwHE+5J14HXk=;
        b=raJBAcB+jS86Er9tUgBGZZLgBIHOpWiRWEyzmXUd1pb2yPDDP2EZfOHPktqXrmeRbT
         CampAZNX4r8cC9KGscJOR7hufcRwYBXeQgkORVRCU+g+xdbK5vkZDYrgCfKAG5wmldwb
         9GeoBXciLppPwgJ3rxBaKd+Ek57OlZn+87FOMctRHLLFFbFGTYerhTlKdB19c69av79Z
         P5iWtwjXUaQKbC1Oa9b9+zmbZPc+gkg3TBj8VPlqiZv/nLW9FoS6btuZCDFTw+fP2EqD
         IZUnQzAb8LiaHXHWUaRnzMZsd0LWqy8YtDS0yhGulGx88MSJd8WSCaORuRd+/njUQ0np
         kOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683933696; x=1686525696;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ye9geh7lOV5hByxxONXqV9/O9K+xXKDrwHE+5J14HXk=;
        b=YJo6Doam3wXtlpAYq1YiQZh70l6KuDuSGCj8H3M5Ew2Z9CiaPYmS5h9604SlbxqXDK
         F2zcxcOkgqVgMZxoPFjISQ8ekQ6fZR1vEr1daVUtviT6pHKhNFgBSnligCgUjnxaw0gn
         D4i081TVny3ZVx97Njkzyv2DalcVvpgbGC8eOERBDdOMb/wbho+mXN/Z6AFdIuIrITwv
         SepLDRaOReDFn5j6Nr3kpMeOs7eGJmClWeWmnu1XfEkSJGweulq/Xhb2aTM+N1hygU9R
         3pBeW05nP4LgVcqRwRBPMxtMQBJ0jSvfmnFTdZGRjydW6O3X93BlL/Gs3iDQ1gpwldyG
         5Zaw==
X-Gm-Message-State: AC+VfDwP8RpuIvblPBkVmMKTRM585shcLruArE5oTKiuTbsmfrSm+eH7
        JK/PeZ7yJBYJgps6KnKymZQ=
X-Google-Smtp-Source: ACHHUZ7puOfxw83ux2yOygETNB/aQFNg7C3ESzvVLF4ejhaERBarPN2AUzjub1jRGRbURv5c9gTJyg==
X-Received: by 2002:a05:6820:5b:b0:54f:5c56:a0c1 with SMTP id v27-20020a056820005b00b0054f5c56a0c1mr6922534oob.1.1683933696325;
        Fri, 12 May 2023 16:21:36 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id d14-20020a9d5e0e000000b006a973ec4660sm2142274oti.78.2023.05.12.16.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 16:21:35 -0700 (PDT)
Date:   Fri, 12 May 2023 17:21:34 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <645ec9fedd6a2_21cbbf2946a@chronos.notmuch>
In-Reply-To: <xmqqlehtnrw4.fsf@gitster.g>
References: <645c5da0981c1_16961a29455@chronos.notmuch>
 <871qjn2i63.fsf@osv.gnss.ru>
 <5bb24e0208dd4a8ca5f6697d578f3ae0@SAMBXP02.univ-lyon1.fr>
 <4f713a29-1a34-2f71-ee54-c01020be903a@univ-lyon1.fr>
 <xmqqo7mpqy6g.fsf@gitster.g>
 <87h6shif6q.fsf@osv.gnss.ru>
 <xmqqv8gxpd8r.fsf@gitster.g>
 <645ea15eca6fa_21989f294f5@chronos.notmuch>
 <xmqq1qjlp98j.fsf@gitster.g>
 <645ea94569b79_21b4f8294e7@chronos.notmuch>
 <xmqqlehtnrw4.fsf@gitster.g>
Subject: Re: Can we clarify the purpose of `git diff -s`?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > Junio C Hamano wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> 
> >> > So your rationale to reject a perfectly logical behavior that *everyone* agrees
> >> > with is that it might break a hypothetical patch?
> >> 
> >> Everyone is an overstatement, as there are only Sergey and you,
> >
> > Matthieu Moy also agreed [1]:
> >
> >   Looking more closely, it's rather clear to me they are not, and that
> >
> >      git show --raw --patch --no-patch
> >
> >   should be equivalent to
> >
> >      git show --raw
> >
> > That's pretty much everyone that has participated in the discussion.
> >
> >> and as we all saw in public some members stated they will not engage in a
> >> discussion thread in which you were involved.
> >
> > Smoke screen.
> >
> >> > Just do `--silent` instead.
> >> 
> >> I am *not* shutting the door for "--no-patch"; I am only saying that
> >> it shouldn't be done so hastily.
> >
> >> But conflating the two will delay the fix for "-s sticks unnecessarily" that
> >> is ready for this cycle.
> >
> > That breaks backwards-compatibility.
> >
> > Why are your patches excempt from bacwards-compatibility considerations?
> 
> It is not who wrote the patch.
> 
> You either did not read what I wrote earlier in the thread
> 
>     ... is another reason why I want to be much more careful about
>     "should --no-patch be changed to mean something other than -s" than
>     "should -s be fixed not to be sticky for some but not all options".
>     The latter is not a documented "feature" and it clearly was a bug
>     that "-s --raw" did not honor "--raw".  The former was a documented
>     "feature", even though it may have been a suboptimal one.
> 
> or you are trying to paint a picture that is different from reality
> with whatever motive you have.

I replied to that comment quoting it in full [2]:

====
  > Until the time when nobody uses "--no-patch" as a synonym for "-s" any
  > longer, such a future improvement would be blocked.  And that is another
  > reason why I want to be much more careful about "should --no-patch be changed
  > to mean something other than -s" than "should -s be fixed not to be sticky
  > for some but not all options".

  > The latter is not a documented "feature" and it clearly was a bug that "-s
  > --raw" did not honor "--raw".

  Users can rely on what you call "bugs".

  It's still a backwards-incompatible change for which you did not provide a
  transitioning plan in [1].

  Or is it a backwards-incompatible change *only* if the person proposing the
  patch is somebody else other than the maintainer?

  [1] https://lore.kernel.org/git/20230505165952.335256-1-gitster@pobox.com/
====

How can I paint a picture different from reality when I'm quoting exactly what
you said?

> Either way, I am not done with the thread, as I said.

You can say you are done with the thread, but your change [1] still breaks
backwards compatibility.

Does your patch change the behavior of this command?

  git show -s --raw

The answer is a "yes" or a "no". Personal attacks are not a valid answer.

[1] https://lore.kernel.org/git/20230505165952.335256-1-gitster@pobox.com/
[2] https://lore.kernel.org/git/645ea15eca6fa_21989f294f5@chronos.notmuch/

-- 
Felipe Contreras
