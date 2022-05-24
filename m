Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5ACC433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 21:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241301AbiEXVeC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 17:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiEXVeB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 17:34:01 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340307B9E0
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:34:00 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 30-20020a9d0121000000b0060ae97b9967so10101265otu.7
        for <git@vger.kernel.org>; Tue, 24 May 2022 14:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lsKQGhaVet+DrWDtVYswq+i2Mbfv81P9kaMUWTIul8E=;
        b=L2MqG4KvCv4oWJkdSzYDgfUOpFiA2Z/dW9ZkGUvP8HkGV/GB7eb76fPb8lbzW8qcQX
         HVwR1Wah/J9QWwABZeBJxlbSyJQpMT7f0rOKRHXeFFXpbCRND/7OvNJ1DTmxINKh6RS3
         wnoW7HLALYP89w0zTXS0GFLJ/JU5Brfwmaaiy/F9w0f83E7KorKP6QNqeaZT/Q/2CdlD
         pC30ccIbTVeXnudR8xbgfYf71ca7XqWVx1PQh/ud5gCJwC4LX6pn9myQXAKdc3cPl4AL
         TxKKa0OLtVe9ilT/CbSwlJOTCbMP2Er0w6RK9PiJK88GHFsAvkaHSAp39PMPePAWVY1+
         DppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lsKQGhaVet+DrWDtVYswq+i2Mbfv81P9kaMUWTIul8E=;
        b=YVJvfPG6ulbTt7vaeLLw1bsQoSSl2KwCtT9fAUN0YmRfwIy97xcFkXYWuNl6a1hJuM
         CmkkFBi17gIP5ylTBeYyoFzgK0FJX81BKYkhsenmHT/78Ddgy9Tpgg5cp61FGyKXpqk1
         Ujmpm8Ol04/QvEtJ46MChcwlw2wSqv/9mYzVUJ0fc6XrgDlFHkw4B+8ajFi/j9Txdo+o
         RgiJZ8aM3UGMDs8hWiMTYZN8Unl0G5VcFXWn1N1VHGagKzkPo4E1W5UrJX8ThbWcobbZ
         5DhFp9i1XpGH00In3CldGs90oC8vuvh4b0ESh/5FcU7caQl3WFpUpdY/XsfzToUXrc27
         b7CA==
X-Gm-Message-State: AOAM530DhgTEp4ldaL/yxsAqY4uGh2G4ki6dyaaGbfd6gAgB+KMllaVT
        iXJ0nBWI/l7SxbqZpWcyc9eXjg==
X-Google-Smtp-Source: ABdhPJwMNDQ6ODXLe8tP4wjm2boiEFU+MPTfpKgliXFdVqQ+NHDHX2RF0FSIIKjMIthKIEHxVzGncA==
X-Received: by 2002:a9d:6f1a:0:b0:60b:20fd:ca75 with SMTP id n26-20020a9d6f1a000000b0060b20fdca75mr2446659otq.126.1653428039454;
        Tue, 24 May 2022 14:33:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i23-20020a4addd7000000b0035eb4e5a6bdsm5823755oov.19.2022.05.24.14.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 14:33:59 -0700 (PDT)
Date:   Tue, 24 May 2022 17:33:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, jonathantanmy@google.com,
        gitster@pobox.com
Subject: Re: [PATCH v2 3/4] builtin/pack-objects.c: ensure included
 `--stdin-packs` exist
Message-ID: <Yo1PRKUGgIyeDGKp@nand.local>
References: <cover.1652458395.git.me@ttaylorr.com>
 <cover.1653418457.git.me@ttaylorr.com>
 <cdc3265ec27f04accc433d9e4e54ac0edc3b3746.1653418457.git.me@ttaylorr.com>
 <220524.86zgj6vhge.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220524.86zgj6vhge.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 24, 2022 at 09:46:09PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Tue, May 24 2022, Taylor Blau wrote:
