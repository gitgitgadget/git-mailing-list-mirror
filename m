From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 25/27] refs: add LMDB refs storage backend
Date: Wed, 24 Feb 2016 15:43:40 -0500
Organization: Twitter
Message-ID: <1456346620.18017.23.camel@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
	 <1455772670-21142-26-git-send-email-dturner@twopensource.com>
	 <20160218085023.GA30049@lanh> <1455922186.7528.97.camel@twopensource.com>
	 <20160220025826.GA9338@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>, mhagger@alum.mit.edu,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 21:43:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYgHt-0005mo-Pq
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 21:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267AbcBXUnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 15:43:43 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35014 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbcBXUnm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 15:43:42 -0500
Received: by mail-qg0-f54.google.com with SMTP id y89so24217712qge.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 12:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=bEsXITnzg49XP7SfMiSCZXnwmAMkzvh/sq3oaPTWCwU=;
        b=Pf+qYk5DIKKKSuRGpA4VoiFCWMwIj5FLJzGKrZAIK9BAvcVbcrVEcJugkWiASarcCa
         ilHyxBR67Nq+ChVhqVKZ8rZR9NJ+7MQEVKAq/8Wb81jp6niN3/gcM89Va3utec3nwCOR
         yYvx/YLGyegip1rHzgpG4/oPQ2beLmwQiM2vlmQfhS7FgbHTeuFxJGqzBA2uwYZuMXRP
         zzaDdQ0NADXapmNV1bgBm2n8vmrluZDsZzLayndnROAR7yd6ZJIKrQ/l+4RLkMJpbsUj
         /GfbtRW7ZtnUSNX01s+nuXmqpUayQvRENFd60Cv4IqbiWHDZ5LU7DhWvxu6UGRKc+bG+
         od9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=bEsXITnzg49XP7SfMiSCZXnwmAMkzvh/sq3oaPTWCwU=;
        b=g3KPHJIHcZfdmsEzlH1jDQlKtswZjeZHCnW9LcXI0uFBnSlLU4lNIZBtnwWc9PgAYu
         suurVeky4QZHTsfSL+HbSGo9uIKsmq4xHwv2kaa9vPRKjqtawOk31QPS0dV7wVnl/Zoj
         IdoxWNRH9WEtg8xml/s4/MT9elJglWbDtIlJRaKq5djVS4WBZsJf+gWI1jtSToxDLYMR
         jkJJ+fQbVd4JU0I1+fUwsLIJbbpJv549QnTbDmmoVqx4S4+j1+6RuQZx9HOodxXeVsJH
         JRGOeKM+7rs/ppCNtcSOMkdxS+30wj8QFGJhfgNclr+Lc7dH3tUcj8ch7Pdeh21uiUg/
         gQUw==
X-Gm-Message-State: AG10YOQp/zvoR8eU4Ynt5pb2NoNrDkGKfaVZ2FVsyBy6i4XaOJoDRF4K8XOAR86PEYz09w==
X-Received: by 10.140.231.80 with SMTP id b77mr54707572qhc.56.1456346621797;
        Wed, 24 Feb 2016 12:43:41 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id a129sm1909794qkb.45.2016.02.24.12.43.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 12:43:40 -0800 (PST)
In-Reply-To: <20160220025826.GA9338@lanh>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287225>

On Sat, 2016-02-20 at 09:58 +0700, Duy Nguyen wrote:
> > On Fri, 2016-02-19 at 09:54 +0700, Duy Nguyen wrote:
> > > On Fri, Feb 19, 2016 at 3:23 AM, David Turner <
> > > dturner@twopensource.com> wrote:
> > > > > > +static int read_per_worktree_ref(const char *submodule,
> > > > > > const
> > > > > > char
> > > > > > *refname,
> > > > > > +                            struct MDB_val *val, int
> > > > > > *needs_free)
> > > > > 
> > > > > From what I read, I suspect these _per_worktree functions
> > > > > will be
> > > > > identical for the next backend. Should we just hand over the
> > > > > job
> > > > > for
> > > > > files backend? For all entry points that may deal with per
> > > > > -worktree
> > > > > refs, e.g. lmdb_resolve_ref_unsafe, can we check ref_type()
> > > > > first
> > > > > thing, if it's per-worktree we call
> > > > > refs_be_files.resolve_ref_unsafe()
> > > > > instead?  It could even be done at frontend level,
> > > > > e.g. refs.c:resolve_ref_unsafe().
> > > > > 
> > > > > Though I may be talking rubbish here because I don't know how
> > > > > whether
> > > > > it has anything to do with transactions.
> > > > 
> > > > The reason I did it this way is that some ref chains cross
> > > > backend
> > > > boundaries (e.g. HEAD -> refs/heads/master).  But if we have
> > > > other
> > > > backends later, we could generalize.
> > > 
> > > Crossing backends should go through frontend again, imo. But I
> > > don't
> > > really know if it's efficient.
> > 
> > It's pretty tricky to maintain state (e.g. count of symref
> > redirects)
> > across that barrier.  So I'm not sure how to do it cleanly.
> 
> I notice files backend does pretty much the same thing. "files"
> backend looks more like two backends combined in one, one is files,
> the other is packed-refs. And it looks like we could solve it by
> providing a lower level api, read_raw_ref() or something, that
> retrieves the ref without any validation or link following. More on
> this later.

That basica pproach appears to mostly work.  I'll send another series
with read_raw_ref as soon as I'm done applying all comments on this
series.

> > > > > I'm not sure I get this comment. D/F conflicts are no longer
> > > > > a
> > > > > thing
> > > > > for lmdb backend, right?
> > > > 
> > > > I'm trying to avoid the lmdb backend creating a set of refs
> > > > that
> > > > the
> > > > files backend can't handle.  This would make collaboration with
> > > > other
> > > > versions of git more difficult.
> > > 
> > > It already is. If you create refs "foo" and "FOO" on case
> > > sensitive
> > > file system and clone it on a case-insensitive one, you face the
> > > same
> > > problem. We may have an optional configuration knob to prevent
> > > incompatibilities with files backend, but I think that should be
> > > done
> > > (and enforced if necessary) outside backends.
> > 
> > Sure, the current state isn't perfect, but why make it worse?
> 
> I see it from a different angle. The current state isn't perfect, but
> we will be moving to a better future where "files" backend may
> eventually be deprecated. Why hold back?
> 
> But this line of reasoning only works if we have a new backend
> capable
> of replacing "files" without regressions or introducing new
> dependency. Which is why I suggest a new backend [1] (or implement
> Shawn's RefTree if it's proven as good with small repos)
> 
> I have no problem if you want to stay strictly compatible with
> "files"
> though.
> 
> [1] http://thread.gmane.org/gmane.comp.version-control.git/285893/foc
> us=286654

Won't RefTree have the same d/f conflict issue?

> OK how about we keep resolve_ref_1() whole and split real backend
> code
> out? Something like these three patches (only built, did not test). A
> bit ugly with continue_symlink, but it's just demonstration.

I did this a somewhat different way -- will see what you think when I
send it.
