Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B02CA0FF7
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 09:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351902AbjIBJLq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 05:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjIBJLp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 05:11:45 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB109F
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 02:11:42 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bc8a2f71eeso21438365ad.0
        for <git@vger.kernel.org>; Sat, 02 Sep 2023 02:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693645902; x=1694250702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HrTr7iqjO1N4KTCImZt7Be3o4Ofo2GhG0sECxrly8kQ=;
        b=hwEfJNX4ucGT0/b91ChO++vsNceXf6r/SHkbq646I10YmOUImWpJjZIBxdLAyh/ITZ
         PdwtWzX6VtjEpFOgU9QEcIzqUWD/qBEyzwlittNMbRSXX43QcfwlQcnIgIfMr4bN9udY
         Afd/odXeK5pIEP0Dm2TUhSQxn5clRZiu03iUZrdD1qoA0/VKVCpRWICdeGINggt1AFC3
         yCQW6Igjv18EPm4RFurk6R2/JpuAgoln/N+LH4e8te2XAtwmUPw+U2dYAEg0LPTN/NJb
         7FZjuToV61wBS7Y9iohjSciLOqfarWn2yZ4XEbS+O3iEmp/axnPbaYWS4YAYYwNO0O/v
         B02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693645902; x=1694250702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrTr7iqjO1N4KTCImZt7Be3o4Ofo2GhG0sECxrly8kQ=;
        b=LrbytPPD8DJurWkcEPQiIk9rmxjsziTGtr6sLEzBdeaprD3s08zxs6ReglbOvW9lWy
         aKr4MOVSnM906pR9T+VjLzjYctOXk6X32EBYapQ1fWfUgazoi2SeVFFYCprOCdASuT5o
         iP/dDulYJdj/XT92b7kVczt57uMv3tBxcVelnKl7LO8+dv4IInOHH3IHL/lfd/qtUVtW
         uq2dXZv7XCqulTWfubEbNx24cWH6Zs/8fmksNW6kciE2qARFsKSjPyBpNiq4+T0WEw09
         7pSrNY/6LjkIRxop2oeBkyXqYWmfiZxf+Sw1e9uZDuqLlKk6jnJDNwUEo2iI+7K+7iWy
         2udA==
X-Gm-Message-State: AOJu0YwKqoXMp4GuMAL37as7XyJMzyZQ6IzLt56/c8MgQU6TRbNd1VrW
        5FiBtNfEsrVAT1cPmfcNTs0DJIP7H+2OZw==
X-Google-Smtp-Source: AGHT+IHLDgt9dx0KnnNn5bHhdPPRCv/XYkX5f35k9NE/TQd+RB88adt4WOF9FdDIb0SJ7cAMIWcOhg==
X-Received: by 2002:a17:903:246:b0:1bf:650b:14fb with SMTP id j6-20020a170903024600b001bf650b14fbmr5146262plh.42.1693645901632;
        Sat, 02 Sep 2023 02:11:41 -0700 (PDT)
Received: from five231003 ([49.37.159.204])
        by smtp.gmail.com with ESMTPSA id d1-20020a170903230100b001b7fd27144dsm4280487plh.40.2023.09.02.02.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 02:11:41 -0700 (PDT)
Date:   Sat, 2 Sep 2023 14:41:37 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] ref-filter: sort numerically when ":size" is used
Message-ID: <ZPL8SQTxbqZ3LTCP@five231003>
References: <20230901142624.12063-1-five231003@gmail.com>
 <20230902090155.8978-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230902090155.8978-1-five231003@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 02, 2023 at 02:30:39PM +0530, Kousik Sanagavarapu wrote:
> Atoms like "raw" and "contents" have a ":size" option which can be used
> to know the size of the data. Since these atoms have the cmp_type
> FIELD_STR, they are sorted alphabetically from 'a' to 'z' and '0' to
> '9'. Meaning, even when the ":size" option is used and what we
> ultimatlely have is numbers, we still sort alphabetically.
[...]
> So, sort numerically whenever the sort is done with "contents:size" or
> "raw:size" and do it the normal alphabetic way when "contents" or "raw"
> are used with some other option (they are FIELD_STR anyways).
> 
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> ---

Oops, forgot the range-diff.

Range-diff against v1:

