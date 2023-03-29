Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC25CC761AF
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 18:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjC2S5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 14:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjC2S5m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 14:57:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B97A5251
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 11:57:40 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so17204074pjb.0
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 11:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680116259;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPV5bJHkS/Asyl6s2VJOewWGaocqGPNCXrxj3s9AVnI=;
        b=BODyKVRmXdgpKXZ2SLzNWO+I7El+ED64jD/PNDDzIyLE80YoZUiY9AGWA9l4kuW/gg
         +QuvchYrAuFMkFuUOZfoC0L0itoBsL8NE5JacKngbPLyMR9Ud4yfvHSOf1WZIL1UB4hV
         grO5+A1OhuVcvdan4+AoL8nE+AQBIdRwREaY8bdF1olGeaxk+CHI/il8ikVcWFKAVJ9g
         y1XyyxBSmsuFzEcWwv3xFkzcfn6ngb4PSbqanSRyK6xxMnMCpMXBk27y2hIg5gYCXt2p
         xfS15+zvZXddQh9wFBF3v1pmwb1xFk8qzJlDcYR241UHelzhqPJ+AOmaE+buDbq5WoqC
         FO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680116259;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPV5bJHkS/Asyl6s2VJOewWGaocqGPNCXrxj3s9AVnI=;
        b=P4EFSEOYcoAiFIbeULvgk/AENS3TsYNBCNatSb389waifkl+/5cLF1+T0cOL5FY/pZ
         ylsawGzPHFehGgTItoXMaVZNIcBdkO0w7CubFCmfgEBionsSsmKTuyufl3eMjR6WT+Od
         PguaYk4TKDHNHYHc9pF7M8tb9KXGB7Oq5aY0fkTgfcaipxRoKJYOWspgFzjpuYxKVwy3
         +O2KKBdVBkQoIodssUzqnm/sYPvtU9iVsKjcBSJUQcEhrRJqo0JNL+SAglDON0MwHLMo
         0r5O49HSFyud9C8haAPuiiG9PXkvt3o82sjSsUQoPEWjlYmY5lC8yOCRYFV9odVu1tnK
         N63w==
X-Gm-Message-State: AO0yUKUn53ixEX/3BWmwC59VdrH6FraN9v5kVA4sPF+vUyuoAemZmOoi
        VbRNbcyFEjXX039vaS0qQl0=
X-Google-Smtp-Source: AK7set8ba07+SoCqrHCEgUUT8rhMSNpQo5sw00jyV08bPdn6TOMc7e02iLGA+igqcgSVJE7z2CKwPA==
X-Received: by 2002:a05:6a20:3aaa:b0:d8:e105:eb25 with SMTP id d42-20020a056a203aaa00b000d8e105eb25mr19190329pzh.7.1680116259492;
        Wed, 29 Mar 2023 11:57:39 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id g6-20020a62e306000000b005a8bf239f5csm23373798pfh.193.2023.03.29.11.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:57:39 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 3/8] config.c: create config_reader and the_reader
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
        <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com>
        <72774fd08f3eb9ff1d449814637e584692ba2bfc.1680025914.git.gitgitgadget@gmail.com>
        <230329.86sfdnvlke.gmgdl@evledraar.gmail.com>
Date:   Wed, 29 Mar 2023 11:57:38 -0700
In-Reply-To: <230329.86sfdnvlke.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 29 Mar 2023 12:41:32 +0200")
Message-ID: <xmqq7cuz9yhp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> But I think this paragraph still does a bad job of justifying this
> direction with reference to existing code.

I thought it read reasonably well, if not perfect, and do not think
I am capable of rewriting it better, unfortunately.

Care to suggest a better rewrite?

> 	 struct config_options {
> 	        unsigned int respect_includes : 1;
> 	+       unsigned int ignore_system : 1;
> 	+       unsigned int ignore_global : 1;
> 	        unsigned int ignore_repo : 1;
> 	+       unsigned int ignore_local : 1;
> 	        unsigned int ignore_worktree : 1;
> 	        unsigned int ignore_cmdline : 1;
> 	        unsigned int system_gently : 1;

That does look (I am not sure about _local bit, though) well
organized, but I suspect that it can be left for a follow-on
clean-up series, perhaps?

Thanks.
