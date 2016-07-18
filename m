Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4FC92018B
	for <e@80x24.org>; Mon, 18 Jul 2016 19:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbcGRTQM (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 15:16:12 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35566 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbcGRTQL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 15:16:11 -0400
Received: by mail-wm0-f51.google.com with SMTP id f65so115281966wmi.0
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 12:16:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5vdKDvKWdM6ssnp/y6pUOXDCY+4BC5PhgWejNvaQP1w=;
        b=PMMb3rvPewq65GFyakHuMgXa9whLTsXWP0QcSISsKAOej58cKASGG51epIjitCaWb2
         1Mht1D03UAS9PxWNDQBxqqafpOwXiojVXYLeqRWn8h91g0PEZ+ofNbrWA8KEYMp/INaw
         DyQVZ9Y4qYR6LQe15LzTn+7JyRmaL7Mr5Ln24ZlFwjhK3naJqTpVbqt9KAEMFXaoDOBx
         ORjEztg4QimWrKSuxPMQa7C/EKi63oc9o3nUEL32J5YUAwW4etCBJuTI4akaLyG7tdKM
         1Mf/HSf6sKXMVvj5iPic6jmLA/byUnEXRdAkGGsuVck3XtfKDXPZGj/QHIlhh8JLo9GA
         6v/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5vdKDvKWdM6ssnp/y6pUOXDCY+4BC5PhgWejNvaQP1w=;
        b=PHnCxAgFfP614C1HbHyYtwCU2T2Lwjr04zaD6QQ5aDMnenpOVK8xKbQxCSOd1nVi8C
         Sg0Nyc5FbRggN4drTJohKt98N5Ga3Avw9F5YtC8FzcEl3LJ4IMH/Vg4qvxBpv1dc30UL
         Th0lvDEPtrHTlyyPZLzcGyBqP5TmEMS+rjT/kBhPYfYiy5B1jxGJQWDqLHYDsh5RGRxR
         MOC0huHPWOxg1F4eyX8V4MPLlv82Rny6saikr5Ojy+J6R0hI49FE7ID44HSFdrXzPlZV
         VPk4zW0M0hqXaQmtnVSYDfUyDNpsHPfYADFPs8YTFTt5I5T0HntAqkHzmxKoS5S8Zdv5
         UKYQ==
X-Gm-Message-State: ALyK8tL8jk88wfPMxozcjwrsbUNTQF6PrdVCI3cJNwgruTwDZCQVCcjWzj5tJtvTxyJK0AqJXWSw7FQYnSTY5t+Z
X-Received: by 10.28.153.70 with SMTP id b67mr20707wme.84.1468869369909; Mon,
 18 Jul 2016 12:16:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.167.87 with HTTP; Mon, 18 Jul 2016 12:16:09 -0700 (PDT)
In-Reply-To: <xmqq37n6kbib.fsf@gitster.mtv.corp.google.com>
References: <1468867019-13086-1-git-send-email-jonathantanmy@google.com>
 <20160718185527.GB29326@google.com> <xmqq37n6kbib.fsf@gitster.mtv.corp.google.com>
From:	Jonathan Tan <jonathantanmy@google.com>
Date:	Mon, 18 Jul 2016 12:16:09 -0700
Message-ID: <CAGf8dgJVkkVwJ5aJCQBcYKw7F9g7u3pMsuJHedSGLG6PQk2Keg@mail.gmail.com>
Subject: Re: [PATCH] fetch-pack: grow stateless RPC windows exponentially
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 18, 2016 at 12:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I'd understand if it were more like "aggressive exponential ->
> conservative exponential" without linear phase when stateless_rpc is
> in use, though.  I just do not quite understand the justification
> behind the order of three phases introduced by this change.

Adding conservative exponential phase after the aggressive exponential
phase was the original intention, but the conservative exponential
approach (e.g. n' = n * 11 / 10) is slower than the existing linear
(n' = n + 1024) approach when n < 10240, so I added that intermediate
phase to avoid a regression in the packet size growth.
