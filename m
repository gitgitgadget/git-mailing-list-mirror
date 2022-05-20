Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8168EC433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 22:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349316AbiETWhz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 18:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbiETWhy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 18:37:54 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C4D185C9F
        for <git@vger.kernel.org>; Fri, 20 May 2022 15:37:53 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id l82so3998658qke.3
        for <git@vger.kernel.org>; Fri, 20 May 2022 15:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EeUUOuZIFUePKsvnu+6/HNJPUL+a2c/grKRNEox0g9M=;
        b=lCzZFl0vXkGMhKCQP3RVl+XF6XXOEUduYtJUQt5MRgp2SEYvBsGe4fwhWGIWyjnmXw
         eqV4wIFtkgu+puygq0hHXlsVb8EPJEa3g3Bv8LcC3amOAw4B6nd1xQgQzaT47PkNTyiQ
         QSuyAQKPLZmsBc13+f1vhnIFQPpT75026MQxYWpZ14SGr7thTRVUP1onNDSziQT7I9AN
         tIKj3GPzp0fnQwaME0ueIuQzLjn9MLZZSPxPJvWsPQq1dY2aAzjVtXQfB9xOzS60A7B3
         V8Qy42PISN72lEuWpxjsiADIg6m6yY7pul7ZA9d/19HvCcbHEPOfMU9SyjAEvq3AQb0e
         OLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EeUUOuZIFUePKsvnu+6/HNJPUL+a2c/grKRNEox0g9M=;
        b=eaxbd9zqhVcJbJlTGTQe8+q8Tmj4FMzEk5kSf9TgDRHATTQ0Cf9POwI784srC77xbU
         T3ez6949+7BAkAwnt6AV49mFxnUwXo/Si7D4UU8Z+8xXmiMEXueWx+age1YFUpcVN5JU
         yfhCeo3tKXiWMVwtqdVBIdz6/pnUgXX5hIDNZ9Bjoio30DVoBWeNgTyXYlUnNVwDYirE
         dNd2cA5kkMs5rTFvxofty0QGr7w0JOI1/Tog6TfM+wyS8ryXpb9u29ZLB/90k6/oXqre
         6+Nj2H9M1XUPBQc+ALCU75yr9i22lHzwHusmVT4tZDNQCr/dJcro5uXkozgNCjUzJh7a
         Z2bw==
X-Gm-Message-State: AOAM530yjkA8kQJO+yT5yOtxE6uytukGT67c5hGDiWrRMuK/U/JlC3pK
        zn0g/QiLFIczvu1NmMNsq94K0g==
X-Google-Smtp-Source: ABdhPJzWDiZgXCpRvjFAE4BkmeR7zntHvafb6ehouN812vIHh2FpBtm26WuqGGvfIUbUzYreGTvw3Q==
X-Received: by 2002:a05:620a:4083:b0:6a0:9d07:5127 with SMTP id f3-20020a05620a408300b006a09d075127mr7512794qko.51.1653086273045;
        Fri, 20 May 2022 15:37:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q6-20020a37f706000000b0069fc13ce204sm434300qkj.53.2022.05.20.15.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 15:37:52 -0700 (PDT)
Date:   Fri, 20 May 2022 18:37:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        derrickstolee@github.com, jrnieder@gmail.com,
        larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v4 02/17] pack-mtimes: support reading .mtimes files
Message-ID: <YogYP03hDH8hZqUV@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1652915424.git.me@ttaylorr.com>
 <8f9fd21be9fcdda5c73d800fc66d1087d61a6888.1652915424.git.me@ttaylorr.com>
 <220519.86zgjd4wvk.gmgdl@evledraar.gmail.com>
 <xmqqr14pr1jt.fsf@gitster.g>
 <220520.86bkvs3bfm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220520.86bkvs3bfm.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 20, 2022 at 09:32:50AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Thu, May 19 2022, Junio C Hamano wrote:
