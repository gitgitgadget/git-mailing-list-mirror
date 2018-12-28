Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF09F1F5B6
	for <e@80x24.org>; Fri, 28 Dec 2018 19:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbeL1T66 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 14:58:58 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46370 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732233AbeL1T66 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 14:58:58 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so24330952qtm.13
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 11:58:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J6CArRzXhtJfjyY/0IBBftC2Ej19iNk856WCPx4Knp8=;
        b=ByM5tUeZwl6fCAHzayvHCi+Q91ZMIVrdO+5CZyhoATHxL5LxndfcaVpvsVax4oWEzO
         CPhaMf9PxK13jfXVGmmMdPLrhFyAphPrapGZqSeomTfKywvNvnd/AQ71DDiZzYhEfkhI
         5lcV9SdqNWJmYyhdUV9kbKBxa6EFFbLnoKDiKTDKKLz/FUBY7dcVaoS4bx9E0e/0iYom
         BrWTu/334ieDwOUVtUO6Z+JUoTE5ksNc1caVEEZ5gxuHfrdq3xma+dVqr+HZSuAn9lAc
         a5MuTGGo8lc84UaW31gIMJnKacEn9qSASpzuESxjChYddftvrta+KFDqQHrSREtkb8Gj
         4K1A==
X-Gm-Message-State: AJcUukdpPNemfSAjjTX9AKjqvFUx0zMypRsnI7aNDz3u5yan3+AP/VPA
        nycbqKBuhSwryiZrfrrWHehO3SUrJgu69GN++HU=
X-Google-Smtp-Source: ALg8bN7xYLa30M26KFDQLCAg3G9h6Upr6gK2Zl1P+VFcbsiSIi0TXT1FHnoU+yLL4cu6h47mBXeQrShpJWOvJjH+l/A=
X-Received: by 2002:a0c:d29b:: with SMTP id q27mr27433320qvh.62.1546027137623;
 Fri, 28 Dec 2018 11:58:57 -0800 (PST)
MIME-Version: 1.0
References: <20181228014720.206443-1-masayasuzuki@google.com>
 <20181228014720.206443-2-masayasuzuki@google.com> <CAPig+cQc6oF3b03XS2jmNdtUDOX_08tv=AMUpdd7D1eDto33=A@mail.gmail.com>
 <CAJB1erXq3JZMd9XwUZFHp80Hr2kRakrp3JJgrAugXPyjp1rxNg@mail.gmail.com>
In-Reply-To: <CAJB1erXq3JZMd9XwUZFHp80Hr2kRakrp3JJgrAugXPyjp1rxNg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 28 Dec 2018 14:58:46 -0500
Message-ID: <CAPig+cTOK9XkGiPcHdVrWbV-L0a+Av0Kv=NcRVYsUHnb0j5-Zw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Unset CURLOPT_FAILONERROR
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 28, 2018 at 2:51 PM Masaya Suzuki <masayasuzuki@google.com> wrote:
> On Fri, Dec 28, 2018 at 11:37 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Thu, Dec 27, 2018 at 8:47 PM Masaya Suzuki <masayasuzuki@google.com> wrote:
> > > +test_expect_success 'failure in git-upload-pack is shown' '
> > > +       (GIT_CURL_VERBOSE=1 git clone --bare "$HTTPD_URL/error_git_upload_pack/smart/repo.git" 2>curl_log ||
> > > +        true) &&
> >
> > Using test_might_fail() would allow you to drop the subshell and the "|| true":
> >
> >     test_might_fail env GIT_CURL_VERBOSE=1  git clone ... &&
> >
> > > +       cat curl_log | grep "< HTTP/1.1 500 Intentional Breakage"
> > > +'
>
> The test should success. This is a test that a log is produced after a
> git command fails. The point of this test is "cat curl_log | grep ..."
> part that asserts the log.

Unfortunately, the name "test_might_fail" is confusing. It is not
saying that the entire test might or might not fail. Rather, it is
saying that the one command might or might not fail (and that you
don't care if it does fail). The idiom:

    (some-git-command || true) &&

can be replaced with:

   test_might_fail some-git-command &&

without changing its meaning, and without affecting the
success/failure status of the test overall.

So, this new test could be written like this:

--- 8< ---
test_expect_success 'failure in git-upload-pack is shown' '
   test_might_fail env GIT_CURL_VERBOSE=1 git clone --bare
"$HTTPD_URL/error_git_upload_pack/smart/repo.git" 2>curl_log &&
   cat curl_log | grep "< HTTP/1.1 500 Intentional Breakage"
'
--- 8< ---

and have the same meaning.
