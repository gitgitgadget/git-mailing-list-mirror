Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F86C433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 20:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242454AbhKXUHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 15:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242566AbhKXUHn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 15:07:43 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9A5C061574
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 12:04:33 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id o1so7575043uap.4
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 12:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=beHCDah3VHQ+YQk8U29iyoJvL3nNQQWhznjavRFjdW0=;
        b=nSGUmWuAtOxbGpE187z+MS/qD+sfuXHx/5EIImYFk1hGuEDWjVbgUVb8pe4TV6sV3+
         wPzDqQv7DPrkX1RwkP/scsiO255mwBuBLKFeRgb5XfcHNRY+O+VDWGdEqYjN1D9HTxuF
         ScrmdXgHcFMdbjAYiPoY2NJcMLej17S1KFbCBtj5+O0hqwmUcAl4xRBEfhLXdVdS5Ut+
         PCApp2PVeK7+gJo7uU33Zt51/enmsEEHaKna3PcXR098JZs0bJid9QWdoe1NfBOMLtEz
         NDlqOWQMj4X3NMyOB3u3Qpc2dkv+NCmw/9I0FqiyQ980M084bJq1a7onXVXZLCekTpB1
         OEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=beHCDah3VHQ+YQk8U29iyoJvL3nNQQWhznjavRFjdW0=;
        b=n3Ggj1jbSYCz0akyxuUXa07oEKfAxiLpgBn6Q6Qos0gopHAV1Wql2uW2EKEAtBDuq5
         WmEy+zFceTSfyqZ0qsi57HsScMeE2JqIihUV+eSjs/n9DPG7wiqHR4We5z/HUMmditcD
         H21MdQKU+9YF6DvBZo0HMCsdDuslsygYsnhtapHlmrN9uWQ/MoyG6U4ZMUZrImIebmDB
         6TNmeLrNL/4/wXJIcfkZojpu3lOQg785OwLuQk6PEx9AkUmvGyitWNHuspyci/D34/Oi
         XNIcfPz1CS3m2NGtBBoAlaJFn1QMdBDAiN6+aLvKQOq9Rjyfv3kmqROTD8Cybf7gYDaW
         nwsw==
X-Gm-Message-State: AOAM532/oTPH/zMHu3Qa/9dslUgS1q8HmVxB1CoakXpUYW84HU7hHTeO
        YzPt2hSf4+H9FnHAuFMNrfCsvlUArH1Kw6IbUAI=
X-Google-Smtp-Source: ABdhPJx5d6kQpgHxFp6zInyN3R+Rowlz7rPjX3CBWWN29EWAfqBvoqsAIbzvXn28sPVn9NdWfK2e0sZjyG8tyImwb6U=
X-Received: by 2002:a05:6102:c86:: with SMTP id f6mr28853460vst.38.1637784272525;
 Wed, 24 Nov 2021 12:04:32 -0800 (PST)
MIME-Version: 1.0
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>
 <20211122222850.674-1-carenas@gmail.com> <xmqqa6hvbxob.fsf@gitster.g>
 <CAPUEspgDafXHHPvzNijTsPsna76yE8W=JH-78LX3jyaieSmp0A@mail.gmail.com>
 <xmqqtug293ml.fsf@gitster.g> <nycvar.QRO.7.76.6.2111241428190.63@tvgsbejvaqbjf.bet>
 <xmqqwnkx1h5y.fsf@gitster.g>
In-Reply-To: <xmqqwnkx1h5y.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 24 Nov 2021 12:04:21 -0800
Message-ID: <CAPUEspjBf1MrN_hhNYndJ3MExikZ=rODbHiLNHNfpz1SUKd3RA@mail.gmail.com>
Subject: Re: [PATCH] editor: only save (and restore) the terminal if using a tty
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, phillip.wood123@gmail.com,
        thomas.wolf@paranor.ch, Alexander Veit <alexander.veit@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 24, 2021 at 11:34 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Why 'vi' and 'vim' are so special?  Is this an attempt to paper over
> a bug in 'vim' on the caller side?

not sure if the bug is on vi/vim, cygwin's pty or the new conPTY that
Windows Terminal uses; but in Git for Windows, using an MSYS vim (that
uses cygwin's pty) within Windows Terminal (and other terminals that
use conPTY most likely) leads to this terminal output corruption, that
bash "fixes" when it gets the control back, but that git does not
(unless something like what I am proposing is done), and that is
specially disruptive when doing several commits in a series (ex: an
interactive rebase).

you could say it is an attempt to paper over that bug, but IMHO it is
also a way for git to protect itself from a "rogue" editor, as it is
now just trusting that the editor wouldn't mess with its terminal
settings after being invoked and it returns control to git.

Carlo
