Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CBBECAAA1
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 22:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiJ0Woz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 18:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiJ0Wow (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 18:44:52 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C462B623
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 15:44:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k2so8872186ejr.2
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 15:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pw8dSa/1MbqefKlr9oBYRTq15JSUJZEJinPUnX8fqH4=;
        b=PjTRfntg3H/Qdiz+OmEVxlw0vuUIjL5oQBZQtYEZk6+anniGjo6Xg9ko5llpJ3ukg9
         /OeACfIkpYxvLVmppfa/3hjuubuxET1ymI7BNd2+nGZbDfZLzArnr+ht7yIl/kKY5EeG
         glsOWCbEgUHsma6qYD9T8WY0rddS9BDuqVMRJ1PxsKQuYIgOuJwkach2YzOBfyPspjqX
         1CE9spDau3PVJERr0facmfUV2h6hy00hC7icyvQcIqA3FSybgZyYqgJtEJUacp/GRJO3
         LNr+nMZ6RSISCh34bw4dMNxrcYiFjmVvvyJE+ZghIv550N4K+oXTF1Tsrff+TZWMY5g2
         lNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pw8dSa/1MbqefKlr9oBYRTq15JSUJZEJinPUnX8fqH4=;
        b=BLlTpptKS42p5HCyTedDQud1qhXGwRmx10ETWvGMksCyByFcw73Y1Z9Qq+myU1MvGy
         AYOPz1o46VEnkhTSUzvjQ6bvVHvmtN+lXWBHe5olJK3czC+gZgJGhOSR+ImnxYDqiCJs
         8n7WI38K0pQQ+U+PV7NHg9k/gd2io+BrA1WshOVSKQeyDh9DWjvPOwIgcTcC1Fy+hSa6
         HegnhpBSNcXWgLXfXe30J7hqQ4uo019WsxPP9QYmaN26RuwdNqazeWiJg3BpjJ0lR26R
         hqLFl+xvGp+aO56ImEXMaa3IHnZctn80gLp6EmRi0/jKdK/d+FP0pR41+sSuvsazEU+e
         yzEA==
X-Gm-Message-State: ACrzQf07mzy9oQSeCWDWR1R+370nKpzOBWug3XRs/+K3Zf0cCoSnEnTa
        Gl5wqHpE21HZ41GlwO/IdQE=
X-Google-Smtp-Source: AMsMyM7wKGLwy11C84rFFjCywsJsd3DVX1bBUd4t/dygLVgd7wSQuVbrQx7oHxGDckE41hOQxRG/QA==
X-Received: by 2002:a17:907:78b:b0:741:3d29:33d2 with SMTP id xd11-20020a170907078b00b007413d2933d2mr45994535ejb.103.1666910689552;
        Thu, 27 Oct 2022 15:44:49 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id k16-20020a05640212d000b004587f9d3ce8sm1593521edx.56.2022.10.27.15.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 15:44:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ooBcF-009dmZ-2E;
        Fri, 28 Oct 2022 00:44:47 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] replace and remove run_command_v_opt()
Date:   Fri, 28 Oct 2022 00:41:53 +0200
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <72e04965-56ec-73cb-4554-9e3bc8f10cb5@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <72e04965-56ec-73cb-4554-9e3bc8f10cb5@web.de>
Message-ID: <221028.86mt9gants.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 27 2022, Ren=C3=A9 Scharfe wrote:

>  #ifndef NO_PTHREADS
>  static pthread_t main_thread;
>  static int main_thread_set;
> diff --git a/run-command.h b/run-command.h
> index 04bd07dc7a..fe2717ad11 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -151,7 +151,7 @@ struct child_process {
>
>  /**
>   * The functions: child_process_init, start_command, finish_command,
> - * run_command, run_command_v_opt, child_process_clear do the following:
> + * run_command, child_process_clear do the following:
>   *
>   * - If a system call failed, errno is set and -1 is returned. A diagnos=
tic
>   *   is printed.

A pre-existing issue mostly, but maybe worth cleaning up while we're
fixing these docs in general.

This summary is incorrect, because the first bullet point is claiming
that these "return -1", but 2 functions on this list return void.

It looks to me if we just remove child_process_{init,clear} altgother
from this it'll be correct. They have their own docs below, and this is
really describing how this now-simpler API works vis-a-vis the
start/run/finish functions.
