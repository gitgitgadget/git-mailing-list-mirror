Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D24181CFA
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722095597; cv=none; b=jfAuyoHjkF+fuwxUqbC6W7g7EvasWxVW4NmmllnahlXFJph/DpF03e2mc6ZeOd9u1L+0/qm/5X67cQ7tDZtqmlwNqn+rQvNhXKnmEMWqy8XrJYZ9wMK6NQkZQT3kILz/rs7SUes3VCNXRKmEpGw2COSUQ4FbHz8zjkrGkacthp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722095597; c=relaxed/simple;
	bh=RIjPQC79thMAJQd8SQ0UDRJkZV7IG7SCUmtd0hDZOCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pbd533jOGBMncsjvLUoW8Oe6SgiWnQgpk/7pF+8bXpjt0IZNbfPWRGuWWyjQMYDxSTckbl1wasHN25mucHqdTNGvtyeznGbyFfN4q2HEKFqYBx+xWm2d8KA/X4L00YdANp36r2xxz/VkPdcG6wRq4VUvdoqJZoCPod3Cs8BsibU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fx2paNTW; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fx2paNTW"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B67282D123;
	Sat, 27 Jul 2024 11:53:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RIjPQC79thMAJQd8SQ0UDRJkZV7IG7SCUmtd0h
	DZOCI=; b=fx2paNTWzQyew6xBhiw4x0ZvJaM/nXeL1ztrfr32pbhR+IRaG5nAtE
	Zsdy4IImAGbIN+McA18RxY/qyZzqb+G4Mz2MF3STEIKFoJ8B2QZb2Jc4QarUOzAu
	48/3khcgzcGzK3qBk0FExjv/xE+CINKH/EsKSBmX1VdpZcR/3T5a0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 97A562D122;
	Sat, 27 Jul 2024 11:53:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D2BA02D11E;
	Sat, 27 Jul 2024 11:53:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: Bug with bash and OpenSSL usage on Windows
In-Reply-To: <ZqUF0ANz9qX-wWEN@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Sat, 27 Jul 2024 14:36:00 +0000")
References: <CAD+08a87xxVRxO1eiWiam-7xvq=AyKUB-MzqG-r=rM_SYbquBQ@mail.gmail.com>
	<ZqUF0ANz9qX-wWEN@tapette.crustytoothpaste.net>
Date: Sat, 27 Jul 2024 08:53:06 -0700
Message-ID: <xmqqttgasufx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 515ACB5C-4C30-11EF-8471-BAC1940A682E-77302942!pb-smtp2.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The Git project doesn't ship OpenSSL, or, for that matter, any binaries
> at all.  All we ship is source versions of Git which various
> distributors compile, sometimes with other binaries.
>
> It looks like you're probably using Git for Windows, which _does_ ship
> OpenSSL, and so you probably want to contact them using their issue
> tracker[0] once you've verified that it hasn't already been reported.
>
> [0] https://github.com/git-for-windows/git

Thanks for giving a response like the above, tirelessly every time
something similar pops out.

I've been wondering if we can somehow reduce the occurrence of such
an issue in the first place.  Elaborating a bit more in the
"Reporting bugs" section of the documentation landing page is
probably the 0-th step, and if people agree that it is going in the
right direction, perhaps we would extend it to include something
similar to the top of the "git bugreport" template, by futzing with
the implementation of builtin/bugreport.c:get_bug_template(), and we
can even encourage customizing it by distribution.

Comments?

Thanks.


 Documentation/git.txt | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git c/Documentation/git.txt w/Documentation/git.txt
index 4489e2297a..495467ac1e 100644
--- c/Documentation/git.txt
+++ w/Documentation/git.txt
@@ -1149,14 +1149,31 @@ the authors for specific parts of the project.
 Reporting Bugs
 --------------
 
+First, thanks for noticing that there may be a problem in Git, and
+be willing to share it to help the larger user base.
+
+Issues which are security relevant should be disclosed privately to
+the Git Security mailing list <git-security@googlegroups.com> and
+not on any other public mailing list.
+
 Report bugs to the Git mailing list <git@vger.kernel.org> where the
 development and maintenance is primarily done.  You do not have to be
 subscribed to the list to send a message there.  See the list archive
 at https://lore.kernel.org/git for previous bug reports and other
 discussions.
 
-Issues which are security relevant should be disclosed privately to
-the Git Security mailing list <git-security@googlegroups.com>.
+The Git project does not distribute anything but the source code to
+Git.  Folks like Debian, Ubuntu, and Git for Windows project make
+binary package to install, and may include software other than Git
+(e.g. OpenSSL and Bash) in their packages.  Please report bugs in
+components *other* *than* *Git* *itself* in such a package to the
+respective packagers, not to the Git mailing list.  How to report
+bugs in some sample binary packages are found here:
+
+ Git for Windoes: https://github.com/git-for-windows/git
+ Ubuntu: https://help.ubuntu.com/stable/ubuntu-help/report-ubuntu-bug.html.en
+ Debian: https://www.debian.org/Bugs/Reporting 
+
 
 SEE ALSO
 --------
