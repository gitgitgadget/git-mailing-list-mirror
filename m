Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502E8C433E0
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21EEF2072F
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QG3LdZ/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgFBERU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgFBERT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 00:17:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D8CC061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 21:17:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id p5so1870697wrw.9
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 21:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=irRmNjlfABDkNJ1GgP9EZDJCYSpAmd5IKd7HfPG+SHs=;
        b=QG3LdZ/8sQEkm3kb3ualzTYJqQSYJZh97TUdyP/LDSydhfhUIg4W+vAlnFHdh7WKpw
         tcqRz8afaakqS1LlFCcwWtZG8v4HuzBs0m9aHF3IoW1fxGFCmwiU307lHvkjoU8GAXn1
         kdptTu3f677bf87dXm1xc02mUrz+nPpnwz/6ECwxpKY8lpyVFtXHQF/+FTBbbljTJzHf
         vge2diHlTote2QuAhLVIC2OO9Lkf9z5JWtF8r355BbjlZhUW2+Qptm2WZsFFDNQz2rHN
         qMwFjbvhbBbapkX1MuUeMu1YZU1ewDaZaIqXRCViSAsJtJlfSZhdQV7LMo3Nn902ZUOf
         Q/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=irRmNjlfABDkNJ1GgP9EZDJCYSpAmd5IKd7HfPG+SHs=;
        b=gUzjoyk2M88sN1zxJJ8zKPTrw4Lkr/ijTgkN862+Q6HvmxGy47hPt07YSpOVt8yL3R
         kpcMpeU1JwZPeqlgbFK3Ix/qdW5TBh9Obgc/cfGLDT23UQ9xZAwytkuYhW7HT/Gk5JWx
         gCN3gfY2s/4zOOO2z+yrx68ApwrJfQN3u2mFPhoGSSI4dRna3xe9gAM+r76UgQDyhV+I
         PbpqB5msKd00hGq/GqwGIE33CHHdE1EuwWEz0PKGs3fUtaCVPSn29U5V3UBtfwcHSqMw
         Aie+/6kCwOheDxZXWbXwkufx6f+vPoBLX+PUWeFY1xTvX5gZG5e63rzNiDFZqs/ZWjQf
         ZnAA==
X-Gm-Message-State: AOAM530UIk0O3rupYX0BY0JLM/0yQOQpwHmd/CLnQOouQ0fB+5Sih+uV
        d/JjHm+TwzjHc+//GgcRj7fauq1taEw=
X-Google-Smtp-Source: ABdhPJxefCIqP+RIOId3Xn1ApQ1NU+CRiUE2PzYMtn6sPKmgFFHCYcACQeoIA5osoXcQ8DPUFJ0bvw==
X-Received: by 2002:adf:82c9:: with SMTP id 67mr27002097wrc.149.1591071436507;
        Mon, 01 Jun 2020 21:17:16 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.249])
        by smtp.gmail.com with ESMTPSA id z2sm1717614wrs.87.2020.06.01.21.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 21:17:15 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 00/13] upload-pack: use 'struct upload_pack_data' thoroughly, part 2
Date:   Tue,  2 Jun 2020 06:16:44 +0200
Message-Id: <20200602041657.7132-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.rc0.26.gf2851482f5
In-Reply-To: <20200527164742.23067-1-chriscool@tuxfamily.org>
References: <20200527164742.23067-1-chriscool@tuxfamily.org>
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

