Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ACBD1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 18:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754785AbeFNSkw (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 14:40:52 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36299 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754660AbeFNSkv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 14:40:51 -0400
Received: by mail-yw0-f196.google.com with SMTP id t198-v6so2494187ywc.3
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 11:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4EOp113yWjZfISbUTY8p6uRfI4lio9X2O0tk6jDTnnw=;
        b=JnuezhQoqAWD3BPXjjPvCeuhr2gSeP/7dSxXlkHAEl9CT5OJnUGnRExrW+KyJHB2bS
         3vxVu5JRvfhn7ZTGiKtW98ZAWUtvE8qp9iJAUKS1h6mPjV6K41S6pXH2JbMSbDjpfGk6
         d/4n+m1Hz5d8BWaF5VMkIT/Zf9muuuO+4hPk3R/rDljK5dDjjUYrcVoss5HdhMs2Idqa
         +rc50vley6mv0b3OOhisEw4doiQeRWObUJhNOupmfczXMxB1j7RRB7lAnHHlhL9RlCnt
         BYPAR5EqPbdhDJCYLfwdPYb5XhakJ9LuEXyTIlsLO7VAfi1cNYXeUykJzi5EZec4pdTa
         V8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4EOp113yWjZfISbUTY8p6uRfI4lio9X2O0tk6jDTnnw=;
        b=R/lRXSjovw3FytS/AmyMM9ty5oyMwRx5bE0bwLc5llbRq7IboIllc2JqYyqOfbKrYt
         s0nyvEU959VttsODrN3Vl4P+7v7jejg5kNcJCc9usHpwQYborx0HDSn7eeJCh4V51G6h
         Mu6VM1Qyrr63phnEjU0eUS/hMmd19bXUyvy8U9o7hKGRB0nJm7Tk/pkR4mdUByj6ug2Y
         aiNJot1yqGRb2uDzk+7QqhuasESi/EWYj/NY0xSchUjIG8dsmRnbiC2LmlJw/GMd+cja
         /QDxpV/MuXF7gwnrNYhnTgQdZNknau5UgFOCtAvKXy9ahu2+ThEECLvqsl3M4uBIweby
         Rqzg==
X-Gm-Message-State: APt69E0PVqioaJHEEQ2aKE3rrr6wiTcQfpFF/Geqcv/Sc6rfXCTX2zSh
        ei3RQQ1CiMkYktCkAtdRLJ0LjI9Q8KnL5Kh2XnNqwQ==
X-Google-Smtp-Source: ADUXVKKgdDQn1NltKRGjaXozHlx83fmSOdmyXBv/I5euLTcJLcZrOkCGtfjfqEBJ4x4NVq6JVj3bO068vW1W8jYRgg8=
X-Received: by 2002:a81:360a:: with SMTP id d10-v6mr2145625ywa.421.1529001650493;
 Thu, 14 Jun 2018 11:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180605175144.4225-1-bmwill@google.com> <20180613213925.10560-1-bmwill@google.com>
 <20180613213925.10560-3-bmwill@google.com>
In-Reply-To: <20180613213925.10560-3-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 14 Jun 2018 11:40:39 -0700
Message-ID: <CAGZ79kahheyo5gFYbxz-+jN7CMcj7tB1XuUPbmZ6+CBgsqxuow@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] upload-pack: implement ref-in-want
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,
On Wed, Jun 13, 2018 at 2:39 PM Brandon Williams <bmwill@google.com> wrote:
>
> Currently, while performing packfile negotiation, clients are only
> allowed to specify their desired objects using object ids.  This causes
> a vulnerability to failure when an object turns non-existent during

I stopped reading when stumbling upon 'vulnerability to failure' a I
found it hard to read. A quick search turns out this is insider slang
of civil engineers. :)

> negotiation, which may happen if, for example, the desired repository is
> provided by multiple Git servers in a load-balancing arrangement.

... and the repository is not replicated evenly to all servers, yet.

> In order to eliminate this vulnerability, implement the ref-in-want
> feature for the 'fetch' command in protocol version 2.  This feature
> enables the 'fetch' command to support requests in the form of ref names
> through a new "want-ref <ref>" parameter.  At the conclusion of
> negotiation, the server will send a list of all of the wanted references
> (as provided by "want-ref" lines) in addition to the generated packfile.

