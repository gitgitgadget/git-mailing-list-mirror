Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FA8C433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 11:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21F9B2067D
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 11:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mforney-org.20150623.gappssmtp.com header.i=@mforney-org.20150623.gappssmtp.com header.b="N3YvIXxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732831AbgF3LEV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729924AbgF3LER (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 07:04:17 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B62C061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 04:04:17 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t27so12332961ill.9
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 04:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0gtWVqCqPFe+m9ZFhAjCg6LxgMHzHicEXdOKQW3EMFs=;
        b=N3YvIXxU9uR7W/yoBLugm2LoAamjd3syeGk111iTKsXdU36GBEdrwLWXVP1Ma4vQB1
         ZRS64VQIQjOVCfmSBrw0nR1JpY0k6XD4CgR1CBuDQEBvStSh+RW91a3SmRfSprorcKJE
         CZZgR8KidMka+XsdY6X1MqgwTMxI80q7Fvy18e6qAWsPit5qTw4DEj7P7Xy3WQz5LIqQ
         3TXzWXwsiPTQv2dxHb5uzDShx/nFlasz3PaqkCWGe3zoACX10J+4z9SUvuG3A1Bx3MLR
         qWw4MzwJQdR37qoGgpSgsGZ8P6rVEvFYiOQ4l/2HtplSDmyNbH//Ohfnpdk8r8np1Om5
         ieWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0gtWVqCqPFe+m9ZFhAjCg6LxgMHzHicEXdOKQW3EMFs=;
        b=D/+nDkbNXkPHqbBj2ednEWQy5UpYUnmk4YSTGnPKvMw4WjxQB07TOutkhhLgoQB6aK
         G8KdLg8sjB9EsV76SljDPuQ46z0sWxGQhhP3GO7aA3iC+Q/eHTg++2Rzx24muNjCCsI0
         eOV/k3ZVr4Ty+4+4JZyfrXGdVQpuJgblymiiq0ZNk/oLwo3bjfjxHjXo25uLzOpYy5TN
         l1Wq11SVvZOS2LDMAuJjzkUUMPZo0BOy+KEUr/hPF1J+J6kJFmHoQIxJR0sms5kU9/LG
         C0IYwbFkE5jnyhwBYINdpHHWcYXSUNMBXbRr0QccrAFxr3sqfSytqZuZG0koz6o435Jj
         nzNw==
X-Gm-Message-State: AOAM531vftfGfGcTbo2+WKwKSmg7Y9E0VpTJt7FUaDclLb9eYSh2xsdS
        h/h1aBCLjWi8YgmXNHIgyij6Po/1iocBTaLKPS+sFA==
X-Google-Smtp-Source: ABdhPJxBebQ+OIzVrYu19HBphKlGwJV40/vsetbL4jPxLgzRSRKbIpn4xFzSdVvmpwQqDQ7kgNaHR1H5B3NdVBGhD38=
X-Received: by 2002:a92:4856:: with SMTP id v83mr1988993ila.125.1593515056752;
 Tue, 30 Jun 2020 04:04:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:b794:0:0:0:0:0 with HTTP; Tue, 30 Jun 2020 04:04:15
 -0700 (PDT)
X-Originating-IP: [73.70.188.119]
In-Reply-To: <33de1078-5f19-e76c-2a30-1754494d1e31@gmail.com>
References: <20200623205659.14297-1-mforney@mforney.org> <20200623205659.14297-2-mforney@mforney.org>
 <33de1078-5f19-e76c-2a30-1754494d1e31@gmail.com>
From:   Michael Forney <mforney@mforney.org>
Date:   Tue, 30 Jun 2020 04:04:15 -0700
Message-ID: <CAGw6cBsctN0-BP6k7p71-edsHR4BxJWai4Qz5m5gi4J6pYh=Kw@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule: use submodule repository when preparing summary
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e71a7a05a94b22dc"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000e71a7a05a94b22dc
Content-Type: text/plain; charset="UTF-8"

On 2020-06-24, Derrick Stolee <stolee@gmail.com> wrote:
> Perhaps the test I requested in patch 1 is only appropriate
> here? Or, maybe the test should be test_expect_failure in the
> first patch and switched to test_expect_success here?

