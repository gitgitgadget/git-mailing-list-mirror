Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B22C433EF
	for <git@archiver.kernel.org>; Wed,  4 May 2022 12:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349866AbiEDMpX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 08:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349920AbiEDMpE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 08:45:04 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E6233E1C
        for <git@vger.kernel.org>; Wed,  4 May 2022 05:41:28 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id s14so1291338plk.8
        for <git@vger.kernel.org>; Wed, 04 May 2022 05:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QKz8+gzRgh2ujXU38sIiW8H0f5SMPoc0PwUd7PP6RCY=;
        b=lD9OW4bTvuWaKMStCSarvtIuulOdi74VWdA7/0Wom+CeNN1fI2RPgvC2I0yA97u3ia
         /92MRwsA7jlDYJV0zPBxw7ygwrG/FGHTZgw52RLfQ9ofwKJuGcys4rr0CV7OitBcVPqN
         dK/MTFZ+FyMKebnpWI9leCs1bRss115LGwH477FDgl2Rvfi9KQk0AwwEKYNpwiGmmvw5
         HjQ+9rICN3zVM/5pZ2IY34sFPfqg2wH34iwaVmph7MN3nLK8oQW42lWKpfGVoxE3CVeO
         56ddOwXkw7WUUsEFbnNSAdEZJO90puvrf+G5m8xtFbdHbEtI6Yp1xfcrMt+jRxU+3y3e
         lZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKz8+gzRgh2ujXU38sIiW8H0f5SMPoc0PwUd7PP6RCY=;
        b=ilRVO+WL6rJLsWGS5oPjBQeaPleVE9yllG9evRC/ocsN8iMr1FPP9/svNk6X2S8txU
         cYsz0GU2gLXdDdJllaDNntcSsJfIhX6B8arX/uVwssVTKQfZ2ZEUvma34fODX4cuUl2x
         FGgpizHdvmF/sUNg7zKeVgmj86Jipk+Pe9PZwo3DruDYy9LoZYkua6FdDmeIcwzy7j5N
         maUzaXBPc2vaRcUFLIknVHSj+ffGuwgD9DEo2Unu5AeiVBTPnI5PgTwn/NkTUUHVPSbI
         bBDu4PaxocPAKaL+Vnv0rDzMfZMLzDBkkUEuUkvhkRtFP8I+ZWU4hb9QmpcDy7yH9+mc
         4Vgw==
X-Gm-Message-State: AOAM5339RBAidOyX5reil07uI1G09Y/2JbGTxeUeSdqDJ9jIwyV96DRT
        MojT89SnQhrTgXD3TyBE5aU=
X-Google-Smtp-Source: ABdhPJwRTUiqGQ1Gk4uz9GDmO/30WYc6QPiCimNSmjlZvOAAY5ALyqdMU18Els/SZMQfgKjM+SJdlQ==
X-Received: by 2002:a17:90b:502:b0:1d9:a907:d845 with SMTP id r2-20020a17090b050200b001d9a907d845mr10218424pjz.162.1651668087867;
        Wed, 04 May 2022 05:41:27 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id z5-20020a170903018500b0015e8d4eb223sm8364677plg.109.2022.05.04.05.41.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 May 2022 05:41:27 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Peter Krefting <peter@softwolves.pp.se>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?ISO-8859-15?Q?Matthias_R=FCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?ISO-8859-15?Q?Christopher_D=EDaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?ISO-8859-15?Q?Jean-No=EBl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Emir SARI <bitigchi@me.com>,
        =?VISCII?Q?Tr=A5n_Ng=F7c_Qu=E2n?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [PATCH 0/9] Incremental po/git.pot update and new l10n workflow
Date:   Wed,  4 May 2022 20:41:21 +0800
Message-Id: <20220504124121.12683-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cb74f3b-c2e9-947f-8f89-f51e79b17825@softwolves.pp.se>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 3 May 2022, Peter Krefting  wrote:

> I do agree that checking in git.pot does create a lot of noise, but ther are
> other ways of fixing that than deleting the file completely. I am also
> translating for dpkg, and there they run "xgettext --add-location=file" to
> remove the line numbers from the POT and PO files (requires GNU gettext
> 0.19; they also use "po4a --porefs=noline" for manual page translations, but
> we do not have translation for manual pages for Git, yet). This reduces diff
> noise considerably.

To evaluate the impact of different formats of po files on the size of the
repository, I tailored the git repository with only "po/*" files with
history, and all "*.po" files are converted using "msgcat" into different
format in 3 different branches. See:

    https://github.com/jiangxin/git-po-filtered

* For po files with file-location:

        $ git clone --single-branch \
            --branch po-with-file-location \
            git@github.com:jiangxin/git-po-filtered.git \
            po-with-file-location

        $ du -sh po-with-file-location/.git/objects 
          28M    po-with-file-location/.git/objects

* For po files with file name only:

        $ git clone --single-branch \
            --branch po-with-file \
            git@github.com:jiangxin/git-po-filtered.git \
            po-with-file

        $ du -sh po-with-file/.git/objects 
         6.1M    po-with-file/.git/objects

* For po files without file-location:

        $ git clone --single-branch \
            --branch po-no-file-location \
            git@github.com:jiangxin/git-po-filtered.git \
            po-no-file-location

        $ du -sh po-no-file-location/.git/objects
         6.2M    po-no-file-location/.git/objects

From the above command output we can see that by removing line numbers
from po files, the size of the repository can be greatly reduced.

> I have been doing updates semi-off-line from my laptop for the last few
> months, without a proper build environment, and having the history for the
> POT file available for diffing has been useful.
> 

"po/git.pot" will be generated periodically at the following location,
where you can get "po/git.pot" if you don't have a build environment
at hand.

 * https://github.com/git-l10n/git-po/tree/pot/master/po


> > * L10n contributors can start translations at any time, even before the
> >  l10n announcing l10n window open. We must have a new l10n workflow,
> >  see patch 9/9.
> 
> You can always re-generate the POT file locally and not commit it, to update
> the PO files. That has not been a problem.

File-location meta info in po file can help l10n tools to locate context
easily. E.g.: When editing po file using Emacs (with po-mode), press the
key "s" (source) will open another window showing context of the specific
l10n message.

But if there is no file-location in "po/git.pot", we have no way to
generate po/XX.po with proper file-location. While if we store po/git.pot
with file location in git repository, repository size will get biger and
biger. As how to commit a po/XX.po without file locaiton automatically,
we add some instructions in patch 9/9, and we can also rewrite l10n CI
pipeline to validate po files from l10n contributors.

--
Jiang Xin
