From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 01/33] setup: call setup_git_directory_gently before
 accessing refs
Date: Tue, 01 Mar 2016 18:47:52 -0500
Organization: Twitter
Message-ID: <1456876072.5981.5.camel@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
	 <1456793586-22082-2-git-send-email-dturner@twopensource.com>
	 <20160301083535.GA4952@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 02 00:48:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aau1a-0003ok-9G
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 00:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753781AbcCAXr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 18:47:57 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34286 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739AbcCAXry (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 18:47:54 -0500
Received: by mail-qk0-f175.google.com with SMTP id x1so76291774qkc.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 15:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Azycp4BBdqcL3sxPKwBNOGQjlmV8yxeij582PRxLzC4=;
        b=yUu0tw1Uz/uKHivMgpLk0OGFTI7mTEkcRBLK1A9ef8UZ/FOoEJsYYjBiOOq8qHV18c
         03fOzT2AZlTsIVfUIay+bo+ZQiPhYPKrO1cfaZ8Q3RSIOQ1xj/W+AiV1c5MfjXBVSeGl
         4Hg/JPFx0HabZGFOPiuH3jm/4sOcQaUjmBkRVqmy0jOcB8gQmc1cb7TLiBW7b5RRTIIm
         5efRzA0GD8J1VE1YdYVuGpArSfc75yKYApTT7lWqr7n14fM/m3B5QZC7pOmTKXNmMfto
         QoTzA+SBamZDuxhduxnl3qUXwEF9YBvjRShFQQNUwNkWWCxvBLNRA42nwz6bqo1jAgPR
         iWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Azycp4BBdqcL3sxPKwBNOGQjlmV8yxeij582PRxLzC4=;
        b=YBZtA4BT39zHnvdR0+Lm4dL6zHELy/nM7OYXa4ywV8/PMkrQTfJKgsCXxSOSbjrzzB
         Riv3h/5w0AHI3Es/KwYwPhir9w6/H846JB8PjBpYG77SKG8LWfs/vpZTRLumSAL/+YV4
         rIlM77e71hlKyMGAKy4CBTHB7t5i0Z0/qFxQ8ImUyYNiB4X+HUy5n6zhN20T59fLUAJR
         3cW13+u9OeEz9aMPYWzu2Lf+x0wAX60zLFxeo5+9XXa0jxCK3c++1QuEeBPF1q8k+9/x
         A1K2MvkiJDnJSq5ugpBOeuc1zN15apZhgnpOAVRKmblk+bL4hrEMrx1zCt4r9v96RFC5
         htIw==
X-Gm-Message-State: AD7BkJJk6T9cBQTTgSkUbESvrqyMPF+9SA61/eLPv0Vls01FC57ief5e1ZRgHNWpVjKzPA==
X-Received: by 10.55.79.17 with SMTP id d17mr29523671qkb.56.1456876073925;
        Tue, 01 Mar 2016 15:47:53 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id n15sm1270799qhc.6.2016.03.01.15.47.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Mar 2016 15:47:53 -0800 (PST)
In-Reply-To: <20160301083535.GA4952@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288082>

On Tue, 2016-03-01 at 03:35 -0500, Jeff King wrote:
> On Mon, Feb 29, 2016 at 07:52:34PM -0500, David Turner wrote:
> 
> > Usually, git calls some form of setup_git_directory at startup. 
> >  But
> > sometimes, it doesn't.  Usually, that's OK because it's not really
> > using the repository.  But in some cases, it is using the repo.  In
> > those cases, either setup_git_directory_gently must be called, or
> > the
> > repository (e.g. the refs) must not be accessed.
> 
> It's actually not just setup_git_directory(). We can also use
> check_repository_format(), which is used by enter_repo() (and hence
> by
> things like upload-pack). I think the rule really ought to be: if we
> didn't have check_repository_format_gently() tell us we have a valid
> repo, we should not access any repo elements (refs, objects, etc).

I'll change that commit message to say
"check_repository_format_gently".

> > diff --git a/builtin/grep.c b/builtin/grep.
> [snip: this is a probably-good behavior change]

Agreed.

> My fix for this was to teach read_mailmap to avoid looking for
> HEAD:.mailmap if we are not in a repository, but to continue with the
> others (.mailmap in the cwd, and the mailmap.file config variable).
> ...
> But I do think your patch is a potential regression there, if anybody
> does do that.

Your version sounds better.  But I don't see it in the patch set you
sent earlier? 

> > diff --git a/git.c b/git.c
> > index 6cc0c07..51e0508 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -376,7 +376,7 @@ static struct cmd_struct commands[] = {
> >  	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
> >  	{ "annotate", cmd_annotate, RUN_SETUP },
> >  	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
> > -	{ "archive", cmd_archive },
> > +	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
> >  	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
> >  	{ "blame", cmd_blame, RUN_SETUP },
> >  	{ "branch", cmd_branch, RUN_SETUP },
> 
> I didn't have to touch this case in my experimenting. I wonder if
> it's
> because I resolved the "grep" case a little differently.
>
> I taught get_ref_cache() to only assert() that we have a repository
> when
> we are looking at the main ref-cache, not a submodule. In theory, we
> can
> look at a submodule from inside an outer non-repo (it's not really a
> submodule then, but just a plain git dir). I don't think there's
> anything in git right now that says you can't do so, though I think
> your
> refs-backend work does introduce that restriction (because it
> actually
> requires the submodules to use the same backend).
> 
> So with that requirement, I think we do need to require a repo even
> to
> access submodule refs. Is that what triggered this change?

No.  What triggered this change was a test failure with your earlier
patch on master -- none of my stuff at all.  The failing command was:

git archive --remote=. HEAD

When writing my patch, I had assumed that the issue was the resolve_ref
on the HEAD that's an argument -- but it's not.  The actual traceback
is:

#0  die (
    err=err@entry=0x57ddb0 "BUG: resolve_ref called without
initializing repo") at usage.c:99
#1  0x00000000004f7ed9 in resolve_ref_1 (sb_refname=0x7c4a50
<sb_refname>, 
    sb_contents=0x7fffffffcfc0, sb_path=0x7fffffffcfe0,
flags=0x7fffffffdaaa, 
    sha1=0x7fffffffd100 "\b\326\377\377\377\177",
resolve_flags=5572384, 
    refname=0x2 <error: Cannot access memory at address 0x2>)
    at refs/files-backend.c:1429
#2  resolve_ref_unsafe (refname=refname@entry=0x550b3b "HEAD", 
    resolve_flags=resolve_flags@entry=0, 
    sha1=sha1@entry=0x7fffffffd100 "\b\326\377\377\377\177", 
    flags=flags@entry=0x7fffffffd0fc) at refs/files-backend.c:1600