I made a good effort to write a test, but I am still unable to
reliably trigger the offending codepath, which is:

submodule.c:prepare_submodule_summary
revision.c:prepare_revision_walk
revision.c:limit_list
revision.c:process_parents
commit.c:repo_parse_commit_gently
commit.c:repo_parse_commit_internal (needs !item->object.parsed and
use_commit_graph)
commit-graph.c:parse_commit_in_graph
commit-graph.c:parse_commit_in_graph_one
commit-graph.c:fill_commit_in_graph (needs pos >= number of commits in
commit-graph in parent repository)

The trick seems to be ensuring that the parent commit of the first
commit in the range of commits changed in a submodule does not get
parsed during show_submodule_header, is not a loose object in the
repository, and has an index in the commit-graph that is larger than
the size of the commit-graph in the parent repository. This seems to
depend on the order of commits in the commit-graph, which seems to be
random (perhaps based on commit hashes?).

I attached my best attempt at a test to trigger the error. The
probability of the test failing correctly (without the fix applied)
seems to depend on how many commits are present in submodule before
the first commit in the range of changed commits. This can be
controlled by adjusting the `seq 1 X` in the for loop. The lowest
number of commits with which I have been able to reproduce the bug is
3, where it occurs around 1% of the time, and if I set it to 200, I
can reproduce the bug around 99% of the time.

I don't really want to spend more time on this than I already have.
Can the bug fix be applied without a test? If not, hopefully someone
can volunteer to craft a reliable test (assuming that this is even
possible).

-Michael

--000000000000e71a7a05a94b22dc
Content-Type: application/x-sh; name="t7421-submodule-commit-graph.sh"
Content-Disposition: attachment; filename="t7421-submodule-commit-graph.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

IyEvYmluL3NoCiMKIyBDb3B5cmlnaHQgKGMpIDIwMjAgTWljaGFlbCBGb3JuZXkKIwoKdGVzdF9k
ZXNjcmlwdGlvbj0nVGVzdCBzdWJtb2R1bGUgc3VtbWFyeSB3aXRoIGNvbW1pdC1ncmFwaAoKVGhp
cyB0ZXN0IHZlcmlmaWVzIHRoYXQgdGhlIHN1Ym1vZHVsZSBsb2cgd29ya3Mgd2hlbiB1c2luZyBh
CmNvbW1pdC1ncmFwaC4KJwoKLiAuL3Rlc3QtbGliLnNoCgp0ZXN0X2V4cGVjdF9zdWNjZXNzICdz
dWJtb2R1bGUgbG9nIHdvcmtzIHdpdGggY29tbWl0LWdyYXBoJyAnCglta2RpciBzdWIgJiYKCSgK
CQljZCBzdWIgJiYKCQlnaXQgaW5pdCAmJgoJCWZvciBpIGluICQoc2VxIDEgMjAwKTsgZG8KCQkJ
ZWNobyAkaSA+ZiAmJgoJCQlnaXQgYWRkIGYgJiYKCQkJZ2l0IGNvbW1pdCAtbSAic3VibW9kdWxl
IGNvbW1pdCAkaSIKCQlkb25lCgkpICYmCglnaXQgYWRkIHN1YiAmJgoJZ2l0IGNvbW1pdCAtbSAi
c3VwZXIgY29tbWl0IDEiICYmCgkoCgkJY2Qgc3ViICYmCgkJZWNobyBmaW5hbCA+ZiAmJgoJCWdp
dCBhZGQgZiAmJgoJCWdpdCBjb21taXQgLW0gImZpbmFsIHN1Ym1vZHVsZSBjb21taXQiICYmCgkJ
Z2l0IHJlcGFjayAtQSAmJgoJCWdpdCBnYwoJKSAmJgoJZ2l0IGFkZCBzdWIgJiYKCWdpdCBjb21t
aXQgLW0gInN1cGVyIGNvbW1pdCAyIiAmJgoJZ2l0IHJlcGFjayAtQSAmJgoJZ2l0IGdjICYmCgln
aXQgc2hvdyAtLXN1Ym1vZHVsZT1sb2cKJwoKdGVzdF9kb25lCg==
--000000000000e71a7a05a94b22dc--
