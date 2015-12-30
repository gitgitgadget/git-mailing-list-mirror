From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] reflog-walk: don't segfault on non-commit sha1's in the
 reflog
Date: Wed, 30 Dec 2015 22:33:28 +0100
Message-ID: <1451511208.9251.21.camel@kaarsemaker.net>
References: <20151230131914.GA27241@lanh> <20151230152245.GA30549@spirit>
	 <xmqqege3eiqb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 22:33:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEONV-0006k7-Nu
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 22:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755171AbbL3Vdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 16:33:42 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38848 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbbL3Vdc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 16:33:32 -0500
Received: by mail-wm0-f43.google.com with SMTP id b14so63377953wmb.1
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 13:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=70XBk5mW7AbB+K7K7PiDKF+2bhbV1q5gU4kyd+gdLnY=;
        b=s97TjZwgMnguyX+IS2x/MItwfSxjIIhqRlmEIswCS/F/dnCDSOImth6Ls8slXQpiiu
         WdSkDYvmRXMDzw5w4SuWCXM2nl1Xq6VvGlXo7ghKpOqaTR/mcLqzsASALIDCK3o4aB7K
         meX1aD7AM9EumIlIwe/MPc80p/wlnWsfgEXpwQNhXs65po4BInZunOheSx+979B+2AMz
         4H56JptBAQI76mLrVjkEkkYLt3DZwhyu3G1FeC5P9UfGVFaNmegR+sIKEo1dkYmwxOmk
         GUPg9ssJt29F8fHomlaR831X76hsfoDlHASvVOA0Z3X5ogmTFyg+oM1nixyzY8hHTjak
         bBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=70XBk5mW7AbB+K7K7PiDKF+2bhbV1q5gU4kyd+gdLnY=;
        b=JMi2f5dpNJBTYNpTPl1vMJ7897XzPF/d4rBjc3o+BkzlP7itWeT+XYETM/JPef3nRk
         IAuDkmHKdZ7PUpjwH6r7CMrJ+KB/NzU1qGQtcVC70IiSrl3fs0AI32ZH4dGP0PN5V9rh
         /ADvAj/6bDO5RRjIivBBJtRLPa+baVoNNYlUV30ITRb6nywbxcbfiPL8SKpExfC3tpkM
         VEFzpsMaOp2owpo1Dt/2PKaulxBJNs/V8v4d7Ny9PqavXLxw4N8IdUvNPjfJ7AHVWbv4
         q3iAIEjXvpmHGQ74z2A3v72ZcagWihKSAT9Mf0Ho58nqHBVc1u+cKvaFpvT+hbRqbHTd
         PB9A==
X-Gm-Message-State: ALoCoQkn+seHeN1G1dD7V1xTIgT5JQ+xcjRkirpbp5vbKnQxOu09ncX7a0z05bii8VLTN9mA0U6ZIr5qCcomPQg9BEfkUEhs1g==
X-Received: by 10.28.178.206 with SMTP id b197mr70585713wmf.20.1451511210553;
        Wed, 30 Dec 2015 13:33:30 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id jo6sm67056013wjb.48.2015.12.30.13.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Dec 2015 13:33:29 -0800 (PST)
In-Reply-To: <xmqqege3eiqb.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283201>

