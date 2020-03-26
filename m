Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F239C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 00:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7922073E
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 00:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgT9BGj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgCZAul (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 20:50:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43511 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbgCZAul (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 20:50:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id v23so1480588ply.10
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 17:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iV6ymD1kQQONQHm4JdBry95DQKFCs+rEV8XV/WUjq8s=;
        b=CgT9BGj/SX+N9el8boeJPlDd1v0cDIoXz9DPW6rKZRlntPuWf4XfJU+/BwYVKOquw3
         sWS1eaLsch5TQH70vO3kNJYXdKksPw5ILklK5+SvkjBrKi0v8HRIegLFTHyXCoNcWFsL
         ldmxjuzDhcH22Cc67wuacktPLZmPg8Ej3LZL19jTQmXxfO+E8zmsn3n/Z7iAeGAwTkHq
         8AvF7+WwTy0dNFYFMS0p7Nb3LdgtpzBif4N2zewUvAEfpY9gvIqgZzZU3iUvLPMnpTpP
         UGexkcl/wdieJ0I47/REfvE0AY9b+wJWb6KO1U6Jjv2VP4XnSvubWae4wdH5Sw3HO7IE
         9Esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iV6ymD1kQQONQHm4JdBry95DQKFCs+rEV8XV/WUjq8s=;
        b=aZ/SDeaNXrvUHV66vd1EJscoSttKfPuOge84Lxv6XqHTKvlnCTdgoaNsiDdCyq7ePH
         PKhR37Ep4/IXtrV+rhBjKmdwIlhE37P87TxOsk6QuktOR3Fi0x1iIR4bADnPXfq0Ngxv
         CkshbCA+bFIyGRSezpwp54udoGnJhqzbBHONAMIdetgTi0TJ3XCj9+L7wwlsNVZlACw8
         hPawbT5GTpfUxTI/yhQeNKkSsU9J5Xl6iQ2HkjLOCPY7916Xr7d9MZEvtyFs7hlSND8h
         eCgxlFg2GI1WQKaOLsF8vBKNbNNFa/kE4kEW/7g//Z5X62iHZJtGGlzOsPCPgy2Id4j/
         6QQQ==
X-Gm-Message-State: ANhLgQ28WBQPzSjBL+1saWvy9nW6NO2WGlpn7/07naVoZB/6EGYW303R
        UKwgaX0E41F+NQ3f9En5tCU72Sc9
X-Google-Smtp-Source: ADFU+vvLeYfuiI7i4D0boXD+qrjB/mNdEtLmkHvHqm7Q5MAe1NmIa8K76KIBf3WipQVWfpNUW7toQQ==
X-Received: by 2002:a17:902:728d:: with SMTP id d13mr5738825pll.92.1585183840325;
        Wed, 25 Mar 2020 17:50:40 -0700 (PDT)
Received: from localhost ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id v25sm262162pgl.55.2020.03.25.17.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 17:50:39 -0700 (PDT)
Date:   Thu, 26 Mar 2020 07:50:37 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Daniel Malendez <dmalendez@googlemail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Git doesn't support symlinks
Message-ID: <20200326005037.GA5398@danh.dev>
References: <CA8EDABA-A41C-4177-A149-51DCD07C319C@googlemail.com>
 <CAGyf7-FF0aEEiRGjZ_+RuyYnSV5cYn+-Hp5q7dZRADj_VL034g@mail.gmail.com>
 <D3B355BB-BB09-4AA7-8D8A-58B61529D617@googlemail.com>
 <F9453040-2E7D-4CAB-AA7F-0C6C04E2FC99@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F9453040-2E7D-4CAB-AA7F-0C6C04E2FC99@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-25 20:37:30-0400, Daniel Malendez <dmalendez@googlemail.com> wrote:
> Thanks for your feedback!
> 
> > On Mar 25, 2020, at 8:23 PM, Bryan Turner <bturner@atlassian.com> wrote:
> > 
> > This didn't add the same thing. What does a "git status" show at this
> > point? I'd expect it would show "Versions/Current/Headers/interior.h"
> > as added to the index, not "Headers/interior.h".
> 
> $ git add .
> $ git status
> Changes to be committed:
>   (use "git rm --cached <file>..." to unstage)
> 	new file:   Foo.framework/Headers
> 	new file:   Foo.framework/Versions/A/Headers/Interior.h
> 
> > It doesn't necessarily seem like a bug, to me; more like a case where
> > Git could potentially be "smarter" to try and determine that, while
> > "Headers/interior.h" is beyond a symlink, the target of that symlink
> > is still in the repository. (Versions/Current _is_ in the same
> > repository, right?)
> 
> Agree, makes sense!
> 
> I think what happens here is that `git add .` adds the
> Foo.framework/Headers directory first, to circumvent this check
> failing here?

"Foo.framework/Headers" is a symlinks,
and git simply adds that, without caring where it's linked to.

To git, there's nothing inside "Foo.framework/Headers",
it's a blob, which happends to be type: symlink.

IOW, you can:

	$ git add Foo.framework/Headers # without add the target
	$ ln -s /usr/bin bin
	$ git add bin # git won't write to index anything from /usr/bin

> https://github.com/git/git/blob/master/pathspec.c#L596
> Whereas a single “git add path/to/file” would fail here

-- 
Danh
