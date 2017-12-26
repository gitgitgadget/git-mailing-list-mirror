Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 222261F404
	for <e@80x24.org>; Tue, 26 Dec 2017 22:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbdLZWOS (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 17:14:18 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37044 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdLZWOR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 17:14:17 -0500
Received: by mail-wm0-f46.google.com with SMTP id f140so36649664wmd.2
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 14:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uIKHrausqIYzcrr7vMuZVx6TAMM6cnK7zr9gXQZuRnw=;
        b=V1Rxg53fr2QOvsdREbQYhW0uSkqGEI0kpooPsRS83rVrWz/KHovog4ifOOTh5OorPr
         N0PdaMHC6/8dQM2NYZxUT9R51zunT3bVO4rHGtSbB7cAl84YcNdWsxTTlSWA+LxIY5lS
         OC4ya0uOCXAzAsQNz6EugU+EatYdUD7YWDrxgxMffZloh/eRkYcqqTOn9hO8m3BZiOfk
         XrdN7Xto1J7daZ4eQEoBQoFDCYJTwujyGNMM6VAgokKzk8JqaAkNdxg4PHjFjw6Nfxv9
         jokKhaYvny+fa2a1KUsDY+KScRzZibqHBZY9ylkcEYn10nlhDKQxIJyoppiEgNXBk8d6
         XGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uIKHrausqIYzcrr7vMuZVx6TAMM6cnK7zr9gXQZuRnw=;
        b=T60CSgG8ZmDV9mJKpaaL2DTigEY35vzGib35Z1zV6c8128wa+quGCulY3BAPJj8o/P
         TgLLjFT+yIEePl5li1nwn4hCK93pJz8s/NS54SpdXEBJhB8QdDZsaO8ylOr/83MwMq5U
         DizdBci8WSdjcvDjKFix2kJQUF6Pfq+CQ0BEzx2gHbrEOLy7s+DnxQ0PtgQN3+4YZWGT
         FRKyNGZ/3Zj9hW/5Z09ESIdyyzEz9YIyR1K1NPMLvZjS3gy2QuR30ntSDZwGdiN7l/8q
         zodlIQ1Uq0RriJiyBED5FC5lDbNjQYLAgdXIaPk7X2g+nXpYXgDW3nxDhgElupKNobsV
         UgHA==
X-Gm-Message-State: AKGB3mJB5XUzyGJTK0BhmptephpEQqtpwiH6043LdHV/dyH7bz3AuWUw
        Fa2vTtZKwGsNLZp9LEfrLke1ipW+
X-Google-Smtp-Source: ACJfBosU7hZ8/l3FHS+gsY9waq2vSatZTNpapAECBRI1wuu0/6zAGkQDnkJJYvwBwQkhe2XtnEjUtg==
X-Received: by 10.28.110.26 with SMTP id j26mr21288032wmc.46.1514326455566;
        Tue, 26 Dec 2017 14:14:15 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id 31sm16930135wrw.8.2017.12.26.14.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Dec 2017 14:14:14 -0800 (PST)
Subject: Re: [PATCH v2 7/7] wt-status.c: avoid double renames in
 short/porcelain format
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     alexmv@dropbox.com, git@vger.kernel.org
References: <20171225103718.24443-1-pclouds@gmail.com>
 <20171226091012.24315-1-pclouds@gmail.com>
 <20171226091012.24315-8-pclouds@gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <cd764b8d-8a85-964f-eaf2-3e6fb784a2ff@gmail.com>
Date:   Tue, 26 Dec 2017 23:14:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171226091012.24315-8-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On 26/12/2017 10:10, Nguyễn Thái Ngọc Duy wrote:
> 
> The presence of worktree rename leads to an interesting situation,
> what if the same index entry is renamed twice, compared to HEAD and to
> worktree? We can have that with this setup
> 
>     echo first > first && git add first && git commit -m first
>     git mv first second  # rename reported in "diff --cached"
>     mv second third      # rename reported in "diff-files"
> 
> For the long format this is fine because we print two "->" rename
> lines, one in the "updated" section, one in "changed" one.
> 
> For other output formats, it gets tricky because they combine both
> diffs in one line but can only display one rename per line. The result
> "XY" column of short format, for example, would be "RR" in that case.
> 
> This case either needs some extension in short/porcelain format
> to show something crazy like
> 
>     RR first -> second -> third
> 
> or we could show renames as two lines instead of one, for example
> something like this for short form:
> 
>     R  first -> second
>      R second -> third
> 
> But for now it's safer and simpler to just break the "second -> third"
> rename pair and show
> 
>     RD first -> second
>      A third
> 
> like we have been showing until now.
> 

I lost you a bit here, partially because of what seems to be an 
incomplete setup script, partially because of this last sentence, as 
Git v2.15.1 doesn`t seem to be showing this, so not sure about "like 
we have been showing until now" part...?

Here, with your setup script, with plain Git v2.15.1, we have:

    $ git status
    On branch master
    Changes to be committed:
      (use "git reset HEAD <file>..." to unstage)
    
            renamed:    first -> second
    
    Changes not staged for commit:
      (use "git add/rm <file>..." to update what will be committed)
      (use "git checkout -- <file>..." to discard changes in working directory)
    
            deleted:    second
    
    Untracked files:
      (use "git add <file>..." to include in what will be committed)
    
            third

Might be an additional `git add -N -- third` is needed here, to show 
what (I assume) you wanted...? If so:

    $ git add -N third
(1) $ git status
    On branch master
    Changes to be committed:
      (use "git reset HEAD <file>..." to unstage)
    
            renamed:    first -> second
    
    Changes not staged for commit:
      (use "git add <file>..." to update what will be committed)
      (use "git checkout -- <file>..." to discard changes in working directory)
    
            renamed:    second -> second
                                  ^^^^^^
Now we can see two renames I believe you were talking about...? (Note 
original bug showing above, which started this thread.) Now, still 
using v2.15.1, let`s see porcelain statuses:

(2) $ git status --porcelain
    RR first -> second
    
(3) $ git status --porcelain=v2
    2 RR N... 100644 100644 000000 9c59e24b8393179a5d712de4f990178df5734d99 9c59e24b8393179a5d712de4f990178df5734d99 R100 second        first

Here, they both report renames in _both_ index and working tree (RR), 
but they show "index" renamed path only ("second", in comparison to 
original value in HEAD, "first").

I`m inclined to say this doesn`t align with what `git status` shows, 
disrespecting `add -N` (or respecting it only partially, through that 
second R, but not showing the actual working tree rename, "third").

Without influencing porcelain format, and to fully respect `add -N`, 
I believe showing two renames (index and working tree) as two lines 
would be the correct approach - and that`s what default `git status` 
does, too.

Now, let`s examine this patch series v2 outputs:

(1) $ git status
    On branch master
    Changes to be committed:
      (use "git reset HEAD <file>..." to unstage)
    
    	renamed:    first -> second
    
    Changes not staged for commit:
      (use "git add <file>..." to update what will be committed)
      (use "git checkout -- <file>..." to discard changes in working directory)
    
    	renamed:    second -> third
    
(2) $ git status --porcelain
    RD first -> second
     A third

(3) $ git status --porcelain=v2
    2 RD N... 100644 100644 000000 9c59e24b8393179a5d712de4f990178df5734d99 9c59e24b8393179a5d712de4f990178df5734d99 R100 second	first
    1 .A N... 000000 000000 100644 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 third

Here, porcelain statuses make situation a bit better, as now at least 
`add -N` is respected, showing new "tracked" path appearing in the 
working tree.

But, we now lost any idea about the rename that happened there as 
well - which Git v2.15.1 porcelain was partially showing (through 
RR), and which `git status` still reports correctly - and which we 
still differ from.
 
I don`t think this looks like what we have been showing until now 
(unless I misunderstood which exact "now" are we talking about), so I 
don`t see that as a valid argument to support this case.

So, while we still changed output of what we were showing so far to 
two-line output, it seems there`s no real gain, as it looks like we 
replaced one partial output (recognize rename, omit path) for the 
other (recognize path, omit rename).

Finally, let`s see your initial patch v1[1], with my exercise 
patch[2] on top:

(1) $ git status
    On branch master
    Changes to be committed:
      (use "git reset HEAD <file>..." to unstage)
    
    	renamed:    first -> second
    
    Changes not staged for commit:
      (use "git add <file>..." to update what will be committed)
      (use "git checkout -- <file>..." to discard changes in working directory)
    
    	renamed:    second -> third

(2) $ git status --porcelain
    R  first -> second
     R second -> third

(3) $ git status --porcelain=v2
    2 R. N... 100644 100644 100644 9c59e24b8393179a5d712de4f990178df5734d99 9c59e24b8393179a5d712de4f990178df5734d99 R100 second	first
    2 .R N... 100644 100644 100644 9c59e24b8393179a5d712de4f990178df5734d99 9c59e24b8393179a5d712de4f990178df5734d99 R100 third	second

Here, both "--porcelain" outputs (2) and (3) seem to much better 
replicate what default `git status` is showing, too - namely separate 
renames in comparison to HEAD for both "index" (2) and "working tree" (3).

And if you don`t like two lines here in comparison to one (incomplete) 
line from Git v2.15.1, I would remark that patch series v2 prints two 
lines as well (so different from v2.15.1 in a same way), but with 
what looks like inferior output in comparison to v1 shown above, where 
both renames are correctly recognized and reported - and finally 
fully compatible with default `git status` output, too.

And if we really think about it, what v1 shows is what actually 
happened - and more important, it`s possible to recreate hypothetical 
"first -> second -> third" change from there. With v2 output, that is 
impossible, that information is lost as second line doesn`t relate to 
the first one in any way.

Now, unless I`m totally missing something here, the only thing left 
is that you mentioned v2 approach being "safer and simpler" than v1, 
something I`m not really competent to comment on, but just wanted to 
provide a second opinion, maybe helping to change your mind in favor 
of v1 outputs, which seem to be _the_ correct ones...? :)

If not that much more complicated/unsafe, of course.

Thanks, Buga

[1] https://public-inbox.org/git/20171226091012.24315-8-pclouds@gmail.com/T/#mf60e88fd351f7ff6a076279794c8343a79835f67
[2] https://public-inbox.org/git/20171226091012.24315-8-pclouds@gmail.com/T/#m095c33d69994c6ecb4f1adbf80dd48eab66750d8
