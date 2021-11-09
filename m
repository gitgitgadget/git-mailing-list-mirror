Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3FBC433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 09:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62EDA6128B
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 09:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242941AbhKIJx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 04:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245156AbhKIJxX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 04:53:23 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFFBC079784
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 01:50:31 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id o8so74196504edc.3
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 01:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=s18IuodDeeDV36/guIEtZGrS/l6YAmHW46z4g0sFbYo=;
        b=WQUyMX1y9G1rBiDsmdwhTrofMZfwIeeVx2cwpqivGlD6W8yGXySdE+CSLYOlQMrWqU
         /eH9IfFPbBodXiIWgAPQTtW27lsgo10j6y7K2ex+BJdJ25ch/Tb4hXEfhaNH2p1XsBin
         e1AE2OivzdyvwVm4+PLh4BjODTTfAS3il/8+j9xzMZYthkMiA+Qt+9OXTmbdFhZjN/TZ
         af3FbMLsh2+27bCJndd+2iM7YU3ZNSJEREmrq8c9S4JkCv3LVsbX/0as+kQukMSVpxog
         DEwJPYawplZvWVtJ4RGc3g1Z/gs3CWao6SAdgKRMCl+FsAuRuzd78rpei7kWAKKopxgx
         bfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=s18IuodDeeDV36/guIEtZGrS/l6YAmHW46z4g0sFbYo=;
        b=kiRINPA2PnVVJnsWbddRDoYvGquQVFHtqEksh/l2gpuYbzi0jZcpB8xa1t0S70KKKe
         QT+z3YbPeQNclCv+x31TWKie86Ftlh48oHRrx8ncWoKNs2NR487hFDRf3SVpEZ2T806p
         XKaVUuFBEAqkaMwPxXRsG4ru/Ed+hb12fDajnSt1nBKam7A06xBA/CZI1DxHRon2tb8Y
         GK0IwkE5PHb6HBThTC027/I1ef4qnEQg89eE+o1Hf2J7IvH+pu4z61Ght9dTOACQfA6x
         RC4vmEuXXzuvDDlktw3yHVq+1TpfwuZg6kpEFIQ6DG6n/jAoSl36YyNwydUsJtP2uYmy
         I1yQ==
X-Gm-Message-State: AOAM532IE3FiUxhQGajQrybe8hbi57tf+nw5FzTmIFDntaC36rtwe+WY
        I6Y2GYWQeF5zPNwQyqvbUTB3FOZtbEs=
X-Google-Smtp-Source: ABdhPJwMhsHM3IBYzF5F1sIQ/b2rZHdFTf4F3A1dlz4tI+rOCEViUeOrclghbhIGKsafQYW6hrOaCg==
X-Received: by 2002:a05:6402:2756:: with SMTP id z22mr8277698edd.88.1636451429784;
        Tue, 09 Nov 2021 01:50:29 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id mp5sm9738101ejc.68.2021.11.09.01.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 01:50:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkNls-0003t6-LX;
        Tue, 09 Nov 2021 10:50:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Vipul Kumar <kumar@onenetbeyond.org>
Cc:     git@vger.kernel.org
Subject: Re: List all commits of a specified file in oldest to newest order
Date:   Tue, 09 Nov 2021 10:42:27 +0100
References: <c3932b3c-323a-39d6-26a7-ba0c3d17378b@onenetbeyond.org>
 <211105.86a6ijhujg.gmgdl@evledraar.gmail.com>
 <182017f6-5dcd-70f0-e0bc-98721c433bf3@onenetbeyond.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <182017f6-5dcd-70f0-e0bc-98721c433bf3@onenetbeyond.org>
Message-ID: <211109.864k8lvesb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 09 2021, Vipul Kumar wrote:

> On 11/5/21 8:13 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> The key thing being the "traversal", i.e. as we walk history we'll
>> encounter a tree entry where b.txt was deleted, and see that it was
>> moved from a.txt.
>
> Thanks, I didn't know "reverse" would change the traversal order. When
> I looked for "--reverse" option in git-log(1), this what I found:
>
>   --reverse
>       Output the commits chosen to be shown (see Commit Limiting
>       section above) in reverse order. Cannot be combined with
>      --walk-reflogs.
>
> From this, I inferred that "--follow" would choose the commits and
> "--reverse" reverses those commits order. Can we improve the wording=20
> here? Especially, about "reverse" changes the traversing order.

Yes, definitely. Suggestions most welcome :)

