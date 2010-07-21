From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 06/13] Dump the revprops at the start of every revision
Date: Thu, 22 Jul 2010 00:25:13 +0530
Message-ID: <20100721185513.GB23839@kytes>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
 <1278461693-3828-7-git-send-email-artagnon@gmail.com>
 <20100707190434.GA2732@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarb@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, dev@subversion.apache.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 20:57:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObeTh-0002RS-Ib
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 20:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758779Ab0GUS5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 14:57:07 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61300 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774Ab0GUS5F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 14:57:05 -0400
Received: by pvc7 with SMTP id 7so2722597pvc.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 11:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Qtd6SET42KNBCAt5zUOLHey+IRu+PqN+S9Eq/HR+PmI=;
        b=w7K4H+DIo5j0YBZOE1vyAgYpHcHRnsRZQ+qmAcuo3fKfKjjkUO8egKsQExsLttOUgC
         0cZL0Y30So0v8VHuRU4+w0SvG3MzIPAo8WsZ5AzAV6361ExVW+7sudc+H9gQzXEHa40s
         nIODHznwIZgfQusRmZmiISK+ieVfLGOu9nTzk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AOBFPCpGJTpTIb+q1+Zip9l8Rt4cpMd5epO9SyA1f8rtAVNv4NV/TuBsp9a3voovWf
         88wnAhFZtNnCpz3xHS2Ghr5ROl0zynSYnVQvQK4fnBzFZ+SbmsZjQXp1/9k4iXE/nokz
         M4ZVsZ3QtAUQrLa6Eg+4VBbVb39PAvhVe8M4w=
Received: by 10.142.211.6 with SMTP id j6mr676985wfg.277.1279738622777;
        Wed, 21 Jul 2010 11:57:02 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id f2sm9390776wfp.11.2010.07.21.11.56.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Jul 2010 11:57:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100707190434.GA2732@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151410>

Hi Jonathan,

I stashed this review away while working on some other important
changes. I finally got around to responding to this review- sorry that
it took so long.

Jonathan Nieder writes:
> > Fill in replay_revstart to dump the revprops at the start of every
> > revision. Add an additional write_hash_to_stringbuf helper function.
> 
> 	A write_hash_to_stringbuf helper does the work of
> 	converting the property hashtable to dumpfile format.
> 
> > +++ b/dumpr_util.c
> [...]
> > +void write_hash_to_stringbuf(apr_hash_t *properties,
> > +			     svn_boolean_t deleted,
> > +			     svn_stringbuf_t **strbuf,
> > +			     apr_pool_t *pool)
[...]

Fixed, but not exactly in the way you've suggested.

> > +			/* Output name length, then name. */
> > +			svn_stringbuf_appendcstr(*strbuf,
> > +						 apr_psprintf(pool, "K %" APR_SSIZE_T_FMT "\n",
> > +							      keylen));
> > +
> > +			svn_stringbuf_appendbytes(*strbuf, (const char *) key, keylen);
> 
> Is the cast needed?  (The answer might be "yes" if this code is meant
> to be usable with C++ compilers.)

These casts are all over in the source tree, so I'm guessing the
answer is "yes".

> Style: better to say in comments what we are trying to do than what we
> actually do.  So:
> 
> 	/* First, dump revision properties. */

I've fixed all the comments in the entire source tree. Thanks :)

-- Ram
