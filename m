From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] reflog-walk: don't segfault on non-commit sha1's in the
 reflog
Date: Wed, 30 Dec 2015 22:49:12 +0100
Message-ID: <1451512152.9251.23.camel@kaarsemaker.net>
References: <20151230131914.GA27241@lanh> <20151230152245.GA30549@spirit>
	 <xmqqege3eiqb.fsf@gitster.mtv.corp.google.com>
	 <1451511208.9251.21.camel@kaarsemaker.net>
	 <xmqq1ta3ehr1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 22:49:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEOcS-00020a-56
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 22:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993AbbL3VtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 16:49:17 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:32923 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbbL3VtP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 16:49:15 -0500
Received: by mail-wm0-f52.google.com with SMTP id f206so78028845wmf.0
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 13:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=giOpflP4boO8lT+T0xsxPij87ylIGxP/eh4/GAvtLnw=;
        b=QVEckgUITRvsAHCpXqjVXmHncIPIhD+iofngTxE4zVxC6xIzR6YPqU3U7LSKB2zqE6
         Z5uo8JM0doxYY6XPQNGtklxyc6/cf/79kvYQgrV4S3RTxnJolKhN7FgIvcgg2jcn4+Ia
         RO73G/weJS5N0OdzQtNTAleCtKozP2iAUgAo/KFvrGwouIh+QOlripbTb7kzjAFMAk5k
         i0RpuA2DQrOjgQYaxs6o7IgHXWOio6GzAsxWMjL/vF2lqDanBcytLQgaKC1q/Dh05Rgh
         15q5IHUABoEw9jNWIC6mXqPzzs8X/CifT4dtp4ywi7dIV8eehdO817pNJx9VBOlSJqjN
         iKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=giOpflP4boO8lT+T0xsxPij87ylIGxP/eh4/GAvtLnw=;
        b=D8iKzke3mWtCPi6bYrXOcyU80Vzo1dbExc75abGspV64eWeGL3CNZdAwmAjq9PlKgL
         /94WQAF6X05uKJxN/bYZucpXJf6wB8LZTgs8fH8QP+GkKbG9+A2QFXfK3FT7KpzI9UzQ
         ZNSWlmMClP8lVLCL/PBI7dvyx8buCjw6csT5oU8JSJiuMAayHZCEI7t72XjmX8mf50ET
         ud/EZSaRTZjkMfjuiktsGThww+TeepKmH9bSCorzP8PTWg1OrjkO5Hvso9Rv1e8UMyXC
         n7iOYz+bbFkIys9qeme4PsofGcDL8wTa7XMQF4MOvdwlSyc6tfjv7lesLyP9nvRxZFR0
         T/Ww==
X-Gm-Message-State: ALoCoQkR4AwvNBmcIOWlVV8s9kEQV3a2fDz6GUfAKgspXhtggk8Sd8uN71iIL/LbekCNCPfQpilsq/qK5/k4B/wYaX75ZgHe1A==
X-Received: by 10.28.187.198 with SMTP id l189mr59160330wmf.89.1451512154388;
        Wed, 30 Dec 2015 13:49:14 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id w194sm12520874wmd.0.2015.12.30.13.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Dec 2015 13:49:13 -0800 (PST)
In-Reply-To: <xmqq1ta3ehr1.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283206>

On wo, 2015-12-30 at 13:41 -0800, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > On wo, 2015-12-30 at 13:20 -0800, Junio C Hamano wrote:
> > > Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> > > 
> > > > diff --git a/reflog-walk.c b/reflog-walk.c
> > > > index 85b8a54..b85c8e8 100644
> > > > --- a/reflog-walk.c
> > > > +++ b/reflog-walk.c
> > > > @@ -236,8 +236,8 @@ void fake_reflog_parent(struct
> > > > reflog_walk_info
> > > > *info, struct commit *commit)
> > > >  	reflog = &commit_reflog->reflogs->items[commit_reflog
> > > > ->recno];
> > > >  	info->last_commit_reflog = commit_reflog;
> > > >  	commit_reflog->recno--;
> > > > -	commit_info->commit = (struct commit
> > > > *)parse_object(reflog
> > > > ->osha1);
> > > > -	if (!commit_info->commit) {
> > > > +	commit_info->commit = lookup_commit(reflog->osha1);
> > > > +	if (!commit_info->commit || parse_commit(commit_info
> > > > ->commit)) {
> > > >  		commit->parents = NULL;
> > > >  		return;
> > > 
> > > This looks somewhat roundabout and illogical.  The original was
> > > bad
> > > because it blindly assumed reflgo->osha1 refers to a commit
> > > without
> > > making sure that assumption holds.  Calling lookup_commit()
> > > blindly
> > > is not much better, even though you are helped that the function
> > > happens not to barf if the given object is not a commit.
> > > 
> > > Also this changes semantics, no?  Trace the original flow and
> > > think
> > > what happens, when we see a commit object that cannot be parsed
> > > in
> > > parse_commit_buffer().  parse_object() calls
> > > parse_object_buffer()
> > > which in turn calls parse_commit_buffer() and the entire
> > > callchain
> > > returns NULL.  commit_info->commit will become NULL in such a
> > > case.
> > > 
> > > With your code, lookup_commit() will store a non NULL in
> > > commit_info->commit, and parse_commit() calls
> > > parse_commit_buffer()
> > > and that would fail, so you clear commit->parents to NULL but
> > > fail
> > > to set commit_info->commit to NULL.
> > > 
> > > Why not keep the parse_object() as-is and make sure we error out
> > > unless the result is a commit with a more explicit check, perhaps
> > > like this, instead?
> > 
> > lookup_commit actually returns NULL (via object_as_type) for
> > objects
> > that are not commits, so I don't think the above is true.
> 
> I think you did not read what you are responding to.  I was talking
> about the error case where the object _is_ a commit (hence lookup
> returns it), but parse_commit_buffer() does not like its contents.

I read it, but misunderstood it. Thanks for clarifying.

> > The code below also loses the diagnostic message about the object
> > not being a commit.
> 
> Giving such a diagnostic message is a BUG.
> 
> A ref can legitimately point at any type of object (only refs under
> refs/heads/, aka "branches", must point at commits), so you MUST NOT
> complain about seeing a non-commit in a reflog in general.

Yeah, that makes sense, didn't think of that.
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
