From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3] reflog-walk: don't segfault on non-commit sha1's in
 the reflog
Date: Thu, 31 Dec 2015 09:57:07 +0100
Message-ID: <1451552227.11138.6.camel@kaarsemaker.net>
References: <xmqqk2nvd0cz.fsf@gitster.mtv.corp.google.com>
	 <20151230233301.GA9194@spirit>
	 <xmqq37ujcwny.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Dec 31 09:57:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEZ2r-0001ce-AI
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 09:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbbLaI5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2015 03:57:12 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36921 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbbLaI5L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2015 03:57:11 -0500
Received: by mail-wm0-f54.google.com with SMTP id f206so104610559wmf.0
        for <git@vger.kernel.org>; Thu, 31 Dec 2015 00:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:content-type
         :mime-version:content-transfer-encoding;
        bh=sf5uTO7m250iTIOwz5pKrpznEvdxdPl2IRPIHQGWZJY=;
        b=1u6dP2esz3ukF+g/seM0OJct+uxrY4dv0cH4Bebpv16HLgOauGyd8yYPwS8NApyRSr
         e43svtJTJbi8SQuOYbqp5qUE4m8IryOT3XANz1iKw8nOIw8+prESb47OFOwbVxJ3/VYB
         Wwt6lO8tSjhaqlH7boUEzIS9ZGlwXYFZC6YjT5aUNLPE6TILs75Eerk2R/D+Xpn8RVEd
         BddZb6WORYvH4PjBIYuXG7zyYMGnRdbCzcZJKl+97ldjEDDM3ldySrlbwR2NQCZSr9b/
         CmvlIkafsTorXBM8w1sxCmkpVFfLtrQ44cPMyN1Oyl6yJrQnuUu3rZbOMMkPxT5R4U+7
         feKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=sf5uTO7m250iTIOwz5pKrpznEvdxdPl2IRPIHQGWZJY=;
        b=GGeFzVSyZg58nUGDoeGzOnI2lK4jennTd+I0Il5xPPooFxuqJKRHiAgXSh25CUGAkp
         WbVcC809L7iNZFenfIp6Slan4LYejibqD8osuDtMGlHQIKy+WyMsCOWEbKpGGV2di8xy
         aWlUJMsZSXoDisuo9m8Mw31sXrRvsotFpiZ1Aj9jPN5Bk9AbhuuYqWWLio7/pYWz6AwA
         /h2WajA4eMCLteloprsN6IXKYi0ZwEPM1wesFdRFq3nONpb9zWvyMBHVQEu4J6wMcnln
         LH2JVHQaJqdpCGMc+YUcirBQtH/FGmyOcyZ7yFsSW1OzGDbUbXdlOJeJZa7jBpITcolL
         h40A==
X-Gm-Message-State: ALoCoQm1cdpo8gKOuxYdGvEKE6cN/5EZyDS+SdReXqi0wE8u6txgyOA/gYYGJUnpsUzmW6vQ3FeidYeMr46P31b6VN9dRLkJ0g==
X-Received: by 10.28.54.209 with SMTP id y78mr22464149wmh.26.1451552229938;
        Thu, 31 Dec 2015 00:57:09 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id x125sm57962485wmg.1.2015.12.31.00.57.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Dec 2015 00:57:08 -0800 (PST)
In-Reply-To: <xmqq37ujcwny.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283232>

On wo, 2015-12-30 at 16:02 -0800, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > diff --git a/reflog-walk.c b/reflog-walk.c
> > index 85b8a54..0ebd1da 100644
> > --- a/reflog-walk.c
> > +++ b/reflog-walk.c
> > @@ -221,6 +221,7 @@ void fake_reflog_parent(struct reflog_walk_info
> > *info, struct commit *commit)
> >  	struct commit_info *commit_info =
> >  		get_commit_info(commit, &info->reflogs, 0);
> >  	struct commit_reflog *commit_reflog;
> > +	struct object *logobj;
> 
> This thing is not initialized...
> 
> >  	struct reflog_info *reflog;
> >  
> >  	info->last_commit_reflog = NULL;
> > @@ -232,15 +233,20 @@ void fake_reflog_parent(struct
> > reflog_walk_info *info, struct commit *commit)
> >  		commit->parents = NULL;
> >  		return;
> >  	}
> > -
> > -	reflog = &commit_reflog->reflogs->items[commit_reflog
> > ->recno];
> >  	info->last_commit_reflog = commit_reflog;
> > -	commit_reflog->recno--;
> > -	commit_info->commit = (struct commit *)parse_object(reflog
> > ->osha1);
> > -	if (!commit_info->commit) {
> > +
> > +	do {
> > +		reflog = &commit_reflog->reflogs
> > ->items[commit_reflog->recno];
> > +		commit_reflog->recno--;
> > +		logobj = parse_object(reflog->osha1);
> > +	} while (commit_reflog->recno && (logobj && logobj->type
> > != OBJ_COMMIT));
> 
> But this loop runs at least once, so logobj will always have some
> sane value when the loop exits.
> 
> > +	if (!logobj || logobj->type != OBJ_COMMIT) {
> 
> And the only case where this should trigger is when we ran out of
> recno.  Am I reading the updated code correctly?

Yes, your description matches what I tried to implement.

> With the updated code, the number of times we return from this
> function is different from the number initially set to recno.  I had
> to wonder if the caller cares and misbehaves, but the caller does
> not know how long the reflog is before starting to call
> get_revision() in a loop anyway, so it already has to deal with a
> case where it did .recno=20 and get_revision() did not return that
> many times.  So this probably is safe.

That corresponds to what I see when experimenting with different
reflogs.

> > +test_expect_success 'reflog containing non-commit sha1s displays
> > properly' '
> 
> In general, "properly" is a poor word to use in test description (or
> a commit log message or a bug report, for that matter), as the whole
> point of a test is to precisely define what is "proper".
> 
> And the code change declares that a proper thing to do is to omit
> non-commit entries without segfaulting, so something like
> 
>     s/displays properly/omits them/
> 
> perhaps?

I did find the test title a bit iffy but couldn't really figure out
why. What you're saying makes a lot of sense, will fix.
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
