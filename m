From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/12] Hard coded string length cleanup
Date: Wed, 18 Dec 2013 10:06:10 -0800
Message-ID: <xmqqtxe6hw4t.fsf@gitster.dls.corp.google.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 19:06:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtLVn-0000vn-8P
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 19:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433Ab3LRSGS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Dec 2013 13:06:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55012 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755404Ab3LRSGO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Dec 2013 13:06:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C1D65A174;
	Wed, 18 Dec 2013 13:06:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tWDFD1EsJq7Z
	/pbNP2CkhuYu4B0=; b=S20msXWZNd7B5zfwtEtWW1MdWmn28LxIBpLepSahfy69
	1TibkrZbxPgtRS7YXaWF0q6OHouINeVASj0h6gidUuBMuHHq7wEveg+R855zSdHj
	VKoYLCFdwdpP6TWwNcGJ+4k899VbTNl73um1N5r+UVbVQjCYZuPb/l0OQpZXGQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=I1i5MH
	ajKlCYW2QjGqRrlPiseVEeHrAn4weWYHICt3oTpYXTuKY2EXhoRjydUQlW3UFFBP
	fwhQ3MjaZxinLtgTVB3ZyX/uAWiqH3cMgX1oFSGPk3bMStJJJvHhc5a+QeaWE0BC
	I989osTHUppA8aIuxBoPYY11orXgEhSg/p1rQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83F1A5A173;
	Wed, 18 Dec 2013 13:06:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CA0D5A171;
	Wed, 18 Dec 2013 13:06:12 -0500 (EST)
In-Reply-To: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 18
 Dec 2013 21:53:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 14504E5A-680F-11E3-AEAA-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239465>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> I reimplemented skip_prefix() again just to realize this function
> already exists. Which reminds me there are a bunch of places that
> could benefit from this function, the same reason that I wanted to
> reimplement it.
>
> So this is series to make it more popular (so hopefully I'll see it
> used somewhere and know that it exists) and the code cleaner. The
> pattern "compare a string, then skip the compared part by a hard code=
d
> string length" is almost killed. I left a few in places for those who
> want to contribute :)

Overall the goal of getting rid of the "if the first N bytes of the
ptr match this string, advance ptr by N bytes" pattern, whether the
first N is implicitly given by using prefixcmp() or explicitly given
by using memcmp(), is very good.  And the result looked good from a
cursory read---though I have not gone through the series with fine
toothed comb yet.

Thanks.

>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (12):
>   Make starts_with() a wrapper of skip_prefix()
>   Convert starts_with() to skip_prefix() for option parsing
>   Add and use skip_prefix_defval()
>   Replace some use of starts_with() with skip_prefix()
>   Convert a lot of starts_with() to skip_prefix()
>   fetch.c: replace some use of starts_with() with skip_prefix()
>   connect.c: replace some use of starts_with() with skip_prefix()
>   refs.c: replace some use of starts_with() with skip_prefix()
>   diff.c: reduce code duplication in --stat-xxx parsing
>   environment.c: replace starts_with() in strip_namespace() with skip=
_prefix()
>   diff.c: convert diff_scoreopt_parse to use skip_prefix()
>   refs.c: use skip_prefix() in prune_ref()
>
>  builtin/branch.c         |   3 +-
>  builtin/checkout.c       |   6 +-
>  builtin/fast-export.c    |   3 +-
>  builtin/fetch-pack.c     |  13 ++--
>  builtin/fetch.c          |  16 ++---
>  builtin/for-each-ref.c   |   9 +--
>  builtin/index-pack.c     |  17 +++---
>  builtin/ls-remote.c      |   9 +--
>  builtin/mailinfo.c       |  11 ++--
>  builtin/merge.c          |  12 ++--
>  builtin/reflog.c         |   9 +--
>  builtin/remote.c         |   3 +-
>  builtin/rev-parse.c      |  41 ++++++-------
>  builtin/send-pack.c      |  18 +++---
>  builtin/show-branch.c    |  14 ++---
>  builtin/unpack-objects.c |   5 +-
>  builtin/update-ref.c     |  21 +++----
>  commit.c                 |   5 +-
>  connect.c                |   6 +-
>  daemon.c                 |  75 +++++++++++------------
>  diff.c                   | 153 +++++++++++++++++++++----------------=
----------
>  environment.c            |   4 +-
>  fetch-pack.c             |   9 +--
>  git-compat-util.h        |  15 ++++-
>  git.c                    |  16 ++---
>  http-backend.c           |   5 +-
>  http-push.c              |   6 +-
>  http.c                   |   5 +-
>  log-tree.c               |   5 +-
>  merge-recursive.c        |  13 ++--
>  notes.c                  |   6 +-
>  pager.c                  |   2 +-
>  pathspec.c               |   5 +-
>  pretty.c                 |   3 +-
>  refs.c                   |  20 ++++---
>  revision.c               |  60 +++++++++----------
>  setup.c                  |   3 +-
>  sha1_name.c              |  12 +---
>  strbuf.c                 |   9 ---
>  tag.c                    |   7 +--
>  transport-helper.c       |  15 +++--
>  transport.c              |  14 +++--
>  upload-pack.c            |   5 +-
>  wt-status.c              |  15 ++---
>  44 files changed, 334 insertions(+), 369 deletions(-)
