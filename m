Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4165DC77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 21:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbjELVr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 17:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbjELVr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 17:47:57 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45C72133
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:47:56 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aae5c2423dso101032015ad.3
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683928076; x=1686520076;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cXsQwgyQt47WsmI3jaRgDjYpKpdSr9Sk7jfXPLCB3E=;
        b=nfMqicJlD0N1g+vJOSuWnj7WDBBA8ne/zYz3UwwCyD5vEy4zJIyyCMEfuoAOe4ljVc
         f94HHpwuuxoNROvRFPlhqNJjr5l2CHQ8BcNqIJj1s5Pcnc6gR644bl4yAZ57EotGoZg4
         xiyCvNJuTsyzQuoWevCRKzIrO+r84l69LVvPWs5EudrAAL6wp/PRELCyQGqpSJxZ0Imd
         wvY3/DHv+ywjrGLqZUZhscUGMu9t6r1DVGJhfs5cREZFobMzLIZFGAEYgRtSzKJEk0BB
         pLuhuAv0fb9VJRWgruHsc77XKXrL3dwPr5wRgH5+p5zQo1bcbk8O2pTKKPxxWUkj2GBN
         r7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683928076; x=1686520076;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8cXsQwgyQt47WsmI3jaRgDjYpKpdSr9Sk7jfXPLCB3E=;
        b=McHud0bLRYnHyNdho9Kb3eSGpIGWd26fBSxEyhW/PlU/RqV7P+jc3bMpfy4uAi8Rfc
         1GrnKKLwoaft9Df8coITGZfQ/lt+hUkBGd3DMs2VBhGe/7LzKPhAvYZUFBOfDHOzJnvJ
         bOhwsO2CFaPhQGd1qvCuj0VA26ckSh19G28cEwoVEOeNj05Kr7olpSa72BZJUwxMmEkF
         pohOPCI8rnqnR7gKd8WOsIbLRDwu5aQ1o4vo1HD1gqM2PS7X3xzr8wj52X9lpjV58Zjl
         C3LEbBfofuwwqJAL+Mpah87psK3fctwiGc6TUvETCmQG9u+Z8uM1rKxny2Z5p+W1fi5o
         qUow==
X-Gm-Message-State: AC+VfDy1odz3sDptyb+hgx9Ja272It900XqbXiPy1bn8nht1LQQ0XuVw
        OOswqGL6OilaMTBmvnWYvCs1bFjCWhE=
X-Google-Smtp-Source: ACHHUZ7iX/ey9PVfAlbVyX0WHrkl9QjZI40qpRISpeBsMEta+oi214A/qG2TrDOCk6ZhN8TAi6MMUg==
X-Received: by 2002:a17:903:2289:b0:1a6:84be:a08f with SMTP id b9-20020a170903228900b001a684bea08fmr31535578plh.64.1683928076175;
        Fri, 12 May 2023 14:47:56 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b001a6ff7bd4d9sm8445663plj.15.2023.05.12.14.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 14:47:55 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Can we clarify the purpose of `git diff -s`?
References: <645c5da0981c1_16961a29455@chronos.notmuch>
        <871qjn2i63.fsf@osv.gnss.ru>
        <5bb24e0208dd4a8ca5f6697d578f3ae0@SAMBXP02.univ-lyon1.fr>
        <4f713a29-1a34-2f71-ee54-c01020be903a@univ-lyon1.fr>
        <xmqqo7mpqy6g.fsf@gitster.g> <87h6shif6q.fsf@osv.gnss.ru>
        <xmqqv8gxpd8r.fsf@gitster.g>
        <645ea15eca6fa_21989f294f5@chronos.notmuch>
        <xmqq1qjlp98j.fsf@gitster.g>
        <645ea94569b79_21b4f8294e7@chronos.notmuch>
Date:   Fri, 12 May 2023 14:47:55 -0700
In-Reply-To: <645ea94569b79_21b4f8294e7@chronos.notmuch> (Felipe Contreras's
        message of "Fri, 12 May 2023 15:01:57 -0600")
Message-ID: <xmqqlehtnrw4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > So your rationale to reject a perfectly logical behavior that *everyone* agrees
>> > with is that it might break a hypothetical patch?
>> 
>> Everyone is an overstatement, as there are only Sergey and you,
>
> Matthieu Moy also agreed [1]:
>
>   Looking more closely, it's rather clear to me they are not, and that
>
>      git show --raw --patch --no-patch
>
>   should be equivalent to
>
>      git show --raw
>
> That's pretty much everyone that has participated in the discussion.
>
>> and as we all saw in public some members stated they will not engage in a
>> discussion thread in which you were involved.
>
> Smoke screen.
>
>> > Just do `--silent` instead.
>> 
>> I am *not* shutting the door for "--no-patch"; I am only saying that
>> it shouldn't be done so hastily.
>
>> But conflating the two will delay the fix for "-s sticks unnecessarily" that
>> is ready for this cycle.
>
> That breaks backwards-compatibility.
>
> Why are your patches excempt from bacwards-compatibility considerations?

It is not who wrote the patch.

You either did not read what I wrote earlier in the thread

    ... is another reason why I want to be much more careful about
    "should --no-patch be changed to mean something other than -s" than
    "should -s be fixed not to be sticky for some but not all options".
    The latter is not a documented "feature" and it clearly was a bug
    that "-s --raw" did not honor "--raw".  The former was a documented
    "feature", even though it may have been a suboptimal one.

or you are trying to paint a picture that is different from reality
with whatever motive you have.  Either way, I am not done with the
thread, as I said.

