Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09BD91F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 12:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfJKMbh (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 08:31:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44350 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfJKMbh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 08:31:37 -0400
Received: by mail-qt1-f196.google.com with SMTP id u40so13532568qth.11
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 05:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gX+ipP0C2/C5B+CmmIBW81JqS9ZvdWAh0lTzO+n830o=;
        b=kudNisynpGQJ4yPNx6gTQtAvmNZnaEoNkJJqDKSQyg4VBTIN5HgEPvycPWPKAenCED
         ltPmwk5ZcqmdGd2NSbErbByOBiYoj3unrdGnn2M36D0NAQiQU06gujsC+UZedVgfxAgD
         MGjEeFh1TyWQsz1sWiljfH1qWgSOmbT941Q+rtHNoY0z//EmwyGOhvpLVIt54g9PLlYp
         6XdlP2g/xOT8ghHO5gKLWBrsHj5nV/AMds29Qh0bMc2ccutFLkOsSaCBCMGTqCkx+xr+
         iTI7wbip1MI46Fg6JX4vjCG6oJOhzc8+90mFuRumNhjwUfm6SmujZvzWMgpbRyvhBjcE
         3YUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gX+ipP0C2/C5B+CmmIBW81JqS9ZvdWAh0lTzO+n830o=;
        b=rZwK8SuEkygzlbLOEfZDRlJKvmjYYi+d3ldCGR8b+7syiMkrGwkuEdKjj55YGbdlEB
         O9Rr3jc6Q9YSJpYayO9xQ3QYIiBzc+d53VdMZCipTfBTw/Az9Hdo4MhCwVhI35NyB49E
         YM/cN2DQRONFIFJmDMOaVHr/evw77i8H1I2KvnG+Ode5Pa56UuYgApl9dGuCWp5Q3k8Z
         HIpGGIwRutqH932KV7GjpHSWG4DCo78P1RYDqRhSEe26cdWK2Bp+IG72YKt/NqKnQKjN
         IinF4vWx0cWARiW3H9fCeMwJt0kd7YcKibEZXnsqYqCtBbRQIMPWu/lRKmQJOpZYYdE7
         qt2w==
X-Gm-Message-State: APjAAAWCocMC2eMFPAtxsNIjCUvjY7ILvJUuSa/Nu+kVERFteU2i/ekY
        NOLmalmJHNg3QOBGg8rq6q4=
X-Google-Smtp-Source: APXvYqzLSMzkWmxh4NfZpP7KyX1HZ9NBTQ+QIO3xVKDYdy+Pnu8ts6oQz4ijDhNc7tUydV3yHH5IVw==
X-Received: by 2002:ac8:2a66:: with SMTP id l35mr17159675qtl.340.1570797094388;
        Fri, 11 Oct 2019 05:31:34 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:2da2:a6da:62ea:75d9? ([2001:4898:a800:1012:ded5:a6da:62ea:75d9])
        by smtp.gmail.com with ESMTPSA id l48sm5124497qtb.50.2019.10.11.05.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 05:31:33 -0700 (PDT)
Subject: Re: [PATCH v2] send-pack: never fetch when checking exclusions
To:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <xmqqzhibnahi.fsf@gitster-ct.c.googlers.com>
 <20191008183739.194714-1-jonathantanmy@google.com>
 <20191011061257.GD20094@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a87cf3ce-fbff-ef4e-941e-bd2da0bf182f@gmail.com>
Date:   Fri, 11 Oct 2019 08:31:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20191011061257.GD20094@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11/2019 2:12 AM, Jeff King wrote:
> On Tue, Oct 08, 2019 at 11:37:39AM -0700, Jonathan Tan wrote:
> 
>> When building the packfile to be sent, send_pack() is given a list of
>> remote refs to be used as exclusions. For each ref, it first checks if
>> the ref exists locally, and if it does, passes it with a "^" prefix to
>> pack-objects. However, in a partial clone, the check may trigger a lazy
>> fetch.
>>
>> The additional commit ancestry information obtained during such fetches
>> may show that certain objects that would have been sent are already
>> known to the server, resulting in a smaller pack being sent. But this is
>> at the cost of fetching from many possibly unrelated refs, and the lazy
>> fetches do not help at all in the typical case where the client is
>> up-to-date with the upstream of the branch being pushed.
>>
>> Ensure that these lazy fetches do not occur.
> 
> That makes sense. For similar reasons, should we be using
> OBJECT_INFO_QUICK here? If the other side has a bunch of ref tips that
> we don't have, we'll end up re-scanning the pack directory over and over
> (which is _usually_ pretty quick, but can be slow if you have a lot of
> packs locally). And it's OK if we racily miss out on an exclusion due to
> somebody else repacking simultaneously.

That's a good idea. We can hint to the object store that we don't expect
misses to be due to a concurrent repack, so we don't want to reprepare
pack-files.

-Stolee

