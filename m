From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: How to fork a file (git cp ?)
Date: Wed, 4 May 2011 22:36:39 +0200
Message-ID: <BANLkTinEb5BmR_Ls8YtGxyqGSVVBcnG32A@mail.gmail.com>
References: <4DC1934D.6070608@aldan.algebra.com>
	<4DC19955.7040503@kdbg.org>
	<4DC1A64C.4090508@aldan.algebra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: "Mikhail T." <mi+thun@aldan.algebra.com>
X-From: git-owner@vger.kernel.org Wed May 04 22:36:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHioP-0000Nh-9Z
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 22:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142Ab1EDUgk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2011 16:36:40 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60481 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab1EDUgj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2011 16:36:39 -0400
Received: by pzk9 with SMTP id 9so662367pzk.19
        for <git@vger.kernel.org>; Wed, 04 May 2011 13:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dmdnPkdCd1q8IdRp+P0BeCGLOZFaPe2sJXeY1vAhIeA=;
        b=XX0jGRjnJqO6QSWMF1T5geZB50++ztRHoxK9nSurRuUCnIM7TSSyJcOpzrxPSsLY4x
         +EJ7bZcivAVa5DC1+2YklYEk2DbQm+Y1qyY+CJkE6nw1iyOj6ROTTD920srA6M5wpgpo
         cjU09fHbIXGrvlABFQK+yCPcWxzBb+dByjoO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=H0PC8Ba50QGKpddz+0LY83Akk14ooq31fVlPcESqaJnXd1VUlICTmjeL4OMsiVFn/k
         jzRxI/J+oySeSojqYb9AT96ae4I8kA/TlCQr/wKzOYW1mmafyJNSPf+HzxKYXCL7wr7Z
         gn/IcuhQTSxoe07N+UCqqSqWuDztXK/ssAzk4=
Received: by 10.142.1.17 with SMTP id 17mr818579wfa.88.1304541399215; Wed, 04
 May 2011 13:36:39 -0700 (PDT)
Received: by 10.142.192.8 with HTTP; Wed, 4 May 2011 13:36:39 -0700 (PDT)
In-Reply-To: <4DC1A64C.4090508@aldan.algebra.com>
X-Google-Sender-Auth: lS9MV9s5R3Un63mZrN95RZjuPGw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172767>

On 4 May 2011 21:17, Mikhail T. <mi+thun@aldan.algebra.com> wrote:
> On 04.05.2011 14:22, Johannes Sixt wrote:
> >
> > You just cp the file and git add it. But you will not be able to
> > follow a history of the file.
>
> Thank you for the information...
>
> So, is this something worth adding to the wishlist, or was it omitted
> on purpose (and which purpose was that, then)?

Oh yes, that was intentional. This is easily one of the most debated
"features" of Git, especially in the early days of Git when almost all
SCM systems did it "the CVS way", by tracking the history of single
files. Instead, Git tracks snapshots of the whole tree and focuses on
the whole content instead of single files. Renames are tracked by
detecting removal/adding of files, which can be detected later, for
example using "git log --follow". The reason for this is mostly speed
issues, and most of the time the history of a single file is not
interesting in a project, but changes in the file tree as a whole.

=46rom the FAQ at <https://git.wiki.kernel.org/index.php/GitFaq>:

  Git has to interoperate with a lot of different workflows, for exampl=
e
  some changes can come from patches, where rename information may not
  be available. Relying on explicit rename tracking makes it impossible
  to merge two trees that have done exactly the same thing, except one
  did it as a patch (create/delete) and one did it using some other
  heuristic.

  On a second note, tracking renames is really just a special case of
  tracking how content moves in the tree. In some cases, you may instea=
d
  be interested in querying when a function was added or moved to a
  different file. By only relying on the ability to recreate this
  information when needed, Git aims to provide a more flexible way to
  track how your tree is changing.

  However, this does not mean that Git has no support for renames. The
  diff machinery in Git has support for automatically detecting renames=
,
  this is turned on by the '-M' switch to the git-diff-* family of
  commands. The rename detection machinery is used by git-log(1) and
  git-whatchanged(1), so for example, 'git log -M' will give the commit
  history with rename information. Git also supports a limited form of
  merging across renames. The two tools for assigning blame,
  git-blame(1) and git-annotate(1) both use the automatic rename
  detection code to track renames.

  As a very special case, 'git log' version 1.5.3 and later has
  '--follow' option that allows you to follow renames when given a
  single path.

  Git has a rename command git mv, but that is just for convenience. Th=
e
  effect is indistinguishable from removing the file and adding another
  with different name and the same content.

This mail from Linus explains the issue in more detail and colour:
<http://permalink.gmane.org/gmane.comp.version-control.git/217>.

Regards,
=C3=98yvind
