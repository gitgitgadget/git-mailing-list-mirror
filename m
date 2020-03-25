Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926A4C2D0E5
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6231020737
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SV+FDjUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgCYVFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:05:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39521 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYVFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 17:05:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id a9so4642794wmj.4
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 14:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cCdycmKQE0kICDiDOxR+5pORw7d7aKEipsf7lT7Us4M=;
        b=SV+FDjUeuSka+QDu1cE4MvbOrvX6r6ujZh7sZ0dohVZoTaDT1tNE6P+DdRc+yDt7Um
         MwjLYHjxp+/NFJ+xBCbQ2eMeldXcusOaIzkzUZj7EW/IN687vtHQl/3iA5VYdehuTLDa
         hdA36fli/x+jtUEx9geVrsS/JAo6ME3p74/G1LZNgjAcaxtKeJZz2k1SCt+CKG/KkFDP
         OyCx/f56B1jXc4YYr4y/0jTVjis5lppobCgwA1vaCbxCy/y78xqi9bnGLpBivTVeSlJp
         2jCLSI3IHuGBcqJF2264ecHH8eCkiLD1DK8UGett4vdDG9lc02TUTim4Mp7ahymKDkew
         NV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cCdycmKQE0kICDiDOxR+5pORw7d7aKEipsf7lT7Us4M=;
        b=dzyMpEEiBUQAWfv+LJB7V0KjKfgx3jA+1m94j8EVLgsQq99E95CPuwWiCJUeQrX8jw
         kSdcxm6M8bc2rtqN+0MTeyRBTO1JDG4GTmBmbK7Q2CoFPG9jLlnAzhQWI31UED3durJs
         vUIonQnARzQzwoLIFPzWuZJj8+ELIlV4lNTceTir3Fqba66a4qfEnH7U1z0IHZ/svsug
         TGTGnJDqRUj1YgcGZNlOg5cITv5LXUyzLOg1syrrwLGIfR9Bmx/TQ0PbtuocQPiScTCQ
         UUuBQOwV/EHS1KEWmsKuQWywl0qqQiEuMuy+qfq2dAXyZj/H30c96ji002KSnTezEV5y
         p8Cg==
X-Gm-Message-State: ANhLgQ01QJ76698qB2npSN3ceBgrPWJSFiAiHXLvw7WwRaQp18sa0WcD
        ia7KVLxzsv8W82Ys+rL91EM=
X-Google-Smtp-Source: ADFU+vsyK2zb9MvPjCfeYO47/Jm24BF+8FYLzZY+f0j0/Vieo8QOtCiymYYYZ8SHhP9wuxsADYgYew==
X-Received: by 2002:a05:600c:54f:: with SMTP id k15mr5188583wmc.76.1585170306977;
        Wed, 25 Mar 2020 14:05:06 -0700 (PDT)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id b11sm291570wrq.26.2020.03.25.14.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 14:05:05 -0700 (PDT)
Date:   Wed, 25 Mar 2020 22:05:03 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/5] doc: document --recurse-submodules for reset and
 restore
Message-ID: <20200325210503.bhkwj5v2xdpjtnvp@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Wed, 25 Mar 2020 22:03:48 +0100
References: <20200320213729.571924-1-damien.olivier.robert+git@gmail.com>
 <20200320213729.571924-3-damien.olivier.robert+git@gmail.com>
 <298AFA4F-3D0D-46C7-872A-9B0A0F38E770@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <298AFA4F-3D0D-46C7-872A-9B0A0F38E770@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Philippe Blain, Sun 22 Mar 2020 at 18:36:23 (-0400) :
> > +--[no-]recurse-submodules::
> > +	When the working tree is updated, using --recurse-submodules will
> > +	also recursively reset the working tree of all active submodules
> > +	according to the commit recorded in the superproject, also setting
> > +	the submodules HEAD to be detached at that commit.

> I *think* that should be "the submodules' HEADs" but I'd prefer that a native speaker confirm.

This was copied from read-tree. So I'll update it too in my next reroll.

> > +	the working tree, the submodule will only be updated if this option
> > +	is given, in which case its working tree will be restored to the
> > +	commit recorded in the superproject, and any local modifications
> > +	overwritten. If nothing (or `--no-recurse-submodules`) is used,
> > +	the work trees of submodules will not be updated. Just like
 
> For consistency I'd use "working trees" here also, as in the first sentence. 
> In fact I think it would read better as "submodules working trees will not be updated".

Likewise, this was copied from checkout (and switch). I'll update all of
them.

-- 
Damien Robert
http://www.normalesup.org/~robert/pro