>> However, if we walk history from the beginning we have no idea of the
>> relationship of a->b.txt, since we didn't encounter that commit yet,
>> that's only something we see while walking the history.
>
> Not showing commits before rename is expected, but I didn't understand
> why combination "--follow" and "--reverse" option showing me only one=20
> commit? And it always points to the rename of the file. Shouldn't it
> also list other commits which changes that file? For example, just
> after "rename of a.txt to b.txt", do some changes in b.txt file and
> then run "git log --follow --reverse -- b.txt" command.
>
> $ for i in {1..2}; do echo "$i" >> b.txt; git add b.txt; git commit -m
> "Update$i b.txt"; done
> $ git log --follow --reverse -- b.txt
> commit 55e3e6857755fe815449e787a90fe82feb174817
> Author: Redacted <Redacted>
> Date:   Fri Nov 5 06:56:58 2021 +0530
>
>     Rename a.txt to b.txt
>
> Here I expect output to be:
>
> $ git log --follow --reverse -- b.txt
> commit 55e3e6857755fe815449e787a90fe82feb174817
> Author: Reacted <Redacted>
> Date:   Fri Nov 5 06:56:58 2021 +0530
>
>     Rename a.txt to b.txt
>
> commit 57aac6d1af2d869557991e714932847f37035d19
> Author: Redacted <Redacted>
> Date:   Sun Nov 7 20:30:32 2021 +0530
>
>     Update1 b.txt
>
> commit ea76a8e8af903dc1522626aa058b8058afbe11f4
> Author: Redacted <Redacted>
> Date:   Sun Nov 7 20:30:32 2021 +0530
>
>     Update2 b.txt
>
> I know, here using "--follow" along with "--reverse" doesn't make any
> sense. Instead we should use "git log --reverse -- b.txt". But I'm
> just curious, is this also an expected caveats of using "--follow"
> along with "--reverse"?

I just assumed this would work, but looking a bit closer it doesn't
really, a better test-case:
=20=20=20=20
    (=20=20=20
        rm -rf /tmp/gt &&
        git init /tmp/gt &&
        cd /tmp/gt &&
        echo hi >a.txt &&
        git add a.txt &&
        git commit -m"initial" &&
        for i in {b..z}
        do
            git mv * $i.txt &&
            git commit -m"Moved to $i.txt"
        done
    )

And if you want to dig the ad-hoc fprintf debugging below is probably a
good start.

I.e. I think we should do this in principle, but I think we trip over
ourselves in the commit parent discovery, i.e. we should probably fake
up the "parent" as the next commit for the purposes of the traversal &
filter options.
=20=20=20=20
>> This caveat doesn't only apply to reverse, try to apply a move of b.txt
>> on top of your history:
>>      b.txt -> c.txt
>> And now do:
>>      git log [--follow] -- b.txt
>> What should we output there? If we're arguing that we should first
>> traverse the history to "look forward" that'll also apply to a
>> non-reverse walk, since we're asking to follow b.txt.
>> But we haven't encountered the b->c.txt relationship yet (well, we
>> run
>> into the rename commit, but once you add a c->d.txt on top...). So maybe
>> instead of --buffer-then-reverse we'd need a hypothetical --two-pass,
>> which would also impact options other than --reverse whose behavior
>> relies on traversal order.
>
> "--two-pass" option sounds like a good idea, but not sure how useful
> it would be for others. In my case, I could read the log's command
> output in bottom to top fashion, and now I also know two other
> approaches to get what I wanted. And I usually don't track deleted
> file.

I think it would be useful to be able to do "I know this file was
renamed to i.txt at some point, what happened after that?" If we start
at the tip we'll always traverse all the way to the root.


diff --git a/log-tree.c b/log-tree.c
index 644893fd8cf..b3894c995bd 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -960,6 +960,8 @@ static int log_tree_diff(struct rev_info *opt, struct c=
ommit *commit, struct log
=20
 		/* Set up the log info for the next parent, if any.. */
 		parents =3D parents->next;
+		fprintf(stderr, "log_tree_diff() parent: %s (parents?: %d) (showed_log?:=
 %d)\n",
+			oid_to_hex(&parent->object.oid), !!parents, showed_log);
 		if (!parents || opt->first_parent_merges)
 			break;
 		log->parent =3D parents->item;
diff --git a/tree-diff.c b/tree-diff.c
index 437c98a70e4..eeb7af0a516 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -588,6 +588,10 @@ static void try_to_follow_renames(const struct object_=
id *old_oid,
 	struct diff_filepair *choice;
 	int i;
=20
+	fprintf(stderr, "try_to_follow_renames(): %s -> %s\n",
+		old_oid ? oid_to_hex(old_oid) : "NULL",
+		new_oid ? oid_to_hex(new_oid) : "NULL");
+
 	/*
 	 * follow-rename code is very specific, we need exactly one
 	 * path. Magic that matches more than one path is not
@@ -633,6 +637,7 @@ static void try_to_follow_renames(const struct object_i=
d *old_oid,
 		 * diff_queued_diff, we will also use that as the path in
 		 * the future!
 		 */
+		fprintf(stderr, "%c: for p->one->path =3D %s...", p->status, p->one->pat=
h);
 		if ((p->status =3D=3D 'R' || p->status =3D=3D 'C') &&
 		    !strcmp(p->two->path, opt->pathspec.items[0].match)) {
 			const char *path[2];
@@ -657,9 +662,11 @@ static void try_to_follow_renames(const struct object_=
id *old_oid,
 			 * ourselves; signal diffcore_std() not to muck with
 			 * rename information.
 			 */
+			fprintf(stderr, "found\n");
 			opt->found_follow =3D 1;
 			break;
 		}
+		fprintf(stderr, "NOT found \n");
 	}
=20
 	/*
@@ -704,6 +711,10 @@ void diff_tree_oid(const struct object_id *old_oid,
 {
 	struct strbuf base;
=20
+	fprintf(stderr, "diff_tree_oid() %s -> %s\n",
+		old_oid ? oid_to_hex(old_oid) : "NULL",
+		new_oid ? oid_to_hex(new_oid) : "NULL");
+
 	strbuf_init(&base, PATH_MAX);
 	strbuf_addstr(&base, base_str);
=20
