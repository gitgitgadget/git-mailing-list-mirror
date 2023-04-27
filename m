Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3A9C77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 21:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344040AbjD0VNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 17:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjD0VNb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 17:13:31 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6559C2D4A
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 14:13:30 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b4960b015so7069833b3a.3
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 14:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682630010; x=1685222010;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lgyAJrdKz/Bqa6ZwOuhBlLI3NHbhhBeNsBvvMp3fniQ=;
        b=q3fQLzZyp/AA+lbDpS+87Dt+a33zx0DplN0R/xWkfdYq4VyWJJ/3DJtjf3nVlMY5sA
         y2bSf90ORZDNvjrp7HSvWlxk89ThIrFGi1yk3gEJmeYdL16pBuNl0XMPoOD6atWW1qNM
         uAu9THe9HinM0KA/BRCUk5WLpJ6cSq8lU+pW7srqbEa8C+QXIk85sdtseDbRFXbRTqqM
         gXY7EhJT/8q31ZH/nF7U7G38GceBfxzeHqlBObhUqvIIO/NGEtfkiKrs8keVqMgwaaOQ
         t5/csKNJmGd/f9+cwXxf3lBjWe/ULrQS/6Zn855UHaSAg+FvxyEtBajT3kfm9iOaF53W
         mKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682630010; x=1685222010;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lgyAJrdKz/Bqa6ZwOuhBlLI3NHbhhBeNsBvvMp3fniQ=;
        b=k8dqIVgYY4rB8EyeqxQ4qC0W6VYR7Sosew5XJMAq3RJ4eUbapH8q0+psPkVd2DoYQx
         8n9axMJKX4hHIwjjlvgfgQOnDtMOvoSBvgqf368hl53bCoJRlIKx51dh+Ucey6luMTZ2
         a97KM1ZGQSIXTptpOAP13AyLTTvUSTOKmSBSzPjsbfYJyCJR8zdJ4oTShQm7FfOs17tz
         0fy+GOdewxNhrBV8dORUILO+lmnXOq+e9ZEiwfnRI559ujIh4aIvZZ04uaWsqhH3RR2y
         V4GP+9kfmranABO/c9hvW1oAX6nxi9XPy9kuF8gUi2t8bbnE1RHb4nDlKuLKveVmp61N
         PFGQ==
X-Gm-Message-State: AC+VfDzpGBLFRPd9z9uEHiNIasTMOQfUgh0BcRZOFjXCKoJ1LWRC3ECY
        Tirt4ytV/P/ANbaUGPLohb8=
X-Google-Smtp-Source: ACHHUZ5pq+vOC1f0K7YHh0Hgwf7pp7FQAn3/92biqtBSNEpoMOBPWFhaIYE4BOUFoi0PFpGnfARAKA==
X-Received: by 2002:a05:6a21:3294:b0:f2:6fc6:9ca3 with SMTP id yt20-20020a056a21329400b000f26fc69ca3mr3865638pzb.43.1682630009721;
        Thu, 27 Apr 2023 14:13:29 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id o76-20020a62cd4f000000b0063d6666ee4csm13658527pfg.34.2023.04.27.14.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 14:13:29 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sequencer: rectify empty hint in call of
 require_clean_work_tree()
References: <20230323162234.995514-1-oswald.buddenhagen@gmx.de>
        <ZEorMhPZRL/w4yKM@ugly>
Date:   Thu, 27 Apr 2023 14:13:29 -0700
In-Reply-To: <ZEorMhPZRL/w4yKM@ugly> (Oswald Buddenhagen's message of "Thu, 27
        Apr 2023 09:58:42 +0200")
Message-ID: <xmqqmt2thvuu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> ping!
>
> On Thu, Mar 23, 2023 at 05:22:34PM +0100, Oswald Buddenhagen wrote:
>>The canonical way to represent "no error hint" is making it null, which
>>shortcuts the error() call altogether.

I won't repeat what Peff already said on another ping! we saw
recently on the list.

The call to require_clean_work_tree() with "" hint existed ever
since this part of the "rebase" machinery was rewritten in C by
b97e1873 (rebase -i: rewrite complete_action() in C, 2018-08-28).
I added the author of that change to the Cc: list.

The original implementation of require_clean_work_tree looked like
this:

require_clean_work_tree () {
	git rev-parse --verify HEAD >/dev/null || exit 1
	git update-index -q --ignore-submodules --refresh
	err=0

	if ! git diff-files --quiet --ignore-submodules
	then
		...
		err=1
	fi

	if ! git diff-index --cached --quiet --ignore-submodules HEAD --
	then
		...
		err=1
	fi

	if test $err = 1
	then
		test -n "$2" && echo "$2" >&2
		exit 1
	fi
}

I.e. the second argument, "hint", is shown only when it was a
non-empty string.  It did not add "error:" prefix before the
message.

In contrast, this is what wt-status.c has:

int require_clean_work_tree(struct repository *r,
			    const char *action,
			    const char *hint,
			    int ignore_submodules,
			    int gently)
{
	struct lock_file lock_file = LOCK_INIT;
	int err = 0, fd;

	...
	if (err) {
		if (hint)
			error("%s", hint);
		if (!gently)
			exit(128);
	}

	return err;
}

Arguably, using error() as a replacement for 'echo "$2" >&2' was a
sloppy conversion made back in ea63b393 (pull: make code more
similar to the shell script again, 2016-10-07), but I suspect that
in-tree callers that do have something to say, and the end-users who
are used to see the messages these callers produce, expect to see
the "error:" prefix these days, so it needs further study if we
wanted to "fix" the misuse of error() there.  In any case, the
observation that motivated your patch is not error() vs fputs().

For squelching a useless "hint" that is empty (other than that
mistaken "error:" prefix), however, I think you can and should do
better than replacing "" with NULL on the callers' side.  As we can
see from the comparison between the original, scripted version and
the verison in C that is in wt-status.c of require_clean_work_tree,
checking for NULL-ness of hint is another misconversion made when
it was rewritten in C.

I think the right fix would be more like the attached patch, which
will fix any other callsites that pass "" at the same time.  Of
course, you can fix the callers on top, but that is secondary.

 wt-status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git i/wt-status.c w/wt-status.c
index 97b9c1c035..2b6dc4d6ac 100644
--- i/wt-status.c
+++ w/wt-status.c
@@ -2650,7 +2650,7 @@ int require_clean_work_tree(struct repository *r,
 	}
 
 	if (err) {
-		if (hint)
+		if (hint && *hint)
 			error("%s", hint);
 		if (!gently)
 			exit(128);

