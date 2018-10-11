Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFFDA1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 22:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbeJLFcP (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 01:32:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32831 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeJLFcP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 01:32:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id l14-v6so722582edq.0
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 15:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=siP5rOIHTFg6fW3U0JxEdfgLatSOWUrx6uplGRfNdA4=;
        b=rn3ZwUFO8GSkyjJCDDyYyDp6f7+Ye8QBi1fWu6oqKJoPhkcctfqyU6yTlJCjqod1vZ
         SymlO9WEVMdR7HnMoIW8CYJ1So52JOzHSApBtnXz/LTi8qMQt5b1p+HL0mxC9vxQDwsc
         t38JsKlQ6L9DCTkfHQAvxlzTAOJOpV9oTADgOmJnoYz7qOA0Gx1QVg0bGAj7OaCZNsJA
         MRLzrUUbfcV9kl1l+Mi4dDVaWMr+qHB68YI1ruCpTeknpwaZfm4CHL1XqAxvxbHMUebI
         dDtLnTxVbgiBM+2INvimn+kNkgoEFrNhk3Cr52dBiXNh8W2YwMD6YtwTkvwhFf4Lc6cz
         mxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=siP5rOIHTFg6fW3U0JxEdfgLatSOWUrx6uplGRfNdA4=;
        b=rSiEUG4OF06pQzOx6RmA+Ox/IZhSBk3FiIycanxSFuCcdh6MbwpTYZ6rvgwjzHkwUr
         KLx75p5kYGeWDJVsWBjQf0x3g2qVMfA1vp+3Px0rP8uIVL1WkfLv58rGmTed21Hqon0B
         74iOC6koBBhShwc00GvGQqbQIBsxMrPeSiTEXwJ5Qq0VRdeCIuKVj9sRutShB7nbIed7
         NPxfPadDv43GUuKuIySoQHn/hBdfmqSHIrwXbM7oOM5rPEvBxwDzpaxC5ZE1YRJEIHjp
         UF2ZN6ksGw9JikyCaJaL7Lg1RTTD3ONs9StZ+y2J1MKPQSEnpxfogmbc6ZT+fUDgKsba
         +I5A==
X-Gm-Message-State: ABuFfoiz4HJK2PQQqHLmMbWySwZOwvMs7/D09BcGyMAGCydvDfHZ2y9w
        NSmsuAH+w1stf1jrIaQi0PWElfgGc7amqo6XJXleQw==
X-Google-Smtp-Source: ACcGV60dO0/n+FkuDjXgw8K8MLl5HtJTOjYTCC2jJNbQIyozOaVHogW5QJK+uo8N2BkpgdGuIN3Bx9NoomHikC3rVAo=
X-Received: by 2002:aa7:d709:: with SMTP id t9-v6mr5359745edq.231.1539295380262;
 Thu, 11 Oct 2018 15:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20181011211754.31369-5-sbeller@google.com> <20181011220147.183266-1-jonathantanmy@google.com>
In-Reply-To: <20181011220147.183266-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 11 Oct 2018 15:02:49 -0700
Message-ID: <CAGZ79ka7Kv51SpqiGdZTr4fA7iAJ1aw-h41NuQPqLutBGaTSfw@mail.gmail.com>
Subject: Re: [PATCH 04/19] object-store: prepare read_object_file to deal with
 arbitrary repositories
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 3:01 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > Introduce repo_read_object_file which takes the repository argument, and
> > hide the original read_object_file as a macro behind
> > NO_THE_REPOSITORY_COMPATIBILITY_MACROS, which we planned for in
> > e675765235 (diff.c: remove implicit dependency on the_index, 2018-09-21)
>
> That commit didn't seem to plan for anything - it just seems to add a
> new function with the name "repo_" preprended and define a macro if
> NO_THE_REPOSITORY_COMPATIBILITY_MACROS is not set, just like this patch.
> Maybe s/which we planned for in/just like in/.

I was reading too much into

    The plan is these macros will always be defined for all library files
    and the macros are only accessible in builtin/

of that commit message.