Thanks to Peff for his review of the first version (V1:
https://lore.kernel.org/git/20200527164742.23067-1-chriscool@tuxfamily.org/)
of this part 2.

Compared to V1 the changes are the following:

  - added patch 2/13 "upload-pack: annotate upload_pack_data fields"
    to add 'v0 only' or 'v2 only' comments to the 'upload_pack_data'
    fields, and to better group 'v0 only' and 'v2 only' fields
    together

  - added similar comments in all the other patches when necessary

  - in patch 3/13 'timeout' is still an 'unsigned int' after being
    moved into 'upload_pack_data'

  - in patch 10/13 commit message has been corrected to say that
    'allow_filter' is used by both protocol v0 and v2

  - in patch 11/13 commit message has been corrected to say that
    'allow_ref_in_want' is used only by protocol v2

Here is the range-diff with V1:

 1:  e5c31f30ec =  1:  e5c31f30ec upload-pack: actually use some upload_pack_data bitfields
 -:  ---------- >  2:  225be644f4 upload-pack: annotate upload_pack_data fields
 2:  5f2da66cfd !  3:  5adca8d70c upload-pack: move static vars to upload_pack_data
    @@ upload-pack.c: static int daemon_mode;
      /* 0 for no sideband,
       * otherwise maximum packet size (up to 65520 bytes).
     @@ upload-pack.c: struct upload_pack_data {
    -   timestamp_t deepen_since;
        int deepen_rev_list;
        int deepen_relative;
    -+  int timeout;
      
    ++  unsigned int timeout;                                   /* v0 only */
    ++
        struct list_objects_filter_options filter_options;
      
        struct packet_writer writer;
      
    -   unsigned stateless_rpc : 1;
    -+  unsigned daemon_mode : 1;
    +   unsigned stateless_rpc : 1;                             /* v0 only */
    ++  unsigned no_done : 1;                                   /* v0 only */
    ++  unsigned daemon_mode : 1;                               /* v0 only */
      
        unsigned use_thin_pack : 1;
        unsigned use_ofs_delta : 1;
    -   unsigned no_progress : 1;
    -   unsigned use_include_tag : 1;
    -   unsigned done : 1;
    -+  unsigned no_done : 1;
    - };
    - 
    - static void upload_pack_data_init(struct upload_pack_data *data)
     @@ upload-pack.c: static void upload_pack_data_clear(struct upload_pack_data *data)
        list_objects_filter_release(&data->filter_options);
      }
      
     -static void reset_timeout(void)
    -+static void reset_timeout(int timeout)
    ++static void reset_timeout(unsigned int timeout)
      {
        alarm(timeout);
      }
 3:  56b90f8b5d !  4:  1507a8134a upload-pack: move use_sideband to upload_pack_data
    @@ upload-pack.c: static unsigned int allow_unadvertised_object_request;
      
      static int filter_capability_requested;
     @@ upload-pack.c: struct upload_pack_data {
    -   int deepen_relative;
    -   int timeout;
    + 
    +   unsigned int timeout;                                   /* v0 only */
      
     +  /* 0 for no sideband, otherwise DEFAULT_PACKET_MAX or LARGE_PACKET_MAX */
     +  int use_sideband;
    @@ upload-pack.c: struct upload_pack_data {
        struct list_objects_filter_options filter_options;
      
        struct packet_writer writer;
    -@@ upload-pack.c: static void reset_timeout(int timeout)
    +@@ upload-pack.c: static void reset_timeout(unsigned int timeout)
        alarm(timeout);
      }
      
 4:  a49469bc06 !  5:  0ef8d28958 upload-pack: move filter_capability_requested to upload_pack_data
    @@ upload-pack.c: static struct object_array extra_edge_obj;
      static int allow_ref_in_want;
      
     @@ upload-pack.c: struct upload_pack_data {
    -   unsigned use_include_tag : 1;
    -   unsigned done : 1;
    -   unsigned no_done : 1;
    -+  unsigned filter_capability_requested : 1;
    - };
    +   unsigned stateless_rpc : 1;                             /* v0 only */
    +   unsigned no_done : 1;                                   /* v0 only */
    +   unsigned daemon_mode : 1;                               /* v0 only */
    ++  unsigned filter_capability_requested : 1;               /* v0 only */
      
    - static void upload_pack_data_init(struct upload_pack_data *data)
    +   unsigned use_thin_pack : 1;
    +   unsigned use_ofs_delta : 1;
     @@ upload-pack.c: static void receive_needs(struct upload_pack_data *data,
                        continue;
      
 5:  e0d720aa97 !  6:  319c09ce02 upload-pack: move multi_ack to upload_pack_data
    @@ upload-pack.c
      #define ALLOW_TIP_SHA1    01
      /* Allow request of a sha1 if it is reachable from a ref (possibly hidden ref). */
     @@ upload-pack.c: struct upload_pack_data {
    -   int deepen_rev_list;
        int deepen_relative;
    -   int timeout;
    -+  int multi_ack;
    + 
    +   unsigned int timeout;                                   /* v0 only */
    ++  int multi_ack;                                          /* v0 only */
      
        /* 0 for no sideband, otherwise DEFAULT_PACKET_MAX or LARGE_PACKET_MAX */
        int use_sideband;
 6:  076f4ad903 !  7:  cd3a0a1e5c upload-pack: change multi_ack to an enum
    @@ Commit message
     
      ## upload-pack.c ##
     @@ upload-pack.c: struct upload_pack_data {
    -   int deepen_rev_list;
        int deepen_relative;
    -   int timeout;
    --  int multi_ack;
    -+
    + 
    +   unsigned int timeout;                                   /* v0 only */
    +-  int multi_ack;                                          /* v0 only */
     +  enum  {
     +          no_multi_ack = 0,
     +          multi_ack = 1,
     +          multi_ack_detailed = 2
    -+  } multi_ack;
    ++  } multi_ack;                                            /* v0 only */
      
        /* 0 for no sideband, otherwise DEFAULT_PACKET_MAX or LARGE_PACKET_MAX */
        int use_sideband;
 7:  c0b051f344 =  8:  c23e37a8da upload-pack: pass upload_pack_data to upload_pack_config()
 8:  5daacc6670 !  9:  26893a4098 upload-pack: move keepalive to upload_pack_data
    @@ upload-pack.c: static timestamp_t oldest_have;
      
      static int allow_filter;
     @@ upload-pack.c: struct upload_pack_data {
    +   timestamp_t deepen_since;
        int deepen_rev_list;
        int deepen_relative;
    -   int timeout;
     +  int keepalive;
      
    +   unsigned int timeout;                                   /* v0 only */
        enum  {
    -           no_multi_ack = 0,
     @@ upload-pack.c: static void upload_pack_data_init(struct upload_pack_data *data)
        data->shallows = shallows;
        data->deepen_not = deepen_not;
 9:  d04f78999b ! 10:  2fa59d6c89 upload-pack: move allow_filter to upload_pack_data
    @@ Commit message
         more thoroughly, let's move the 'allow_filter' static variable
         into this struct.
     
    -    It is only used by protocol v0 code since protocol v2 assumes
    -    certain baseline capabilities, but rolling it into
    -    upload_pack_data and just letting v2 code ignore it as it does
    -    now is more coherent and cleaner.
    +    It is used by both protocol v0 and protocol v2 code.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    @@ upload-pack.c: static int shallow_nr;
      
      static int allow_sideband_all;
     @@ upload-pack.c: struct upload_pack_data {
    -   unsigned done : 1;
    -   unsigned no_done : 1;
    -   unsigned filter_capability_requested : 1;
    -+
    +   unsigned use_ofs_delta : 1;
    +   unsigned no_progress : 1;
    +   unsigned use_include_tag : 1;
     +  unsigned allow_filter : 1;
    - };
      
    - static void upload_pack_data_init(struct upload_pack_data *data)
    +   unsigned done : 1;                                      /* v2 only */
    + };
     @@ upload-pack.c: static void receive_needs(struct upload_pack_data *data,
                        data->no_progress = 1;
                if (parse_feature_request(features, "include-tag"))
10:  9e99d94c33 ! 11:  d501b0f694 upload-pack: move allow_ref_in_want to upload_pack_data
    @@ Commit message
         more thoroughly, let's move the 'allow_ref_in_want' static
         variable into this struct.
     
    -    It is only used by protocol v0 code since protocol v2 assumes
    -    certain baseline capabilities, but rolling it into
    -    upload_pack_data and just letting v2 code ignore it as it does
    -    now is more coherent and cleaner.
    +    It is used only by protocol v2 code.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    @@ upload-pack.c: static int shallow_nr;
     -
      static int allow_sideband_all;
      
    - struct upload_pack_data {
    + /*
     @@ upload-pack.c: struct upload_pack_data {
    -   unsigned filter_capability_requested : 1;
    - 
        unsigned allow_filter : 1;
    -+  unsigned allow_ref_in_want : 1;
    + 
    +   unsigned done : 1;                                      /* v2 only */
    ++  unsigned allow_ref_in_want : 1;                         /* v2 only */
      };
      
      static void upload_pack_data_init(struct upload_pack_data *data)
11:  64928f291d ! 12:  90513f0543 upload-pack: move allow_sideband_all to upload_pack_data
    @@ upload-pack.c: static int shallow_nr;
      
     -static int allow_sideband_all;
     -
    - struct upload_pack_data {
    -   struct string_list symref;
    -   struct string_list wanted_refs;
    + /*
    +  * Please annotate, and if possible group together, fields used only
    +  * for protocol v0 or only for protocol v2.
     @@ upload-pack.c: struct upload_pack_data {
      
    -   unsigned allow_filter : 1;
    -   unsigned allow_ref_in_want : 1;
    -+  unsigned allow_sideband_all : 1;
    +   unsigned done : 1;                                      /* v2 only */
    +   unsigned allow_ref_in_want : 1;                         /* v2 only */
    ++  unsigned allow_sideband_all : 1;                        /* v2 only */
      };
      
      static void upload_pack_data_init(struct upload_pack_data *data)
12:  07c5ed9528 ! 13:  f2851482f5 upload-pack: move pack_objects_hook to upload_pack_data
    @@ upload-pack.c: static timestamp_t oldest_have;
      static struct object_array extra_edge_obj;
     -static const char *pack_objects_hook;
      
    - struct upload_pack_data {
    -   struct string_list symref;
    + /*
    +  * Please annotate, and if possible group together, fields used only
     @@ upload-pack.c: struct upload_pack_data {
      
        struct packet_writer writer;
      
     +  const char *pack_objects_hook;
     +
    -   unsigned stateless_rpc : 1;
    -   unsigned daemon_mode : 1;
    - 
    +   unsigned stateless_rpc : 1;                             /* v0 only */
    +   unsigned no_done : 1;                                   /* v0 only */
    +   unsigned daemon_mode : 1;                               /* v0 only */
     @@ upload-pack.c: static void upload_pack_data_clear(struct upload_pack_data *data)
        object_array_clear(&data->shallows);
        string_list_clear(&data->deepen_not, 0);
    @@ upload-pack.c: static void upload_pack_data_clear(struct upload_pack_data *data)
     +  free((char *)data->pack_objects_hook);
      }
      
    - static void reset_timeout(int timeout)
    + static void reset_timeout(unsigned int timeout)
     @@ upload-pack.c: static void create_pack_file(struct upload_pack_data *pack_data)
        int i;
        FILE *pipe_fd;


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
2.27.0.rc0.26.g636377a2c4

