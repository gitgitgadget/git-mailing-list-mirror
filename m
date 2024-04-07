Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBA52AF1E
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712511565; cv=none; b=WLSFBfqH/uOBd3+5cgO0PiPpVS/6Te5FITlfHxivvHNlXcJF7zZpPZ10/uCvI8fag058rw48h3qnIRfuPW4yxtIbl3+SzXerM4QRZvPGLRr24eq94TeHwiqB5KoTDvYL88kPeI6eeIzu3ClEQv+1H+jf9AXgVWB1Sl5Ifkrcfk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712511565; c=relaxed/simple;
	bh=0/OrzM6QyGHjqzc87m3QFmFvkHCVLWkBUYLdA8XDQSM=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=bh1P9cW5pvcA3/vEZK7BPy+iWHGIzTB9FzDKzIOt4ImMQdkmXvyt5vLz93Bxgwv6gcFeQZ2NejAUdBB7QgScdvuupchPY0J/3AX/4t/tSPnR5joYxyHEEyMZcgofzkWdW003PD9w0r+SMiLuasxZItqtmTBBufE1pFeygPZ6PAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 437HdDKb3430245
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 7 Apr 2024 17:39:13 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'David Karr'" <davidmichaelkarr@gmail.com>, <git@vger.kernel.org>
References: <CAA5t8Vp9ugXrgawDYA-+2mXT_RWPUUvv-rH9P+Exgb2dtvX6Sw@mail.gmail.com>
In-Reply-To: <CAA5t8Vp9ugXrgawDYA-+2mXT_RWPUUvv-rH9P+Exgb2dtvX6Sw@mail.gmail.com>
Subject: RE: What are good reasons to use trunk-based dev, as opposed to release branch to release branch?
Date: Sun, 7 Apr 2024 13:39:09 -0400
Organization: Nexbridge Inc.
Message-ID: <036201da8912$825b5050$8711f0f0$@nexbridge.com>
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
Thread-Index: AQFNyAQSStnOcEiSMmVGAd22yuurGbJ2kyLg
Content-Language: en-ca

On Sunday, April 7, 2024 1:17 PM, David Karr wrote:
>Personally, I always use trunk-based development.  New changes go into =
feature
>branches from master, and are merged to master after approval.
>When we're ready to make a release, we create the release branch from =
master,
>very few changes go into the release branch after we cut it.
>Any changes that have to go into the release branch are first merged to =
master, and
>then cherry-picked to the release branch.
>
>My team maintains the "platform" for a large number of =
similarly-constructed
>microservices. That includes the build process, foundation libraries, =
and some
>development guidance to the teams developing those services. We advise =
using
>trunk-based development, but it's up to each team what they actually =
do.  I recently
>heard of some teams doing what I would roughly call =
"release-to-release"
>development, which means at some point in the distant past they created =
a release
>branch from master, and then the next release they cut from that =
release branch,
>ad infinitum.
>
>What bothers me is that although I know this practice is wrong, I don't =
think I can
>fully and completely describe why it is wrong, and why TBE is better.
>
>At a minimum, I know that with TBE, someone with no knowledge of the =
repository
>can look at the master branch and know that represents the latest work =
on the
>repository.
>
>I can't very argue that their practice results in "merge hell" when =
merging to master,
>because they never actually do that.
>
>Can someone describe the flaws in this roughly named =
"release-to-release"
>strategy, and why TBE is better?

There are advantages and disadvantages to both. The key reason for =
release-to-release is to allow multiple releases to be simultaneously =
prepared with different features in each. TBE is fundamentally =
cumulative, with branches for new features and fixes. It supports =
development well but is not conducive to controlled production =
deployment. The TBE can be used at the same time as release-to-release. =
Developers work in TBE and should, IMO. But using merge-squash pull =
requests into release branches allows different ordering of features to =
be deployed in varying order (called sequencing). I would say, though, =
that continually basing release branches off of previous release =
branches is not a good practice as it does not allow any history cleanup =
- important when git is used as an release object repo. There should be =
a separate release main branch off which release branches are based. Fix =
release can be based off of their related base release branch, but main =
releases should not really be based off of other main releases. Periodic =
synchronizing of the TBE main with the release main can line things back =
up to reduce future conflicts.

The key take-away, perhaps, is that the two concepts are not mutually =
exclusive.

Just my thoughts.
--Randall

