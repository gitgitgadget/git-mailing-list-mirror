Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7A571F404
	for <e@80x24.org>; Wed, 14 Mar 2018 16:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbeCNQTB (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 12:19:01 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:53853 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbeCNQTA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 12:19:00 -0400
Received: by mail-wm0-f47.google.com with SMTP id e194so5157196wmd.3
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 09:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8QFEn6PGZBnWdayP5t7awB9F6KFKTQelCUJ69vI35nE=;
        b=ctCNwSJdn/j88CuXHusWFw5vbWbhApwmIV2/3atP4fZ5jEmBrPdSTdZJskMTQDHHiG
         Y/9e2Anw3rgvdtM6WgVkolIQSbjZv8SPxFmQcDKRJtZ3OHGkHa4aj0Dek2kL2yg+28Gc
         DmBkzjsupdc1Ej5KqBFm5MkXL13oZm3lw6n8MMnxnVQOHW006XdHUyOZRLYVf5+s4r0m
         DhngB+VcUnydxt50ZPLADoJuiNNtVyR8VgquLYBGwkdWjvovm+O/NT9G3zHcaRe07mKx
         gwxSxQ17LXcj/iJAPzT+itq3K2QEWg7DrVRIgLtSi+j93A4ndAzqa/HN9VzMqgldMcoY
         QM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8QFEn6PGZBnWdayP5t7awB9F6KFKTQelCUJ69vI35nE=;
        b=CGijMQPTttghFmkYfJECVWY9RBkqJukD7DctGBGBEPdi0OpDGRQLMR2+iZO5KXZmkp
         UgfZiYxfGVufWYl2cFjP5LGxyTryKOj1o0L89mqUOhuhUmYnhgNVK9iQtg60u5E8m9QH
         tUscozyGPDSpO1lNArfUnr0eWCCWYYyNK3ZKF4U3b1+a2SYhAgLKGec/Zp4eKT4jKmdf
         Ry/mfpWNStsLgCdtWLfD3qssfcAKjztlJkiirFidoraMfnGDwhZDwr6PgUsmaoEdSzdG
         BXLRul7rkKwAB2yosCCxonZ6Tb0AMPDQ4rgHjORi4DHFW14t8EL0YviMTY4weXFrTn8E
         6/5g==
X-Gm-Message-State: AElRT7GhQ+iEyFG/nTgaA6AS9S8Dlt8nuOUDFw/mVkmNdM9o7d96jAf7
        YPAkEPyNAJlAcAHdvSVaINU=
X-Google-Smtp-Source: AG47ELsJWvegtREuEfWfwxBDUGqeAb7vumXnRUmJCGWmm2tnXOTF8OqYmUpnJG7qqJ4638XxwLvUuA==
X-Received: by 10.28.124.20 with SMTP id x20mr2054129wmc.62.1521044339024;
        Wed, 14 Mar 2018 09:18:59 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b7sm1359077wmg.41.2018.03.14.09.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Mar 2018 09:18:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH/RFC v3 08/12] pack-objects: refer to delta objects by index instead of pointer
References: <20180303024706.31465-1-pclouds@gmail.com>
        <20180308114232.10508-1-pclouds@gmail.com>
        <20180308114232.10508-9-pclouds@gmail.com>
Date:   Wed, 14 Mar 2018 09:18:57 -0700
In-Reply-To: <20180308114232.10508-9-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 8 Mar 2018 18:42:28 +0700")
Message-ID: <xmqqy3iuzl3i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Notice that packing_data::nr_objects is uint32_t, we could only handle
> maximum 4G objects and can address all of them with an uint32_t. If we
> use a pointer here, we waste 4 bytes on 64 bit architecture.

Some things are left unsaid or left unclear and make readers stutter
a bit while reading this paragraph.  We can address them with
uint32_t only because we happen to have a linear array of all
objects involved already, i.e. the pack->objects[] array.  The
readers are forced to rephrase the above in their mind

	... and each of them can be identified with an uint32_t.
	Because we have all of these objects in pack->objects[], we
	can replace the "delta" field in each object entry that
	points at its delta base object with uint32_t index into
	this array to save memory (on 64-bit arch, 8-byte pointer
	gets shrunk to 4-byte uint).

or something like that before understanding why this is a valid
memory footprint optimization.

