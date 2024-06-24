Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FD519DFB1
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246852; cv=none; b=He5GNTLpRvpaiwmcJSQ2uyLWnTfmSWfs96pu5sf7OaNXg+iXMk3DET43Cu1dUfPlzVOjadLihsIEE/4RF0+XycNBRI6dsqXsMsv6fEeJ0rXS2TIM3lA4PXKvmX5WybrusDWF5qpq8hOqLmlsm9x8nH07tWNJ975rJQVYcsiZxbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246852; c=relaxed/simple;
	bh=2jIt7J8bWWLg1SeUdX30qwHYJGAaT/fN1yqGgngMD50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZidRBiU4wa3KQB6/XtDU8hyKYLth4NBgRCzuMQRCYjd/9v2Db7i0kiZcwf5m/ee53DA2mF4984hgR/WeHehVkLMBNIgOn6ZMbD2VuvrEIN8p9+6Tg/S2bBdFMk7At2lBtm/N2cCOZQ+CrECrfGaYe5in4FMp3+mVskXaNo2WTQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ze/WMEFH; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ze/WMEFH"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B745D214B6;
	Mon, 24 Jun 2024 12:34:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2jIt7J8bWWLg
	1SeUdX30qwHYJGAaT/fN1yqGgngMD50=; b=Ze/WMEFHnBSIwvT+NGkzCvjHRP43
	a6rtOHIhkG4SiPwFwdY6eiPRz++MwoOCXvC1jrbVL5Tx9kP2Wvhb19WTVIm337a6
	Qvn6roaBklYk1EDucCXgxEgGyrUqcpylTN/HGa7PCcFY3Ga0M4Pm0pipMz0OAvL6
	Yu4d+M1IOp59HrU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AF5EE214B5;
	Mon, 24 Jun 2024 12:34:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CD4EE214B2;
	Mon, 24 Jun 2024 12:34:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Karthik Nayak <karthik.188@gmail.com>,
  git@vger.kernel.org,  Paul Millar <paul.millar@desy.de>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH] describe: refresh the index when 'broken' flag is used
In-Reply-To: <735b4a95-fe8e-4bff-9dd3-10ddd4bdb5b5@gmail.com> (Abhijeet
	Sonar's message of "Mon, 24 Jun 2024 19:18:33 +0530")
References: <20240623214301.143796-1-abhijeet.nkt@gmail.com>
	<CAOLa=ZRGramQ3MdzzXzZ19yeUB_rQZPbZ3u=eA=T2SfV3nhYOA@mail.gmail.com>
	<054c6ac1-4714-4600-afa5-7e9b6e9b0e72@gmail.com>
	<69662b07-e216-421b-b947-afa52e56d7ec@gmail.com>
	<735b4a95-fe8e-4bff-9dd3-10ddd4bdb5b5@gmail.com>
Date: Mon, 24 Jun 2024 09:34:00 -0700
Message-ID: <xmqqcyo6cnbb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 9067B970-3247-11EF-BC70-C38742FD603B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:

> I would like to change the owner of a file
> in the test case I am writing -- an operation
> that requires super-user privileges.=C2=A0 I am not
> sure if it is okay to do that in tests.=C2=A0 Since
> that would require running tests with `sudo`.

What is the reason why you want to change the owner of a file in
your test?

If it is merely to make sure you cannot write to the .git/index
file, temporarily doing chmod of the .git directory in a test (with
POSIXPERM prerequisite) may be one way to do so, and you do not need
the second user in the system test is running.

Or if you pretend that you have a second process that is holding the
lock in .git/index by creating .git/index.lock file yourself, that
would also prevent your tested command from touching the index.

The latter approach would result in a test that may look like so (I
am writing this in my mail client, and I expect there may be some
fix ups needed):

test_expect_success 'see what --broken does upon unwritable index' '
        test_when_finished "rm -f .git/index.lock" &&
        test_commit A A.file &&
        echo changed >>A.file &&
        >.git/index.lock &&
	test_must_fail git describe --dirty >actual 2>error &&
	test_grep "could not write index" error &&
	git describe --broken --dirty >actual 2>error &&
	test_grep ! "could not write index" error &&
	echo ...expected.describe.result... >expect &&
	test_cmp expect actual
'

HTH.
