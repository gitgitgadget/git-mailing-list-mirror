From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [BUG?] Fresh clone of jquery.git shows modifications?
Date: Wed, 18 Aug 2010 15:14:14 +0100
Message-ID: <1282140854.24584.112.camel@wpalmer.simply-domain>
References: <1282135226.24584.92.camel@wpalmer.simply-domain>
	 <2F030CF4-995A-4BA2-9D79-DA2A71F9FF79@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 16:14:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OljPR-0003qs-T3
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 16:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091Ab0HROOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 10:14:21 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52991 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934Ab0HROOU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 10:14:20 -0400
Received: by ewy23 with SMTP id 23so371913ewy.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 07:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=+rBcaYcFECemUvhfF1mZPHwtij3CoI9817TVN2UtSjQ=;
        b=pTXvuaNJ7u0Be0PRz1L9KydbKqArlHIx9hhboUCh4SgzdDSbT67MNTPH68Y5EQAVt7
         kKeSzw/yg2ckyvqL/FsQB1PYpHlF543rmfAiijLQRZ5nLDuW7Ddr9BA2yvkijqEBmnaS
         sjfpKnBr/OeztCsuTh4an9CjFmaRzqCQ6bfDM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=J+k/y9QiXB7/Ot3mRHHSj9QDvErtrfL9bXEO3tNJ7kBC4WVdk78dvYRChMwGBBZYol
         3Kf4Hn4bjTzqBNMPMiJCQpdtgGAivznQrUYNCeYRBKKCIJBh/N/93F6sRwFgk3OXFvkM
         D4QygHFU68TfdcGabQOcp/zzZXevmmkTvFbDA=
Received: by 10.216.178.130 with SMTP id f2mr7002127wem.101.1282140858767;
        Wed, 18 Aug 2010 07:14:18 -0700 (PDT)
Received: from [192.168.2.64] ([193.164.118.24])
        by mx.google.com with ESMTPS id r18sm224793weo.24.2010.08.18.07.14.16
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 07:14:17 -0700 (PDT)
In-Reply-To: <2F030CF4-995A-4BA2-9D79-DA2A71F9FF79@gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153857>

On Wed, 2010-08-18 at 15:18 +0200, Eyvind Bernhardsen wrote:
> On 18. aug. 2010, at 14.40, Will Palmer wrote:
> 
> > I am on Linux, and core.autocrlf is not set. .gitattributes in the
> > JQuery repository contains:
> > * crlf=input
> 
> That's a strange setting; in older versions of git, it means something like "if core.autocrlf is enabled, only convert CRLF on input"; that is, it effectively turns core.autocrlf=true into core.autocrlf=input.  I'm not sure why anybody would want that.
> 
> In any case, it doesn't appear to have prevented CRLFs from entering the repository, which is what's causing the behaviour you see.

I don't know when the .gitattributes file was added, surely git should
account for varied settings over time, especially when the meanings of
those settings have changed over time? Something like "only apply when
there are other changes to this file", or only when the newline-status
of the file itself has otherwise changed, for that matter.

> 
> > Bisect reveals:
> > fd6cce9e89ab5ac1125a3b5f5611048ad22379e7  v1.7.0-3-gfd6cce9
> > Add per-repository eol normalization
> > 
> > is the first git commit which shows this problem.
> 
> That's because from that commit, "crlf=input" turns on autocrlf implicitly (it is equivalent to "eol=lf").  Previously, the crlf attribute would only have an effect with core.autocrlf turned on.
> 
> > I am confused as to why I am seeing what I am seeing, though. I was
> > under the impression that "crlf=input" meant: "convert crlf to lf on
> > input", which I would take to mean that it would never have any effect
> > whatsoever on "git status"'s output.
> 
> Files containing CRLFs in your repository keep the CRLFs in the working tree.  If you check them in now git will convert CRLF to LF, so they are marked as modified.

So how do I tell git that I don't want those files to be modified? How
do I tell git "discard all local changes, even those which some random
file has asked you to make"?

>  
> > If I clone using a version of git before v1.7.0-3-gfd6cce9, then "git
> > status" from a newer git, then everything also appears to work normally
> > (though I haven't dug much into this aspect)
> 
> If you turn on core.autocrlf=input or core.autocrlf=true you should get the same behaviour with older gits as well.  Note that msysgit has had autocrlf enabled by default for years, so no positive action is required to do this.

This was one of the first things I tried, but with no luck. Perhaps
there is some extra step involved to tell git "update the working copy
using the new setting"? I have tried both git checkout --force HEAD, and
git reset --hard HEAD, but neither seem to have an effect.

> 
> > Is there a git option for "just give me what's in the repository, don't
> > ever perform any conversions, one way or the other, just act sane" ?
> 
> Not with that .gitattributes :)  If you don't want conversion, don't set the crlf, eol or text attributes.

How about an "ignore .gitattributes" option? Or a "use
alternative .gitattributes" option? This is not my repository. I don't
have control over what's in it, and while I expect I'll be maintaining a
local patchset, I don't really want to maintain patches of the "my git
is more-broken than the upstream's git" variety.

> 
> > I thought I had finally understood all this autocrlf nonsense, but once
> > again I see this as being only an "act stupid mode". I have no idea
> > what's going on here, and I just want to be able to rely on the
> > following:
> > - git clone someproj.git && cd someproj && git status;
> >   should NEVER report changes
> > - git reset --hard HEAD && git status;
> >   should NEVER report changes
> > 
> > and, why I ran into this situation this time around:
> > - git clone someproj.git && cd someproj && git checkout sometag;
> >   should ALWAYS work
> > 
> > Can anyone explain why these aren't valid assertions? If they're not,
> > then what is the proper way to tell git "give me a real pristine copy"?
> 
> Git _is_ giving you a real pristine copy, it's just informing you that your repository is not consistent with the attributes you have set.

"pristine" to me means "no changes". If there is an inconsistency which
git doesn't like, git should complain about that, refuse to checkout,
declare "broken repository! Oh no!" and refuse all operations, etc. It
git can determine that it is unable to act in a sane manner, I don't
want git to just go ahead making wild guesses.

> 
> > Below is a log of the problem in-action.
> 
> [...]
> 
> > #	modified:   build/google-compiler-20091218.jar
> > #	modified:   build/js.jar
> 
> Heh.  I was about to ask if there was anything funny about these presumably binary files, but then I realized that .gitattributes is forcing crlf=input for _all_ files.  I suggest removing the crlf setting from .gitattributes.

Just to re-state: This is not "my repository". That is, I don't consider
it to be. So I would prefer only solutions which involve editing
something unversioned, such as .git/config, rather than making random
patches which feel very much like work-arounds to a git problem.

If it were "my repository", and there were some problem like this, then
I would probably use filter-branch to remove the error from history.

> 
> - Eyvind

- Will