#3  0x00000000004ffe69 in read_config () at remote.c:471
#4  0x0000000000500235 in read_config () at remote.c:705
#5  remote_get_1 (name=0x7fffffffdaaa ".", 
    get_default=get_default@entry=0x4fe230 <remote_for_branch>)
    at remote.c:688
#6  0x00000000005004ca in remote_get (name=<optimized out>) at
remote.c:713
#7  0x00000000004159d8 in run_remote_archiver (name_hint=0x0, 
    exec=0x550720 "git-upload-archive", remote=<optimized out>, 
    argv=0x7fffffffd608, argc=2) at builtin/archive.c:35
#8  cmd_archive (argc=2, argv=0x7fffffffd608, prefix=0x0)
    at builtin/archive.c:104
#9  0x0000000000406051 in run_builtin (argv=0x7fffffffd608, argc=3, 
    p=0x7bd7a0 <commands+96>) at git.c:357
#10 handle_builtin (argc=3, argv=0x7fffffffd608) at git.c:540
#11 0x000000000040519a in main (argc=3, av=<optimized out>) at
git.c:671

> I'd think you would need a matching line inside cmd_archive, too. It
> should allow "--remote" without a repo, but generating a local
> archive
> does need one.  And indeed, I see in write_archive() that we run
> setup_git_repository ourselves, and die if we're not in a git repo.
> So
> I'm puzzled about which code path accesses the refs.

I agree that  --remote should work without a repo,  It seems that we do
n't test this and we probably should.  

I'm not sure what the right way to fix this is -- in read_config, we're
about to access some stuff in a repo (config, HEAD).  It's OK to skip
that stuff if we're not in a repo, but we don't want to run
setup_git_directory twice (that breaks some stuff), and some of the
other callers have already called it.  On top of your earlier
repo_initialized patch, we could add the following to read_config:

+       if (!repo_initialized) {
+               int nongit = 0;
+               setup_git_directory_gently(&nongit);
+               if (nongit)
+                       return;
+       }

But that patch I think was not intended to be permanent.  Still, it
does seem odd that there's no straightforward way to know if the repo
is initialized. Am I missing something? 

> > diff --git a/test-match-trees.c b/test-match-trees.c
> But your patch here is certainly the right thing to do if we are 
> keeping it.

Let's keep it for now; we could always remove it later.
