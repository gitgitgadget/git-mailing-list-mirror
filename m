Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9743C38142
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 09:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjBAJ5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 04:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjBAJ5c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 04:57:32 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CAD51C61
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 01:57:26 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id f7so9857988edw.5
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 01:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o1aORIhmFCfkbBR+CM/nGakTY/MbdVb/8loYgFsFU1w=;
        b=i5h9ayQ5tUDtzo8JfwO8SqKlHdv65GXv925hCwZtDjilt20dvfTpFaDQlec1bTSPYz
         KDlBf/IuisM1fRYk+FsGIzKh9/+fokbqBMk67ooCYQ/ABAJtl3WEuuiPYSoyvt/e3cfZ
         aKNZnccUXm6vLOf332+gD9P1e3jMfN1A2znmuqQ4jj1l7NywmQN8Y5ewxNEws/wCmG9p
         bjeeOwIajqDEycXeHAWot1ZipcqsCgJBYSaw8Un+u5VpJDfRSvToVfz2F8dw+BQgfzba
         KtMPU98GRP1k7Q5HWEzDlYkdTNNJcfGZCmNSZ8AIGkGA6TtQkOclRetBJnzrqBXF4k94
         OQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1aORIhmFCfkbBR+CM/nGakTY/MbdVb/8loYgFsFU1w=;
        b=1m9xjlLT6AGbjQ3bxODPTyI7dfZLdbGamW3sEDmVLz8sHVU33ufUpi/EP/BfX6Xm/a
         QF5DQt052lk/iNRBkqezZYhjG6FczYxqNn18LB+3ok1mCPgz3k7636JtIIW+Oc2oMH0Y
         A4Hm1XslBBkHLt6/s2l3L/KvyvPAQIKo9/Js1mrbfj5zj5gfw+uHQ9mHqUjF3zZgj6lS
         iCwWKzddpLoZNpUasvuDtKCEzymIrXpqmH9g7WOucxxKqNn+JpGFlOmLMoTBy/GlEeFS
         mIR2BbBdQw4OWMVYiGeaJsUUDAS2aFaDdfTvAwQB/rnLomiJEmYlEJIBY0IyVkPOQwBl
         SE8g==
X-Gm-Message-State: AO0yUKVAdjlI47Zeyd+SA0Ue0R9AfdPoxlCTfHKypU2MAJ7nfep5/ZpN
        yFbrE5tCNQU4jYP+vsa7otHXs4BFEpDTBA==
X-Google-Smtp-Source: AK7set8G45twUSacelC1IfPrrmW5mU7u4fbQQeU35o/NmiJBXriTi6EK81GQQymUMHqMglcbJe7iLg==
X-Received: by 2002:a50:c001:0:b0:4a2:2819:ed22 with SMTP id r1-20020a50c001000000b004a22819ed22mr1427386edb.38.1675245445388;
        Wed, 01 Feb 2023 01:57:25 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id p4-20020a056402500400b0049dfd6bdc25sm9561848eda.84.2023.02.01.01.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 01:57:24 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pN9ro-002937-0F;
        Wed, 01 Feb 2023 10:57:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eli Schwartz <eschwartz93@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
Date:   Wed, 01 Feb 2023 10:40:57 +0100
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
 <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
 <20230131150555.ewiwsbczwep6ltbi@meerkat.local>
 <Y9mXB1LaYSUJBlwF@tapette.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y9mXB1LaYSUJBlwF@tapette.crustytoothpaste.net>
Message-ID: <230201.86pmatr9mj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 31 2023, brian m. carlson wrote:

> As far as whether other people want to implement consistent compression,
> they are welcome to also write a spec and implement it.  I personally
> feel that's too hard to get right and am not planning on working on it.

"A spec" here seems like overkill to me, so far on that front we've been
shelling out to gzip(1), and the breakage/event that triggered this
thread is rectified by starting to do that again by default.

It means that someone writing a clean-room implementation of git would
likely run into the same issue, if they used e.g. the Go language and a
native Go implementation of deflate.

But so what? We don't need to make promises for all potential git
implementations, just this one. So we could add a blurb like this to the
docs:

	As people have come to rely on the exact "deflate"
	implementation "git archive" promises to invoke the system's
	"gzip" binary by default, under the assumption that its output
	is stable. If that's no longer the case you'll need to complain
	to whoever maintains your local "gzip".

If we wanted to be even more helpful we could bunde and ship an old
version of GNU gzip with our sources, and either default to that, or
offer it as a "--stable" implementation of deflate.

That would be going above & beyond what's needed IMO, but still a lot
easier than the daunting task of writing a specification that exactly
described GNU gzip's current behavior, to the point where you could
clean-room implement it and be guaranteed byte-for-byte compatibility.
