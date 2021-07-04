Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE3CC07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 06:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8910613BA
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 06:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhGDGdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 02:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhGDGdj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 02:33:39 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19A8C061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 23:31:03 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id s14so13587583pfg.0
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 23:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8jEpD0HCy+RqniuqQNQI3uLYUhPHsAuQveUkQN8dLT4=;
        b=jQhDXa5w0rOsYa39ms7x4Nfw2XXXFkYVqK6vvUfAsXT9lZb4X1svJgRb9sEnYo5Q92
         KnJy7L2nunc9Wq//4S/W6XsxK+4AH04V77xOOyQrcdlxnGLsqBWvkSKkJUudO8nb24yB
         IJl8JHlz2a5jq7q8/oqbbi9wcnj3zdJMSkVrLbdSuGyCfmouttlLmZxBnnxtOFbirp1+
         nkYwIIQm8BIEtjfum+3Pq4LCcsN47/1bJB2jfvvg6OYWqdwWls3vLn6Pk+Y2+CLvKB6O
         /ZBoolB50GGelPTdYksoZgOjW5AdLAuu7s93M6Uy6cA3buP9FWoFmwuvCRqyjfDBMuRZ
         zyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8jEpD0HCy+RqniuqQNQI3uLYUhPHsAuQveUkQN8dLT4=;
        b=B++zBIbzq8/y7yEKq5/IbBKuLFm8/eX6UAox6jri65CUArncWd2mAo6AUZJtfyMxUC
         5KPC7mlk0L8EOl5kjjTYJTrTH8HnzfNtUy18iewOqoMJk1UP8Ex/HJrKq0L1UFn9HzD6
         tOQNuUacpNd9wihSCbQ77CaT8FLPidHqzN69c8tsG3MLSJ4uCErwRKz2A8NvWI96uB+/
         4oFzGf+xqZD2ogw2V8xeIxm8VAlcgRDBo3OmqlfWFWlj5BeW2z0fd6n7Ebk+L/Poduwu
         pCGfDKUaJbDzJjmQaJ2tBXBwvB7i6C48MF16I4clLAwnoWXUDS/lPmNG6eAcm2Knrw0/
         TDLQ==
X-Gm-Message-State: AOAM532OtOmyt5Fjeapj0zismtN7iIUyABaPDLEUhIih/fyAc8lJSsfG
        RrN00/iMK0OHy3UcJDQ5Ubg=
X-Google-Smtp-Source: ABdhPJzj+egYo+pPZyB6ji+fyPwCzmPTIV48c7CXgPz5t4LlHdyO0gGyZcR4mDcmK99u+vreZjyT0Q==
X-Received: by 2002:a63:1709:: with SMTP id x9mr8875922pgl.245.1625380263162;
        Sat, 03 Jul 2021 23:31:03 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.56])
        by smtp.gmail.com with ESMTPSA id q29sm8710716pfl.209.2021.07.03.23.31.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Jul 2021 23:31:02 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: Logical bug during MERGE or REBASE
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <3f09d890-e9b7-0e54-0d03-2ed7609cb448@gmail.com>
Date:   Sun, 4 Jul 2021 12:00:59 +0530
Cc:     skottkuk@wp.pl, Git List <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <928F285A-4F5B-48BA-A817-EE809FD16E16@gmail.com>
References: <1932019063.20210702192555@wp.pl>
 <3CD890FA-7A99-4DDC-9691-80D1ED6BD51B@gmail.com>
 <3f09d890-e9b7-0e54-0d03-2ed7609cb448@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04-Jul-2021, at 11:42, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> 
> On 03/07/21 14.57, Atharva Raykar wrote:
>> Let's look at the diffs (I have annotated this with arrows):
>> $ # common ancestor, ie, the first commit
>> $ initial=$(git merge-base master dev)
>> $ git diff $initial master
>> diff --git a/program.cs b/program.cs
>> index 8bc1a4d..93f872f 100644
>> --- a/program.cs
>> +++ b/program.cs
>> @@ -1,4 +1,6 @@
>>  {
>>   Console.Writeline("1");
>> + Console.Writeline("2");
>> + Console.Readline();
>>   Console.Readline();     <--- X
>>  }
>> $ git diff $initial dev
>> diff --git a/program.cs b/program.cs
>> index 8bc1a4d..eb91c97 100644
>> --- a/program.cs
>> +++ b/program.cs
>> @@ -1,4 +1,6 @@
>>  {
>>   Console.Writeline("1");
>>   Console.Readline();     <--- X
>> + Console.Readline();
>> + Console.Readline();
>>  }
>> As you can tell, on the master branch, Git sees the changes as
>> "lines were added above the line labeled X",
>> and on the dev branch, Git sees the changes as
>> "lines were added below the line labeled X".
> 
> What's the purpose of "X-labeled line" above?

It was just something I manually annotated on the output to keep a track
of which 'Console.Readline()' line I was referring to.

It is less tedious for to say "line labeled X" than, "the second line in
the code block in the initial commit".

If it has made my explanation a little unclear, I don't mind having a
second attempt at it :)

