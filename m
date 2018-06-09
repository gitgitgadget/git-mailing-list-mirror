Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DD761F403
	for <e@80x24.org>; Sat,  9 Jun 2018 18:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753464AbeFISGH (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 14:06:07 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40856 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753359AbeFISGG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 14:06:06 -0400
Received: by mail-oi0-f68.google.com with SMTP id f79-v6so14590361oib.7
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 11:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qpu87oM2VkDd4iVhjMiRmuob9aMk+8DIbdRxFVMdH88=;
        b=kxYS3zGWnRiIPoMtDXQREsI/8mPrIXZoMngBh9/XElcpsKDS3VvmYRWskeCC8pVlnn
         ecbS/tE2NtFqRfWAAIpG/eEVgcgUCZY2iPpBqCg3ris7/leyMM3fdg26KHQmnXSCg84Y
         PToGfvq8THe0q7bJUbVvIqBDCERwTUz6HM1bldJwJzN465U52pwcfbre8urp0Hz0gAGH
         ab79Ev2utGzopDvOFMiMe7n/lIkmWaZyKVkeqJjeFrWoP6iS2JR7ibKvcMiGRrrtJF96
         LsU7qSNeVPtGr1Z56+KEUH35OUSLACzJVu2pBiwpsyn77MrJpUMJvDv+RSjbNcGMFrDV
         83dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpu87oM2VkDd4iVhjMiRmuob9aMk+8DIbdRxFVMdH88=;
        b=aK5TZBphlERFr8eChwDxUcEYVprnGgJpRDZQ2d7xMvPUCcfEsUl1cwD9sBMyFLnGeL
         PzQ+g18bD7SNOPuLGYQkrGAGexZzKY9wwwxWWex3VDNThNW4cbAbKFZV6UDYFfTu3KJS
         4rtDdbrHryhj9O02ti3ctx9Gredjj5c0cg2JXlTxRvjnsSXN+cJMmWmEry7SoNrIWnoC
         +hKzGv+gGRt/IQ84uUMndWlO/Y0g1h9Nn6ARwb+6cpOSfEcAcsHLuF0Fm1KYSZoafPEy
         xLMcxANsj1EPxqNy2/8FgQWjYvKzScP4tdCfw0L0kDiD+nHUHC5T8qrTKiJnJwmOnvIF
         ad8w==
X-Gm-Message-State: APt69E05qZzlc+G1Ya9Cz3QXkAjs8rc/1PS53K0htEbuptUssXKsdKtl
        FKRtM3uQzcI5Zk52b0/B4BuFyT32dAwjrkS/VwA=
X-Google-Smtp-Source: ADUXVKIX96g0WlJxOtGqE0udWsUMujf+8QcMb9JIdeVXQC0c8BQw0UqQTmrd/YcgzlyqsFOHu5NirTH1jGO32V0eIlA=
X-Received: by 2002:aca:aa54:: with SMTP id t81-v6mr5516441oie.30.1528567565593;
 Sat, 09 Jun 2018 11:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-22-dstolee@microsoft.com>
In-Reply-To: <20180607140338.32440-22-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 9 Jun 2018 20:05:39 +0200
Message-ID: <CACsJy8DbF3AXuHK9yaEtYPwkhP_BC47b50iTT0tHqODGVp7FCA@mail.gmail.com>
Subject: Re: [PATCH 21/23] midx: prevent duplicate packfile loads
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 7, 2018 at 4:07 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> If the multi-pack-index contains a packfile, then we do not need to add
> that packfile to the packed_git linked list or the MRU list.

Because...?

I think I see the reason, but I'd like it spelled out to avoid any
misunderstanding.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  midx.c     | 23 +++++++++++++++++++++++
>  midx.h     |  1 +
>  packfile.c |  7 +++++++
>  3 files changed, 31 insertions(+)
>
> diff --git a/midx.c b/midx.c
> index 388d79b7d9..3242646fe0 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -278,6 +278,29 @@ int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct mi
>         return nth_midxed_pack_entry(m, e, pos);
>  }
>
> +int midx_contains_pack(struct midxed_git *m, const char *idx_name)
> +{
> +       uint32_t first = 0, last = m->num_packs;
> +
> +       while (first < last) {
> +               uint32_t mid = first + (last - first) / 2;
> +               const char *current;
> +               int cmp;
> +
> +               current = m->pack_names[mid];
> +               cmp = strcmp(idx_name, current);
> +               if (!cmp)
> +                       return 1;
> +               if (cmp > 0) {
> +                       first = mid + 1;
> +                       continue;
> +               }
> +               last = mid;
> +       }
> +
> +       return 0;
> +}
> +
>  int prepare_midxed_git_one(struct repository *r, const char *object_dir)
>  {
>         struct midxed_git *m = r->objects->midxed_git;
> diff --git a/midx.h b/midx.h
> index 497bdcc77c..c1db58d8c4 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -13,6 +13,7 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
>                                         struct midxed_git *m,
>                                         uint32_t n);
>  int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct midxed_git *m);
> +int midx_contains_pack(struct midxed_git *m, const char *idx_name);
>  int prepare_midxed_git_one(struct repository *r, const char *object_dir);
>
>  int write_midx_file(const char *object_dir);
> diff --git a/packfile.c b/packfile.c
> index 059b2aa097..479cb69b9f 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -746,6 +746,11 @@ static void prepare_packed_git_one(struct repository *r, char *objdir, int local
>         DIR *dir;
>         struct dirent *de;
>         struct string_list garbage = STRING_LIST_INIT_DUP;
> +       struct midxed_git *m = r->objects->midxed_git;
> +
> +       /* look for the multi-pack-index for this object directory */
> +       while (m && strcmp(m->object_dir, objdir))
> +               m = m->next;
>
>         strbuf_addstr(&path, objdir);
>         strbuf_addstr(&path, "/pack");
> @@ -772,6 +777,8 @@ static void prepare_packed_git_one(struct repository *r, char *objdir, int local
>                 base_len = path.len;
>                 if (strip_suffix_mem(path.buf, &base_len, ".idx")) {
>                         /* Don't reopen a pack we already have. */
> +                       if (m && midx_contains_pack(m, de->d_name))
> +                               continue;
>                         for (p = r->objects->packed_git; p;
>                              p = p->next) {
>                                 size_t len;
> --
> 2.18.0.rc1
>


-- 
Duy
