Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E27DC43334
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 13:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiFXNq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 09:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiFXNqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 09:46:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FFD2619
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 06:46:23 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z11so3528717edp.9
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 06:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=81li7fiBTQzinJxQic9sPZycFv0H0/XJgRZw1nv9l2A=;
        b=Fwno4JA8KbPUSJuI/x+kp8xA/T94een73tfiOrE5oqqp0YhOB3ZjAsfgIqO8V+3jYE
         xtsJ1tmiJrJJIhZ5tYaDKyGsQBrvqPOX2ur1kMhVs6Ns/btkCKY/MR0H10IbuWmHZI1/
         1YRw2ntxxEue2ReQBabob6Ew7F6O0iwVC50wvdUMZ07+glbY3JVF3GnvHFX/U49PW9aR
         Ai03r01cR2/+xOxCjdKHP3M696p+NQ3IkAay3hxawaa2oHmivABe68s636VaLZmmhFV1
         kwE6Nh8vmKegOadm/BVTnCtLLdsh7qrWZZLL/LzpCfx/rxE4pD/Ek78po9fhWkNaslZL
         QJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=81li7fiBTQzinJxQic9sPZycFv0H0/XJgRZw1nv9l2A=;
        b=mVzSN8ocmXLaBxrpT5LCy4xRAlxgzjy9DBk6WNqP2X1Lw4nx+9x37b6Ryy4pgdq622
         sDxghwizUNAUDvbDMWgw3HrWYeR6nmx2GnMA9XcZYtu5d50s6myZY/f6+r61Yx+jneUE
         F4eAPVYFuumUf3gSUJVl/1XISEQvr95rLE0iUEBXUkBmXE1koXImsYDeG36tKybig7JO
         WsyKf/BPTDdLtcLHNtCSvTzCRCz2+paf5kqFMXwWejI0kZl06WCN7/aYuuUr7BFGog47
         CJNdn+eWteNyz7kWoGbaD+DEcCSijAgHZJRNyJ1dXcYyloKP37owgBm753lubXzBLJjn
         tupA==
X-Gm-Message-State: AJIora9t9dMqqpnVqbXCnsziQY56A6yI34d6w26CBdPgMcu8O/KjyhNt
        bf1At8+/H3BbYz4IgkQCOzAcIbTEKCY5Lg==
X-Google-Smtp-Source: AGRyM1vE/Wgf4L9wqfyEfdBQk9G9QFzrXr1Ag81sH9t1seZkHZS2DSRbomD5lpUx8y8iEwSTlvZ+RA==
X-Received: by 2002:a05:6402:5214:b0:437:5b1d:9966 with SMTP id s20-20020a056402521400b004375b1d9966mr2824396edd.16.1656078381397;
        Fri, 24 Jun 2022 06:46:21 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id bh25-20020a170906a0d900b00722e1635531sm1136183ejb.193.2022.06.24.06.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 06:46:20 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o4jdc-001KZj-7K;
        Fri, 24 Jun 2022 15:46:20 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v3] ls-files: introduce "--format" option
Date:   Fri, 24 Jun 2022 15:25:13 +0200
References: <pull.1262.v2.git.1655629990185.gitgitgadget@gmail.com>
 <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com>
Message-ID: <220624.86letmi383.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 21 2022, ZheNing Hu via GitGitGadget wrote:

> From: ZheNing Hu <adlternative@gmail.com>
> [...]
> +	if (skip_prefix(start, "(objectmode)", &p))
> +		strbuf_addf(sb, "%06o", data->ce->ce_mode);
> +	else if (skip_prefix(start, "(objectname)", &p))
> +		strbuf_add_unique_abbrev(sb, &data->ce->oid, abbrev);
> +	else if (skip_prefix(start, "(stage)", &p))
> +		strbuf_addf(sb, "%d", ce_stage(data->ce));
> +	else if (skip_prefix(start, "(eol)", &p))
> +		write_eolinfo_to_buf(sb, data->istate,
> +				     data->ce, data->pathname);
> +	else if (skip_prefix(start, "(path)", &p))
> +		write_name_to_buf(sb, data->pathname);
> +	else if (skip_prefix(start, "(ctime)", &p))
> +		strbuf_addf(sb, "ctime: %u:%u",
> +			    sd->sd_ctime.sec, sd->sd_ctime.nsec);
> +	else if (skip_prefix(start, "(mtime)", &p))
> +		strbuf_addf(sb, "mtime: %u:%u",
> +			    sd->sd_mtime.sec, sd->sd_mtime.nsec);
> +	else if (skip_prefix(start, "(dev)", &p))
> +		strbuf_addf(sb, "dev: %u", sd->sd_dev);
> +	else if (skip_prefix(start, "(ino)", &p))
> +		strbuf_addf(sb, "ino: %u", sd->sd_ino);
> +	else if (skip_prefix(start, "(uid)", &p))
> +		strbuf_addf(sb, "uid: %u", sd->sd_uid);
> +	else if (skip_prefix(start, "(gid)", &p))
> +		strbuf_addf(sb, "gid: %u", sd->sd_gid);
> +	else if (skip_prefix(start, "(size)", &p))
> +		strbuf_addf(sb, "size: %u", sd->sd_size);
> +	else if (skip_prefix(start, "(flags)", &p))
> +		strbuf_addf(sb, "flags: %x", data->ce->ce_flags);


In my mind almost the entire point of a --format is that you can
e.g. \0-delimit it, and don't need to do other parsing games.

