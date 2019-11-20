Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316D0C432C3
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 19:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D4F206DA
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 19:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvS6ztKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfKTTNC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 14:13:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33930 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfKTTNB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 14:13:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id h13so236608plr.1
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 11:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z/Or/sDxYvyIWWziNlG6zxyDHoOMVZP48td3cfnE2M4=;
        b=LvS6ztKazkWOXJVkcM5eUuFQLFKg8GIMImTa/RqIH6HFmMGlTjpzyZo7ve0RQG7NW3
         arhSTgz2JqGtx2RbDc+ZL6VjgrdXI5wb4LiACQlUO8ezokW4AT1W+H02mFG2vwIdCyUx
         y863cVq1z6I+7p+ip77s9vxeQPGiHUaoY9k+WQQY9qZAFs50qR3JMg5czVmlgACEwm/8
         JahmowYbQy4N7TzR0ndjK2D8M8UehS5INTkihV1TN3fFXYmNh/MBNIy6G8WpsL+FXnXm
         OBmIbzNYxUv5JOAj/I3qldpe7YiL/tqO3IxFL/fjHNTLHlzJ7oq8OYHgF2mpt9vPw4Wh
         XhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z/Or/sDxYvyIWWziNlG6zxyDHoOMVZP48td3cfnE2M4=;
        b=aezn3H/C2JarrBCh9jQTrUXj7JXkpauC9W7CMJkxWtxVLBac1VbOlk4AJuqOTmuaX7
         8cs2mtUKjqlkFjO5sw+dqU3cNpUfGo+Te+Eaacp70N1YsIdGwyvMgFw0rR/jB4EjdZZZ
         sxKf0yODvMHAAy1LzwYA3qVlycdoRdUfJ23h/BedE9wqIs3Z1/tPyqFo20E3knPysK5y
         IsYgv6uBboxptR9weuHrRN5JQHb6S1hQXmJyh5BQQ464ip+fXfdfIFEcx0duf8oraYHm
         rTQ0JBs1lWCzOBtrIfP8jR1zcWR3G20cOKMFgWLVbfH0oduDkO+zwcWpMKaDYLg12GnX
         IOYQ==
X-Gm-Message-State: APjAAAXglKN8kLMgtpgVKot/cKJOeFcG4jrbstz5e+oFsgR39FTAnOE1
        KEiLUs1yHtqetjTsuDVsQUA=
X-Google-Smtp-Source: APXvYqx8b23nx8LxK0rM+XjDuSTqpXuxAqqDBpR3GdljN3qv2DT3gWHS2V0f6g7bzCEwMxpTOOU69g==
X-Received: by 2002:a17:90a:fb57:: with SMTP id iq23mr6118786pjb.79.1574277180488;
        Wed, 20 Nov 2019 11:13:00 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id y11sm147107pfq.1.2019.11.20.11.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 11:12:59 -0800 (PST)
Date:   Wed, 20 Nov 2019 11:12:58 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 7/8] range-diff: passthrough --[no-]notes to `git log`
Message-ID: <20191120191258.GA73969@generichostname>
References: <cover.1574125554.git.liu.denton@gmail.com>
 <cover.1574207673.git.liu.denton@gmail.com>
 <0cb86b383b9c115c9c6077d47f0c124a96b30acf.1574207673.git.liu.denton@gmail.com>
 <xmqqwobvb2cj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwobvb2cj.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Nov 20, 2019 at 01:26:04PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > When a commit being range-diff'd has a note attached to it, the note
> > will be compared as well. However, if a user has multiple notes refs or
> > if they want to suppress notes from being printed, there is currently no
> > way to do this.
> >
> > Passthrough `---no--notes` to the `git log` call so that this option is
> 
> "`--[no-]notes`" or perhaps "`--[no-]notes` and `--notes=<ref>`"?

Whoops, I probably typed `ys-` in vim instead of `ys[` so I surrounded
the `no-` with the wrong characters.

> 
> I think the verb phrase is two words, "pass through", by the way.

Thanks, I didn't know this.

> 
> > +--[no-]notes[=<treeish>]::
> > +	This flag is passed to the `git log` program
> > +	(see linkgit:git-log[1]) that generates the patches.
> 
> I can see this was taken from "git log --help", and it probably
> needs fixing for consistency as well, but I think --notes=<ref>
> would be easier to click users' minds with notes.displayRef
> configuration variable.

I'll put in a cleanup patch for this as well.

> 
> > @@ -61,8 +62,11 @@ static int read_patches(const char *range, struct string_list *list)
> >  			"--output-indicator-new=>",
> >  			"--output-indicator-old=<",
> >  			"--output-indicator-context=#",
> > -			"--no-abbrev-commit", range,
> > +			"--no-abbrev-commit",
> >  			NULL);
> > +	if (other_arg)
> > +		argv_array_pushv(&cp.args, other_arg->argv);
> > +	argv_array_push(&cp.args, range);
> 
> Makes sense.
> 
> > diff --git a/range-diff.h b/range-diff.h
> > index 08a50b6e98..7d918ab9ed 100644
> > --- a/range-diff.h
> > +++ b/range-diff.h
> > @@ -2,6 +2,7 @@
> >  #define RANGE_DIFF_H
> >  
> >  #include "diff.h"
> > +#include "argv-array.h"
> >  
> >  #define RANGE_DIFF_CREATION_FACTOR_DEFAULT 60
> >  
> > @@ -12,6 +13,7 @@
> >   */
> >  int show_range_diff(const char *range1, const char *range2,
> >  		    int creation_factor, int dual_color,
> > -		    struct diff_options *diffopt);
> > +		    struct diff_options *diffopt,
> > +		    struct argv_array *other_arg);
> >  
> >  #endif
> 
> I thought a mere use of "pointer to a struct" did not have to bring
> the definition of the struct into the picture?  In other words,
> wouldn't it be fine to leave the other_arg a pointer to an opaque
> structure by not including "argv-array.h" in this file?

Without including "argv-array.h", we get the following hdr-check error:

	$ make range-diff.hco
	    HDR range-diff.h
	In file included from range-diff.hcc:2:
	./range-diff.h:16:14: error: declaration of 'struct argv_array' will not be visible outside of this function [-Werror,-Wvisibility]
			    struct argv_array *other_arg);
				   ^
	1 error generated.
	make: *** [range-diff.hco] Error 1

I am currently using this compiler for reference:

	$ clang --version
	Apple LLVM version 10.0.1 (clang-1001.0.46.4)
	Target: x86_64-apple-darwin18.7.0
	Thread model: posix
	InstalledDir: /Library/Developer/CommandLineTools/usr/bin

Thanks,

Denton

> 
> Thanks.
