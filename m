Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED0E2208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 21:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbeHGX0A (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 19:26:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54472 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeHGX0A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 19:26:00 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so495467wmb.4
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 14:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4iO3ENrVK7U5bvy0cfrIqhKTsXX7Kfqs8meGbFNP7F4=;
        b=O+YXn5kNtlgOfazrnfpamj3h+bGnyIk/m5IWy3mNA+PELlFJUWNj0RlGUDyUJKgbem
         FZbfxciwhr1rqbkbj9kyzf4Ks3Pp2Tk53j8Aa9CkgBAJg3qvs9EnMvnrUmW+Yejw8+p0
         xdm7gfhfYJ0z8+8wXb3UlpZ7y0BAZqnJhShevZC0/Ee4h04zWdNrRJmM8GXOYJsJyA/y
         U6FYfdLXMLWcdMIfz36+/u819O2pDBXwjrZx82rh4jbJFt5bRq+B5UhviNJdBrfDryaN
         q0MU8px2ZW5+fAeSHmIuK+UYuXeM804lOXlSKuxEPDnciXMcgDBtwTnLKuTfxJ1QMexQ
         nwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4iO3ENrVK7U5bvy0cfrIqhKTsXX7Kfqs8meGbFNP7F4=;
        b=Qg8M0Jao1L6IDVTLP+RE9RwmxFGL/iUN1aKbw7TPg1ZdaPIOwETkiR1+Dg2Qjlzzj/
         8PqbeHO9VjrjiPK4GedYy6oiQG0uCpItsCo2e6c1CaOKlRDKR3Tdg6o7WLBncFi2LkS1
         75L5Xumn+SIhGgUudsDCZP0U3QToK+oN38fE5ssdubkvc2+cRFei4IE9b7KqHx+EwnYM
         7dOnHG5mn8KkB/yoyWRq/Q6EKt7J8jZYGDpzRFlGIA9zosqECG5xtO9oWmZ46NRU/yvi
         bLir4Ne+WqkNeclRfu0q7H39IY+v2Iy/2rmYsjyexGzal2obN1JuRTLTBVq2s2euItAi
         VrBQ==
X-Gm-Message-State: AOUpUlFTQ9YZGxu7lQqgHYtbLfbJ70I97awtrCQGdWMeFa0SRqFQrh06
        IQLXLQuXjtZJVcy8qWex3Ag=
X-Google-Smtp-Source: AA+uWPxQQ5tDydBHBZ4JcrZXx3cHYaMniZ9BPioYC16YTpSX4on1J+wlsO6mVJr2MjmA4OpkEjj8tg==
X-Received: by 2002:a1c:8b81:: with SMTP id n123-v6mr42006wmd.142.1533676181819;
        Tue, 07 Aug 2018 14:09:41 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 139-v6sm5148222wmp.4.2018.08.07.14.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 14:09:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Akinori MUSHA <knu@idaemons.org>
Subject: Re: [PATCH v2 0/4] fix "rebase -i --root" corrupting root commit
References: <20180731073331.40007-1-sunshine@sunshineco.com>
        <CAE1pOi3oeBEyD8skwfLAd7JviGYOUZaZwj3u9pznM4eLAR7fDQ@mail.gmail.com>
        <CAPig+cRe1R1YWpLaXVtTmwhaJiz2dONU83qtn_+XhaRevjn2fQ@mail.gmail.com>
        <CAE1pOi3+FW8itk4AHhG+r02TGyGTeoZpq7S6HKXkQtOVqigWGQ@mail.gmail.com>
        <CAPig+cT0ATgRMY-mhttViaburFW37G352BX=mj-Cnr2_wZruaQ@mail.gmail.com>
Date:   Tue, 07 Aug 2018 14:09:40 -0700
In-Reply-To: <CAPig+cT0ATgRMY-mhttViaburFW37G352BX=mj-Cnr2_wZruaQ@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 6 Aug 2018 23:31:41 -0400")
Message-ID: <xmqqr2j9khnv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Aug 6, 2018 at 9:20 PM Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:
>> But your suggestion did make me think about what behaviour I would
>> like to see, exactly. I like that Git removes commits that no longer
>> serve any purpose (because I've included their changes in earlier
>> commits). So I would not want to keep commits that become empty during
>> the rebase. What I would like to see is that commits that _start out_
>> as empty, are retained. Would such behaviour make sense? Or would that
>> be considered surprising behaviour?
>
> I, personally, have no opinion since I don't use empty commits.
> Perhaps someone more experienced and more long-sighted will chime in.

0661e49a ("git-rebase.txt: document behavioral differences between
modes", 2018-06-27) added the following.  In short, "rebase -i"
should already behave that way.

+ * empty commits:
+
+    am-based rebase will drop any "empty" commits, whether the
+    commit started empty (had no changes relative to its parent to
+    start with) or ended empty (all changes were already applied
+    upstream in other commits).
+
+    merge-based rebase does the same.
+
+    interactive-based rebase will by default drop commits that
+    started empty and halt if it hits a commit that ended up empty.
+    The `--keep-empty` option exists for interactive rebases to allow
+    it to keep commits that started empty.
