From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: help with distributed workflow/signoff
Date: Wed, 14 Jul 2010 12:16:14 -0500
Message-ID: <20100714171614.GA2799@burratino>
References: <loom.20100714T180615-173@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brock Peabody <brock.peabody@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 19:17:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ5a7-0002Nj-Jt
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 19:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681Ab0GNRRJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 13:17:09 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:41435 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565Ab0GNRRI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 13:17:08 -0400
Received: by ewy23 with SMTP id 23so1467114ewy.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 10:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=feOFj4zPr0bJybZr4OANlK85ln43B5bEYtT2ZyhqIcg=;
        b=ol+U/xJcW/9KGj+/lJ2yQi6Oym8pSvb2wgbB9zyau2WUWcQQ/NI/E0j82wvHp0Dn3Q
         I6BYjmMjKQ/S06V+3JWKXraPcqMY538EnL/eLw+1F7Pcp8WQXI5BKSKb30vXIpSPNMas
         cLTGS6qmv1QlM0ogSc9w1/mGy8JfYvVsSB+RA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=iDI5hd1LQa1YqpHTlmnMuXdLfXwyCk61cadBc72+EhwRhrF7ICmQQWcaFxi+uX9WSj
         xxj4azfYuxznvpZvRN4bHY6KDq/DfkhjjGvHZX24Xz28UjM3m8uNDo0z7lXDxPTvmjoL
         rF5rYRJDL/85KO21+1hqF8j/m3GiRBbnL6zU4=
Received: by 10.213.29.17 with SMTP id o17mr4668750ebc.8.1279127825669;
        Wed, 14 Jul 2010 10:17:05 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v59sm58873042eeh.4.2010.07.14.10.17.03
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 Jul 2010 10:17:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20100714T180615-173@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151015>

Hi Brock,

Brock Peabody wrote:

> Developers wishing to contribute code would push revisions to the gat=
ekeepers'
> repos, who after reviewing the revisions would push them to the Maste=
r
> repository, from which developers would have only pull access.
[...]
> This works fine, except for the fact that there is no trail in the ma=
ster
> repository indicating which GateKeeper approved which revision.
[...]
> I've seen evidence of what we're after - by browsing the repository o=
f git
> itself.  Each revision in it contains an "Author" field and a (freque=
ntly
> different) "Committer" field.  Furthermore, there are often multiple
> "Signed-off-by" and "Acked by" logs.  How are these fields populated?

In the Linux kernel and similar projects, there is a sharp distinction
between patch authors and committers[1].  The life cycle of a patch is
something like this:

A patch is written and a rough version is mailed to interested parties.
=E2=80=98git format-patch=E2=80=99 or =E2=80=98git request-pull=E2=80=99=
 can be useful for this.

The patch is discussed.  Subsystem maintainers, reviewers, testers,
and others try out the patch and form an opinion on whether it is
=E2=80=9Ccooked=E2=80=9D or needs more improvements.  Some of these peo=
ple (including
the original author) might suggest improved versions of the patch;
each person doing so adds her name to the bottom of the Signed-off-by
list to indicate that to the best of her knowledge the updated patch
is not proprietary but is suitable for inclusion in the project.

At a certain point, the patch is ready.  A committer applies it,
adding appropriate Acked-by etc headers to summarize the discussion
for reference when the code breaks :).  =E2=80=98git am -s=E2=80=99 can=
 take care of
adding the sign-off in this case.

The trajectory of the patch afterwards can be tracked through merges.
The commit passes through a hierarchy of maintainers, usually with
the help of =E2=80=98git request-pull=E2=80=99.  There is no need to re=
certify
origin at this point, since the commit object is already set in
stone.

-----

Wait a second.  The patch is never in a git tree until it is fully
cooked?

Well, no, as long as it is made clear, it is perfectly fine to publish
a patch as a commit before it is cooked.  But the relevant git
branches at this point are just a distribution medium, and those
commits are not meant to be pulled by anyone upstream.  Once the
patches seem cooked, a person can _propose_ a branch to be pulled.  If
that branch is completely broken, it is back to the drawing board, and
a new branch is made, usually with the help of =E2=80=98git rebase
--interactive=E2=80=99, or =E2=80=98git reset=E2=80=99 followed by =E2=80=
=98git add --patch=E2=80=99.

-----

Why not keep the false starts?  Why such concern with history?

To get maximum utility out of =E2=80=98git bisect=E2=80=99, it is best =
if each commit
builds cleanly and the result is not too broken.

To get maximum utility out of =E2=80=98git log --grep=E2=80=99 and =E2=80=
=98git log -S=E2=80=99, it
is best if the commit log clearly and logically explains the design
of the current code.

Probably only some of these concerns will apply in your case, but
I thought I should explain the story as well as I could.

Hope that helps,
Jonathan

[1] I am thinking in particular of this message as I write:
http://thread.gmane.org/gmane.comp.video.dri.devel/34739/focus=3D34744
