Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CEEC4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 23:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4736622208
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 23:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dh4YoFQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgIXXnG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 19:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgIXXnG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 19:43:06 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6828C0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 16:43:05 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id w25so329736vsk.9
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 16:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qc5gzLk2mlGVMhUsvDRICg/F2rDQ6UGOzbeq+Taqxsw=;
        b=dh4YoFQMlODPAHI6XOmVE0XHetcapQH9xrs+rhxnWkYAMf8PClcpZHdXj7JLgYq/EQ
         2ciwejUvrxeeBXoGiaAHiJSFluK5Rd9znaXqKtZRKXoTUQ7jPoApSF3tD48UnQmhRESD
         HpPqNpQC9WWlUNFOYq02njyqu7gDSHNVSV9lE/AOIncxRwYgW4HymvMeiF0ONN6cJgy8
         Nui9qBn9Qei2oSa6gFLyTYgzszdGEh6qis28qI52KJqHnOoVmfarUBFDKRNQzMoujRnC
         oFA0nbD4kQDM6ee00vEjW4kQ/AK1b3wTNoTHBSUDrBBaKlMp88N1a/bFXAv3wMqodCKj
         keeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qc5gzLk2mlGVMhUsvDRICg/F2rDQ6UGOzbeq+Taqxsw=;
        b=SjaRlFHm7AqPERcqpyFWg+e2M7bjJICCMuMoo3rGVw/BoouFeNXalTKT1YIb55hLpR
         n4oEsXNjmI67YwrO8Hpo1JTidRnuiglB0YiyotKeuO6xjbcq3q1buaP+W9bICW3lXQSC
         klGwmxQqcanV2QQoeW79jZD/kBnU0goD0BVbMpBR1OdCMivVTsbAJW/OpEBkR6Dh+JDr
         fMSstWTPut8Q0czGvidUdhLv3MnSxVDE2Bhn7AUdD+mdYRlipAPzk9miAu/rn/EeMH19
         M6ZUmaw6cTNOtZQl/38QIBx502STSsISPEBGFORTfGYkuRTxwPcP8U/anx238cjZQ4w6
         kmvw==
X-Gm-Message-State: AOAM531mrHQvwto/P3xXpFcLzivoaSd7PpFnxqZdPhAmMEI8n3ZbX2P5
        EiSBujz5edtxDuV+pToDcR/w/jotzPTxuczEEe4=
X-Google-Smtp-Source: ABdhPJzVRWVqvwngyj6EHZ1zwFYAJ3bkaohUAnhNAGF3teIdusd8PxPEVuqSfKyKTDudCj+4Q5soFiwY37eUW6zoVfY=
X-Received: by 2002:a67:e248:: with SMTP id w8mr1367852vse.33.1600990985209;
 Thu, 24 Sep 2020 16:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200821215247.758978-1-jacob.e.keller@intel.com>
 <20200821215247.758978-2-jacob.e.keller@intel.com> <xmqqzh5onea1.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqzh5onea1.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 24 Sep 2020 16:42:54 -0700
Message-ID: <CA+P7+xqJis+DA=ZZ0Qphf0P8RGVbXyvHUHaqo30LQDytxAvs-w@mail.gmail.com>
Subject: Re: [RFC v2 1/1] refspec: add support for negative refspecs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 17, 2020 at 5:02 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
> > @@ -1441,6 +1559,8 @@ int match_push_refs(struct ref *src, struct ref **dst,
> >               string_list_clear(&src_ref_index, 0);
> >       }
> >
> > +     *dst = apply_negative_refspecs(*dst, rs);
> > +
> >       if (errs)
> >               return -1;
> >       return 0;
>
> And after grabbing all the candidate refs to be updated via this
> push, we filter out the ones that match negative pattern.  Can it
> also produce an error, or it can never fail (to udpate errs)?
>

It can't fail. Either refs match a negative refspec and will get
excluded, or they do not match a negative refspec and will be kept. We
already validate the negative refspecs earlier.

Thanks,
Jake
