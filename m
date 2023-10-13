Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768EE63A9
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="lori6W81"
Received: from st43p00im-ztbu10073601.me.com (st43p00im-ztbu10073601.me.com [17.58.63.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11FF11A
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 02:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1697188170;
	bh=qCVgiGRh3eIEPf2bqGKKnOdEyco9TxXou1WYIR50y74=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=lori6W81EcREZKwZHeaUKX38d6kVqhrBFv6GhbQa2sMK+IVhMycm+Lh5V0AhshJIf
	 U4eIV0DnMB/4ye/oDzV+8/jKvW/QcXWRP7qEhjoP892cR5V26Sw0srnqOSrFWg1Fjo
	 tobdY3JhheEOFHD+hmCDbF9iBePj+qADG+7qCEO+A5zhgybBNB0tJrCetfvw9woMYz
	 JdMWkYYzWFOSUjp1XGsy4dwlmh7HY1rZOBuoDqJjC22ww+qbO74k0mQOnlbaXlmlHB
	 mHmXndOfeeDAydHH4HBI7pHowDWGLR6jT0ZShoKHMUKSGaPhk29wLTZYdgo0/p/NIJ
	 3A6g1NNkX3IDw==
Received: from [169.254.31.67] (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztbu10073601.me.com (Postfix) with ESMTPSA id 9F38E180203;
	Fri, 13 Oct 2023 09:09:29 +0000 (UTC)
From: Sebastian Thiel <sebastian.thiel@icloud.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
Date: Fri, 13 Oct 2023 11:09:27 +0200
X-Mailer: MailMate Trial (1.14r5937)
Message-ID: <9C4A2AFD-AAA2-4ABA-8A8B-2133FD870366@icloud.com>
In-Reply-To: <xmqqttqvg4lw.fsf@gitster.g>
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
 <xmqqttqytnqb.fsf@gitster.g>
 <0E44CB2C-57F2-4075-95BE-60FBFDD3CEE2@icloud.com>
 <xmqqttqvg4lw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 7B3Z4f5cxsl4J3qdMH0mw7hpRsU2Qrch
X-Proofpoint-ORIG-GUID: 7B3Z4f5cxsl4J3qdMH0mw7hpRsU2Qrch
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=748 suspectscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2310130074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12 Oct 2023, at 18:58, Junio C Hamano wrote:

> I presume you picked '$' > exactly because of this reason?

Yes, and because I thought '$' seems a great fit to represent value.

> I do not think it will be the end of the world if we don't do so,
> but it would be really really nice if we at least explored a way (or
> two) to make a big enough hole in the syntax to not just add
> "precious", but leave room to later add other traits, without having
> to worry about breaking the backward compatibility again.  A
> simplest and suboptimal way may be to declare that a path that
> begins with '$' now needs '\'-quoting (just like your proposal),
> reserve '$$' as the precious prefix, and '$' followed by any other
> byte reserved for future use, but there may be better ideas.

Even though I'd love to go with the unextensible option assuming it would=
 last
another 15 years, I can see the appeal of making it extensible from the s=
tart.

In a world where '$' is a prefix, I'd also think that it's now possible t=
o
specify exclusion using '$!path' for completeness, if '$$path' marks 'pat=
h'
precious.

But if there is now a prefix, I feel that it might as well be chosen so t=
hat it
is easier to remember and/or less likely to cause conflicts. I think it m=
ust
have been that reason for pathspecs to choose ':' as their prefix, and it=
 seems
to be an equally good choice here.

This would give us the following, taking the Linux kernel as example:

    .*
    !this-file-is-hidden-and-tracked
    :!new-syntax-for-negation-for-completeness
    \!an-ignored-file-with-leading-!
    \:an-ignored-file-with-leading-:-which-is-technically-breaking
    :$.config
    :x-invalid-as-:-needs-either-!-or-$-to-follow-it

Now ':$path' would make any path precious, which is `:$.config` in the ex=
ample
above.

How does that 'feel'? Is the similarity to pathspecs without being pathsp=
ecs
an anti-feature maybe?

>> Thus, to make this work, projects that ship the `.gitignore` files wou=
ld *have
>> to add patterns* that make certain files precious.
>
> Not really.  They do not have to do anything if they are content
> with the current Git ecosystem.  And users who have precious stuff
> can mark them in the.git/info/excludes no?

Yes, but only if they control all the ignore patterns in their global fil=
es. If
the repository decides to exclude a file they deem precious, now it won't=
 be
precious anymore as their ':$make-this-precious' pattern is seen sequenti=
ally
after the pattern in the repository.

For instance, tooling-specific ignores are typically fully controlled by =
the
user, like '/.idea/', which could now easily be made precious with ':$/id=
ea/'.

But as the Linux kernel repository ships with a '.gitignore' file that in=
cludes
the '.*' pattern, users won't be able to 'get ahead' of that pattern with=
 their
':$.config' specification.

> The only case that is
> problematic is when the project says 'foo' is ignored and expendable
> but the user thinks otherwise.  So to make this work, projects that
> ship the ".gitignore" files have to avoid adding patterns to ignore
> things that it may reasonably be expected for its users to mark
> precious.

Yes, I think my paragraph above is exactly that but with examples to prac=
tice
the new syntax-proposal.

>
>> Such opted-in projects would produce `.gitignore` files like these:
>>
>>     .*
>>     $.config
>
> I would understand if you ignored "*~" or "*.o", but why ignore ".*"?

I don't have an answer, the example is from the Linux Kernel repository w=
as
added in 1e65174a33784 [1].

I am definitely getting excited about the progress the syntax is making :=
),
thanks for proposing it!

[ Reference ]

1. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D1e65174a33784

