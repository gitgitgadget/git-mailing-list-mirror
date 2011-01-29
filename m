From: David Aguilar <davvid@gmail.com>
Subject: Re: Project- vs. Package-Level Branching in Git
Date: Sat, 29 Jan 2011 15:28:50 -0800
Message-ID: <20110129232848.GC7676@gmail.com>
References: <14F4737F-E8E4-4E4E-A625-16CA63CF9EFF@shaggyfrog.com>
 <AANLkTinTRgzv0s9MTyM4TaOwVOmhwRckDqMfxrbsKVfm@mail.gmail.com>
 <15B7CA2E-C584-4563-B9E3-D80861CD9565@shaggyfrog.com>
 <m3tygt9xmn.fsf@localhost.localdomain>
 <20110129194258.GE602@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Enrico Weigelt <weigelt@metux.de>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Thomas Hauk <tom@shaggyfrog.com>
X-From: git-owner@vger.kernel.org Sun Jan 30 00:24:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjKA4-00029T-Ff
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 00:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416Ab1A2XYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jan 2011 18:24:47 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39060 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab1A2XYq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jan 2011 18:24:46 -0500
Received: by iwn9 with SMTP id 9so4250709iwn.19
        for <git@vger.kernel.org>; Sat, 29 Jan 2011 15:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=n44xYZ1LAQ4a/L8N7VUGsimDn8bh83Ol7OtxSJcp2ps=;
        b=ZnilstDpecxL7BuH9ILPlhfwW/THC85oR2eiXOhoYe0WvWvbxMKUdVoT4Pi8uGr3zY
         o4E0mOlyGyPjeWW2BSIWIvwTuJM8TvWjFVwKv9YMfVF6olDsxNCO00MBIuY0JYRGN21R
         gLT6d4JOJJttnq3vDPQivrX6ERAiPu6AGlex8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AwSNKlpZSmKQXWWn6BSSbvWcNQHWx97WTl3c/9D4YE9B0JbJzyMji0MNiKM6TXLW/F
         5hgDjnPBaH7a4MeOygegDUqCGms1pX5m+Gfs6opnYVs9dBp7Q+c2PR+u9JHvTJOf9BiL
         2SIjqaQpfkgZmENEXq2TXB7FKwM/y/lC71680=
Received: by 10.42.178.135 with SMTP id bm7mr5858947icb.101.1296343486273;
        Sat, 29 Jan 2011 15:24:46 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id i16sm16246614ibl.12.2011.01.29.15.24.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 Jan 2011 15:24:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110129194258.GE602@nibiru.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165675>

On Sat, Jan 29, 2011 at 08:42:59PM +0100, Enrico Weigelt wrote:
> * Jakub Narebski <jnareb@gmail.com> wrote:
> 
> > That is only if lib{a,b,c} is _internal_ dependency.  In usual case
> > project A might depend on library B *to be installed*, but it doesn't
> > mean that source code of library B has to be in repository for project
> > A.  And in usual case when project A depends on library B, it relies
> > on library B public stable API (its build system might check if you
> > have new enough library B installed).  If you depend on specific
> > version of library, patched, that is your problem...
> 
> To make it more clear: 
> 
> At buildtime, a _package_ (not project!) "A" requires a already built
> and installed package B in some sane place where the toolchain can find it.
> On deployment of package "A", it has to be made sure that package "B"
> is also deployed (eg. by a dependency-handling package manager).
> 
> These are two entirely separate stages in a software's lifecycle.
> Buildtime and deployment dependencies may be different (even deployment
> and runtime deps may differ).

This is exactly how we do it at my workplace.  We have literally
hundreds of individual git repositories.  Naturally, some
packages depend on others and the only "trick" is building them
in the correct dependency order.  A simple dependency tree
handles this for us.

We use same-named branches across several repos when coordinating
features across many projects.  e.g. we had an "el6" branch
when we were gettings things ready for that platform.  It's a
convention but it helps when writing helper scripts.

We can clone and work on any subset of the entire tree by
cloning just the repos we are interested in.  Setting
$LD_LIBRARY_PATH and $PATH helps when testing builds in their
sandboxes.  You still need to get the compiler/linker to
construct paths into the sandboxes instead of the standard
release area.

This is what the pkg-config command does.  It respects the
$PKG_CONFIG_PATH environment variable which can be used to
point to staged installs so that you don't have to deploy the
package before building against it.  The idea is so simple
that you could write an equivalent command in an afternoon and
extend it to work however you need in the event that pkg-config
does not fit.

There's only two components that are needed to make this work:

1. a simple shell wrapper to aid in setting the env. variables
   on the fly.  Let's call it "devo".  That way you can say
   "devo foo bar baz" and it'll put
   foo/linux-x64/lib64/pkgconfig and bar/linux-x64/lib64/pkgconfig
   (assuming linux-x64 is the "make install"ed path)
   at the front of the PKG_CONFIG_PATH, foo/linux-x86/bin in PATH,
   etc.

   You can do without a wrapper by either setting the variables
   manually or by having a shell scriplet that you 'source'
   whenever you want the settings.

2. the build must use the pkg-config command when constructing
   include/library paths.

As I mentioned, perhaps you don't want to use pkg-config.
The idea ("overridable projects using a single env. variable")
is the important part.  You can certainly write something
tailored to your needs if you want something simpler.
-- 
		David
