Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFB9C678D5
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 23:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjCCXFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 18:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjCCXFk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 18:05:40 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391B45ADE6
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 15:05:23 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso3774819pjs.3
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 15:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6knnI7k+bGgUIzY/zfm9qgCwE2+qiQzzv7YwGAjCHQA=;
        b=Rg1dRR6B6E28fjAApp4DsR7MWlWgmKlA9Du8FI48XO1oiZVxHu/I6KDpy81rYJs9/E
         dqdoF1yMI5loHQbnHeQA/xxhCkb45ffOQh/fjpF/VjU92lBsx0zSq1I6K4g7IkJnQ97c
         ezaksnOGJBgnUQ5578jhHsJeSCQiMLKOnukBW/owOm+Ws9rhhkMc04j2CaOo+lsPXiTQ
         tjnLOpz8cbiBHNPZLsN5KKnMPVOPZ3Fcedpn+hEiR+NGIqw4Gnt+1E4yCJsAGgh+SCcr
         lyfS1InDAlck83vdtbfv0km5DvlCdP+wh1Jd5xj+klT6IBg2BjL9JAsvtWMq3U95CjAb
         Yr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6knnI7k+bGgUIzY/zfm9qgCwE2+qiQzzv7YwGAjCHQA=;
        b=s9/e52vqBh0OsppPed4M4MBaMpJaI7a7aWD6MGWye3CA2jLT2UH0UKumGTI6PPkEbz
         hm7Sjz43Sbw/CV+ZDx7llCZFrMkrVFrK/UCNefwuQP5/io1av8tnB0O2qDeCQnX+K9UH
         TOVRTXqUBLUcqKLKJn8viyMbysESW/KpVQa1O85hT5HrMJ8u0k0tOEJhldZ5csJ4XwLW
         aGqU+KSZS3NvjN2CpAYAoY1HCTSSdeMd8vcHyRJiR0bAuUVaXfQE+laklkPba9HcCVtP
         NDJ3fl9bqZVythRf/1VpyQPkeDfGFM/UaY7ryC4x67SvDJt2IWB3yFr9ECea0DLW7r3g
         dpFA==
X-Gm-Message-State: AO0yUKWV6BTowsg0wr12APvtk+3wob8FPXf5UR0H6Ez7qQZIjSWLLUEU
        WH14/NHhVKcIA7zX1lCOPcw=
X-Google-Smtp-Source: AK7set9g1WL3ZkwonBg6cKySidk+zIdC7afuxh4Pulgb7FoIAB8ejd5WxnaLsNGziB/UmtMac0/RMQ==
X-Received: by 2002:a17:903:41d0:b0:19b:c2d:1222 with SMTP id u16-20020a17090341d000b0019b0c2d1222mr4473805ple.52.1677884715592;
        Fri, 03 Mar 2023 15:05:15 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id kk15-20020a170903070f00b00189743ed3b6sm2011737plb.64.2023.03.03.15.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 15:05:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Henry <git@drmikehenry.com>, git@vger.kernel.org
Subject: Re: `git bundle create -` may not write to `stdout`
References: <80beb487-cd93-06ed-88cf-87a96a829ff6@drmikehenry.com>
        <Y/voNv1OQ1Cf/N5a@coredump.intra.peff.net>
        <xmqqv8jhcvrq.fsf@gitster.g>
        <ZAJ6oI3clNH2O3R7@coredump.intra.peff.net>
Date:   Fri, 03 Mar 2023 15:05:14 -0800
In-Reply-To: <ZAJ6oI3clNH2O3R7@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 3 Mar 2023 17:54:24 -0500")
Message-ID: <xmqqpm9pcu6t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This test looks good to me. Let's also not forget about the doc fixes. I
> don't think there's much urgency to get this into v2.40,

Doc?  Meaning 

	<file> can be "-" to mean the standard output (for writing)
	or the standard input (for reading)

or something?

Given that the other three subcommands also take <file>

    'git bundle' create [-q | --quiet | --progress | --all-progress] ...
                        [--version=<version>] <file> <git-rev-list-args>
    'git bundle' verify [-q | --quiet] <file>
    'git bundle' list-heads <file> [<refname>...]
    'git bundle' unbundle [--progress] <file> [<refname>...]

but read_bundle_header() function all three calls begins like so:

    int read_bundle_header(const char *path, struct bundle_header *header)
    {
            int fd = open(path, O_RDONLY);

            if (fd < 0)
                    return error(_("could not open '%s'"), path);
            return read_bundle_header_fd(fd, header, path);
    }

this function needs to be fixed first ;-)

Of course none of these is urgent for the upcoming 2.40 ;-).

> but I can put
> it together in the next day or three.

Thanks.  Just for reference, here is what I have (just a log
message, the patch is the same and does not support input yet).

----- >8 -----
Subject: [PATCH] bundle: don't blindly apply prefix_filename() to "-"

A user can specify a filename to a command from the command line,
either as the value given to a command line option, or a command
line argument.  When it is given as a relative filename, in the
user's mind, it is relative to the directory "git" was started from,
but by the time the filename is used, "git" would almost always have
chdir()'ed up to the root level of the working tree.

The given filename, if it is relative, needs to be prefixed with the
path to the current directory, and it typically is done by calling
prefix_filename() helper function.  For commands that can also take
"-" to use the standard input or the standard output, however, this
needs to be done with care.

"git bundle create" uses the next word on the command line as the
output filename, and can take "-" to mean "write to the standard
output".  It blindly called prefix_filename(), so running it in a
subdirectory did not quite work as expected.

Introduce a new helper, prefix_filename_except_for_dash(), and use
it to help "git bundle create" codepath.

Reported-by: Michael Henry
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 abspath.c              |  7 +++++++
 builtin/bundle.c       |  2 +-
 cache.h                |  3 +++
 parse-options.c        |  4 ++++
 t/t6020-bundle-misc.sh | 11 +++++++++++
 5 files changed, 26 insertions(+), 1 deletion(-)
