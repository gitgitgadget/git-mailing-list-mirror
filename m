From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: How do I qualify paths in the .gitignore file w.r.t. the repo 
	root directory?
Date: Tue, 24 Feb 2009 17:14:42 -0800
Message-ID: <e38bce640902241714s720a4e23v49e0a4ab22da9bde@mail.gmail.com>
References: <e38bce640902232247t63a37f63x9f403fbda0744cfd@mail.gmail.com>
	 <7v1vtomhz1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 02:16:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc8Nu-0003LM-Eo
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 02:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221AbZBYBOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 20:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbZBYBOp
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 20:14:45 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:60331 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895AbZBYBOo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 20:14:44 -0500
Received: by gxk22 with SMTP id 22so7881842gxk.13
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 17:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xNS2r7a3d+qTjAt7P/hswyuftRh2fC51lf7iyJjE4ZY=;
        b=rq/zpUWFabsR1CV/puC69b6whPQAoCe8o7UB5bF8pA4f8xACNlOmnmofHHjY2MYIMq
         vLjokjdQWuzygI2x79Xy/UF04NuuyzrVwY0m9zjbGcHuaQp9Q6OBaGt3g7gLcu6kgnyE
         a1Zj526kluEHiBJwb6Hb8l/shcq1iatuowDcg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=x8Kn/Pj5hO3Wx8HwQLE01N2RskJZRcadIIWKZud+JS5mfx8LOBJ6vcszQwu9oqwASt
         DcI5km+mJ+yK48sE17lSZBe67lWviLpVTone+gDkLgKa8y3tdA7mbqFMeZBjfpXVNC72
         suU80w46or9sxvYZMXyuleY/MpmYB+NlT9Ykw=
Received: by 10.90.35.15 with SMTP id i15mr2533735agi.101.1235524482467; Tue, 
	24 Feb 2009 17:14:42 -0800 (PST)
In-Reply-To: <7v1vtomhz1.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111365>

Thanks James and Junio.  I'll try the leading slash. I assumed that
the beginning slash means what it means for other tools (meaning a
fully-qualified path to some file somewhere on the file system), but
apparently such is not the case with git (and I conclude from this
that it is actually not possible to store fully qualified paths
_unless_ the $GIT_DIR is right under the root filesystem).  This isn't
a problem for me, and probably not for most folks, but it was
confusing to me the way it was written in the man page.

Brent


On Mon, Feb 23, 2009 at 11:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Brent Goodrick <bgoodr@gmail.com> writes:
>
> > Say I have these files and directories [2]:
> >
> >   /home/smart_tator/misc_files/.gitignore
> >   /home/smart_tator/misc_files/foo/
> >   /home/smart_tator/misc_files/bar/
> >   /home/smart_tator/misc_files/bar/baz/foo/
> >   /home/smart_tator/misc_files/bar/baz/real/
> >
> > then I do:
> >
> >   cd /home/smart_tator/misc_files/; git init
> >
> > and say I have this line in that .gitignore file:
> >
> >   foo/
> >
> > And then I naively execute:
> >
> >   git add bar/
> >
> > then the bar/baz/real/ is added, but these are dutifully ignored:
> >
> >   /home/smart_tator/misc_files/foo/
> >   /home/smart_tator/misc_files/bar/baz/foo/
>
> I think you are looking for "/foo/".  From Documentation/gitignore.txt:
>
>  - If the pattern ends with a slash, it is removed for the
>   purpose of the following description, but it would only find
>   a match with a directory.  In other words, `foo/` will match a
>   directory `foo` and paths underneath it, but will not match a
>   regular file or a symbolic link `foo` (this is consistent
>   with the way how pathspec works in general in git).
>
> With this rule, (1) the trailing slash in your "foo/" tells git to match
> only with directories, but (2) it behaves as if you said "foo" for all the
> other rules.
>
> With "/foo/", you tell git to match only with a directory, and it is as if
> you said "/foo".
>
>  - If the pattern does not contain a slash '/', git treats it as
>   a shell glob pattern and checks for a match against the
>   pathname without leading directories.
>
> Your "foo/" now behaves the same way as "foo" behaves.  You are telling
> git to match directory foo anywhere in the tree.  "/foo/" (now behaving
> the same way as "/foo") does not satisfy this criteria so we would skip
> this rule.
>
>  - Otherwise, git treats the pattern as a shell glob suitable
>   for consumption by fnmatch(3) with the FNM_PATHNAME flag:
>   wildcards in the pattern will not match a / in the pathname.
>   For example, "Documentation/\*.html" matches
>   "Documentation/git.html" but not
>   "Documentation/ppc/ppc.html".  A leading slash matches the
>   beginning of the pathname; for example, "/*.c" matches
>   "cat-file.c" but not "mozilla-sha1/sha1.c".
>
> Your "foo/" does not survive to this rule, but "/foo/" does.  It now
> behaves as "/foo" and its leading slash makes it match the beginning.