>
> > -	struct rev_info *revs = _data;
> > -	struct object_info oi = OBJECT_INFO_INIT;
> >  	off_t ofs;
> > -	enum object_type type;
> > +	enum object_type type = OBJ_NONE;
> >
> >  	display_progress(progress_state, ++nr_seen);
> >
> > @@ -3215,20 +3213,25 @@ static int add_object_entry_from_pack(const struct object_id *oid,
> >  	if (!want_object_in_pack(oid, 0, &p, &ofs))
> >  		return 0;
> >
> > -	oi.typep = &type;
> > -	if (packed_object_info(the_repository, p, ofs, &oi) < 0)
> > -		die(_("could not get type of object %s in pack %s"),
> > -		    oid_to_hex(oid), p->pack_name);
> > -	else if (type == OBJ_COMMIT) {
> > -		/*
> > -		 * commits in included packs are used as starting points for the
> > -		 * subsequent revision walk
> > -		 */
> > -		add_pending_oid(revs, NULL, oid, 0);
> > +	if (p) {
> > +		struct rev_info *revs = _data;
> > +		struct object_info oi = OBJECT_INFO_INIT;
> > +
> > +		oi.typep = &type;
> > +		if (packed_object_info(the_repository, p, ofs, &oi) < 0) {
> > +			die(_("could not get type of object %s in pack %s"),
> > +			    oid_to_hex(oid), p->pack_name);
> > +		} else if (type == OBJ_COMMIT) {
> > +			/*
> > +			 * commits in included packs are used as starting points for the
> > +			 * subsequent revision walk
> > +			 */
> > +			add_pending_oid(revs, NULL, oid, 0);
> > +		}
> > +
> > +		stdin_packs_found_nr++;
> >  	}
> >
> > -	stdin_packs_found_nr++;
> > -
> >  	create_object_entry(oid, type, 0, 0, 0, p, ofs);
>
> Not rhetorical, since I have no idea: Is the behavior change here to
> make create_object_entry with type=OBJ_NONE desired? I.e. do we actually
> want to create object entries for OBJ_NONE?

This is intentional. OBJ_NONE tells create_object_entry() "we don't know
the type of this object yet", and then `check_object()` (which does the
bulk of the work in the "Counting objects" phase) goes through and fills
in any missing type information.

The caller in `builtin/pack-objects.c::read_object_list_from_stdin()` is
a good example of this (all of the objects created this way start out
with OBJ_NONE).

> If that is the case I for one would find this a bit easier to follow
> like this, even if it has some minor duplication, i.e. the intent is
> clearer:
>
> 	diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> 	index ffeaecd1d84..a447f6d5164 100644
> 	--- a/builtin/pack-objects.c
> 	+++ b/builtin/pack-objects.c
> 	@@ -3202,7 +3202,6 @@ static int add_object_entry_from_pack(const struct object_id *oid,
> 	 				      void *_data)
> 	 {
> 	 	off_t ofs;
> 	-	enum object_type type = OBJ_NONE;
>
> 	 	display_progress(progress_state, ++nr_seen);
>
> 	@@ -3216,6 +3215,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
> 	 	if (p) {
> 	 		struct rev_info *revs = _data;
> 	 		struct object_info oi = OBJECT_INFO_INIT;
> 	+		enum object_type type;
>
> 	 		oi.typep = &type;
> 	 		if (packed_object_info(the_repository, p, ofs, &oi) < 0) {
> 	@@ -3230,9 +3230,11 @@ static int add_object_entry_from_pack(const struct object_id *oid,
> 	 		}
>
> 	 		stdin_packs_found_nr++;
> 	-	}
>
> 	-	create_object_entry(oid, type, 0, 0, 0, p, ofs);
> 	+		create_object_entry(oid, type, 0, 0, 0, p, ofs);
> 	+	} else  {
> 	+		create_object_entry(oid, OBJ_NONE, 0, 0, 0, p, ofs);
> 	+	}
>
> 	 	return 0;
> 	 }
>
> Or the same with adding "type = OBJ_NONE" to the "else" branch, leaving
> the initial "type" uninitialized"?

I'd be fine with that (and don't really have a very strong opinion
either way). Let's see if anybody else has thoughts about it, and then
I'm happy to change it in a subsequent version.

Thanks,
Taylor