1:  9b561e429b ! 1:  194dcb0b0d ref-filter: sort numerically when ":size" is used
    @@ Commit message
         "raw:size" and do it the normal alphabetic way when "contents" or "raw"
         are used with some other option (they are FIELD_STR anyways).

    +    Helped-by: Jeff King <peff@peff.net>
         Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>

      ## ref-filter.c ##
    -@@ ref-filter.c: struct atom_value {
    -   ssize_t s_size;
    -   int (*handler)(struct atom_value *atomv, struct ref_formatting_state *state,
    -                  struct strbuf *err);
    --  uintmax_t value; /* used for sorting when not FIELD_STR */
    -+
    -+  /*
    -+   * Used for sorting when not FIELD_STR or when FIELD_STR but the
    -+   * sort should be numeric and not alphabetic.
    -+   */
    -+  uintmax_t value;
    -+
    -   struct used_atom *atom;
    - };
    -
    +@@ ref-filter.c: static int contents_atom_parser(struct ref_format *format, struct used_atom *ato
    +           atom->u.contents.option = C_BARE;
    +   else if (!strcmp(arg, "body"))
    +           atom->u.contents.option = C_BODY;
    +-  else if (!strcmp(arg, "size"))
    ++  else if (!strcmp(arg, "size")) {
    ++          atom->type = FIELD_ULONG;
    +           atom->u.contents.option = C_LENGTH;
    +-  else if (!strcmp(arg, "signature"))
    ++  } else if (!strcmp(arg, "signature"))
    +           atom->u.contents.option = C_SIG;
    +   else if (!strcmp(arg, "subject"))
    +           atom->u.contents.option = C_SUB;
    +@@ ref-filter.c: static int raw_atom_parser(struct ref_format *format UNUSED,
    + {
    +   if (!arg)
    +           atom->u.raw_data.option = RAW_BARE;
    +-  else if (!strcmp(arg, "size"))
    ++  else if (!strcmp(arg, "size")) {
    ++          atom->type = FIELD_ULONG;
    +           atom->u.raw_data.option = RAW_LENGTH;
    +-  else
    ++  } else
    +           return err_bad_arg(err, "raw", arg);
    +   return 0;
    + }
     @@ ref-filter.c: static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
                                v->s = xmemdupz(buf, buf_size);
                                v->s_size = buf_size;
                                v->s = xmemdupz(buf, buf_size);
                                v->s_size = buf_size;
                                v->s_size = buf_size;
                        } else if (atom->u.raw_data.option == RAW_LENGTH) {
     -                          v->s = xstrfmt("%"PRIuMAX, (uintmax_t)buf_size);
    -+                          v->value = (uintmax_t)buf_size;
    ++                          v->value = buf_size;
     +                          v->s = xstrfmt("%"PRIuMAX, v->value);
                        }
                        continue;
    @@ ref-filter.c: static void grab_sub_body_contents(struct atom_value *val, int der
                        v->s = xmemdupz(bodypos, bodylen);
     -          else if (atom->u.contents.option == C_LENGTH)
     -                  v->s = xstrfmt("%"PRIuMAX, (uintmax_t)strlen(subpos));
    +-          else if (atom->u.contents.option == C_BODY)
     +          else if (atom->u.contents.option == C_LENGTH) {
    -+                  v->value = (uintmax_t)strlen(subpos);
    ++                  v->value = strlen(subpos);
     +                  v->s = xstrfmt("%"PRIuMAX, v->value);
    -+          }
    -           else if (atom->u.contents.option == C_BODY)
    ++          } else if (atom->u.contents.option == C_BODY)
                        v->s = xmemdupz(bodypos, nonsiglen);
                else if (atom->u.contents.option == C_SIG)
    +                   v->s = xmemdupz(sigpos, siglen);
     @@ ref-filter.c: static int populate_value(struct ref_array_item *ref, struct strbuf *err)

                v->s_size = ATOM_SIZE_UNSPECIFIED;
    @@ ref-filter.c: static int populate_value(struct ref_array_item *ref, struct strbu
                v->atom = atom;

                if (*name == '*') {
    -@@ ref-filter.c: static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
    -           cmp_detached_head = 1;
    -   } else if (s->sort_flags & REF_SORTING_VERSION) {
    -           cmp = versioncmp(va->s, vb->s);
    --  } else if (cmp_type == FIELD_STR) {
    -+  } else if (cmp_type == FIELD_STR && !va->value && !vb->value) {
    -           if (va->s_size < 0 && vb->s_size < 0) {
    -                   int (*cmp_fn)(const char *, const char *);
    -                   cmp_fn = s->sort_flags & REF_SORTING_ICASE

      ## t/t6300-for-each-ref.sh ##
     @@ t/t6300-for-each-ref.sh: test_expect_success 'Verify sorts with raw' '
