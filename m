From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: More Beginning Git Questions
Date: Fri, 23 Sep 2011 10:42:18 -0700 (PDT)
Message-ID: <m3ipojqhpm.fsf@localhost.localdomain>
References: <4E7C9AAD.7060209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jon Forrest <nobozo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 19:42:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R79lf-0007qf-KC
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 19:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206Ab1IWRm3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Sep 2011 13:42:29 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45331 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab1IWRmT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2011 13:42:19 -0400
Received: by mail-fx0-f46.google.com with SMTP id 4so4036972fxe.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=eiJ1W0Ni81N5ZYf3zg87anHt06ATSh8O1vu/M7QgAhM=;
        b=B4RJzLKuJ9tm0knyg7YEYQ1LCiRsML59lrmuvyiBkzVIUWFJVPRAX7EkIv96vxo8nq
         7HVgdYH7v86Eio/4+Q9vcGqN9UNdYT0Qzm+zHnQrw7ubsh0Jxd/cQmWO3EkChVkWXHTx
         1zUnbM7fbm9aCAylM7afTzVQluBl449L/7oJQ=
Received: by 10.223.64.66 with SMTP id d2mr5327005fai.116.1316799739065;
        Fri, 23 Sep 2011 10:42:19 -0700 (PDT)
Received: from localhost.localdomain (abwe70.neoplus.adsl.tpnet.pl. [83.8.228.70])
        by mx.google.com with ESMTPS id b10sm11790234fam.1.2011.09.23.10.42.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Sep 2011 10:42:18 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8NHfqi1026397;
	Fri, 23 Sep 2011 19:42:02 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8NHfgoN026393;
	Fri, 23 Sep 2011 19:41:42 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4E7C9AAD.7060209@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181979>

Jon Forrest <nobozo@gmail.com> writes:

> I'm reading the git tutorial at
> http://schacon.github.com/git/gittutorial.html

I recommend reading "Pro Git" book (http://progit.org)

> I'm a very literal reader so if something isn't clear
> to me, I try to make the effort to understand it.
>=20
> In reading about what happens when Alice pulls from Bob,
> it says:
>=20
> "Note that in general, Alice would want her local changes committed
> before initiating this "pull"."
>=20
> This is an interesting statement. I'll come back to it shortly.
>=20
> "If Bob=C2=92s work conflicts with what Alice did since their histori=
es forked,"
>=20
> Does this include both changes that Alice has checked in to
> her repository and uncommitted changes in her working tree?

Generally Alice shouldn't have uncommitted changes when doing
"git pull".

> "Alice will use her working tree and the index to resolve conflicts,"
>=20
> How does Alice use her working tree and index? Does this mean
> she makes changes to her working tree so that the conflicts
> no longer exist? How does the index play a part in this?
> I thought that the index gets populated only when a
> "git add" is done. Does Alice need to do "git add" as part
> of the conflict resolution process?

This is actually a very important information.

When there is a merge conflicts, the index gets populated by more than
one version: "ours" (i.e. Alice version) in stage 2, "theirs"
(i.e. Bob version) in stage 3, and "base" (common ancestor version) in
stage 1.  The stage 0, where "git add" / "git stage" puts contents of
file, is empty.

You can see it using "git ls-files --abbrev --stage".
=20
The working area gets populated with version that contains both "ours"
and "theirs" hunks using conflict markers (the 3-way textual merge,
like 'rcsmerge' or 'diff3 -E' does).  Sidenote: you can use "git
checkout --conflict=3Dmerge <file>" to re-create this version if you
messed up conflict resolution, or even --conflict=3Ddiff3 if you want
"base" (ancestor) version to be shown in conflict markers as
well... but this would discard your changes.

After resolving conflict you do "git add" on resolved file to mark it
as done.  This leaves you with only newly add-ed stage 0 in the index!

The pre-commit hook might check if you didn't accidentally marked as
resolved (added) file with [something that looks like] conflict
markers in it.

HTH
--=20
Jakub Nar=C4=99bski
