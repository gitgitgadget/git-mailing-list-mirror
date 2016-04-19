From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Tue, 19 Apr 2016 18:00:11 -0400
Organization: Twitter
Message-ID: <1461103211.5540.129.camel@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
	 <1460507589-25525-4-git-send-email-dturner@twopensource.com>
	 <CAGZ79kYV6dHzuT51Pg9Oc6yBf_f9407JTe2kRpPyNxgXyfha4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 00:00:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asdh6-0005fH-7a
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 00:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbcDSWAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 18:00:20 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34378 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbcDSWAO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 18:00:14 -0400
Received: by mail-qg0-f54.google.com with SMTP id c6so18210593qga.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 15:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=dQc0v34dv5mMtXV2aZBihXtg2gRZ3tn2gNOrQl1QGgE=;
        b=NSoMvmbDImG+W4SJM1e/SPmKXvj5QmzirVGVZYTKx6pZ9jgBOwSIT+GT4maoOvmDKi
         2c3zDXOPJ6LqLOkmexLkTRlxv4TAo0O+kugXhQpB1SltV03FxoPIl5Enkn3TonhkPk2l
         4MCFWNaSUp7A1yfQA1N5B4qN+MFgv0p3M1f6dABcT5qMtRJUkzPMJicSLdpB5Yflcftn
         iWqe2pqW20qBgNw/Oq/2Fyu7tQZC0+wWqug5wF/4kdNY8aisnWVNAiX+Tqm6+aA+OHsY
         Wju8ROpmOsyPhlNVWN9Gw/Ae87zYlAS296AU7iwpzvhUnSQ1upieA5dCdS2RDlFm40v8
         Kabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=dQc0v34dv5mMtXV2aZBihXtg2gRZ3tn2gNOrQl1QGgE=;
        b=EMJ2unI9PwfPcP1Ox//9zAzz02sFGAtkjZeuwitLMOVT22LdcVpi11BR4ysCsFxvcv
         +kaoLeU4tHXEpUAr9sPplGFgy2v4XCxL6gE/fG822hopaXOoDfra4lcjZj6gx/YXfPQF
         YAc3igVsAyscaRv2uepEkJRUCahC8rxX4AZs2cyAEMHr1Z3WD0cGWsJqkYsHiOVgL4Sh
         rm7nh9N+dITf3xCv6V/JfCR87Sv/63e/ofjLa1LbbEW0JBvW24pA7LZrREkTi7HpgbZf
         cKHKV4DbHZjTEI/oT4etRNQ5lXooGYxEzxJb4sl8wqM3aUxQYUH777vR54Gf5EWjPXTk
         BFeQ==
X-Gm-Message-State: AOPr4FXJurgVSxRGlA6eSbNE9/rEw5yJXlNgZzer8GJYXodaM6YzCrqEW74Ohd7SwA/XUg==
X-Received: by 10.140.89.178 with SMTP id v47mr6619781qgd.11.1461103213099;
        Tue, 19 Apr 2016 15:00:13 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g186sm10380096qke.49.2016.04.19.15.00.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 15:00:12 -0700 (PDT)
In-Reply-To: <CAGZ79kYV6dHzuT51Pg9Oc6yBf_f9407JTe2kRpPyNxgXyfha4g@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291935>

On Fri, 2016-04-15 at 17:04 -0700, Stefan Beller wrote:
> > +static int try_shm(struct index_state *istate)
> > +{
> > +       void *new_mmap = NULL;
> > +       size_t old_size = istate->mmap_size;
> > +       ssize_t new_size;
> > +       const unsigned char *sha1;
> > +       struct stat st;
> > +       int fd;
> > +
> > +       if (!is_main_index(istate) ||
> > +           old_size <= 20 ||
> > +           stat(git_path("index-helper.path"), &st))
> > +               return -1;
> > +       if (poke_daemon(istate, &st, 0))
> > +               return -1;
> > +       sha1 = (unsigned char *)istate->mmap + old_size - 20;
> > +
> > +       fd = open(index_helper_path("git-index-%s",
> > sha1_to_hex(sha1)),
> > +                 O_RDONLY);
> > +       if (fd < 0)
> > +               goto fail;
> > +
> > +       if (fstat(fd, &st))
> > +               goto fail;
> > +
> > +       new_size = st.st_size;
> > +       new_mmap = mmap(NULL, new_size, PROT_READ, MAP_SHARED, fd,
> > 0);
> > +       if (new_size <= 20 ||
> > +           hashcmp((unsigned char *)istate->mmap + old_size - 20,
> > +                   (unsigned char *)new_mmap + new_size - 20)) {
> > +               if (new_mmap)
> > +                       munmap(new_mmap, new_size);
> > +               goto fail;
> 
> coming from here
> 
> > +       }
> > +
> > +       /* The memory barrier here matches index
> > -helper.c:share_index. */
> > +       __sync_synchronize();
> > +
> > +       munmap(istate->mmap, istate->mmap_size);
> > +       istate->mmap = new_mmap;
> > +       istate->mmap_size = new_size;
> > +       istate->from_shm = 1;
> > +       return 0;
> > +
> > +fail:
> 
> fd may be leaking here?
> 
> > +       poke_daemon(istate, &st, 1);
> > +       return -1;
> > +}
> > +


Good point.  (It's also leaking on the happy path -- will fix all of
those)
