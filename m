Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0BEF1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 19:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfAYTv5 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 25 Jan 2019 14:51:57 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39771 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfAYTv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 14:51:57 -0500
Received: by mail-qk1-f196.google.com with SMTP id c21so6101084qkl.6
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 11:51:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IiyuPmEv5lVPsYZcNmE+W3sF7OkcQVBS1I0i4jqt1h8=;
        b=m6a2c7gRos5RTr8JQa7hbf7j4XObuWMcbnlUACB6ASGvwvYBoBlWWY4feSAv3zxF6P
         XvQzxUMaqA6dEdxO69BDf3r4jLfbwt1PX7CSlthErql0AEMMdEcglh85qvStUTYwo1PO
         pvj6q3skqoHuh/zoIPBIkhgpqilqy19gEzUe1IhoL6tHpiG/DgrZOOLh5VkHYeXa9KgF
         hf746vw1XYHWSEFF59y3yvt5F0F37VFazI8x6Kr/3CVZgZWLghGl7y+lAjXj0MpzzUkt
         zSDMknmXGgh1mfZsRvq0Z3eQzjItNMrviBWZlG0iKgLG+gNQHRDV0Kk9S3NczFHJ204z
         bYmA==
X-Gm-Message-State: AJcUukdbCaqSlpMtVg87M8uLmpshvKgWxtLgGOfZNdzg2FDbF94t4fFy
        Y0GsSy/S18cXou0C0kIlTSNSl8tl2DHFyPNqGKU=
X-Google-Smtp-Source: ALg8bN4zdHvtQ9b/8PbcUiy8FapfA5qsVxnOt9qx6Hge7lvJXFFZ62KXJHc+mlPfzbqg9AAgnlN2isRVWKoH+JJOnxo=
X-Received: by 2002:a37:a315:: with SMTP id m21mr10850605qke.152.1548445916606;
 Fri, 25 Jan 2019 11:51:56 -0800 (PST)
MIME-Version: 1.0
References: <20190124164654.1923-1-newren@gmail.com> <20190125165416.17473-1-newren@gmail.com>
 <2f785c2d-161c-b6a3-7743-b071969d60d7@gmail.com> <CABPp-BHTsZBO11ykfTaZ_dzpvrww5D3A57qBM05EgP_wK-iM9g@mail.gmail.com>
In-Reply-To: <CABPp-BHTsZBO11ykfTaZ_dzpvrww5D3A57qBM05EgP_wK-iM9g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 25 Jan 2019 14:51:45 -0500
Message-ID: <CAPig+cRefjWr3gNOfQou9JyW=yfACEvbXPPRzXU+VkJN_gCTzA@mail.gmail.com>
Subject: Re: [PATCH v2] log,diff-tree: add --combined-with-paths options for
 merges with renames
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 25, 2019 at 12:52 PM Elijah Newren <newren@gmail.com> wrote:
> On Fri, Jan 25, 2019 at 9:41 AM Derrick Stolee <stolee@gmail.com> wrote:
> > On 1/25/2019 11:54 AM, Elijah Newren wrote:
> > > +     printf "0f9645804ebb04cc3eef91f799eb7fb54d70cefb\0::100644 100644 100644 f00c965d8307308469e537302baa73048488f162 088bd5d92c2a8e0203ca8e7e4c2a5c692f6ae3f7 333b9c62519f285e1854830ade0fe1ef1d40ee1b RR\0file\twith\ttabs\0i\tam\ttabbed\0fickle\tnaming\0" >expect &&
> >
> > I'm guessing that you use printf here because the
> > 'cat <<-\EOF' approach doesn't work with the special
> > tabs? Kudos for putting in the extra effort here for
> > the special formatting!
>
> Yeah, I didn't know how to easily get NUL bytes in the stream without
> printf, and once I was using printf the EOF HEREDOC no longer had a
> useful purpose.  In the first testcase, since there were only
> printable characters in the expected output, a HEREDOC worked well.  I
> guess I could have just used printf for both testcases, but having the
> literal output shown where it's possible for a human to read it seemed
> like an advantage worth capitalizing on.

If the readability of a here-doc is preferred, you should be able to
achieve the desired result with the q_to_tab() and lf_to_nul()
functions. For instance:

    q_to_tab <<-\EOF | lf_to_nul >expect &&
    ...Q...Q...
    EOF
