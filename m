Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D921C14
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 06:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="f0aVvWiP"
X-Greylist: delayed 563 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 15 Oct 2023 23:11:52 PDT
Received: from ms11p00im-qufo17281901.me.com (ms11p00im-qufo17281901.me.com [17.58.38.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4E6D9
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 23:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1697436148;
	bh=uqb3wi04tvsIKSghw1M/lUv2ACtArZFgh0+WTvcFsSU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=f0aVvWiPkakAlZoWFg/SDsFw+aIFjTxZetIQd/Nw6DhnzR/oJApb+d0KrqRYPSbz3
	 t++xPOOiOOIShtqj4ayayvHP7SMEaE5z7GqFctk3crRihK2Ci20/eP7XDHAq+wli0u
	 xt76XE7duRKkaO8SDRtSQh5yBcLpC/mLwtcPrCHI5cksypow5xqFbstuPWF6msAqbk
	 yE4Nd1xWWL/d/Q3rIaLWrYhK8+Na/DpUKCo8Fs8OH1qX2v93Bc/JE0qlbNkrNY7jRE
	 lrfGh07P6jOCWNimcTRu8CINa9O2ppMkCQNCVyus0+8R2eAyFSO8yOwGyfHJ8QTNyN
	 7HNmB7irOUKbQ==
Received: from [192.168.178.33] (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
	by ms11p00im-qufo17281901.me.com (Postfix) with ESMTPSA id 9891DD801DE;
	Mon, 16 Oct 2023 06:02:27 +0000 (UTC)
From: Sebastian Thiel <sebastian.thiel@icloud.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>, Josh Triplett <josh@joshtriplett.org>,
 git@vger.kernel.org
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
Date: Mon, 16 Oct 2023 08:02:25 +0200
X-Mailer: MailMate (1.14r5937)
Message-ID: <1EE716BB-C8D5-4543-A5BE-EB8518151077@icloud.com>
In-Reply-To: <xmqqmswjsv8c.fsf@gitster.g>
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
 <xmqqttqytnqb.fsf@gitster.g> <ZSouSI_zPusOefsv@localhost>
 <CABPp-BEg6vxiUpcJAG_=KB_sTrVgCF19JZh-+ZGCTPXdbo9ekg@mail.gmail.com>
 <B088FC28-BE30-424D-9CDD-7A53EDFC1710@icloud.com>
 <xmqqmswjsv8c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: yY7ZYj2_FFCcfnmHtgK2M-e1vOxmTRfl
X-Proofpoint-ORIG-GUID: yY7ZYj2_FFCcfnmHtgK2M-e1vOxmTRfl
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2310160051
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks a lot, that makes perfect sense!

Thanks to Elijah we may also have discovered why the idea of precious files
didn't get implemented last time it came up: it's too much work to make
all portions of the code aware.

I don't know if this time will be different as I can only offer to implement
the syntax adjustment, whatever that might be (possibly after validating
the candidate against a corpus of repositories), along with the update
to `git clean` so it leaves precious files alone by default and a new flag
to also remove precious files.

Maybe that already is something worth having, but I can also imagine
that ideally there is a plan for retrofitting other portions of git as
well along with the resources to actually do it.

On 15 Oct 2023, at 18:31, Junio C Hamano wrote:

> Sebastian Thiel <sebastian.thiel@icloud.com> writes:
>
>> A particularly interesting question brought up here also was the question
>> of what's more important: untracked files, or precious files? Are they
>> effectively treated the same, or is there a difference?
>
> Think of it this way.  There are two orthogonal axes.
>
>  (1) Are you a candidate to be tracked, even though you are not
>      tracked right now?
>
>  (2) Should you be kept and make an operation fail that wants to
>      remove you to make room?
>
> For untracked files, both are "Yes".  As we already saw in the long
> discussion, precious files are "not to be added and not to be
> clobbered", so you'd answer "No" and "Yes" [*].
>
> In other words, both are equally protected from getting cloberred.
>
>     Side note: for completeness, for ignored files, the answers are
>     "No", and "No".  The introduction of "precious" class makes a
>     combination "No-Yes" that hasn't been possible so far.
>
> Elijah, thanks for doing a very good job of creating a catalog of
> kludges we accumulated over the years for the lack of proper support
> for the precious paths.  I think they should be kept for backward
> compatibility, but for new users they should not have to learn any
> of them once we have the support for precious paths.
