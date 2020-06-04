Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A27C433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 380FE206DC
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgWdhfW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgFDRzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730124AbgFDRzI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 13:55:08 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960B7C08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 10:55:08 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j198so7375905wmj.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eU695WVPbx+6SAapeimxytDEpVWVT4kOtfk/d4jSSd4=;
        b=CgWdhfW6HpRw94t4OCEzs6Rb5HDYOYaLC8P8IdTAwEgCrTfXN8PdZWmhd6u8Kk/O2Y
         ZYifB8cgfGA9jh+c9MlcKegk92pvQT7epZGYVD5LR/L7ZpM491h/yVwJ6QJBSeg/XvHr
         efXLh3sUF8t6BFNfBqpy3er1KECJBE4ucptERCH4LePgYMZFpJ9mcZ1NfNiIn0Qk/vLC
         oSOGV4fm4XFjX0bGs0tqTc453sJfQ+XbJ3BUPfFT5DJjBQGrB9vq9kQ4hJssBMktkkuR
         AuYupRg3X3IGLkKQXnDDWme+Ul6od6qoLcJLp5wtuXQWbKynbThvGDEv6kj+T7ZWUqB3
         NoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eU695WVPbx+6SAapeimxytDEpVWVT4kOtfk/d4jSSd4=;
        b=tRErbCUdfcsbgFaXUBPw995Brj9nyVdCgc3lm+6tUOMXCdX1TJa22viRrhleXFnPnL
         KcTfOKhZYE61KPXsfm4lH9/Gsq2pyPtTWbboUidlm2RybQn0HKyQe4JNvYDKhZeX67Lk
         43Pwm0aawq43Aa/+pn43WgnfkSfi6nkJ6yZU1/g+Cuc+qGn5afd9780ikEZ/wSnehNZ5
         grPgLpJkgL2IdCZBcbQGq9/C5cHk+EfBXtzmdC0L4Z4aWHsHoAAW2aOWLyL5siGGf6ez
         0/VRBoXZKWZxZbtgaln9euTUWsQxEw2UeShcnOcXMRwwwuBLhe04aspLUBfVgAt11dvH
         EMbg==
X-Gm-Message-State: AOAM5300Jfl/TuW6CDNJhdsE3+Pzw/JXDi/qSCNTo5i4QGzrjozNTorI
        d8cB0X4EeI9TQhcR5w4gq/ySFdb3bQw=
X-Google-Smtp-Source: ABdhPJxCWhCVFCWcM/ceNNJHnIZ7sbytdq8dHS346cM7yB1ffeSDIzwTGWonKfeXxJLU494qLfxb2w==
X-Received: by 2002:a7b:cf21:: with SMTP id m1mr5256041wmg.71.1591293306663;
        Thu, 04 Jun 2020 10:55:06 -0700 (PDT)
Received: from localhost.localdomain ([185.228.231.251])
        by smtp.gmail.com with ESMTPSA id s7sm9173540wrr.60.2020.06.04.10.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 10:55:05 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 00/13] upload-pack: use 'struct upload_pack_data' thoroughly, part 2
Date:   Thu,  4 Jun 2020 19:54:37 +0200
Message-Id: <20200604175450.17385-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.rc0.26.gf2851482f5
In-Reply-To: <20200602041657.7132-1-chriscool@tuxfamily.org>
References: <20200602041657.7132-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is the second part of an effort to move all static
variables in 'upload-pack.c' into 'struct upload_pack_data'.

