From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Fri, 15 Apr 2016 17:04:11 -0700
Message-ID: <CAGZ79kYV6dHzuT51Pg9Oc6yBf_f9407JTe2kRpPyNxgXyfha4g@mail.gmail.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
	<1460507589-25525-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.co>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 02:04:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arDij-0005R3-IF
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 02:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbcDPAEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 20:04:13 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38797 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbcDPAEM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 20:04:12 -0400
Received: by mail-ig0-f173.google.com with SMTP id ui10so37151410igc.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 17:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ZaKviRd4qTnXOyGpokPWdVUkujsJ6YeLEe6FE6vhX+Y=;
        b=mCFh5TrptrQQXRYWXrA8a+EDuMua93iZxc/TtqkukqYeyGSz9jSFntoUMZVgpowCBc
         iKUcLc0uPQeXolIY2MkmRKOKBczOfGgVHfYZSMLzmyjRCu8HYg18ddMpfce+naP7C32V
         VJ67joDuIjUsC3oO3IcBc0QKGxJESMb/bq5LyjTVBwvEizaDy0LfgWQZv/CGpjYoWk8i
         exoB/mfF4jfLhPFqw40zRnlvTYC7RaVIG1uu+gdDQZWLvln+L8kJrjA6PND+x1D8kWk3
         JkvJlE+PwGin8F9+SBH5YRlM31YmFY3MTDZ565CAjpdu2lUKqgFbdBqbQYLjw5ALbDMS
         qLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ZaKviRd4qTnXOyGpokPWdVUkujsJ6YeLEe6FE6vhX+Y=;
        b=UBGxxZn3+ZCsLbb/rC5Vr/9bhDmsIxYLfeiqIzoI50vdgsUIOVers4g+VABBhatCcl
         WCu8zmMkENEUQPYNSqIa7xnKmEhaIaYnhaVNZLdEm3rpcm7Rje77OAtrxNbqyq4z8oDx
         ySJ+hvp44D9SUWMKSFuYVWD4IREimi3dH+/RbDrfJU5n8htzvfALDuEeM2RVdtcyXcjl
         s8mRxhCymwGC0+3kUhOd1vd9uzIb+z9fRWCSQuQwDOSept+lWOcKxPgiGdkirGTHTv+q
         vCpEweSXVhcimTO5OgDUQdxsPkUguDPBBtj08ERo6uMrdLyq9vyhngGoWKUfQKxV8jUR
         FgiA==
X-Gm-Message-State: AOPr4FXDdOgK4kxWt4Dn4/rlV8rCZz7lU6MUfCNUSJ1yVNNMRhN80kr6dk/oqKN72Ym3qPtkM36ueFSHRZEpkq5H
X-Received: by 10.50.112.10 with SMTP id im10mr7978299igb.93.1460765051810;
 Fri, 15 Apr 2016 17:04:11 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Fri, 15 Apr 2016 17:04:11 -0700 (PDT)
In-Reply-To: <1460507589-25525-4-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291700>

> +static int try_shm(struct index_state *istate)
> +{
> +       void *new_mmap = NULL;
> +       size_t old_size = istate->mmap_size;
> +       ssize_t new_size;
> +       const unsigned char *sha1;
> +       struct stat st;
> +       int fd;
> +
> +       if (!is_main_index(istate) ||
> +           old_size <= 20 ||
> +           stat(git_path("index-helper.path"), &st))
> +               return -1;
> +       if (poke_daemon(istate, &st, 0))
> +               return -1;
> +       sha1 = (unsigned char *)istate->mmap + old_size - 20;
> +
> +       fd = open(index_helper_path("git-index-%s", sha1_to_hex(sha1)),
> +                 O_RDONLY);
> +       if (fd < 0)
> +               goto fail;
> +
> +       if (fstat(fd, &st))
> +               goto fail;
> +
> +       new_size = st.st_size;
> +       new_mmap = mmap(NULL, new_size, PROT_READ, MAP_SHARED, fd, 0);
> +       if (new_size <= 20 ||
> +           hashcmp((unsigned char *)istate->mmap + old_size - 20,
> +                   (unsigned char *)new_mmap + new_size - 20)) {
> +               if (new_mmap)
> +                       munmap(new_mmap, new_size);
> +               goto fail;

coming from here

> +       }
> +
> +       /* The memory barrier here matches index-helper.c:share_index. */
> +       __sync_synchronize();
> +
> +       munmap(istate->mmap, istate->mmap_size);
> +       istate->mmap = new_mmap;
> +       istate->mmap_size = new_size;
> +       istate->from_shm = 1;
> +       return 0;
> +
> +fail:

fd may be leaking here?

> +       poke_daemon(istate, &st, 1);
> +       return -1;
> +}
> +
