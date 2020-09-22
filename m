Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82F7C2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 08:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D80D23A1E
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 08:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HT81UnEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgIVIdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 04:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgIVIdV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 04:33:21 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3ECC061755;
        Tue, 22 Sep 2020 01:24:54 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id z23so21520619ejr.13;
        Tue, 22 Sep 2020 01:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=euHLybc7rW/4XsdAvIoyvU/CkIl8dD4tTWO/e4S01eI=;
        b=HT81UnEC6Hoq1ZvZ7PQvretGUxhZmk/+dosnsd2UG7h+5bIsZ0bWoFT9TYN9jQenBe
         9tD3X6YSHND2DbXWP5m0qDCbWKtl8G/aWcY6JBelwFr2VLTotEdrUMeFI9cF4MpH5Isu
         IBFinDf1lc09B3jfbaJ1ziTJvGsve4uYjjw3OquLc/hhJGMrdHAseQH9ZffqHq5R4IFR
         XYpViCRFfXYGAu7/hJ8f1Lf+XHFOE7c/jXfZP2aWsh9O6vSx4nc15UovmEIl6cIscYi6
         PVOc0Ojo84C8ldNYOHJ2fWt5KTcxh5YpOsBxDBaoip2vG25Yw5BF1zFYnn2TMljlE52X
         C77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=euHLybc7rW/4XsdAvIoyvU/CkIl8dD4tTWO/e4S01eI=;
        b=UulpX21Zs8kHG6NJT1NzgHEuUlhjYmNJhrV1lUScFR7J+7K5rJyywJ5feKPRt3ofAy
         e8nxnn8yPispu04UavCGylkAAANOMjG62oU2NAhr/g/fuH5R/PvyCpJ2LUOPEcAi3aa5
         gtfvchrWw7YtFxy0En0Fstb//l1b0D2xyFfhVpBS/dgfCHkEGH4aRgHkCrVpJN/0K1R8
         m4WUbqEkcASj8jwNhgI/T8QZ/+qae5M8EcRtxlWPVA/0ycRxqwljoHjvsOl7yyvKu3kv
         fxnQ8/ZW/7T4PKDBSAZi+20G3iy1go7PzxtKQEjqV/HWlAczmeeXFf1P0afS57zxIEVr
         Om4w==
X-Gm-Message-State: AOAM531HvAeDQN74g84UIaJEJllQRqLkqF2bvBi/LEBK8v+6Q7fLX2kd
        uxbsaKeKPbDdD93iOc3AJg6i75Mkcqj2Ew==
X-Google-Smtp-Source: ABdhPJxt0TEg4+8/K6Xstz1eCqn+Y2D3uk1VmkTkThmeIOekJhpwABIMvzmE325n7cv4qu01kL6N3w==
X-Received: by 2002:a17:906:4d97:: with SMTP id s23mr3757441eju.157.1600763092675;
        Tue, 22 Sep 2020 01:24:52 -0700 (PDT)
Received: from evledraar (dhcp-077-248-252-018.chello.nl. [77.248.252.18])
        by smtp.gmail.com with ESMTPSA id j15sm10728520ejs.5.2020.09.22.01.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 01:24:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, tytso@mit.edu,
        Junio C Hamano <gitster@pobox.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] sha1-file: fsync() loose dir entry when core.fsyncObjectFiles
References: <87sgbghdbp.fsf@evledraar.gmail.com> <20200917112830.26606-2-avarab@gmail.com> <64358b70-4fff-5dc8-6e63-2fc916bea6af@kdbg.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <64358b70-4fff-5dc8-6e63-2fc916bea6af@kdbg.org>
Date:   Tue, 22 Sep 2020 10:24:51 +0200
Message-ID: <87a6xii5gs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 17 2020, Johannes Sixt wrote:

> Am 17.09.20 um 13:28 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> Change the behavior of core.fsyncObjectFiles to also sync the
>> directory entry. I don't have a case where this broke, just going by
>> paranoia and the fsync(2) manual page's guarantees about its behavior.
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  sha1-file.c | 19 ++++++++++++++-----
>>  1 file changed, 14 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/sha1-file.c b/sha1-file.c
>> index dd65bd5c68..d286346921 100644
>> --- a/sha1-file.c
>> +++ b/sha1-file.c
>> @@ -1784,10 +1784,14 @@ int hash_object_file(const struct git_hash_algo =
*algo, const void *buf,
>>  }
>>=20=20
>>  /* Finalize a file on disk, and close it. */
>> -static void close_loose_object(int fd)
>> +static void close_loose_object(int fd, const struct strbuf *dirname)
>>  {
>> -	if (fsync_object_files)
>> +	int dirfd;
>> +	if (fsync_object_files) {
>>  		fsync_or_die(fd, "loose object file");
>> +		dirfd =3D xopen(dirname->buf, O_RDONLY);
>> +		fsync_or_die(dirfd, "loose object directory");
>
> Did you have the opportunity to verify that this works on Windows?
> Opening a directory with open(2), I mean: It's disallowed according to
> the docs:
> https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/open-wop=
en?view=3Dvs-2019#return-value

I did not, just did a quick hack for an RFC discussion (didn't even
close() that fd), but if I pursue this I'll do it properly.

Doing some research on it now reveals that we should probably have some
Windows-specific code here, e.g. browsing GNUlib's source code reveals
that it uses FlushFileBuffers(), and that code itself is taken from
sqlite. SQLite also has special-case code for some Unix warts,
e.g. OSX's and AIX's special fsync behaviors in its src/os_unix.c

>> +	}
>>  	if (close(fd) !=3D 0)
>>  		die_errno(_("error when closing loose object file"));
>>  }
>
> -- Hannes

