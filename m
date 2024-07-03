Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39581DA318
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015525; cv=none; b=VJomE8bfNbbsjNxdQEfLc0pp2MChqyGEX7KIVZNz0Zjnk27G9h8+0qiS6Nu8Dyo4mUePu9CN+6dpIyMkNWAIvQ8hc5JV+mPDpOxXQmp5uotnXjSzoorNP/xEmtYjmRY9OTfl92RfftZFstbRwjGsmRW7eTLj4joi6V3jNqTmQkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015525; c=relaxed/simple;
	bh=neDv6rP26jljl1mnZiChDgKfxLDQTvQKHzyqj2R6PvI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=S6KUqk2sS1+INLJGv67hZ0k4t5Xn8m0zKe5eVrefqFH5kY4G2Nn6+74o+O7Yrb3fMoPFyMKSrS120tN0amWCxz6PW6S/4CRMIas8uaCizJjByTluVx94Q8wMF5rSHlq8dg5JdKfRHntl+b+ivtI3ldDP3tC96aruK3Rzf/yzvLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 463E5CQn2197125
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 14:05:12 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Bruce Perry'" <bruce.a.perry@gmail.com>
Cc: "'Bruce Perry via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>, "'Stefan Beller'" <stefanbeller@gmail.com>,
        "'Emily Shaffer'" <emilyshaffer@google.com>
References: <pull.1740.git.git.1719947271.gitgitgadget@gmail.com> <07d801daccb3$c1de13e0$459a3ba0$@nexbridge.com> <CAJ_CbHX5nyvMy3ZO+YYCWnPhUmS2QZJjTzsePqXT2TEy-LBQfQ@mail.gmail.com>
In-Reply-To: <CAJ_CbHX5nyvMy3ZO+YYCWnPhUmS2QZJjTzsePqXT2TEy-LBQfQ@mail.gmail.com>
Subject: RE: [PATCH 0/2] clone: shallow-submodules should be single-branch by default
Date: Wed, 3 Jul 2024 10:05:06 -0400
Organization: Nexbridge Inc.
Message-ID: <082a01dacd52$056ddf70$10499e50$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGX+KKwWdOtKoOFI1UgP9Cu4TL/awI6irKsAaoFOVWyS44R4A==
Content-Language: en-ca

On Wednesday, July 3, 2024 1:00 AM, Bruce Perry wrote:
>Perhaps I was using imprecise terminology. This change should not =
impact whether
>submodule clones land in a detached head state, so it should not impact =
anything
>that assumes submodule clones are detached head.
>
>The change being made is this: "git clone --recurse-submodules =
--shallow-
>submodules" currently gives you a submodule with a detached head at the =
desired
>state, but also downloads data for the tips of all branches in the =
remote being
>cloned (potentially a lot of unneeded data as in my use case). The =
modification
>means the same command would give you a detached head at the desired =
state,
>plus the tip of only the default branch in the remote. The modified =
behavior
>matches the current behavior for a simple "git clone" followed by "git =
submodule
>update --init --recurse--submodules --depth=3D1".
>
>Thanks,
>Bruce
>
>(Resent due to a formatting failure)
>
>On Tue, Jul 2, 2024, 1:12=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>>
>> On Tuesday, July 2, 2024 3:08 PM, Bruce Perry wrote:
>> >I noticed a couple places where the behavior of recursive clones for
>> >shallow submodules does not match what is implied by the
>> >documentation. Shallow submodules should be, but aren't, single
>> >branch by default. It would also be useful to allow users to =
override
>> >the shallow specification in gitmodules on the command line for
>> >clones as they can for submodule update. The modification here for =
the former is
>a bit ugly, but hopefully at least gets the point across to start a =
discussion.
>> >First time submitting a patch here, hopefully I'm getting the =
process right.
>> >
>> >Bruce Perry (2):
>> >  clone: shallow-submodules should be single-branch by default
>> >  clone: no-shallow-submodules clone overrides option in gitmodules
>> >
>> > Documentation/git-clone.txt         |  3 ++
>> > Documentation/gitmodules.txt        |  4 +--
>> > builtin/clone.c                     | 10 ++++--
>> > t/t5614-clone-submodules-shallow.sh | 52
>> > +++++++++++++++++++++++------
>> > 4 files changed, 53 insertions(+), 16 deletions(-)
>> >
>> >
>> >base-commit: daed0c68e94967bfbb3f87e15f7c9090dc1aa1e1
>> >Published-As:
>> >https://github.com/gitgitgadget/git/releases/tag/pr-git-
>> >1740%2Fbaperry2%2Fsubmods-clone-bug-v1
>> >Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-
>> >1740/baperry2/submods-clone-bug-v1
>> >Pull-Request: https://github.com/git/git/pull/1740
>>
>> I am concerned about this one. Many CI systems (including Jenkins =
GitSCM)
>assume a detached head for submodule clone/checkout. Adding a branch to =
the mix
>will change the expected semantics. Am I missing something?

Thanks for clearing that up. Fine with me.
Regards
Randall

