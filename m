Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5697920248
	for <e@80x24.org>; Thu, 14 Mar 2019 17:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfCNRa4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 13:30:56 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:42536 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfCNRaz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 13:30:55 -0400
Received: by mail-qk1-f178.google.com with SMTP id b74so3823982qkg.9
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 10:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PX4eqx6fSZ37CI9GAcwIXOsidviO7uhaT9G/aLDnnwU=;
        b=hoxGXvWo4a+JKm5e9Hm+Edxt7FQcEyslZCzw5HCplT1SnjBLcRTwaIuhAs/JOAWS5/
         sfawoTCXdjYidqlWhdF2vVFqTsU1jK30jFrUlf5KEq1rpAyPPxpR4vqwlOYqdU4JvDfP
         UZybkJSFK7tDLne0RBX+W9MQlovWB3jHS75vQbn+BnrTTIn15OIebu/y97YWMWPsGS2W
         oEbP2q25NOyE0bIEy7l8VL9yfzaj61JgOwJ9K7WU7eEkcEaGlBJKnE2opfpw91wBoQoA
         XUIwoZQ0Fws20Zoggd4jbq7T8Fk7KH+HO9aL9rKNheB/bcAlz+GxVgn+ejH3AmOKI6KE
         U6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PX4eqx6fSZ37CI9GAcwIXOsidviO7uhaT9G/aLDnnwU=;
        b=SaaQoskwXlfo8lJmNPaDb2Q+EAQ66S5dg6DXtoACBx+mit07O8dxrw2jKTxi+cS6rW
         MLU0NC9gy3EVjZ54kdLG93qxNvnJLV8nF5WD+6vGjzyyhqVFYTsXnW8PY7e9p7CjYG7G
         GvXNYXa4Ri4mYUCneUUMiEq6rq2irGsxkcRTlq6e4I9qbJYFeCcCL+yPdJ0XaPJPzb2j
         R8IqawHxPDDM7s/Pqjak5UDUS3KmN7+VvzuFXMj0QdD+xETe6hGDXp4AbVJW+NS417/6
         suNYmQ7++JdCjrHtZ1eHyb1T6ZHPT/elRixeYc4dmGlRJImU5SJynIKF9OyLwj9Uv+tG
         gZXg==
X-Gm-Message-State: APjAAAUBXNc/+2/f6rOG3URww3nxSpwTI0nx9BZbzfLKHiuOVXzrsCwd
        SrrYag+PZt+OJHiPyEcwhXFl9B7VxqKEhWiMAwzETfGHJN0=
X-Google-Smtp-Source: APXvYqwS1WkrMTCkoWrCDjKgBkrS42ps01u5lgzvxHRPPc8isNvxk7JVRKavtt9wZSteG2vp1zxJP5tyaRJ8CrX8PJI=
X-Received: by 2002:a37:4bd2:: with SMTP id y201mr37540280qka.346.1552584654649;
 Thu, 14 Mar 2019 10:30:54 -0700 (PDT)
MIME-Version: 1.0
From:   Jason Karns <jason.karns@gmail.com>
Date:   Thu, 14 Mar 2019 13:30:43 -0400
Message-ID: <CAKNmmv26G05GO7hG9bNvMsjpuUMHZRA+2f94TuG2wDNUwNhHkw@mail.gmail.com>
Subject: [BUG] Suspected with double asterisk in conditional include pattern
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I believe I've encountered a bug regarding the use of double asterisk
( /**/ ) within includeIf patterns.

git-config man pages state that

    **/ and /**, that can match multiple path components

They then refer to the gitignore man pages which further define
supported wildcard patterns:

    A slash followed by two consecutive asterisks then a slash matches
zero or more directories.
    For example, "a/**/b" matches "a/b", "a/x/b", "a/x/y/b" and so on.

My understanding of these docs are that the pattern
`/usr/local/**/Homebrew/` ought to match
both`/usr/local/cache/Homebrew/foo` and `/usr/local/Homebrew/foo`.

However, given the following conditional include rule:

    [includeIf "gitdir:/usr/local/**/Homebrew/"]

The external config file is successfully included while in repo
`/usr/local/cache/Homebrew/foo` but NOT `/usr/local/Homebrew/foo`.

If I change the pattern to `**/Homebrew/**`, then the pattern matches
both desired repos. So it would seem that the `/**/` does not match 0
directories when the pattern begins with a slash.

Thank you,
Jason