>
> > Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> >
> >> On Wed, May 18 2022, Taylor Blau wrote:
> >>
> >> Nit:
> >>
> >>> +  - A 4-byte magic number '0x4d544d45' ('MTME').
> >>> +
> >>> +  - A 4-byte version identifier (= 1).
> >>> +
> >>> +  - A 4-byte hash function identifier (= 1 for SHA-1, 2 for SHA-256).
> >>
> >> Here we let it suffice that later we'll say "All 4-byte numbers are in
> >> network order".
> >>
> >>> +  - A table of 4-byte unsigned integers in network order. The ith
> >>
> >> But here we call out "network order" explicitly, shouldn't this just be
> >> s/ in network order//?
> >>
> >>> +    value is the modification time (mtime) of the ith object in the
> >>> +    corresponding pack by lexicographic (index) order. The mtimes
> >>> +    count standard epoch seconds.
> >>> +
> >>> +  - A trailer, containing a checksum of the corresponding packfile,
> >>> +    and a checksum of all of the above (each having length according
> >>> +    to the specified hash function).
> >>> +
> >>> +All 4-byte numbers are in network order.
> >>
> >> I.e. this is sufficient.
> >
> > Very good eyes.  One explicit mention among several others can
> > indeed be misleading the readers.
> >
> > When asked for "network order", all your search engines show are
> > entries about "network byte order", so let's use that longer form of
> > spelling.
>
> *Nod*, note that "network order" is on "master" already though,
> i.e. this section re-used a template introduced in 2f4ba2a867f
> (packfile: prepare for the existence of '*.rev' files, 2021-01-25) just
> above this hunk.
>
> Before that change the rest of the file used "network byte order"
> consistently.

Hmm. e0d1bcf825 (multi-pack-index: add format details, 2018-07-12)
(which predates 2f4ba2a867f by a few years) introduced the first use of
"network order" as opposed to "network byte order".

I think it's worth cleaning this up, but let's do it in two parts.
I'll send a rerolled version of tb/cruft-packs that moves the "All
4-byte numbers are in network order" to the top of that section,
switching "network order" for "network byte order", and dropping other
mentions of "network [byte] order" from that section.

Then, we can come back later and perhaps do something like the following
(but I don't want to do it now and tie up this series with semi-related
cleanups):

--- 8< ---

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index b520aa9c45..2591a410fd 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -276,6 +276,8 @@ Pack file entry: <+

 == pack-*.rev files have the format:

+All 4-byte numbers are in network byte order.
+
   - A 4-byte magic number '0x52494458' ('RIDX').

   - A 4-byte version identifier (= 1).
@@ -283,8 +285,8 @@ Pack file entry: <+
   - A 4-byte hash function identifier (= 1 for SHA-1, 2 for SHA-256).

   - A table of index positions (one per packed object, num_objects in
-    total, each a 4-byte unsigned integer in network order), sorted by
-    their corresponding offsets in the packfile.
+    total, each a 4-byte unsigned integer), sorted by their
+    corresponding offsets in the packfile.

   - A trailer, containing a:

@@ -292,8 +294,6 @@ Pack file entry: <+

     a checksum of all of the above.

-All 4-byte numbers are in network order.
-
 == pack-*.mtimes files have the format:

 All 4-byte numbers are in network byte order.
@@ -322,7 +322,7 @@ the body into "chunks" and provide a lookup table at the beginning of the
 body. The header includes certain length values, such as the number of packs,
 the number of base MIDX files, hash lengths and types.

-All 4-byte numbers are in network order.
+All 4-byte numbers are in network byte order.

 HEADER:

@@ -397,8 +397,8 @@ CHUNK DATA:

 	[Optional] Bitmap pack order (ID: {'R', 'I', 'D', 'X'})
 	    A list of MIDX positions (one per object in the MIDX, num_objects in
-	    total, each a 4-byte unsigned integer in network byte order), sorted
-	    according to their relative bitmap/pseudo-pack positions.
+	    total, each a 4-byte unsigned integer), sorted according to their
+	    relative bitmap/pseudo-pack positions.

 TRAILER:


--- >8 ---

Thanks,
Taylor
