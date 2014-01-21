From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix safe_create_leading_directories() for Windows
Date: Tue, 21 Jan 2014 12:09:08 -0800
Message-ID: <xmqqeh41umfv.fsf@gitster.dls.corp.google.com>
References: <52C5A039.6030408@gmail.com>
	<alpine.DEB.1.00.1401021826120.1191@s15462909.onlinehome-server.info>
	<xmqqtxdmp39a.fsf@gitster.dls.corp.google.com>
	<52C5D0AB.7050309@gmail.com>
	<xmqqha9mozvc.fsf@gitster.dls.corp.google.com>
	<CAHGBnuNoTrRwnjp7ZqMgveLHZeV68cxOqawf7nWo7gnAAYfSOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 21 21:09:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5hdO-0007DG-6l
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 21:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbaAUUJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 15:09:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41010 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbaAUUJN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 15:09:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F8DB63511;
	Tue, 21 Jan 2014 15:09:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0GDk6Ca+DRlFPrsp99Aocvk0F78=; b=bSAlLX
	q7z/Chgwip0oKoiQCLzL5SL3RnR9x8yShhM+Ssz1DCnxIkU5425uFg4xhuTz5Q8F
	Y8m8NqlzwHB1kSEikG6HCdmGRZfJ3YH8qaNK3g48yvivvjYns/KEPK/Y0dkvCvrf
	8HS2GzTF8ChkaUhXpJNyP9E6bABiYYlC/0S3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wi2affPF0v1KRigzw4qmiufYS2RAIKhg
	F3qvb3az6PQM8e1ILqXMF2B6R/2BN6FvYZzkbi8clBM2+5T12t+9YOXKK3vUEJ/d
	+HOCyvPbWA4xZHliChM3lCo8ujw3tZ8RswdyafRjJwD7cA37YHu04MWw8pbEpRfd
	ZTwoGuAKf/g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EDB86350E;
	Tue, 21 Jan 2014 15:09:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1AC356350D;
	Tue, 21 Jan 2014 15:09:10 -0500 (EST)
In-Reply-To: <CAHGBnuNoTrRwnjp7ZqMgveLHZeV68cxOqawf7nWo7gnAAYfSOw@mail.gmail.com>
	(Sebastian Schuberth's message of "Sun, 19 Jan 2014 08:26:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E44F1CF2-82D7-11E3-8102-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240771>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Thu, Jan 2, 2014 at 10:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>> Seems like the path to clone to is taken as-is from argv in
>>> cmd_clone(). So maybe another solution would be to replace all
>>> backslashes with forward slashes already there?
>>
>> That sounds like a workable alternative, and it might even be a
>> preferable solution but if and only if clone's use of the function
>> to create paths that lead to a new working tree location is the only
>> (ab)use of the function.  That was what I meant when I said "it may
>> be that it is a bug in the specific caller".  AFAIK, the function
>
> I think Dscho made valid points in his other mail that the better
> solution still is to make safe_create_leading_directories() actually
> safe, also regarding its arguments.

Sorry, but I think I misremebered the reason why we have that
function.

There are two reasons we may need to do a rough equivalent of 

	system("mkdir -p $(dirname a/b/c)")

given an argument 'a/b/c' in our codebase.

 1. We would want to be able to create 'c' such that we can later
    refer to "a/b/c" to retrieve what we wrote there, so we need to
    make sure that "a/b/" refers to a writable directory.

 2. We were told by the index (or a caller that will then later
    update the index in a consistent way) that 'a/b/c' must exist in
    the working tree, so we need to make sure that "a/" and "a/b/"
    are both directories (not a symlink to a directory elsewhere).

Seeing hits "git grep safe_create_leading_directories" from apply
and merge-recursive led me to incorrectly assume that this function
was meant to do the latter [*1*].

But the original purpose of safe_create_leading_directories() in
sha1_file.c was to "mkdir -p" inside .git/ directories when writing
to refs e.g. "refs/heads/foo/bar", and for this kind of use, we must
honor existing symlinks.  ".git/refs" may be a symbolic link in a
working tree managed by "new-workdir" to the real repository, and we
do not want to unlink && mkdir it.

We even have an "offset-1st-component" call in the function, which
is a clear sign that we would want this as usable for the full path
in the filesystem, which is an indication that this should not be
used to create paths in the working tree.

So I think it is the right thing to do to allow the function accept
platform specific path here, and it is OK for "clone" to call it to
create the path leading to the location of the new repository.

A related tangent is that somebody needs to audit the callers to
make sure this function is _not_ used to create leading paths in the
working tree.  If a merge tells us to create "foo/bar/baz.test", we
should not do an equivalent of "mkdir -p foo/bar && cat >baz.test";
we must make sure foo/ and foo/bar are real directories without any
symbolic link in the leading paths components (the same thing can be
said for "apply").  I have a suspicion that the two hits from apply
and merge-recursive are showing an existing bug that is not platform
specific.

Thanks.


[Footnote]

*1* In such a context, getting "a/b\c/d" and failing to make sure
"a/" is a directory that has "b\c/" as its immediate subdirectory is
a bug---especially, splitting at the backslash between 'b' and 'c'
and creating 'a/b/c/' is not acceptable. The platform code should
instead say "sorry, we cannot do that" if it cannot create a
directory entry "b\c" in the directory "a/" (which would make sure
such a non-portable path in projects will be detected).