This paragraph makes it sound as if it can be combined technically,
i.e.

client:
    want 01234...
    want-ref master

.. usual back and forth + pack..

server:

  wanted-ref: master 2345..

What happens if the client "wants" a sha1 that is advertised,
but happens to be the same as a wanted-ref?

> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Documentation/config.txt                |   7 ++
>  Documentation/technical/protocol-v2.txt |  29 ++++-
>  t/t5703-upload-pack-ref-in-want.sh      | 153 ++++++++++++++++++++++++
>  upload-pack.c                           |  64 ++++++++++
>  4 files changed, 252 insertions(+), 1 deletion(-)
>  create mode 100755 t/t5703-upload-pack-ref-in-want.sh
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ab641bf5a..fb1dd7428 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -3479,6 +3479,13 @@ Note that this configuration variable is ignored if it is seen in the
>  repository-level config (this is a safety measure against fetching from
>  untrusted repositories).
>
> +uploadpack.allowRefInWant::
> +       If this option is set, `upload-pack` will support the `ref-in-want`
> +       feature of the protocol version 2 `fetch` command.  This feature
> +       is intended for the benefit of load-balanced servers which may
> +       not have the same view of what OIDs their refs point to due to
> +       replication delay.

Instead of saying who benefits, can we also say what the feature is about?
Didn't someone mention on the first round of this series, that technically
ref-in-want also provides smaller net work load as refs usually are shorter
than oids (specifically as oids will grow in the hash transisition plan later)?
Is that worth mentioning?

When using this feature is a ref advertisement still needed?

> +
>  url.<base>.insteadOf::
>         Any URL that starts with this value will be rewritten to
>         start, instead, with <base>. In cases where some site serves a
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index 49bda76d2..6020632b4 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -299,12 +299,22 @@ included in the client's request:
>         for use with partial clone and partial fetch operations. See
>         `rev-list` for possible "filter-spec" values.
>
> +If the 'ref-in-want' feature is advertised, the following argument can
> +be included in the client's request as well as the potential addition of
> +the 'wanted-refs' section in the server's response as explained below.
> +
> +    want-ref <ref>
> +       Indicates to the server that the client wants to retrieve a
> +       particular ref, where <ref> is the full name of a ref on the
> +       server.  A server should ignore any "want-ref <ref>" lines where
> +       <ref> doesn't exist on the server.

Are patterns allowed?, e.g. I might want refs/tags/* at all times.

> @@ -319,6 +329,10 @@ header.
>      shallow = "shallow" SP obj-id
>      unshallow = "unshallow" SP obj-id
>
> +    wanted-refs = PKT-LINE("wanted-refs" LF)
> +                 *PKT-LINE(wanted-ref LF)
> +    wanted-ref = obj-id SP refname
> +
>      packfile = PKT-LINE("packfile" LF)
>                *PKT-LINE(%x01-03 *%x00-ff)
>
> @@ -379,6 +393,19 @@ header.
>         * This section is only included if a packfile section is also
>           included in the response.
>
> +    wanted-refs section
> +       * This section is only included if the client has requested a
> +         ref using a 'want-ref' line and if a packfile section is also
> +         included in the response.

Is it possible to fetch non-fast-forwarded refs this way? Or specifcially
refs that were reset to an older point in history such that no pack file
is needed to transfer; would we transfer an empty pack and then
the wanted-refs section for that use case?


> +
> +# c(o/foo) d(o/bar)
> +#        \ /
> +#         b   e(baz)  f(master)
> +#          \__  |  __/
> +#             \ | /
> +#               a

time is up in this diagram, most diagrams I looked at in tests
are sideways. Should be fine either way.

> +test_expect_success 'invalid want-ref line' '
> +       test-pkt-line pack >in <<-EOF &&
> +       command=fetch
> +       0001
> +       no-progress
> +       want-ref refs/heads/non-existent
> +       done
> +       0000
> +       EOF
> +
> +       test_must_fail git serve --stateless-rpc 2>out <in &&
> +       grep "unknown ref" out

The docs disagree with the test?
     A server should ignore any "want-ref <ref>" lines where
    <ref> doesn't exist on the server.


> +
> +test_expect_success 'mix want and want-ref' '

cool!
