Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F0FC43217
	for <git@archiver.kernel.org>; Fri, 27 May 2022 21:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354789AbiE0VaF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 17:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354818AbiE0V37 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 17:29:59 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7565134E35
        for <git@vger.kernel.org>; Fri, 27 May 2022 14:29:57 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id z24-20020a056a001d9800b0051868682940so2974561pfw.1
        for <git@vger.kernel.org>; Fri, 27 May 2022 14:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=uQbGY7SyjoPt1wugm6HNBfbJRJTkSizDKA5YT0Z1Hoc=;
        b=bEAKyIZqK7ZVZJ8nkR3S3oBl7OIBQf+eSSup/0CtN30PXw17r4cltsr4ukFH7Fh0Qw
         gfO89A84Qw7NhyM/n5HZaE7CRFBjt3j/a8ltCHOCyUAQvNmuOQ+BM18l+FpM4NltXIAC
         PZFUvDR2P/vf2V+sDVhr0hZTocUwQduEkkK0CralyoD8za0cw4afM1TPOrM6gP18IwXR
         IToRM7JZuhLNyiS64hLtFCbUJC1OXAFHrZrFYHDxKPCIEzR+5JwZSNmZ3evqRJvU/Vl3
         STyYBp7mLXK+vQ7xfT4HKhn6oRKpM2GaO8CE+wYN2xDKfzFCKRuBHjGtiHcCTQrQ8hQt
         JFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=uQbGY7SyjoPt1wugm6HNBfbJRJTkSizDKA5YT0Z1Hoc=;
        b=WuLxMcn3/7lmLrBxJrkehIJvU2fiCAczKuy57eclQYBba3HeCiX6d6H496kAoiSgCm
         TRPNhEr6F9K4Kp5mCqIakejhC8s01vUPw2PtuhiwIeenBAbKureQq4hD/yF6h9gg6mto
         hLMa1nQrZMNdzCANC9mbv4Mofxx1P0pia06QtPTQEy+4KmfydzAlrEhWgJD5xsIzGhlE
         Em9qqf2uqF0S58xBh2QvwnU6NQU82whAWYW7EYhhD6bXZzHPf7c77NmkyNppb/V2pQTU
         TuEySe07pMXfSSnnv0SSZDc1/JT8qQomiwu+h9G+ISUBEmzDtyQeM1YKW5rQZpokEgUO
         Yifw==
X-Gm-Message-State: AOAM531ZY0WNZMvTuUUPUC6xHa2VJV8Ws1QTKROkhwdRJlBYImqDJrNE
        mqt15KeypqhbNN5KJv/0jClPClQTQxpZ0A==
X-Google-Smtp-Source: ABdhPJx0eYQG+e3laRJ7wYax3YXHfV3OBu6kqLXwO7svsMRMzs3BTyZcX+24l1yiTfZGP8GyoZm4Ik5XCtJolA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:a8b:b0:4e1:52db:9e5c with SMTP
 id b11-20020a056a000a8b00b004e152db9e5cmr45404736pfl.38.1653686996623; Fri,
 27 May 2022 14:29:56 -0700 (PDT)
Date:   Fri, 27 May 2022 14:29:47 -0700
In-Reply-To: <patch-5.5-bb5a53f3b73-20220521T170939Z-avarab@gmail.com>
Message-Id: <kl6lk0a6mzp0.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com> <patch-5.5-bb5a53f3b73-20220521T170939Z-avarab@gmail.com>
Subject: Re: [PATCH 5/5] cache-tree.c: use bug() and BUG_if_bug()
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Capturing the discussion from Review Club :)

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason         <avarab@gmail.com> writes:

> This gets the same job done with less code, this changes the output a
> bit, but since we're emitting BUG output let's say it's OK to prefix
> every line with the "unmerged index entry" message, instead of
> optimizing for readability. doing it this way gets rid of any state
> management in the loop itself in favor of BUG_if_bug().

[...]

>  cache-tree.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index 6752f69d515..9e96097500d 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -692,14 +692,13 @@ struct tree* write_in_core_index_as_tree(struct rep=
ository *repo) {
>  	ret =3D write_index_as_tree_internal(&o, index_state, was_valid, 0, NUL=
L);
>  	if (ret =3D=3D WRITE_TREE_UNMERGED_INDEX) {
>  		int i;
> -		fprintf(stderr, "BUG: There are unmerged index entries:\n");
>  		for (i =3D 0; i < index_state->cache_nr; i++) {
>  			const struct cache_entry *ce =3D index_state->cache[i];
>  			if (ce_stage(ce))
> -				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
> -					(int)ce_namelen(ce), ce->name);
> +				bug("unmerged index entry on in-memory index write: %d %.*s",
> +				    ce_stage(ce), (int)ce_namelen(ce), ce->name);
>  		}
> -		BUG("unmerged index entries when writing inmemory index");
> +		BUG_if_bug();
>  	}
> =20
>  	return lookup_tree(repo, &index_state->cache_tree->oid);

Once we hit this `if` block, we are already confident that we want to
BUG() out no matter what, so I think this could be equivalently
rewritten as:

  -		fprintf(stderr, "BUG: There are unmerged index entries:\n");
  +		bug("There are unmerged index entries:");
   		for (i =3D 0; i < index_state->cache_nr; i++) {
   			const struct cache_entry *ce =3D index_state->cache[i];
   			if (ce_stage(ce))
  -				fprintf(stderr, "BUG: %d %.*s\n", ce_stage(ce),
  -					(int)ce_namelen(ce), ce->name);
  +				bug("%d %.*s\n", ce_stage(ce), (int)ce_namelen(ce), ce->name);
   		}
   		BUG("unmerged index entries when writing inmemory index");
   	}
  =20
   	return lookup_tree(repo, &index_state->cache_tree->oid);

And just musing here, like Junio mentioned upthread [1], BUG_if_bug() no
longer protects us the way BUG() does. This technically isn't an issue
here since we're confident we'll call bug() at least once, but the
reader has to do a bit more work to convince themselves that we will
never hit the return statement later on.

So in this case, we want to be aware of the previous bug() calls, but
don't really want the 'conditional dying' behavior of BUG_if_bug().
Maybe BUG() could learn about previous bug() messages, and we insist
that bug() be followed up by BUG_if_bug() or BUG().

[1] https://lore.kernel.org/git/xmqqk0a95nni.fsf@gitster.g
