Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 693A21F803
	for <e@80x24.org>; Thu, 10 Jan 2019 23:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbfAJXRo (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 18:17:44 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37534 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbfAJXRo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 18:17:44 -0500
Received: by mail-ed1-f68.google.com with SMTP id h15so11634456edb.4
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 15:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6p2IvXDf3H6uqLj5I9PhhWsuj+XXzcW0LgwikL8oruI=;
        b=hZUE1EPAyZqw9cMLrcW2iJvQWTHRkZnxhkQTypDGhGhIsP5sC9XZps6vDryEc/MrP7
         3zqN3DVkJmzhKfB6QtlLNQqVnxWQSZyPA2hgJROv+dwQoPRZWxQa3gqZeyKEmp2bBiGz
         iwpD/2FpCIcFEYgpoF1puOWIAp4DNZt/z/Z754VktduU7bJ7SYTLqtw4+t1uCt+V3DRS
         OWRufg0a2mb8Ch76/36aoPSQa95g79+dsaLC8ERgVhqG/SE1fo0fL2TN40dX1p8AvjeO
         Fg4Zr0rCCElGc5jnr3QRi4Q0QSdNhH1BK8vO22p9ETIEA/nss1PcvycVzul9E9C+ikl0
         V3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6p2IvXDf3H6uqLj5I9PhhWsuj+XXzcW0LgwikL8oruI=;
        b=RPYzY2d098iDiSiwW19ddOKJ+OJLFI5lspoUEjoz4cgGSlbkSqfpGqrjGBUmWjStwb
         q9AMCqrbpCecXjC5XdJ6j38hYQzv1y1Uf6UVPGgx5rP+b2dyO5rTajGlfe2PrxjKo/yz
         FT+n8LigAtwJnMI0Fn7Hm6Z9BelVnR7GGxWY3KFXQRrzfnyeW8RBSdBDIk1kUF3fqirk
         yKaP5EKZQeNdAl5V9hkyUUguh6My1xGqGdRrD0qAyJtTahi7FlHdY+TEpBYqebTJd6wp
         ZNmJn/vpATr620YhSLJ3SAK3zZsdCufuKoFPmRBTTU7T/h8YqR2HPXkSyaj8ozMAentX
         UtmA==
X-Gm-Message-State: AJcUukcHBTgxGV6zUzkVo/FsMYjebPQdKR0Y8HVXRMzjT/E+IM5+O/zn
        z4b6ruG9cKOYAHOohBt/3gghokzErQWxxGPQ0FV+8g==
X-Google-Smtp-Source: ALg8bN6utRs0pfvCcJF7uZWT5mVnGsEypds5pMRBuxsTergip0Lz1YQXk/Y8N5MW17ZDx2AK63daqAQRHn/iA5EmltM=
X-Received: by 2002:a17:906:dda:: with SMTP id p26-v6mr10192130eji.6.1547162262457;
 Thu, 10 Jan 2019 15:17:42 -0800 (PST)
MIME-Version: 1.0
References: <20190110193645.34080-1-jonathantanmy@google.com>
In-Reply-To: <20190110193645.34080-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 Jan 2019 15:17:31 -0800
Message-ID: <CAGZ79kZ8U6xWKQrmBW-G5HrZC0DN3AroxLCnkN2FPC70rQGYyg@mail.gmail.com>
Subject: Re: [PATCH] fetch-pack: do not take shallow lock unnecessarily
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 10, 2019 at 11:36 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> When fetching using protocol v2, the remote may send a "shallow-info"
> section if the client is shallow. If so, Git as the client currently
> takes the shallow file lock, even if the "shallow-info" section is
> empty.
>
> This is not a problem except that Git does not support taking the
> shallow file lock after modifying the shallow file, because
> is_repository_shallow() stores information that is never cleared. And
> this take-after-modify occurs when Git does a tag-following fetch from a
> shallow repository on a transport that does not support tag following
> (since in this case, 2 fetches are performed).
>
> To solve this issue, take the shallow file lock (and perform all other
> shallow processing) only if the "shallow-info" section is non-empty;
> otherwise, behave as if it were empty.

In other parts of the code we often have an early exit instead of
setting a variable and reacting to that in the end, i.e. what
do you think about:

static void receive_shallow_info(struct fetch_pack_args *args,
    struct packet_reader *reader)
{
     process_section_header(reader, "shallow-info", 0);
+    if (reader->status == PACKET_READ_FLUSH ||
+        reader->status == PACKET_READ_DELIM)
+            /* useful comment why empty sections appear */
+            return;
    while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
    ...

instead? This would allow us to keep the rest of the function
relatively simple as well as we'd have a dedicated space where
we can explain why empty sections need to be treated specially.

> A full solution (probably, ensuring that any action of committing
> shallow file locks also includes clearing the information stored by
> is_repository_shallow()) would solve the issue without need for this
> patch, but this patch is independently useful (as an optimization to
> prevent writing a file in an unnecessary case), hence why I wrote it. I
> have included a NEEDSWORK outlining the full solution.

I like this patch..

> +test_expect_success 'ensure that multiple fetches in same process from a shallow repo works' '
> +       rm -rf server client trace &&
> +
> +       test_create_repo server &&
> +       test_commit -C server one &&
> +       test_commit -C server two &&
> +       test_commit -C server three &&
> +       git clone --shallow-exclude two "file://$(pwd)/server" client &&
> +
> +       git -C server tag -a -m "an annotated tag" twotag two &&
> +
> +       # Triggers tag following (thus, 2 fetches in one process)
> +       GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
> +               fetch --shallow-exclude one origin &&
> +       # Ensure that protocol v2 is used
> +       grep "fetch< version 2" trace
> +'

Would we also need to ensure tags 'one' and 'three',
but not 'two' are present?
(What error condition do we see without this patch?)
