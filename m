Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBE8C33CAD
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 11:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A26020678
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 11:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt7S/w98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgAML00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 06:26:26 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:46935 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgAML00 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 06:26:26 -0500
Received: by mail-wr1-f46.google.com with SMTP id z7so8117614wrl.13
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 03:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EyDq6KW2wsHdhAtq9HKs0/YZ/SnmzL3ACbc8/g9a94Y=;
        b=Pt7S/w98oBqxbJUneZ/1bJ39EXUSRlSRXZWYHoOekuUpipMKaxb5YLHRRZWiOH9hBG
         Ilx9KWhTtHRlHPNJnkUZIuu0a+f2Em+xZF2NX5tMrS8ue2JEkguXsTJD6aVvqZpjjssS
         SEyYU78PMv7f5gtkEADru0b43uqF2ezbeCawC8MsOJuVoW8FLi1slgnSZ6ffD7JgNuR7
         WC6tq7KWaN02Hkeg/Hg6L3u2bU12vd3/HXXUf/kmgsrrzK+lkmeG6q9BDhMTh1NXdXLT
         aehJO6ZT5353NGYXtBY084/kGRJiP5+ORwztcVJQ4Hw+D+yMjexdu0V2tOqdbpLxesDP
         U1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EyDq6KW2wsHdhAtq9HKs0/YZ/SnmzL3ACbc8/g9a94Y=;
        b=mkmuLM1fI4jrrFReA+i5aWrnXkihxAZIIuuilfVCvcMm1FN94b+LAolsj+9elECHQ9
         d+zioE4fJEtjmAOnComXyVcfEyLV7jndJgPKMbotm4546mkPG/YLt/GMQuJ/z12Ujmfl
         PnBcR9Cw2EpRHRYIYE5uv0vab6wC8Nyh31LP5emT01k0GycTRztSyykEgth092/uJFJG
         ESbVVK+IcsICH0dXDyKIX3Dk/iq89Yh405Qi2zF+PNfWxSrQx4NseR91CEpCKf9InsjB
         VEXJt1/l8O3pKPK4i/xOc7F6x4KXDboOhSTXLdNZCeuSJTcZtc3rC9C3lTEr4g4Fnszf
         tKbw==
X-Gm-Message-State: APjAAAVFo2VcXdi53ylWacZ0WK2tCIJYvNc77w75Yp9bUphxoyp/ks/f
        fBIMdCua2wARknFsYQz50iP/SGdi
X-Google-Smtp-Source: APXvYqyNjB8vU+c9yE080bxM8sdgRIq85WjBXBNAR+kp4sec5UTs70UjuhN5Ly/gOdR9BIN5H3ecxg==
X-Received: by 2002:adf:ea4f:: with SMTP id j15mr18229486wrn.356.1578914784413;
        Mon, 13 Jan 2020 03:26:24 -0800 (PST)
Received: from szeder.dev (x4d0c05b5.dyn.telefonica.de. [77.12.5.181])
        by smtp.gmail.com with ESMTPSA id q14sm14364397wmj.14.2020.01.13.03.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jan 2020 03:26:23 -0800 (PST)
Date:   Mon, 13 Jan 2020 12:26:21 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jude Guan Wang <guan@clicktherapeutics.com>, git@vger.kernel.org
Subject: Re: Fwd: Issue with Git Branch
Message-ID: <20200113112621.GJ32750@szeder.dev>
References: <56F9DC91-740F-47C7-9C2A-B6B1EC3A12B6@clicktherapeutics.com>
 <29742805-4992-47E6-9889-F55F5EFBBFF1@clicktherapeutics.com>
 <20200113001143.GA13099@syl.local>
 <20200113004235.GI32750@szeder.dev>
 <20200113004814.GA15236@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200113004814.GA15236@syl.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 12, 2020 at 04:48:14PM -0800, Taylor Blau wrote:
> On Mon, Jan 13, 2020 at 01:42:35AM +0100, SZEDER Gábor wrote:
> > On Sun, Jan 12, 2020 at 04:11:43PM -0800, Taylor Blau wrote:
> > > On Sun, Jan 12, 2020 at 07:01:04PM -0500, Jude Guan Wang wrote:
> > > > 	I noticed something weird with my git command. In my local
> > > > 	environment I seem to have a branch named `-D`:
> > > >
> > > > 	And I don’t remember how I was able to create a branch like that.
> >
> > > If you do find a reproducible way to create branches named '-D' or
> > > similar, please do let us know, as these are not intended to be valid
> > > branch names in general.
> >
> >   $ git update-ref refs/heads/-D master
> >   $ git branch |head -n1
> >     -D
> 
> I was assuming that Jude had gotten the ref to appear by using 'git
> branch' alone, i.e., without the help of 'git update-ref' or 'cp
> .git/refs/heads/{master,-D}'.

On a somewhat related note, while trying whether I could
"inadvertently" create such a branch with gitk I stumbled upon this
bit of weirdness:

  $ git rev-parse v2.24.0^{commit}
  da72936f544fec5a335e66432610e4cef4430991
  $ git branch da72936f544fec5a335e66432610e4cef4430991 v2.24.0
  $ gitk -1 v2.24.0

(While starting up gitk might show a popup warning about the branch
with 40 hexdigit name, close it.)

So now gitk displays a commit with the v2.24.0 tag and the da7293...
branch pointing to it.  Right click on the commit's subject line,
select "Create new branch" from the context menu.  Enter "-D" as the
name of the new branch, and click Create.  Now gitk displays a "-D"
branch pointing to the same commit as well, but it's only a display
thing, as it did not actually create that branch, because it
carelessly run the 'git branch -D da7293...' command...  After
refreshing with F5 it won't display the da7293... and "-D" branches.

