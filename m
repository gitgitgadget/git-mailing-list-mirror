From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 25/27] refs: add LMDB refs storage backend
Date: Fri, 19 Feb 2016 14:10:39 -0500
Organization: Twitter
Message-ID: <1455909039.7528.89.camel@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
	 <1455772670-21142-26-git-send-email-dturner@twopensource.com>
	 <20160218085023.GA30049@lanh> <1455827001.7528.87.camel@twopensource.com>
	 <CACsJy8AEOzSi-yJo3eJLSv5s6RW1sZBw+G2Y7cypGb2b+p0QLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 20:10:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWqS2-0007y1-II
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 20:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1427937AbcBSTKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 14:10:43 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:36536 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030273AbcBSTKm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 14:10:42 -0500
Received: by mail-qg0-f43.google.com with SMTP id y9so69936419qgd.3
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 11:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=ZMvtyy9E4a3yqNGAjuLXRYWO7VcetJH3PIZkGFcmQek=;
        b=I7zqggKn6hbLWY9THGMPu6zRdbwqH0ghY+K2p+Wz/ap9UOh9tKru0uYOeAupZ7pWKr
         a1YwM7cztbK2juvIQLxI1Q9EqtjvCU+iWSdYYC+s8rK5okb+NDVroA684NL/+fcjB9wl
         a+p3r7CW33WEQHSDM2Ziob+MehU3TvANEgr1iJ8pLTfhoumz8wxUaonoo+CxaZTVLr+G
         TJw83p3UyzD+zcbN/tnSXB0sbvxsWApMdE1eeIPX2pBCH649yiWMK+GXMHxCiOHMAUoB
         CuhckyDaRFTfp/ktzxAm0oak6oLd2fgVIhG9qF2uKrFMOUFECCZzQtQOMTIXFQ97hLAi
         RMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=ZMvtyy9E4a3yqNGAjuLXRYWO7VcetJH3PIZkGFcmQek=;
        b=kQoOXDue0XLZYmK6iUonKPGrs5a7wCUTtC9ayYzniUvx/dG1VYIlEmeHPn20xoBY1j
         ZakeBgpOqLeE29Mqq38Y1yppDfV45pqpqPyCaJbaWdLMfOy2rqwm3wly1DKptYVEVgd6
         0ZkqfdjqYSN4LTGmIe7rChcDQ3PGdgxEdUAiyvXePM2o6e8IsWNO5uj8JBP1nhmpu95N
         IwqXfJOV0dREawYiiZiiUtENP3q2XNIeQrHRJoXCFvCBZgdLPJJHPKzk1m4kmZ54tVM/
         smwm1q6YWe3o48yGF2xjSyhaT7XFPmDB0W36fAU0igWj6XX7s+Qv1bRS6F5bMsKU4ZkE
         lXDg==
X-Gm-Message-State: AG10YOQbj7ABn6Ha7iiKPS7FFdCsf7XnLCTowa8B5zApeOrRHJJXphTpC9ltls2brEwIWA==
X-Received: by 10.140.177.71 with SMTP id x68mr19050817qhx.39.1455909041443;
        Fri, 19 Feb 2016 11:10:41 -0800 (PST)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id x79sm5240248qka.37.2016.02.19.11.10.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 19 Feb 2016 11:10:40 -0800 (PST)
In-Reply-To: <CACsJy8AEOzSi-yJo3eJLSv5s6RW1sZBw+G2Y7cypGb2b+p0QLg@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286742>

On Fri, 2016-02-19 at 09:54 +0700, Duy Nguyen wrote:
> On Fri, Feb 19, 2016 at 3:23 AM, David Turner <
> dturner@twopensource.com> wrote:
> > > > +static int read_per_worktree_ref(const char *submodule, const
> > > > char
> > > > *refname,
> > > > +                            struct MDB_val *val, int
> > > > *needs_free)
> > > 
> > > From what I read, I suspect these _per_worktree functions will be
> > > identical for the next backend. Should we just hand over the job
> > > for
> > > files backend? For all entry points that may deal with per
> > > -worktree
> > > refs, e.g. lmdb_resolve_ref_unsafe, can we check ref_type() first
> > > thing, if it's per-worktree we call
> > > refs_be_files.resolve_ref_unsafe()
> > > instead?  It could even be done at frontend level,
> > > e.g. refs.c:resolve_ref_unsafe().
> > > 
> > > Though I may be talking rubbish here because I don't know how
> > > whether
> > > it has anything to do with transactions.
> > 
> > The reason I did it this way is that some ref chains cross backend
> > boundaries (e.g. HEAD -> refs/heads/master).  But if we have other
> > backends later, we could generalize.
> 
> Crossing backends should go through frontend again, imo. But I don't
> really know if it's efficient.

It's pretty tricky to maintain state (e.g. count of symref redirects)
across that barrier.  So I'm not sure how to do it cleanly.

> > > > +static int lmdb_create_symref(const char *ref_target,
> > > > +                         const char *refs_heads_master,
> > > > +                         const char *logmsg)
> > > > +{
> > > > +
> > > ...
> > > > +   mdb_put_or_die(&transaction, &key, &val, 0);
> > > > +
> > > > +   /* TODO: Don't create ref d/f conflicts */
> > > 
> > > I'm not sure I get this comment. D/F conflicts are no longer a
> > > thing
> > > for lmdb backend, right?
> > 
> > I'm trying to avoid the lmdb backend creating a set of refs that
> > the
> > files backend can't handle.  This would make collaboration with
> > other
> > versions of git more difficult.
> 
> It already is. If you create refs "foo" and "FOO" on case sensitive
> file system and clone it on a case-insensitive one, you face the same
> problem. We may have an optional configuration knob to prevent
> incompatibilities with files backend, but I think that should be done
> (and enforced if necessary) outside backends.

Sure, the current state isn't perfect, but why make it worse? 
