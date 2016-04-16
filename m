From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 09/16] index-helper: use watchman to avoid refreshing
 index with lstat()
Date: Fri, 15 Apr 2016 17:07:10 -0700
Message-ID: <CAGZ79kbzp9N10KoY6hCsFBFiU3SEkdmUN-gCC7he6z4UUHx28A@mail.gmail.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
	<1460507589-25525-10-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.co>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 02:07:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arDlf-00074J-O6
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 02:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbcDPAHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 20:07:13 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:34917 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbcDPAHM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 20:07:12 -0400
Received: by mail-io0-f173.google.com with SMTP id g185so149717106ioa.2
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 17:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=U0uC1oM9PYZ12G5xdmXsIWDSLG0JrX0XiedurtBImEE=;
        b=N1mvVQCIxomMdNo2HratZzAaTK/6tmzOxvqyWIpxqg8L5veiFCa3X/+q7xLF1+TcMk
         2M2SCUeDUuC5+lUcIHfWYdpHnjRpk9JIBGrXCWPqnVM9c8JmFEwmorJVMjJ+wOhf4m2H
         pLUAOt/+RtZngTo6cyg3uNMD47Xr8CxUCe41ipBjrLBjDB4B1bxOVWdA7fY7fwsNiet3
         +NUwJMvShFf2Zmg3Dwt7mqGBN/PpkHRMwtV8noI9MstnjQn2A/WR0RnYkTV8iYIlMWmO
         CH3plE0yXWD+MoDuj9CzNo9JuViS5gX0owyZb42W3FOCG7tX7vHRWH6mGwoe6qsQhJgZ
         f++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=U0uC1oM9PYZ12G5xdmXsIWDSLG0JrX0XiedurtBImEE=;
        b=GEim+eSZ/VfIx5vv1C4FSeAjfNmUl2zGrPOQfz2utOrTYXX9vRF+DbdvYPhA+CVJ8w
         tz5rC8QmoajMs25pr8P43MvkTTJKng+cZ6la8HafFNJPu5Vj+mwpOXnsiSjETM28K+De
         wRck7PKD9caTk8qKSb5eiELxwMhn2YMx0ZBYuiaVjtTFvQqiOMaOMELU8YZ4VyjlqEZL
         CyYRXyb04uU6X4+q4dfcCPZjqyY6sULoOHRF1+gkstB4i0E7u1757n4K+JuJsVRNDnlI
         B2Vf4Xh5L3le8k5gD6saTgacwI0vqx6U8tTTOjdiCoVsHPBvXtE6/Wjvk+YzweFWL0b1
         MOgw==
X-Gm-Message-State: AOPr4FWy827Wt6FKoKOsPpFGWSsLERVHiTut6p14h2zK2lnY5Dys3cRiuy/HyQtXzr8ZxCZP5KMLBPG+XdFa5xN0
X-Received: by 10.107.184.8 with SMTP id i8mr25455579iof.96.1460765230955;
 Fri, 15 Apr 2016 17:07:10 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Fri, 15 Apr 2016 17:07:10 -0700 (PDT)
In-Reply-To: <1460507589-25525-10-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291701>

> +static void refresh_by_watchman(struct index_state *istate)
> +{
> +       void *shm = NULL;
> +       int length;
> +       int i;
> +       struct stat st;
> +       int fd = -1;
> +       const char *path = index_helper_path("git-watchman-%s-%"PRIuMAX,
> +                                            sha1_to_hex(istate->sha1),
> +                                            (uintmax_t)getpid());
> +
> +       fd = open(path, O_RDONLY);
> +       if (fd < 0)
> +               return;
> +
> +       /*
> +        * This watchman data is just for us -- no need to keep it
> +        * around once we've got it open.
> +        */
> +       unlink(path);
> +
> +       if (fstat(fd, &st) < 0)
> +               goto done;
> +
> +       length = st.st_size;
> +       shm = mmap(NULL, length, PROT_READ, MAP_SHARED, fd, 0);
> +
> +       if (shm == MAP_FAILED)
> +               goto done;
> +
> +       close(fd);
> +       fd = -1;
> +
> +       if (length <= 20 ||
> +           hashcmp(istate->sha1, (unsigned char *)shm + length - 20) ||
> +           /*
> +            * No need to clear CE_WATCHMAN_DIRTY set by 'WAMA' on
> +            * disk. Watchman can only set more, not clear any, so
> +            * this is OR mask.
> +            */
> +           read_watchman_ext(istate, shm, length - 20))
> +               goto done;
> +
> +       /*
> +        * Now that we've marked the invalid entries in the
> +        * untracked-cache itself, we can erase them from the list of
> +        * entries to be processed and mark the untracked cache for
> +        * watchman usage.
> +        */
> +       if (istate->untracked) {
> +               string_list_clear(&istate->untracked->invalid_untracked, 0);
> +               istate->untracked->use_watchman = 1;
> +       }
> +
> +       for (i = 0; i < istate->cache_nr; i++) {
> +               struct cache_entry *ce = istate->cache[i];
> +               if (ce_stage(ce) || (ce->ce_flags & CE_WATCHMAN_DIRTY))
> +                       continue;
> +               ce_mark_uptodate(ce);
> +       }
> +done:
> +       if (shm)
> +               munmap(shm, length);
> +
> +       if (fd > 0)
> +               close(fd);

coverities opinion:
> off_by_one: Testing whether handle fd is strictly greater than zero is suspicious.
> fd leaks when it is zero. Did you intend to include equality with zero?

We can assert that fd is never 0, because that is where stdin is?

> +}
> +
