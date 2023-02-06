Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB7FC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 22:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjBFWbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 17:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjBFWav (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 17:30:51 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3784303F6
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 14:30:23 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ml19so38708554ejb.0
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 14:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/qWVFlgPcosp+ARtgrp4chOWyUIGz6pEb02oARFUEDM=;
        b=CDqT0wqD9fdQtbjZ5iWXHHqydMbnmJoFR9bTI5TPDZbQLVYdiSNOP0NpvULGFyCzx3
         yrRQGqDnCt4PBuGr5/oUDCwhIH0nntV4ohSszmrKXsJOOnvjor0fxTtb2NgAZfEIp8+w
         xC13kORsZsmwqWU6EyfH19jLhUnm12rWYRxFGH+Bl4wABy8pHYKoC+OfnijaNznxy8CI
         DrPU5yA6To+2bpYHM7h6gdAyvUBz0SEFjBfRft1GCoOVC1otiQbuunqq6g0qKX1+znKh
         PpYf6A+nJ97iVxKhgEAM/Ae8hmE3GE/f5pH/yFNxjwCKKpHB0Bbbw0SJjCjamv+uR78A
         w45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qWVFlgPcosp+ARtgrp4chOWyUIGz6pEb02oARFUEDM=;
        b=R0VlGsx57nlBOdGHSw3xG7Im79eEKE/T/bcDdLaxw2cx3sYbkWGc4ln9ChzKjTq+ha
         /A4vrBNcDdxIffMj6Tb+lyFtHRox17cX48i1G3FsXLckM63XAr/vb15h/Ggm+VYbVw4D
         RttB5BHPscVaLYxL1KYvdWrxo05mB5ekp94kBBlet/8tHMcqiXW0Ao29c6QnlFYQo166
         U7pcbT2fGg0JvjBM7LBfLAqT/B9dbBLsG9Ir/a1YSwyY4TKDmKyNTY7Fjn0xOaRp4wlI
         Rgh7Hqz28EoccdGrfcBtBTl0S2PPpwXkz0bXFu5PzpS372/Smd3ubywod56slgrOAyyU
         Yk3w==
X-Gm-Message-State: AO0yUKWCw0TkTPuLUd6cujmuWLTMIN7Fcq7oH1Gyk1DylcnYOijUxs6/
        cURbCloPHeXWXt7n7AYPY5YQeNeYMtYN9lj/
X-Google-Smtp-Source: AK7set/IhhUdFrKIQTHjS5HSS+kaV7bC/p2xwq6lhjb91lUrSd5UJ61+2oUELhkhG+tCLfEmhLfs4Q==
X-Received: by 2002:a17:906:c342:b0:878:7f6e:38a7 with SMTP id ci2-20020a170906c34200b008787f6e38a7mr932465ejb.44.1675722618532;
        Mon, 06 Feb 2023 14:30:18 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id rn26-20020a170906d93a00b008845c668408sm5978382ejb.169.2023.02.06.14.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:30:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPA09-000YyB-1J;
        Mon, 06 Feb 2023 23:30:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Eli Schwartz <eschwartz93@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [RFC PATCH 1/1] Document a fixed tar format for interoperability
Date:   Mon, 06 Feb 2023 23:18:47 +0100
References: <20230205221728.4179674-1-sandals@crustytoothpaste.net>
        <20230205221728.4179674-2-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230205221728.4179674-2-sandals@crustytoothpaste.net>
Message-ID: <230206.86lela4ebq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 05 2023, brian m. carlson wrote:

> +The goals for this format are that it is first and foremost reproducible, that
> +identical trees produce identical results, that it is simple and easy to
> +implement correctly, and that it is useful in general.  While we don't consider
> +functionality needs beyond Git's at the moment (such as hardlinks, xattrs, or
> +sparse files), there is intense interest in reproducible builds, and so it makes
> +sense to design something that can see general use for software interchange.

I think a goal should be to be bit-for-bit compatible with what we've
had historically, which...

> +Object IDs are not included in this version of the format because this produces
> +non-identical data when identical data is serialized with different hash
> +algorithms.

...this is inherntly at odds with. I had a longer comment about why I
think we can have our cake & eat it too at
https://lore.kernel.org/git/230131.86tu06rkbp.gmgdl@evledraar.gmail.com/

Maybe there are other changes in the proposed spec that put it at odds
with such a goal, it's unclear to me if this is the only difference.

But I don't see why we need bit-for-bit compatible output between SHA-1
and SHA-256 git repos for the reasons noted in the linked-to reply, and
removing this will remove a *really useful* aspect of our tar format,
which is that you can grab an arbitrary tarball, and see what commit
it's produced from.

Even if you want to retain SHA-1 and SHA-256 interop as far as tar is
concerned, an un-discussed alternative is to just stick the SHA-1 OID
into the SHA-256 archive.

For repos that are migrated we envision having such a bi-directional
mapping anyway.

And for those that started out as SHA-256, or where we no longer care
about compatibility with old SHA-1, we can just start including the
SHA-256 OID, as all compatibility concerns have gone away when we
stopped bothering to maintain the mapping, no?

> +|===
> +| Field Name | Value
> +
> +| `name`     | the last path component if it fits; otherwise, `path.%d`
> +| `mode`     | `0640` (regular file), `0777` (symbolic link), `0750` (directory)
> +| `uid`      | `0`
> +| `gid`      | `0`
> +| `size`     | the size of the data in bytes for regular files if it fits; otherwise, `0`
> +| `mtime`    | `0` (the Epoch)
> +| `chksum`   | as specified in the standard

This is the nth reference to "the standard". I think this would be
improved by linking to it, isn't it
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/pax.html ?
