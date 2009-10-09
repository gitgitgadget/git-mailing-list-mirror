From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: can't create a branch on remote
Date: Fri, 9 Oct 2009 23:54:36 +0200
Message-ID: <20091009215436.GA21017@atjola.homenet>
References: <17cb70ee0910091435l4c4d1736hf4d403a2fe6331a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Auguste Mome <augustmome@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 23:57:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwNT0-0000zk-PQ
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 23:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934555AbZJIVzb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Oct 2009 17:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934553AbZJIVza
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 17:55:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:54776 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934509AbZJIVz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 17:55:27 -0400
Received: (qmail invoked by alias); 09 Oct 2009 21:54:39 -0000
Received: from i59F571D9.versanet.de (EHLO atjola.homenet) [89.245.113.217]
  by mail.gmx.net (mp006) with SMTP; 09 Oct 2009 23:54:39 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18S2gx2yiYSDuwjBXb5SymLw1LkKXqRcEYkO/cDjM
	gCldpfePAXIs8z
Content-Disposition: inline
In-Reply-To: <17cb70ee0910091435l4c4d1736hf4d403a2fe6331a2@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129849>

On 2009.10.09 23:35:03 +0200, Auguste Mome wrote:
> # git branch mylocal26217=A0 v2.6.21.7

This automatically peels the v2.6.21.7 tag to get the commit object, an=
d
creates the new branch head, referencing that commit.

> # git push /home/user/dev/git/linux-2.6
> =A0=A0=A0 v2.6.21.7:refs/heads/new_feature_name26217
> Total 0 (delta 0), reused 0 (delta 0)
> error: Trying to write non-commit object
> 170684ef0557d4b711a86595d31dcbebcb9d4ba2 to branch
> refs/heads/new_feature_name26217

This didn't peel the tag, because you might actually want the remote re=
f
to reference the tag, not the commit referenced by the tag. So you trie=
d
to create a branch head that would reference a tag, and that is not
allowed. To peel the tag you can use:
v2.6.21.7^0
v2.6.21.7^{commit}
v2.6.21.7^{}

The first two ensure that you actually get a commit object or an error,
the last one just peels the tag until it finds a non-tag object.

So:
git push /home/user/dev/git/linux-2.6 \
	v2.6.21.7^0:refs/heads/new_feature_name26217

should do the trick.

Though I don't see why you would create a branch like that. Usually, I'=
d
expect you to create new_feature_name26217 locally, work on it, and the=
n
just push that branch head, instead of creating that rather pointless
branch head remotely.

Bj=F6rn
