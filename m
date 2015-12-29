From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/20] More flexibility in making shallow clones
Date: Tue, 29 Dec 2015 11:09:29 -0800
Message-ID: <xmqqy4cdgjh2.fsf@gitster.mtv.corp.google.com>
References: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 20:09:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDzeL-0006iE-4T
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 20:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656AbbL2TJe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 14:09:34 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53251 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753606AbbL2TJc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Dec 2015 14:09:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7BD5F3511A;
	Tue, 29 Dec 2015 14:09:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xnQZfZghiODd
	dXeWGiviodSk4zY=; b=wGuauF8zRhYexcVIdoIBq7pxPChuEdW4Q5hrDAfKGTVf
	ZD5f4dEY5iZ8uYstC/nObxdGIBgIuRyXLeFP82xi8JZbxBjwle5Syfbe8OPqA37q
	2uM8x1IXOliydUGW1oGnKBA/X0exKeyXouqbH6wuALIfXl4KWnrKoy/hv5isYfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JZWIhS
	Bg1/nMZuMphFrLso8uIiG91y4+6YJANFYMMNFf3VrpaVmUAHUmkbxX1K1+pLiumW
	hdsFnrjYcpYJNn3C8ANy30Z/IXuGTkwFa8C7ws46hP+rea5Nx8td7GOY8suov12S
	KEK4nzlx5Chj+h0/JmLcFgGYN9lCI2ocR0jhA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 73E0C35119;
	Tue, 29 Dec 2015 14:09:31 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EC7C535117;
	Tue, 29 Dec 2015 14:09:30 -0500 (EST)
In-Reply-To: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 29
 Dec 2015 19:10:23 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B06E10A4-AE5F-11E5-A9A5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283145>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This series brings three new options to shallow clone/fetch. --since
> lets you specify cut point by time. --not cuts by excluding specified
> refs. And --deepen=3D<N> extends shallow boundary in a more predictab=
le
> way. Some of these were requested in the past.

Hmm, is this --deepen=3D<N> a response to the "--depth=3D<N> after too
long a time since the clone may even lose the originally acquired
history because the tip has advanced more than <N>"?  If that is so,
I guess it is a welcome change ;-)

> An important point of this series is it starts to use rev-list behind
> the scene to define shallow boundary, which opens doors to even more
> ways of cutting a repository.
>
> The series is good enough to look at but I don't think I have stared
> long enough to spot all the bugs. This mail is mostly about checking
> if the design (at both code and protocol levels) and the UI make
> sense. I'm thinking --since and --not may be too generic, but I don't
> see any better names, for example.
>
> Refactor/cleanup patches are sprinkled throughout (bad?). The meat is
> in 05, 09, 12, 13, 16, 17, 18 and 20.

Thanks.  As an initial "how about going in this direction?"
weatherbaloon, the order of changes are less important, but as the
topic gets closer to the final, it would be nicer to see preparatory
things done as, eh, preparatory steps ;-)

> HTTP support is not in this series (and I don't intend to do soon).
> The amount of filler code just to pass some info from UI down to the
> protocol seems too much, and it's even more so when HTTP support is
> added. But I don't see anyway around it. Maybe we can share some code
> between git-clone, git-fetch and git-fetch-pack, at least the argumen=
t
> parsing..
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (20):
>   upload-pack: move shallow deepen code out of receive_needs()
>   upload-pack: move "shallow" sending code out of deepen()
>   upload-pack: remove unused variable "backup"
>   upload-pack: move "unshallow" sending code out of deepen()
>   shallow.c: implement a generic shallow boundary finder based on rev=
-list
>   upload-pack: glue code to use get_shallow_commits_by_rev_list
>   upload-pack: use skip_prefix() instead of starts_with() when possib=
le
>   upload-pack: tighten number parsing at "deepen" lines
>   upload-pack: add deepen-since to cut shallow repos based on time
>   fetch-pack: use a common function for verbose printing
>   fetch-pack: use a separate flag for fetch in deepening mode
>   fetch: define shallow boundary with --since
>   clone: define shallow clone boundary based on time with --since
>   Add test_repo_expect_success for running tests in a new repository
>   t5500: test for shallow depth since a specific date
>   upload-pack: support define shallow boundary by excluding revisions
>   fetch: define shallow boundary with --not
>   clone: define shallow clone boundary with --not
>   t5500: test for shallow depth excluding a ref
>   fetch: add --deepen=3D<N> to extend shallow boundary by <N> commits
>
>  Documentation/fetch-options.txt                   |  14 ++
>  Documentation/git-clone.txt                       |   8 +
>  Documentation/technical/pack-protocol.txt         |   4 +-
>  Documentation/technical/protocol-capabilities.txt |  25 +++
>  builtin/clone.c                                   |  32 +++-
>  builtin/fetch.c                                   |  44 ++++-
>  commit.h                                          |   2 +
>  fetch-pack.c                                      | 128 ++++++++----=
--
>  fetch-pack.h                                      |   4 +
>  shallow.c                                         |  92 ++++++++++
>  t/README                                          |  15 ++
>  t/t5500-fetch-pack.sh                             |  36 ++++
>  t/t5510-fetch.sh                                  |  12 ++
>  t/test-lib-functions.sh                           |  20 +++
>  transport.c                                       |  11 ++
>  transport.h                                       |  14 ++
>  upload-pack.c                                     | 206 ++++++++++++=
++++------
>  17 files changed, 550 insertions(+), 117 deletions(-)
