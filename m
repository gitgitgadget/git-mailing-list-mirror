From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 05/13] Drive the debug editor
Date: Wed, 7 Jul 2010 21:08:13 +0200
Message-ID: <20100707190813.GA16065@debian>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
 <1278461693-3828-6-git-send-email-artagnon@gmail.com>
 <20100707182631.GB2617@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, dev@subversion.apache.org,
	Julian Foad <julian.foad@wandisco.com>,
	Mark Phippard <mphippard@collab.net>,
	Stefan Sperling <stsp@elego.de>,
	Will Palmer <wmpalmer@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 21:06:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWZxN-0004Az-Fh
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 21:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757054Ab0GGTGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 15:06:34 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45497 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756150Ab0GGTGd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 15:06:33 -0400
Received: by wwb24 with SMTP id 24so3162166wwb.1
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 12:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=4bLp0gXMvgzy1PLLBlBPkpFThc7E8ZLgtGC05VRG6hw=;
        b=XkdmYpVZsQu7LS0Nrv1sNtsuEJ9Y4QT6tSllsoObvIcK0/zdHpiFBkaAG7kzWlNUM5
         a3cyHiLN+bazReyrUmYkPWCy1p0zIwBh6/egJhaUuG1yT2GNlq3YHoVCmcxnWRmy26gy
         iAEX4tsvxH9EILP5tj34kKQyKhFE94PcH0j9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sxcQL7bI7U1Zqa72kIgoDQ+zIukPNLHXl3NOWAIuakVwfaFwLK6r2XjzmmBTlQROJP
         i9i9SRURGk/ieHdHShvMswlUR5KFeTkPaRPd2ETa1U2ECNnkCF9j6dduWOlCAUF1nGZw
         yHq3f5KFHqj5RNSEk/jor0pvyOgU8AUYNa594=
Received: by 10.213.20.66 with SMTP id e2mr6062890ebb.83.1278529590149;
        Wed, 07 Jul 2010 12:06:30 -0700 (PDT)
Received: from debian (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id a48sm63663929eei.18.2010.07.07.12.06.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 12:06:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100707182631.GB2617@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150494>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> 
> > +++ b/dump_editor.c
> > @@ -128,7 +128,7 @@ svn_error_t *get_dump_editor(const svn_delta_editor_t **editor,
> >  	de->close_directory = close_directory;
> >  	de->change_dir_prop = change_dir_prop;
> >  	de->change_file_prop = change_file_prop;
> > -	de->apply_textdelta = apply_textdelta;
> > +	/* de->apply_textdelta = apply_textdelta; */
> 
> Hmm...

Without this, the program segfaults because the necessary setup for
applying a text delta hasn't been set up. Perhaps I should explain
this in my commit message?

> [...]
> > +++ b/dumpr_util.h
> > @@ -1,6 +1,11 @@
> >  #ifndef DUMPR_UTIL_H_
> >  #define DUMPR_UTIL_H_
> >  
> > +struct replay_baton {
> > +	const svn_delta_editor_t *editor;
> > +	void *baton;
> > +};
> > +
> 
> Context during svnsync-like replay ops:
> 
>  - a diff replayer
>  - its context object
> 
> Maybe "void *edit_baton" would be clearer.
> 
> >  struct edit_baton {
> 
> Which might involve renaming this to dump_edit_baton to avoid
> confusion.

Done. I renamed both.

> > +++ b/svndumpr.c
> > @@ -8,10 +8,40 @@
> [...]
> > +static svn_error_t *replay_revstart(svn_revnum_t revision,
> > +                                    void *replay_baton,
> > +                                    const svn_delta_editor_t **editor,
> > +                                    void **edit_baton,
> > +                                    apr_hash_t *rev_props,
> > +                                    apr_pool_t *pool)
> 
> This function is called to acquire an editor to replay one revision.
> 
> > +{
> > +	/* Extract editor and editor_baton from the replay_baton and
> > +	   set them so that the editor callbacks can use them */
> 
> This comment just paraphrases the code.  What in particular requires
> explanation here?

This concept took me some time to wrap my head around: I had to stuff
the replay_baton with the editor/ editor_baton so that I could set
them for use in the callback functions. Comment moved to a later
patch.

> > +	struct replay_baton *rb = replay_baton;
> > +	*editor = rb->editor;
> > +	*edit_baton = rb->baton;
> > +
> > +	return SVN_NO_ERROR;
> > +}
> 
> [...]
> > @@ -47,6 +77,25 @@ svn_error_t *open_connection(const char *url)
> >  
> >  svn_error_t *replay_range(svn_revnum_t start_revision, svn_revnum_t end_revision)
> >  {
> [...]
> > +	SVN_ERR(svn_cmdline_printf(pool, SVN_REPOS_DUMPFILE_MAGIC_HEADER ": %d\n",
> > +				   SVN_REPOS_DUMPFILE_FORMAT_VERSION));
> 
> Did this sneak in from a later patch?

Yes. Fixed now. I moved it this change to the next patch.

> > +	SVN_ERR(svn_ra_replay_range(session, start_revision, end_revision,
> > +	                            0, TRUE, replay_revstart, replay_revend,
> > +	                            replay_baton, pool));
> 
> Makes sense.

Thanks for the excellent review.

-- Ram
