Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FCDC433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 01:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51252078D
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 01:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZb/d6Cf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgIPBxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 21:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgIPBxi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 21:53:38 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A640FC06174A
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 18:53:35 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id h206so4143734ybc.11
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 18:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cp06wUDx9xp1ygJHC0+2NCMLoEOkyOqxR4zYqYsEC7E=;
        b=DZb/d6CfMBD1WN+8u+vSTxhknZafUJjY7HXusggNDFloeN3+Cyu7pArOOH/B1pPL2i
         d19jymY+UyksxiIJkFAH+D7bfEMFIr/BSCk7YYuOPcE0g+kwhlH82xwDQ+B9I0PqxRqA
         Wo0JHvXzGjbkZSUO3sEZ9t8D3EqK98E21Yz4QUqkmaRgoYFHiWIu9rxxWCep86lQourZ
         qcXbJpocPeOTcOzRPtaWtlqwoI+zpdD2AONvDUOstF8kJbkjMnqvO/g2Jm0uY3DpW6J/
         DExR5U37GJl0EH67kuD67Ndxfnis4UePaX0KWUOQflEN+Jj7GUNg5V6PRN9GL7HfQ5V2
         NETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cp06wUDx9xp1ygJHC0+2NCMLoEOkyOqxR4zYqYsEC7E=;
        b=OI7NubM61LHVuNLC9+oyPi0oGqamhpdaBCRJ6ruqhLK1ZC3bpxY6in4orHqopcCNXX
         kW9MZQPWmMwxpoL5DJPOMU4Yv82D1XKbLyfuY3xCnF4Lb8IMQ3NlssH6Q3o2LaIDP44G
         /7iQVejJpBzIWB/w6cDKZI86IkNUoLVUsE46+TGuAi5Fi5Jon4KgToF/CSuhmkih615U
         SOy2IGownxMe9hC3tH/mXUCuCBfyOuNvkt1PDENnttoNma/xprgK317+7TECQxUdxuHa
         sbsdawv4QAa96ptYOvIds9o45dXcI0VViK3vrYL7HsnqZ/XTyLvPCbEPFSvlEhKezl1G
         ESrA==
X-Gm-Message-State: AOAM531aw9YJNze+kN5dsazveQzLjH9ttzNuC361wD5okmG8oaVbSbuM
        xptLWWeluoC/aEimoy52SS4dRqNE6BiJ1vlGBMI=
X-Google-Smtp-Source: ABdhPJzsjPDkwY5OOVjOSu+WfQA4X8mEU5t2TdCji//ax9SCPh5RmGCA2I5goj0rcnSPoefuobQ76MMlqWWrl6eBABA=
X-Received: by 2002:a25:c049:: with SMTP id c70mr32155512ybf.403.1600221214965;
 Tue, 15 Sep 2020 18:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200915095827.52047-1-hanxin.hx@alibaba-inc.com>
 <20200915095827.52047-2-hanxin.hx@alibaba-inc.com> <xmqqmu1qzrbo.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmu1qzrbo.fsf@gitster.c.googlers.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 16 Sep 2020 09:53:24 +0800
Message-ID: <CANYiYbHYi70ZcjDTyQ++_+njuZMF=TksPepH+wP+zNmhBABNAg@mail.gmail.com>
Subject: Re: [PATCH 2/2] send-pack: check atomic push before running GPG
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han Xin <chiyutianyi@gmail.com>, Git List <git@vger.kernel.org>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8816=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=885:08=E5=86=99=E9=81=93=EF=BC=9A
>
> Han Xin <chiyutianyi@gmail.com> writes:
>
> > Atomic push may be rejected, which makes it meanigless to generate push
> > cert first. Therefore, the push cert generation was moved after atomic
> > check.
>
> The overstatement "may be rejected" is probably a bit misleading the
> readers and reviewers.  REF_STATUS_REJECT_NONFASTFORWARD may be
> observed by check_to_send_update() but the reason is set in
> set_ref_status_for_push(), which locally decides not to propose a
> no-ff ref update to the other side.  At this point of the control
> flow, the other side hasn't have a chance to reject the push,
> because "we want you to update these refs to these new values" is
> yet to be sent (it is done after composing the push certificate).
>
>     We may decide not to push (e.g. their ref may not fast forward
>     to what we are pushing) at this point in the code.  Checking the
>     condition first will save us to ask GPG to sign the push
>     certificate, since we will not send it to the other side.
>

It's always hard for a new contributor to write a decent commit log message=
.

>
> > -     if (!args->dry_run)
> > -             advertise_shallow_grafts_buf(&req_buf);
>
> Why should this be moved?  It doesn't seem to have anything to do
> with the push certificate.
>

Checking the condition first will also save us to prepare shallow advertise=
.

> > -
> > -     if (!args->dry_run && push_cert_nonce)
> > -             cmds_sent =3D generate_push_cert(&req_buf, remote_refs, a=
rgs,
> > -                                            cap_buf.buf, push_cert_non=
ce);
> > -
> >       /*
> >        * Clear the status for each ref and see if we need to send
> >        * the pack data.
>
> This "Clear the status for each ref" worries me.
>
> The generate_push_cert() function RELIES on ref->status and filters
> out the ref that failed to pass the local check from the generated
> push certificate.  If you let the loop (post context of this hunk)
> run, ref->status will be updated by it, so the net effect of this
> patch is that it breaks "non-atomic" case that pushes multiple refs
> and one of ref fails to pass the local check.
>
> IOW, generate_push_cert() MUST be called before this loop "clears
> the status for each ref" by assigning to ref->status.
>

The next block ("Finally, tell the other end!") is what we send
commands to "receive-pack", right after some of the status are reset
to REF_STATUS_OK or REF_STATUS_EXPECTING_REPORT by this chunk of code.
So moving the generate_push_cert() part right before the "Finally,
tell the other end!" part LGTM.
