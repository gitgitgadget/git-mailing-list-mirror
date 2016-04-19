From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Tue, 19 Apr 2016 18:00:02 -0400
Organization: Twitter
Message-ID: <1461103202.5540.127.camel@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
	 <1460507589-25525-4-git-send-email-dturner@twopensource.com>
	 <CAGZ79kYV6dHzuT51Pg9Oc6yBf_f9407JTe2kRpPyNxgXyfha4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.co>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 00:00:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asdgz-0005bN-2I
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 00:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbcDSWAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 18:00:09 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35195 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbcDSWAH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 18:00:07 -0400
Received: by mail-qg0-f54.google.com with SMTP id f74so16294903qge.2
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 15:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=dQc0v34dv5mMtXV2aZBihXtg2gRZ3tn2gNOrQl1QGgE=;
        b=0jjigS1mDv7HUleuXptCSZFSXEfneYvTayxAMYhUJ37/GYxGQeRteXhiqAmnwrVtsQ
         nwdC/JhnNgwq/zWmYu8FJX+3SgLPQlY73DQsPZjgsPv5h9gIYbOyDcAiIuVBTHyvii+a
         6fb44+SnJjPy1y4xrJMLSDH6wrurs35vRXZzkrFmlx0pCUvmYjNHMfAt5WIQA0Sat1ga
         vpgySrGn40xJb/l61x83gwp3ei9IPeO06NqWzlR35pmFYTHEQkuEUQL2CkAl/1bB8mmR
         S7MbnGzukyM6nToZT+4oNVrvCS66HY4Da/ADnTNF8vmVSl1LbebvOxGN0tFrO0eLnjiV
         tDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=dQc0v34dv5mMtXV2aZBihXtg2gRZ3tn2gNOrQl1QGgE=;
        b=TsDY7MnTGBqJulpEQV3d5zDn4cGynYEwmSDmvsPKLzLMJqR9Ysnjxc1RyTfIIFa/H/
         GmkPauVx6NlppGThSEY9+dBKrIAyXFpBm/PsUr+ZrGkXcTR+Z+rJpoJmxJrNEJDbidLX
         K/jS+lqDDZVEerk/lC/92VScGg6yK0S0vLimERq+3EAH9m9zJ0gEdKYxiZ4f7KsbQFcm
         5NKXOU2XP79S+5a5uic7a5HBAGhIZO1anOeuZq99Ttc8Aso/heR5dlR6k0wMCIwVJDdN
         87xsw1Ba/eqIcH+9Cc8KpnvGDdRmjJErMmvBB4wPKL3NA+KXJxfl7WqrkcgSbw5GQ81o
         l7Aw==
X-Gm-Message-State: AOPr4FWsz5DUqrT1a0URvDuCCeLi7WmM3tFSyB1zRX8rNVqg03NtYzg5uOcWIIHb4xAQ1A==
X-Received: by 10.141.30.201 with SMTP id t70mr7084724qhf.3.1461103205563;
        Tue, 19 Apr 2016 15:00:05 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id f83sm29916962qkb.25.2016.04.19.15.00.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 15:00:03 -0700 (PDT)
In-Reply-To: <CAGZ79kYV6dHzuT51Pg9Oc6yBf_f9407JTe2kRpPyNxgXyfha4g@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291936>

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
