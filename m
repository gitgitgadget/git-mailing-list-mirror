Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 376C81F453
	for <e@80x24.org>; Tue, 30 Oct 2018 20:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeJaE6X (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 00:58:23 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:32832 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbeJaE6X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 00:58:23 -0400
Received: by mail-wr1-f43.google.com with SMTP id u1-v6so14039854wrn.0
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 13:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:user-agent:date:message-id
         :mime-version;
        bh=AtObFi0lUiXtqgwsqk/px0S2cAezLO/pPg1zWrqetRU=;
        b=jgBp41D9iTbEEntC/R0I2vVgWoG2ZlhOQz54hgFyR7z/STjeGFb8TRRCkTYC1XiuPh
         f/ou90epfsCp4vT6TD8k8IOcqTZnK1fjap1m/rub/jwjQuG2N0XlvNVF4Satj4XdTwMa
         JfcAXS2muV6b0anfXfHTHAOPb5mrDxRlV6oGZCTl3Ai0Lzj6TJi/bmcK6olR74fWpw+a
         xKUtNxOWYIR0nbt0YjpOd1qQzzUN7puwsvzFOZluLbI5fcFiw9pFKRe7rxaxuGkTOAWH
         8cYCKjn7kaVI1ox95JGOUkvMhtynQ786YPznsWE1BweN3/g3gwvYj14ATyeQNpxdpIGw
         bmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:user-agent:date
         :message-id:mime-version;
        bh=AtObFi0lUiXtqgwsqk/px0S2cAezLO/pPg1zWrqetRU=;
        b=LYwPnfJJr/Hi4CMA6j7dgqWf6iEkv196zix9QX5fKGP9wqAhwCM0MkkNkE1vrdQBOj
         YlBveLIVfV5bII9JmPCvzGz2XnYkGoW40/lWkAf3K/5GsFfoLw4BvjN7I6ub2jdrKIg+
         8UdmLrk9f9X8zdwQMs+WdhUQQacZ8cciOgPvsfRg4q3HPLzjpJ0BP0ELXAmgCBHbgA30
         Fy617dJ007iPFki/Ah+YwoXXx1sp917E5gRtPuuU0GmVIMlrum0CquHL3+2TDiDPjGOd
         B2vCOvycsg6t78QFtaELCP05Q58J3uoPVAU3bNW/qDlwywMdi2CG6dHl/PFDBS6Nx8OM
         Uh+Q==
X-Gm-Message-State: AGRZ1gIiTchFwY3wwibIBRoUrnaWCWn2OaqSu01xW7Xe8AixX8EE443n
        a4kMeoUV94igh3fd68rWG5zOxVkgON4=
X-Google-Smtp-Source: AJdET5cxh8gBSca5pqfvF9/kbzBjwnWD4lIvxDNNX9vw37RC20TEW/qeLh9og9Od+kVn/z4Nqi0TpQ==
X-Received: by 2002:a5d:6750:: with SMTP id l16-v6mr117276wrw.152.1540929807210;
        Tue, 30 Oct 2018 13:03:27 -0700 (PDT)
Received: from evledraar ([2a02:a450:3911:1:fd59:dbfe:7c38:41f0])
        by smtp.gmail.com with ESMTPSA id y21-v6sm6636985wma.36.2018.10.30.13.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 13:03:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Infinite loop regression in git-fsck in v2.12.0
In-Reply-To: <20170113175944.tdbfqx3e4xhris7m@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
Date:   Tue, 30 Oct 2018 21:03:24 +0100
Message-ID: <878t2fkxrn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While playing around with having a GIT_TEST_FSCK=true as I suggested in
https://public-inbox.org/git/20181030184331.27264-3-avarab@gmail.com/ I
found that we've had an infinite loop in git-fsck since c68b489e56
("fsck: parse loose object paths directly", 2017-01-13)

In particular in the while() loop added by f6371f9210 ("sha1_file: add
read_loose_object() function", 2017-01-13) in the check_stream_sha1()
function.

To reproduce just:

    (
        cd t &&
        ./t5000-tar-tree.sh -d &&
        git -C trash\ directory.t5000-tar-tree/ fsck
    )

Before we'd print:

    error: sha1 mismatch 19f9c8273ec45a8938e6999cb59b3ff66739902a
    error: 19f9c8273ec45a8938e6999cb59b3ff66739902a: object corrupt or missing
    Checking object directories: 100% (256/256), done.
    missing blob 19f9c8273ec45a8938e6999cb59b3ff66739902a

Now we just hang on:

    Checking object directories:   9% (24/256)

I have no idea if this makes sense, but this fixes it and we pass all
the fsck tests with it:

    diff --git a/sha1-file.c b/sha1-file.c
    index dd0b6aa873..fffc31458e 100644
    --- a/sha1-file.c
    +++ b/sha1-file.c
    @@ -2182,7 +2182,7 @@ static int check_stream_sha1(git_zstream *stream,
     	git_hash_ctx c;
     	unsigned char real_sha1[GIT_MAX_RAWSZ];
     	unsigned char buf[4096];
    -	unsigned long total_read;
    +	unsigned long total_read, last_total_read;
     	int status = Z_OK;

     	the_hash_algo->init_fn(&c);
    @@ -2193,6 +2193,7 @@ static int check_stream_sha1(git_zstream *stream,
     	 * do not count against the object's content size.
     	 */
     	total_read = stream->total_out - strlen(hdr) - 1;
    +	last_total_read = total_read;

     	/*
     	 * This size comparison must be "<=" to read the final zlib packets;
    @@ -2207,6 +2208,9 @@ static int check_stream_sha1(git_zstream *stream,
     		status = git_inflate(stream, Z_FINISH);
     		the_hash_algo->update_fn(&c, buf, stream->next_out - buf);
     		total_read += stream->next_out - buf;
    +		if (last_total_read == total_read)
    +			return -1;
    +		last_total_read = total_read;
     	}
     	git_inflate_end(stream);


I.e. we get into a loop where total_read isn't increasing. We no longer
print "sha1 mismatch" but maybe that's an emergent effect of something
else. Haven't checked.

The test is easy, just add a 'git fsck' at the end of t5000-tar-tree.sh,
but more generally it seems having something like GIT_TEST_FSCK=true is
a good idea. We do a bunch of stress testing of the object store in the
test suite that we're unlikely to encounter in the wild.

Of course my idea of how to do that in my
<20181030184331.27264-3-avarab@gmail.com> would be counterproductive,
i.e. it seems we want to catch all the cases where there's a bad fsck,
just that it returns in a certain way.

So maybe a good approach would be that we'd annotate all those test
whose fsck fails with "this is how it should fail", and run those tests
under GIT_TEST_FSCK=true, and GIT_TEST_FSCK=true would also be asserting
that no tests other than those marked as failing the fsck check at the
end fail it.