It is based on 'cc/upload-pack-data' which contains "part 1" of this
effort. (See also: https://lore.kernel.org/git/20200515100454.14486-1-chriscool@tuxfamily.org/)

A part 3 will follow with the rest of the patches needed to get rid of
the static variables left after this patch series.

Thanks to Peff for his review of the first and second versions of this
part 2:

V1: https://lore.kernel.org/git/20200527164742.23067-1-chriscool@tuxfamily.org/
V2: https://lore.kernel.org/git/20200602041657.7132-1-chriscool@tuxfamily.org/

Thanks to Jonathan Tan for his review of V2 too.

Compared to V2 the changes are the following:

  - patch 01/13 integrates Jonathan's commit message improvement

  - patch 07/13 integrates Jonathan's fixup patch which makes
    multi_ack enum values all-caps and fixes a spacing issue (2 spaces
    between "enum" and "{")

There is a lot of noise in the range-diff with V2, because V3 contains
Peff's 'Acked-by:' and Junio's 'Signed-off-by', but here it is:

 1:  e5c31f30ec !  1:  12f8a9c953 upload-pack: actually use some upload_pack_data bitfields
    @@ Commit message
     
         As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
         more thoroughly, let's actually start using some bitfields of
    -    that struct, which were previously unused.
    +    that struct. These bitfields were introduced in 3145ea957d
    +    ("upload-pack: introduce fetch server command", 2018-03-15), but
    +    were never used.
     
         We could instead have just removed the following bitfields
         from the struct:
    @@ Commit message
         fixing a bug, but one nobody is likely to see, because it would
         imply the client sending different capabilities for each request.
     
    +    Helped-by: Jonathan Tan <jonathantanmy@google.com>
         Signed-off-by: Jeff King <peff@peff.net>
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Acked-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## upload-pack.c ##
     @@ upload-pack.c: static timestamp_t oldest_have;
 2:  225be644f4 !  2:  b74c2f4d64 upload-pack: annotate upload_pack_data fields
    @@ Commit message
         ones only for protocol v2.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Acked-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## upload-pack.c ##
     @@ upload-pack.c: static int allow_ref_in_want;
 3:  5adca8d70c !  3:  05cb66320a upload-pack: move static vars to upload_pack_data
    @@ Commit message
         now is more coherent and cleaner.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Acked-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## upload-pack.c ##
     @@
 4:  1507a8134a !  4:  be32b64b0a upload-pack: move use_sideband to upload_pack_data
    @@ Commit message
         definition.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Acked-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## upload-pack.c ##
     @@ upload-pack.c: static unsigned int allow_unadvertised_object_request;
 5:  0ef8d28958 !  5:  154651241d upload-pack: move filter_capability_requested to upload_pack_data
    @@ Commit message
         now is more coherent and cleaner.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Acked-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## upload-pack.c ##
     @@ upload-pack.c: static struct object_array extra_edge_obj;
 6:  319c09ce02 !  6:  ba6999dc74 upload-pack: move multi_ack to upload_pack_data
    @@ Commit message
         now is more coherent and cleaner.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Acked-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## upload-pack.c ##
     @@
 7:  cd3a0a1e5c !  7:  988e2e1d9a upload-pack: change multi_ack to an enum
    @@ Commit message
     
         This will make it clear which values this variable can take.
     
    +    Helped-by: Jonathan Tan <jonathantanmy@google.com>
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Acked-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## upload-pack.c ##
     @@ upload-pack.c: struct upload_pack_data {
    @@ upload-pack.c: struct upload_pack_data {
      
        unsigned int timeout;                                   /* v0 only */
     -  int multi_ack;                                          /* v0 only */
    -+  enum  {
    -+          no_multi_ack = 0,
    -+          multi_ack = 1,
    -+          multi_ack_detailed = 2
    ++  enum {
    ++          NO_MULTI_ACK = 0,
    ++          MULTI_ACK = 1,
    ++          MULTI_ACK_DETAILED = 2
     +  } multi_ack;                                            /* v0 only */
      
        /* 0 for no sideband, otherwise DEFAULT_PACKET_MAX or LARGE_PACKET_MAX */
    @@ upload-pack.c: static int get_common_commits(struct upload_pack_data *data,
      
                if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
     -                  if (data->multi_ack == 2
    -+                  if (data->multi_ack == multi_ack_detailed
    ++                  if (data->multi_ack == MULTI_ACK_DETAILED
                            && got_common
                            && !got_other
                            && ok_to_give_up(&data->have_obj, &data->want_obj)) {
    @@ upload-pack.c: static int get_common_commits(struct upload_pack_data *data,
                                    && ok_to_give_up(&data->have_obj, &data->want_obj)) {
                                        const char *hex = oid_to_hex(&oid);
     -                                  if (data->multi_ack == 2) {
    -+                                  if (data->multi_ack == multi_ack_detailed) {
    ++                                  if (data->multi_ack == MULTI_ACK_DETAILED) {
                                                sent_ready = 1;
                                                packet_write_fmt(1, "ACK %s ready\n", hex);
                                        } else
    @@ upload-pack.c: static int get_common_commits(struct upload_pack_data *data,
                                got_common = 1;
                                oid_to_hex_r(last_hex, &oid);
     -                          if (data->multi_ack == 2)
    -+                          if (data->multi_ack == multi_ack_detailed)
    ++                          if (data->multi_ack == MULTI_ACK_DETAILED)
                                        packet_write_fmt(1, "ACK %s common\n", last_hex);
                                else if (data->multi_ack)
                                        packet_write_fmt(1, "ACK %s continue\n", last_hex);
    @@ upload-pack.c: static void receive_needs(struct upload_pack_data *data,
                        data->deepen_relative = 1;
                if (parse_feature_request(features, "multi_ack_detailed"))
     -                  data->multi_ack = 2;
    -+                  data->multi_ack = multi_ack_detailed;
    ++                  data->multi_ack = MULTI_ACK_DETAILED;
                else if (parse_feature_request(features, "multi_ack"))
     -                  data->multi_ack = 1;
    -+                  data->multi_ack = multi_ack;
    ++                  data->multi_ack = MULTI_ACK;
                if (parse_feature_request(features, "no-done"))
                        data->no_done = 1;
                if (parse_feature_request(features, "thin-pack"))
 8:  c23e37a8da !  8:  8dcd7dddc2 upload-pack: pass upload_pack_data to upload_pack_config()
    @@ Commit message
         that are set in upload_pack_config() into 'upload_pack_data'.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Acked-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## upload-pack.c ##
     @@ upload-pack.c: static int find_symref(const char *refname, const struct object_id *oid,
 9:  26893a4098 !  9:  8c165eef8f upload-pack: move keepalive to upload_pack_data
    @@ Commit message
         It is used by code common to protocol v0 and protocol v2.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Acked-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## upload-pack.c ##
     @@ upload-pack.c: static timestamp_t oldest_have;
    @@ upload-pack.c: struct upload_pack_data {
     +  int keepalive;
      
        unsigned int timeout;                                   /* v0 only */
    -   enum  {
    +   enum {
     @@ upload-pack.c: static void upload_pack_data_init(struct upload_pack_data *data)
        data->shallows = shallows;
        data->deepen_not = deepen_not;
10:  2fa59d6c89 ! 10:  17ac2a015a upload-pack: move allow_filter to upload_pack_data
    @@ Commit message
         It is used by both protocol v0 and protocol v2 code.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Acked-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## upload-pack.c ##
     @@ upload-pack.c: static int shallow_nr;
11:  d501b0f694 ! 11:  74245639d8 upload-pack: move allow_ref_in_want to upload_pack_data
    @@ Commit message
         It is used only by protocol v2 code.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Acked-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## upload-pack.c ##
     @@ upload-pack.c: static int shallow_nr;
12:  90513f0543 ! 12:  d866ea2741 upload-pack: move allow_sideband_all to upload_pack_data
    @@ Commit message
         It is used only by protocol v2 code.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Acked-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## upload-pack.c ##
     @@ upload-pack.c: static int shallow_nr;
13:  f2851482f5 ! 13:  fce53edae4 upload-pack: move pack_objects_hook to upload_pack_data
    @@ Commit message
         While at it let's also free() it in upload_pack_data_clear().
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
    +    Acked-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## upload-pack.c ##
     @@ upload-pack.c: static timestamp_t oldest_have;

Christian Couder (12):
  upload-pack: annotate upload_pack_data fields
  upload-pack: move static vars to upload_pack_data
  upload-pack: move use_sideband to upload_pack_data
  upload-pack: move filter_capability_requested to upload_pack_data
  upload-pack: move multi_ack to upload_pack_data
  upload-pack: change multi_ack to an enum
  upload-pack: pass upload_pack_data to upload_pack_config()
  upload-pack: move keepalive to upload_pack_data
  upload-pack: move allow_filter to upload_pack_data
  upload-pack: move allow_ref_in_want to upload_pack_data
  upload-pack: move allow_sideband_all to upload_pack_data
  upload-pack: move pack_objects_hook to upload_pack_data

Jeff King (1):
  upload-pack: actually use some upload_pack_data bitfields

 upload-pack.c | 199 ++++++++++++++++++++++++++++----------------------
 1 file changed, 110 insertions(+), 89 deletions(-)

-- 
2.27.0.rc0.26.gf2851482f5