On wo, 2015-12-30 at 13:20 -0800, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > diff --git a/reflog-walk.c b/reflog-walk.c
> > index 85b8a54..b85c8e8 100644
> > --- a/reflog-walk.c
> > +++ b/reflog-walk.c
> > @@ -236,8 +236,8 @@ void fake_reflog_parent(struct reflog_walk_info
> > *info, struct commit *commit)
> >  	reflog = &commit_reflog->reflogs->items[commit_reflog
> > ->recno];
> >  	info->last_commit_reflog = commit_reflog;
> >  	commit_reflog->recno--;
> > -	commit_info->commit = (struct commit *)parse_object(reflog
> > ->osha1);
> > -	if (!commit_info->commit) {
> > +	commit_info->commit = lookup_commit(reflog->osha1);
> > +	if (!commit_info->commit || parse_commit(commit_info
> > ->commit)) {
> >  		commit->parents = NULL;
> >  		return;
> 
> This looks somewhat roundabout and illogical.  The original was bad
> because it blindly assumed reflgo->osha1 refers to a commit without
> making sure that assumption holds.  Calling lookup_commit() blindly
> is not much better, even though you are helped that the function
> happens not to barf if the given object is not a commit.
> 
> Also this changes semantics, no?  Trace the original flow and think
> what happens, when we see a commit object that cannot be parsed in
> parse_commit_buffer().  parse_object() calls parse_object_buffer()
> which in turn calls parse_commit_buffer() and the entire callchain
> returns NULL.  commit_info->commit will become NULL in such a case.
> 
> With your code, lookup_commit() will store a non NULL in
> commit_info->commit, and parse_commit() calls parse_commit_buffer()
> and that would fail, so you clear commit->parents to NULL but fail
> to set commit_info->commit to NULL.
>
> Why not keep the parse_object() as-is and make sure we error out
> unless the result is a commit with a more explicit check, perhaps
> like this, instead?

lookup_commit actually returns NULL (via object_as_type) for objects
that are not commits, so I don't think the above is true. The code
below also loses the diagnostic message about the object not being a
commit.

>  reflog-walk.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/reflog-walk.c b/reflog-walk.c
> index 85b8a54..861d7c4 100644
> --- a/reflog-walk.c
> +++ b/reflog-walk.c
> @@ -221,6 +221,7 @@ void fake_reflog_parent(struct reflog_walk_info
> *info, struct commit *commit)
>  	struct commit_info *commit_info =
>  		get_commit_info(commit, &info->reflogs, 0);
>  	struct commit_reflog *commit_reflog;
> +	struct object *logobj;
>  	struct reflog_info *reflog;
>  
>  	info->last_commit_reflog = NULL;
> @@ -236,11 +237,13 @@ void fake_reflog_parent(struct reflog_walk_info
> *info, struct commit *commit)
>  	reflog = &commit_reflog->reflogs->items[commit_reflog
> ->recno];
>  	info->last_commit_reflog = commit_reflog;
>  	commit_reflog->recno--;
> -	commit_info->commit = (struct commit *)parse_object(reflog
> ->osha1);
> -	if (!commit_info->commit) {
> +	logobj = parse_object(reflog->osha1);
> +	if (!logobj || logobj->type != OBJ_COMMIT) {
> +		commit_info->commit = NULL;
>  		commit->parents = NULL;
>  		return;
>  	}
> +	commit_info->commit = (struct commit *)logobj;
>  
>  	commit->parents = xcalloc(1, sizeof(struct commit_list));
>  	commit->parents->item = commit_info->commit;
> 
> 
> > +test_expect_success 'reflog containing non-commit sha1s' '
> > +	git checkout -b broken-reflog &&
> > +	echo "$(git rev-parse HEAD^{tree}) $(git rev-parse HEAD)
> > abc <xyz> 0000000001 +0000" >> .git/logs/refs/heads/broken-reflog
> > &&
> > +	git reflog broken-reflog
> > +'
> > +
> 
> This will negatively affect the ongoing effort to abstract out the
> on-disk implementation of the reflog.  In some future installation
> of Git, the reflog may not even be in .git/logs/refs/whatever file.

I was following the style of the test above it, will fix.

> Use a non-branch ref, so that you can store any valid object not
> just commits, and use a Git command (e.g. "git update-ref" or "git
> tag") instead of the raw filesystem access to update it, perhaps
> like this?
> 
> 	git tag --create-reflog test-logs HEAD^ &&
> 	git tag -f test-logs HEAD^{tree} &&
> 	git tag -f test-logs HEAD &&
> 	git reflog test-logs

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
