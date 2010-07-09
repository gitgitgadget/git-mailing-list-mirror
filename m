From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Add svnrdump
Date: Fri, 9 Jul 2010 15:42:28 +0200
Message-ID: <20100709134228.GB12315@debian>
References: <20100708083516.GD29267@debian>
 <002d01cb1e7f$e0ff03c0$a2fd0b40$@nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dev@subversion.apache.org, 'Jonathan Nieder' <jrnieder@gmail.com>,
	'Sverre Rabbelier' <srabbelier@gmail.com>,
	'Git Mailing List' <git@vger.kernel.org>
To: Bert Huijben <bert@qqmail.nl>
X-From: git-owner@vger.kernel.org Fri Jul 09 15:40:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXDoz-0003Mu-RA
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 15:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756092Ab0GINks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 09:40:48 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34814 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755834Ab0GINkr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 09:40:47 -0400
Received: by eya25 with SMTP id 25so302800eya.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/Sd5T7aZMrSRX0e78nXitM+Xw13mRnhtEh78Big/rFI=;
        b=QeFBhc4ES3v1x5Pyx80LUHLbSzmUrTVuh0f2kYqegCZil9zbWsKqIVizzKpfP9/pvl
         PCNTRgMPtVks9+lQpzwZhxhEfzfCrE36BoWDKqjyYgO991EVGswAvrgZE37aZ70pAR4c
         ntZU0yGMT8OIXJzNvctlYWfmg+v/ngmsUtmMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BRLjMafnm0bKo5IMGu+8bptBs35S0rb3nES+zR5h9sl1JP4erGwKDQcMAg/Xf9c8jD
         Qqbs/BJ/mY0WkeFJa7eCdSxj5u2nlyt+5UbmQUqpHcAEB4X2VeTJ3cZ5Wgb7C16d036m
         jZqAfdfTkc8Yr5RbSmO5VYNpwwvVEZyAVVgzA=
Received: by 10.213.2.194 with SMTP id 2mr8218979ebk.97.1278682846418;
        Fri, 09 Jul 2010 06:40:46 -0700 (PDT)
Received: from debian (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id a48sm7708187eei.0.2010.07.09.06.40.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 06:40:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <002d01cb1e7f$e0ff03c0$a2fd0b40$@nl>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150666>

Hi Bert,

Thank you for the review.

Bert Huijben writes:
> > +svn_error_t *open_root(void *edit_baton,
> > +                       svn_revnum_t base_revision,
> > +                       apr_pool_t *pool,
> > +                       void **root_baton)
> 
> Static and the return type on its own line.

Fixed. Sorry about the sloppy error.

> This looks like more than 80 characters to me.

I didn't realize that it was a strict requirement. Fixed now.

> > +  if (pb && ARE_VALID_COPY_ARGS(pb->cmp_path, pb->cmp_rev)) {
> > +    APR_ARRAY_PUSH(compose_path, const char *) = pb->cmp_path;
> > +    APR_ARRAY_PUSH(compose_path, const char *) =
> > svn_dirent_basename(path, pool);
>
> Assuming that the path doesn't start with a '/' here, this should be
> svn_relent_basename() to avoid platform specific path rules.

Where is svn_dirent_basename defined? I can't seem to find it in the
codebase at all.

> > +  hb->temp_filepath = apr_psprintf(eb->pool, "%s/svn-fe-XXXXXX",
> > tempdir);
> 
> Why store this path in the editor pool? Do you really need this XXXX path to
> live that long?

Excellent catch! :) Fixed now.

> > +svn_error_t *
> > +get_dump_editor(const svn_delta_editor_t **editor,
> > +                void **edit_baton,
> > +                svn_revnum_t to_rev,
> > +                apr_pool_t *pool);
> 
> These structs and this function don't follow our naming guidelines for
> libraries. But these functions are no reusable library (yet).

Right. Is it alright then? Can I re-submit the patch now? (Also fixed
a couple of things Daniel pointed out).

-- Ram
