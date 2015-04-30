From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Thu, 30 Apr 2015 10:10:21 +0200
Message-ID: <5541E36D.1010606@alum.mit.edu>
References: <1430341032.14907.9.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 30 10:11:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnjZ1-0007d1-0N
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 10:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbbD3ILO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 04:11:14 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:48873 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751013AbbD3IK0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2015 04:10:26 -0400
X-AuditID: 1207440c-f79376d00000680a-6f-5541e36f64c1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 27.D6.26634.F63E1455; Thu, 30 Apr 2015 04:10:23 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97A01.dip0.t-ipconnect.de [79.201.122.1])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3U8AL1w026607
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 30 Apr 2015 04:10:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1430341032.14907.9.camel@ubuntu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqJv/2DHUYPMFaYv5m04wWnRd6WZy
	YPJY8Pw+u8fnTXIBTFHcNkmJJWXBmel5+nYJ3Bk7715lL/gqUfFox3W2BsbHwl2MHBwSAiYS
	vfvFuxg5gUwxiQv31rN1MXJxCAlcZpQ4+quDCcI5xyTRPmEDI0gVr4C2xNEFN8BsFgFVia27
	njOD2GwCuhKLepqZQGxRgSCJ1mtToeoFJU7OfMICYosIxEjc2rMdzBYWMJT4cuAuM8gRQkC9
	R966goQ5BfQkHp+4ywZiMwuoS/yZd4kZwpaXaN46m3kCI/8sJFNnISmbhaRsASPzKka5xJzS
	XN3cxMyc4tRk3eLkxLy81CJdQ73czBK91JTSTYyQcOTZwfhtncwhRgEORiUe3hmtjqFCrIll
	xZW5hxglOZiURHnTHwKF+JLyUyozEosz4otKc1KLDzFKcDArifB23ALK8aYkVlalFuXDpKQ5
	WJTEeVWXqPsJCaQnlqRmp6YWpBbBZGU4OJQkeNkfATUKFqWmp1akZeaUIKSZODhBhnNJiRSn
	5qWkFiWWlmTEg+IxvhgYkSApHqC9T0Bu4i0uSMwFikK0nmJUlBLnFQWZKwCSyCjNgxsLSzKv
	GMWBvhTm9QOp4gEmKLjuV0CDmYAGn7/lADK4JBEhJdXAKB8qHLdos8vG9X9VL8u21b4IeNKo
	sub1IvvV+2+fWhPV97As6WrrRXGGgzOFFi5MUWPm6b6ziPEH1xUPab+zjHn/PqwwrN94geNn
	TUJzPJuyztyVvpae4fOWdl78u0XzVHrKY3a1RlODnlaFDXnn+cSM+/Xf9r3RXay6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268062>

On 04/29/2015 10:57 PM, David Turner wrote:
> I recently had a situation where I was using git cat-file (--batch) to
> read files and directories out of the repository -- basically, todo the
> equivalent of open, opendir, etc, on an arbitrary revision.
> Unfortunately, I had to do a lot of gymnastics to handle symlinks in the
> repository.  Instead of just doing echo $SHA:foo/bar/baz | git cat-file
> --batch, I would have to first check if foo was a symlink, and if so,
> follow it, and then check bar, and so on.
> 
> Instead, it would be cool if cat-file had a mode in which it would
> follow symlinks.

I guess it's obvious, but I haven't seen it discussed in this thread, so
I wanted to point out that this feature has some limitations related to
how its arguments are constructed.

In the examples discussed,

    git cat-file --follow-symlinks $committish:foo/bar/baz

, we know the root of a tree and we know the relative path where the
symlink was located, so all is well (modulo a policy for handling
symlinks that point outside of the repo). But the following, which would
naively seem to be identical, cannot work:

    oid=$(git rev-parse $committish:foo/bar/baz)
    git cat-file --follow-symlinks $sha1

The problem is that `$oid` is the name of a blob, and `cat-file` can't
know whether the blob represents the contents of a symlink or the
contents of a file. (And even if it knew, it would have no idea what
tree the symlink paths should be interpreted relative to.) What if we
pass `cat-file` a tree and a relative path instead?:

    tree=$(git rev-parse $committish:foo/bar)
    git cat-file --follow-symlinks $tree:baz

Now it can work, but only if the symlink chain never rises above the
level of `$tree`. So for example, if `foo/bar/baz` points at `../xyzzy`,
then the very first example would succeed, whereas the last one would
have to fail. Please note that there is no possible way to avoid failure
by reading files from the filesystem outside of the repository, because
in this case `cat-file` can have no idea where to look.

> The major wrinkle is that symlinks can point outside the repository --
> either because they are absolute paths, or because they are relative
> paths with enough ../ in them.  For this case, I propose that
> --follow-symlinks should output [sha] "symlink" [target] instead of the
> usual [sha] "blob" [bytes].  Since --follow-symlinks is new, this format
> change will not break any existing code.
> [...]

I don't think this is doable in the general case, because it is not only
the last component of the path that can point outside of the repository.
Suppose we have

    foo -> ../plugh

and I run

    git cat-file --follow-symlinks HEAD:foo/bar/baz

The lookup of `foo` already falls outside of the repository, and
`bar/baz` is relative to *it*, so in this case it would have to return

    ???? "symlink" ../plugh/bar/baz

The question is, what SHA-1 should be output in place of the question
marks? The only SHA-1 we have handy is the SHA-1 of `foo`, but that
doesn't seem especially useful.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
