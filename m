From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Wed, 13 Apr 2016 13:10:35 -0400
Organization: Twitter
Message-ID: <1460567435.5540.74.camel@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
	 <1460507589-25525-4-git-send-email-dturner@twopensource.com>
	 <570E7B1B.6040207@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
	pclouds@gmail.co,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 19:10:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqOJP-0004oq-Cq
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 19:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbcDMRKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 13:10:39 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:34740 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbcDMRKj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 13:10:39 -0400
Received: by mail-qg0-f43.google.com with SMTP id c6so48336521qga.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 10:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=mRrSy0J7n+hhrstm8FW4yTPXcKGkxodypF+J9ygVXZI=;
        b=J5ygmNzG6MgUmzj/3iR6pVhmoLBJmtCESinwzE+QGZ88BrEFOdBNEBswiAZ0w/7m4g
         rdkBFc0HZnGmnQH1H8a2QDt7WyT+diVe8Ye5XKq49lpRoERiRNfE2uOPtjSx/+W/+3Wy
         5Z8G1jjdkRS1+RnsnD2Cn1JaO0n3uDMlHQb1FGzn7KvPgAekCBsIyVeic77gBDz15ceG
         vimyrcwRwojACy1R1C00skP048SW1Hn4mWg9VrMxLmoxuT3V7UQcbS3lD09O6GSkNnNc
         n7C50N5RLDlwkfShnV78RLBCh2IWgv3Ouczjh59OtPHTbmaev2ZpiSqdvkrmlDlvKZCL
         qR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=mRrSy0J7n+hhrstm8FW4yTPXcKGkxodypF+J9ygVXZI=;
        b=nMn1IX0u9sIQSROWAgYtRQWlgZ2dNV8MM8yKUEZGziGv2F8AJqTpOBznDezFBk3uio
         PYlIa4NBECbGagHDKWuFVMnHEO4hiq47jOjO58K0wUu7CIUBvg5E/0BRUGIpFKI4upaR
         vykQJnll7HP5Z/bCDEOW3rdyhC95dWG1m0kZQEMm82kAbOLULQaapiycpS6WiFyBvdso
         XG/W104TQ/2ovxwapOhyBBuL2PVtNX1FDS15VjbFN31GABqehWJzhPqj8NE9S7fSR4VA
         FtC4KQ/3c/wgkx1M/nzyRJ4ICxtqq3Nh01NB8ooZb97tyfxlvfs/lIzRh+EhIHCDHIDV
         ApoQ==
X-Gm-Message-State: AOPr4FVyJsbnIGH0fb7UGMcQOzy6VlK21yomGF9PW/bs++DjsQgzNC/yps4A2LpVvk857g==
X-Received: by 10.140.92.15 with SMTP id a15mr12327917qge.93.1460567437749;
        Wed, 13 Apr 2016 10:10:37 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id a6sm4922955qhd.33.2016.04.13.10.10.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Apr 2016 10:10:36 -0700 (PDT)
In-Reply-To: <570E7B1B.6040207@ramsayjones.plus.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291462>

On Wed, 2016-04-13 at 18:00 +0100, Ramsay Jones wrote:
> 
> On 13/04/16 01:32, David Turner wrote:
> 
> [snip]
> 
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index c07e0c1..8b878fe 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -513,6 +513,7 @@ static inline int ends_with(const char *str,
> > const char *suffix)
> >  #define PROT_READ 1
> >  #define PROT_WRITE 2
> >  #define MAP_PRIVATE 1
> > +#define MAP_SHARED 2
> >  #endif
> >  
> >  #define mmap git_mmap
> > @@ -1045,4 +1046,21 @@ struct tm *git_gmtime_r(const time_t *,
> > struct tm *);
> >  #define getc_unlocked(fh) getc(fh)
> >  #endif
> >  
> > +#ifdef __linux__
> > +#define UNIX_PATH_MAX 108
> > +#elif defined(__APPLE__) || defined(BSD)
> > +#define UNIX_PATH_MAX 104
> > +#else
> > +/*
> > + * Quoth POSIX: The size of sun_path has intentionally been left
> > + * undefined. This is because different implementations use
> > different
> > + * sizes. For example, 4.3 BSD uses a size of 108, and 4.4 BSD
> > uses a
> > + * size of 104. Since most implementations originate from BSD
> > + * versions, the size is typically in the range 92 to 108.
> > + *
> > + * Thanks, POSIX!  Super-helpful!  Hope we don't overflow any
> > buffers!
> > + */
> > +#define UNIX_PATH_MAX 92
> > +#endif
> > +
> 
> It seems you forgot to delete this hunk. ;-)

Oops.  Thanks.