So this really should be adding just e.g. "%x", not "flags: %x", 

Similarly, let's no have :-delimited fields. First, for a formatted
number "1656077225:850723245" is just bizarre for %(ctime), let's use
".", not ":", so: "1656077225.850723245".

And let's call that %(ctime), then have (which is trivial to add) a
%(ctime:sec) and %(ctime:nsec), so someone who wants to format this can
parse it as they please, ditto for mtime.

Looking at your tests it seemed you went down the route of aligning the
output with the --debug output, which is already pre-formatted. I.e. to
make what you have here match:

                printf("  ctime: %u:%u\n", sd->sd_ctime.sec, sd->sd_ctime.nsec);
                printf("  mtime: %u:%u\n", sd->sd_mtime.sec, sd->sd_mtime.nsec);
                printf("  dev: %u\tino: %u\n", sd->sd_dev, sd->sd_ino);
                printf("  uid: %u\tgid: %u\n", sd->sd_uid, sd->sd_gid);
                printf("  size: %u\tflags: %x\n", sd->sd_size, ce->ce_flags);

I think that's a mistake, we should be able to emit those individual
%-specifiers instead, not that line as-is without the " " prefix and
"\n" suffix.

> +
> +	if (format && (show_stage || show_others || show_killed ||
> +		show_resolve_undo || skipping_duplicates || debug_mode))
> +			die(_("ls-files --format cannot used with -s, -o, -k, --resolve-undo, --deduplicate, --debug"));

Use usage_msg_opt() or usage_msg_optf() here instead of die(), and no
need to include "ls-files " in the message.

See die_for_incompatible_opt4, maybe you can just use that instead? A
bit painful, but:

    die_for_incompatible_opt4(format, "--format", show_stage, "-s", show_others, "-o", show_killed, "-k");
    die_for_incompatible_opt4(format, "--format", show_resolve_undo, "--resolve-undo", skipping_duplicates, "--deduplicate", debug_mode, "--debug");

But urgh, that helper really should use usage_msg_opt() instead, but
using it for now as-is probably sucks less.

I also think we should not forbid combining this wtih --debug, it's
helpful to construct a format. This seems to work:
		
	diff --git a/builtin/ls-files.c b/builtin/ls-files.c
	index 387641b32df..82f13edef7e 100644
	--- a/builtin/ls-files.c
	+++ b/builtin/ls-files.c
	@@ -343,12 +343,17 @@ static void show_ce(struct repository *repo, struct dir_struct *dir,
	 				  S_ISGITLINK(ce->ce_mode))) {
	 		if (format) {
	 			show_ce_fmt(repo, ce, format, fullname);
	-			return;
	+			if (!debug_mode)
	+				return;
	 		}
	 
	 		tag = get_tag(ce, tag);
	 
	-		if (!show_stage) {
	+		if (format) {
	+			if (!debug_mode)
	+				BUG("unreachable");
	+			; /* for --debug */
	+		} else if (!show_stage) {
	 			fputs(tag, stdout);
	 		} else {
	 			printf("%s%06o %s %d\t",
	@@ -814,7 +819,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
	 	}
	 
	 	if (format && (show_stage || show_others || show_killed ||
	-		show_resolve_undo || skipping_duplicates || debug_mode))
	+		show_resolve_undo || skipping_duplicates))
	 			die(_("ls-files --format cannot used with -s, -o, -k, --resolve-undo, --deduplicate, --debug"));
	 
	 	if (show_tag || show_valid_bit || show_fsmonitor_bit) {
	
I.e. we'll get:
	
	$ ./git ls-files --debug --format='<%(flags) %(path)>'  -- po/is.po
	<flags: 0 po/is.po>
	po/is.po
	  ctime: 1654300098:369653868
	  mtime: 1654300098:369653868
	  dev: 2306     ino: 10487322
	  uid: 1001     gid: 1001
	  size: 3370    flags: 0

Which I think is quite useful when poking around in this an coming up
with a format.

> +
>  	if (show_tag || show_valid_bit || show_fsmonitor_bit) {
>  		tag_cached = "H ";
>  		tag_unmerged = "M ";
> diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
> new file mode 100755
> index 00000000000..8c3ef2df138
> --- /dev/null
> +++ b/t/t3013-ls-files-format.sh
> @@ -0,0 +1,124 @@
> +#!/bin/sh
> +
> +test_description='git ls-files --format test'
> +

Add this line here:

TEST_PASSES_SANITIZE_LEAK=true

I.e. just before test-lib.sh, see other test examples. Then we'll test
this under SANITIZE=leak in CI, to ensure it doesn't leak memory.

> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	echo o1 >o1 &&
> +	echo o2 >o2 &&
> +	git add o1 o2 &&
> +	git add --chmod +x o1 &&
> +	git commit -m base
> +'
> +
> [...]

> +for flag in -s -o -k --resolve-undo --deduplicate --debug
> +do
> +	test_expect_success "git ls-files --format is incompatible with $flag" '
> +		test_must_fail git ls-files --format="%(objectname)" $flag
> +	'
> +done

Nit: I think it's good to move these sotrs of tests before "setup", and
give them a "usage: " prefix, see some other existing examples.

We usually use test_expect_code 129 for those, depending on if you'll
end up with die() or not...

nit: missing \n before this line:

> +test_done
>
> base-commit: ab336e8f1c8009c8b1aab8deb592148e69217085

