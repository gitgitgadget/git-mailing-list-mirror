From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 09/16] index-helper: use watchman to avoid refreshing
 index with lstat()
Date: Tue, 19 Apr 2016 14:54:10 -0400
Organization: Twitter
Message-ID: <1461092050.5540.106.camel@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
	 <1460507589-25525-10-git-send-email-dturner@twopensource.com>
	 <CAGZ79kbzp9N10KoY6hCsFBFiU3SEkdmUN-gCC7he6z4UUHx28A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 20:54:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asamv-0001su-TU
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 20:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759AbcDSSyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 14:54:14 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36768 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932667AbcDSSyN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 14:54:13 -0400
Received: by mail-qg0-f44.google.com with SMTP id f52so14861421qga.3
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 11:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Rsyjj0ArubXxH2Dnf73WnLG18R+1f2oznX4nQrMXC3g=;
        b=sroChPcBc4KlG9Zr6ADa+97QM3S03PFXLOEzO67lk/zPtI0cd7Y9qfQJXjuMdlwN8D
         18UpvtHEf5N1GQZeN5rEffHPsjCZzwrDfHUdJVsCGwSN2Hjxl/COba6bsAP/ZdIcaP6s
         4OtB4MZYvDTDkSbr/Z+DT7JDKYuQOUiBjib/LeZqvfcFXPIB2KNgVucNCk473Ryw5RH2
         op1bCg5At0YAtPqRvn/pF4Gz/KFDuXI5rKzaTjjhnT00c6K4TVcBSUfXREh0X2kM9hzJ
         KeDNJK9PIxnL5tLMjcglgXj4ZHiiX7UjQju/L16204Rm++w5LVe9NqmubZm4nLIPSfAC
         YEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Rsyjj0ArubXxH2Dnf73WnLG18R+1f2oznX4nQrMXC3g=;
        b=D3+LmRMRWlVI+pw3TxTGAm2Ntawq1rsethg/W5OLESMexRmsUFrFT3S3S9R1DmpJxm
         87vYO/zoBHaKahAgEkOd8r/Dafcf4Yj1bjedJrGUP4VfXEoIinMUi7ob+utIMqryzgKb
         Gnm8i4L8IMixUmnPuB+PvvBSXJsjHpCtDeh9PIab1+ZuZmFHMT1sKUUdCMuDsrCX0+6q
         bx0DjXiYwZ5UTKUPEjpOl6wyS+oUkvcfBfQot4IrHMorVk447kUi/FwVhB+RwrJ4wdBY
         bmccp4MWuslZAK4fM5wg81vnJRw7H10MtQPMQJQY5pN1LVdDmnLfyNY7CcwrnVrv86oK
         gslw==
X-Gm-Message-State: AOPr4FV/XVgcMyw2Ee47DZE7CxYV/ndz4wpIG6afHERv/Ss7F8ER3piBUcB6nYaBUSVxTQ==
X-Received: by 10.140.222.71 with SMTP id s68mr6014165qhb.49.1461092051772;
        Tue, 19 Apr 2016 11:54:11 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id n90sm29370779qge.46.2016.04.19.11.54.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 11:54:10 -0700 (PDT)
In-Reply-To: <CAGZ79kbzp9N10KoY6hCsFBFiU3SEkdmUN-gCC7he6z4UUHx28A@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291903>

On Fri, 2016-04-15 at 17:07 -0700, Stefan Beller wrote:
> > +static void refresh_by_watchman(struct index_state *istate)
> > +{
> > +       void *shm = NULL;
> > +       int length;
> > +       int i;
> > +       struct stat st;
> > +       int fd = -1;
> > +       const char *path = index_helper_path("git-watchman-%s
> > -%"PRIuMAX,
> > +                                            sha1_to_hex(istate
> > ->sha1),
> > +                                            (uintmax_t)getpid());
> > +
> > +       fd = open(path, O_RDONLY);
> > +       if (fd < 0)
> > +               return;
> > +
> > +       /*
> > +        * This watchman data is just for us -- no need to keep it
> > +        * around once we've got it open.
> > +        */
> > +       unlink(path);
> > +
> > +       if (fstat(fd, &st) < 0)
> > +               goto done;
> > +
> > +       length = st.st_size;
> > +       shm = mmap(NULL, length, PROT_READ, MAP_SHARED, fd, 0);
> > +
> > +       if (shm == MAP_FAILED)
> > +               goto done;
> > +
> > +       close(fd);
> > +       fd = -1;
> > +
> > +       if (length <= 20 ||
> > +           hashcmp(istate->sha1, (unsigned char *)shm + length -
> > 20) ||
> > +           /*
> > +            * No need to clear CE_WATCHMAN_DIRTY set by 'WAMA' on
> > +            * disk. Watchman can only set more, not clear any, so
> > +            * this is OR mask.
> > +            */
> > +           read_watchman_ext(istate, shm, length - 20))
> > +               goto done;
> > +
> > +       /*
> > +        * Now that we've marked the invalid entries in the
> > +        * untracked-cache itself, we can erase them from the list
> > of
> > +        * entries to be processed and mark the untracked cache for
> > +        * watchman usage.
> > +        */
> > +       if (istate->untracked) {
> > +               string_list_clear(&istate->untracked
> > ->invalid_untracked, 0);
> > +               istate->untracked->use_watchman = 1;
> > +       }
> > +
> > +       for (i = 0; i < istate->cache_nr; i++) {
> > +               struct cache_entry *ce = istate->cache[i];
> > +               if (ce_stage(ce) || (ce->ce_flags &
> > CE_WATCHMAN_DIRTY))
> > +                       continue;
> > +               ce_mark_uptodate(ce);
> > +       }
> > +done:
> > +       if (shm)
> > +               munmap(shm, length);
> > +
> > +       if (fd > 0)
> > +               close(fd);
> 
> coverities opinion:
> > off_by_one: Testing whether handle fd is strictly greater than zero
> > is suspicious.
> > fd leaks when it is zero. Did you intend to include equality with
> > zero?
> 
> We can assert that fd is never 0, because that is where stdin is?

You are right: it should be if (fd >= 0).  Will fix. Thanks.
