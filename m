Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49211877
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="rkEJbqdK"
Received: from st43p00im-zteg10071901.me.com (st43p00im-zteg10071901.me.com [17.58.63.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E60C2
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 00:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1697268656;
	bh=iCKt5TctUc7KXlmPEeDz8afMhnkcqQ3WMZ0oCtv5La0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=rkEJbqdKjh3Tt21RqCEzzZYG2Et0t9ivQyUiie3rDzbKGYayMfUQ8O6MLRlmC+XzY
	 jm7lYUNKK11h1SNPv8lF4ANNaSOQNEYHQMI5DpCSTM36AnwEsBm+OG599t0aExbrc/
	 cMf2CT12dqRb6ZFgrlBAbkaY3ZOPOGzzDzl90uv6Ze46AGNpLF6fMq3PC4v03FPEuJ
	 KzdbQAeMxy2PuueG+iU5wkmmahAhcFG3W/BcxQr6bEW+a5eZT7IBGIWhxydcGm4XQs
	 qiST8tXCrF26s+itK4WdzLPEGiLY5Qg/3pswBckTzBqSCi/u4SmKyh4aUh/dzd+y5v
	 jSBql2d85nFvA==
Received: from [192.168.178.33] (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-zteg10071901.me.com (Postfix) with ESMTPSA id DF9BB8400D0;
	Sat, 14 Oct 2023 07:30:55 +0000 (UTC)
From: Sebastian Thiel <sebastian.thiel@icloud.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
Date: Sat, 14 Oct 2023 09:30:53 +0200
X-Mailer: MailMate (1.14r5937)
Message-ID: <9815705C-EF59-473F-A119-DE84C0E16A89@icloud.com>
In-Reply-To: <xmqqfs2e3292.fsf@gitster.g>
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
 <xmqqttqytnqb.fsf@gitster.g>
 <0E44CB2C-57F2-4075-95BE-60FBFDD3CEE2@icloud.com>
 <xmqqttqvg4lw.fsf@gitster.g>
 <9C4A2AFD-AAA2-4ABA-8A8B-2133FD870366@icloud.com>
 <xmqqfs2e3292.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: e-m_T5GgMwDCsxKaWbZTFfR7_To1_Jeg
X-Proofpoint-GUID: e-m_T5GgMwDCsxKaWbZTFfR7_To1_Jeg
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.591,18.0.572,17.11.176.26.0000000_definitions?=
 =?UTF-8?Q?=3D2023-07-31=5F02:2023-07-31=5F02,2020-02-14=5F11,2023-05-22?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 mlxlogscore=728 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2310140065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 13 Oct 2023, at 18:39, Junio C Hamano wrote:

> Come to think of it, we might be able to retrofit '!' without too
> much damage.  Something like "!unignored" is now a deprecated but
> still supported way to say "!!unignored", "!*precious" is new, and
> "\!anything" is a pathname that begins with '!'.

I don't know anything about statistics, and I don't which of the proposed
syntax thus far has the lowest probability of accidental breakage, possibly
in combination with the best possible usability.

However, I do like even more the idea to retro-fit `!` instead of having an
entirely new prefix, it seems more intuitive to me.

An apparent disadvantage would be that using `!` prefix with
backwards-compatibility will make any additional future modifier more
breaking. For instance `!*` is potentially ignoring an additional file
in old git, and another `!-` modifier is having the same effect.

Chances for this are probably low though, but if in doubt it would be possible
to check certain patterns against all files of the top-3.5TB of
GitHub repositories.

Using `!*` to signal precious files also seems like a less likely
path prefix than `!$` would be, but then again, it's just a guess
which most definitely doesn't have much bearing.

I personally also like this more than using special comments as 'modifier',
even though doing so would probably have the lowest probability for
accidentally ignoring files in old git.

Maybe it's time to choose one of the options with the possibility to validate
it for accidental exclusion of files against the top 3.5TB of
GitHub repositories to be more sure it?

