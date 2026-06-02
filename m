Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA04306757
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418218; cv=none; b=GZLQW9+YH3TH18im7fO13Sj9uRiF1CQAIvY+iVik2bWX+gKOVUW04qY+TPL0G5AbrtAZOXMHB3+UpDKeNVfvPZ6F2kWykcFlnGPmzwATICZ8NFDUYIYEfAJI0PKf8jGK1j4ym1QyawgqMoEPf6Vs9vfWHk/+juwVnPX23fh+zIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418218; c=relaxed/simple;
	bh=6zMCSzQ7AdZsa3az8pKp9BZ/h+4fl9PCcL65SoSznsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AlPFDLV4AbaDMJALs33xzu8XjAbdqBkIH/OvBRnusFCq6nP/xzvnyLvlPbIfLy7nnxWZ9IEuDENDhamgKXsGI4EVAuls8n/nFGCNbhVMFCErwRDeNKb6nf3TIv0UBln5qmqDUSkWLj0dsgXRbUsPCyGqcoOvQ1fj5aG39+Z/nOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=V+gSuz0C; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="V+gSuz0C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1780418208; x=1781023008; i=l.s.r@web.de;
	bh=OjjnHJ45QKZIgI45Fe8jZZ3G85s/ogp/R36mH6mjvHU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=V+gSuz0CQ2q5hVpnm12R3jUghMj/x2xc6qqEso6c4H2hGA16y6M4Ua76+muXLq+l
	 rm7P5TqtyNn4y3Hd0ulCsB53HFH2QviqKwuDFtm8TBzPBKo7YfNDFhssADMdbcc5D
	 4sMZ8cwGMPiEYVy/Wlb3g8lfo2bErLpWD1ram8c/bvZo2+qzvGaqA2fIJOAiqlXw1
	 R/gBN6SzdwaBYA7q6WzgfjsnrZ4HXMW54d3gbeOVNq9186gJ+2PZ4GtY9AMNK491+
	 2GTCogRxEZIupVWQzydhpV9q8mc4M1nAFomNX1RUqT2TguzbwewOq++vzCXIRIsdk
	 U7n+vG70fT4SVcMmbg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Xnl-1xTSk72pbn-00r6cJ; Tue, 02
 Jun 2026 18:36:48 +0200
Message-ID: <90270818-c52b-4611-8da2-6cee20628fc2@web.de>
Date: Tue, 2 Jun 2026 18:36:48 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] prio-queue: use cascade-down for faster extract-min
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>
References: <pull.2132.git.1780250236304.gitgitgadget@gmail.com>
 <pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/wZJiaOKTkG4z1clj2XclMTJOxg8d81h4cH5i+WUaQ6nuz43dr4
 71jH/e7mTveljfdZhyFpFZfLpsUhKA7KztMGxvQvr5z01Hzngg6AFjl0Ssy7RdzTcQSFZnH
 Cb9w6mLFF/8m9LT0JHi4f+vIY/CK3wM9E+VTn6qoXGWa7blFg7PATNtiJCRmbCjRz+8ahdd
 PxdtizFnkc+ibYLRGkxgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b1vYhlMSJBU=;YhDHHx+yQQTbqwaU9q3WaSlpmC9
 5D+lxt/lb6obCHtZ60GXVmaPgSRd/4C5d6tQMC/YzCpiI1mbWU4ylzDqDwqvJ1eKYkNx6JdSO
 5LQyqxofg7b6do33HNShfKik1XOUkH8Kwsr2JbIwSgzJIfYAaqGQ3eaTL1sAczKLxOExxQtwX
 6MkqbIIYDSEWsH4oKGYWOHpG/lNuhcK91M+tkYtmxdnAioss1nPzhsa0a98Ariw7pSSrGxKJj
 LdAWTDXRKFclhOklVCkvO/iu5nes3kZWfIp001ehb57l/VRgmzSY6qcA1uOO7T0RPstZ/0s1L
 uz8WfDhk63YugTcKPFZN98DJPEPh+9IhcrcYw83ZnotSYR6jhAlaUA7L1bledqMR3xWshgf0n
 ahG58Z8HMEZjmv520mCzOL21sWr3CYjGvuWdGilueGOM+EPilT+h5aEUJX+OQk3QYmLI/mGD6
 prTWqOkTTRjA3QimuqMf0HRxY8BFj9CKwP4RZ4c2c+rb44Xj7XlscFNVC+9hePEBDh1ky1Y9i
 /+qvr6WQlKr3aiE4HNYfYiNBSZz78Z2y6BtxWZBapTiuTG0GZlalAlDwCcyB/0y8PZUZaH5oH
 Fnvk4x9c5QEc8n0gOuD55LQaStL20XgLhWk8g1tHbQKMZ5WUhkPszI4oHMZtqcM/NiyuZOdy2
 lPIcy5R/ZyE88Cagmo16y4y1/4q1Jem3QR8eHB8ojoA7G9UEW1R1nMXP9hM0U21TdKO1//Jok
 JVPdKeey4EgYhgAvxrZbBFruyUJ/xs/JbFAIpgCi0H0Gm9lLZID6nmQVhUQg1o8CDL6pCl25N
 egRg7Gk9yE8DC13X5gDdxaTOxpuvkcCwoCERu4fFh8liFg/O4L6oXKOPFfnlT7ihE9YtCJHOT
 qFKgtt85tcAZIPDHNWfDp97xYYAmEQvitfJ/aTM+UQgZ04JJoQ0HH8Ddn0bxuOk4VmlHwltI3
 bYxBaNVOPZlDMjk2gB4B3/GhKRjU3zbw5OiZB/NMW/byySdxbRzbtQf/2UK8w5DRgbWbVRVGV
 i74kRF+8idUC5fQgByy0qtK51/2noGEEZPTdObytAdlvn64/VfYKHpj3awQgR/45MSJklPoSb
 CGu+E5vJGDgLpWTl9Y4DhPPx9m8PZd4tQ1qcq/WB2WvkX+aYKmtOyD3pJkb2POliAtxVWy96d
 1TsnqAWFcBefjwb3p/vR/Wqr8MolS7TAGd8LSNA3sD9nU1IaritBHgTqdXOnaUBeljdfUMSxD
 Ob/GqtfWIgOtsltryHeBoYwpbjVd7gPwTExRvytmxDJxTiH+CvUG+FD/uAbjTtzmS/Xjc4MpD
 MNh6+wGcPC+wl4GqNoI7TkSA8B96LYRdkttXRXI6Ju8T7lfNqrZmcLcEhBUmwHtGZwoC8yFYW
 T6gCpdy66SIz9QnxE1rjLiVv//E//yV7jt8uyR+pVNYvR2VK2LG9M2avKnTmIBiVh58bdjXao
 maBXkEE6VrX/bwQfdCCfBqA3wehntkyQn8yIfXzQuXRQ14XIuCTjc4RsMGPsNf/cajzYZohtS
 ynUxO0cA63mYkD75gHh0IOSjY4nkd2o8vquV9L7bu7joEG4sPfUT4wzgelsGq+kUDzSPz2SNY
 Va/1Jc9/9KpXjiQUw28QRkcQCtwlPiOeTfNLNqMy/ZNzg0ZzmxOOoKR/MvXkjIPtlDOzDgE/d
 Zl+avpipna2UZgfI75vTlEXxhIdnYsm0c5WzhTsxRlsUKhtxGATjVmahSCC37c/JzIyP51EXO
 QocWYU4fZeC76gxmSGY5gmxQkmXhc1akGcaq2pxcKAaKbz0gCqwGmVtK/HoJ/kJYErUCNP8gi
 YHAaDg/8U9DHkOyZqASM2DS7luGeypcwAtpmlLHyQoyWvBRyRAJrhu7aih60vzBEcc8uvb/6s
 uIQyGo7T/Bo1pwqw4PLNOvI0rzeHrH91X6reyTYq9dMBICC8h8KFPHXB2wRu/XjWRbpamF5uR
 esB0n7WlskcOZyTYUx+AFYwUc+XEhiUisbOGK8cVBWAlRzC4CjkrWPGw1lxf52Fn3BIiKd81/
 gA3KqPRzpVi8P3hfP+JuZp2jGCmGbkfkHt8Gas43Hrh5fWlVkEtQBmXgWumUHI63uTyluAE8W
 +kW5JgKvozPQVEYbzjoGd7gjXPz6Gg1PCl7lQrkG2mz521fGkia4ck6X6ykBc/eKQJ8HP2g2t
 FYqQWoWNqn8VhHmo9yjBqVbFE5V1fa3vHj1qN0syYRJ9UUWZ7Z161vDpZyhaPkkXD9vmvT6bb
 ZYW6dfja39XBX554Zm37EjHlAyF2Pr5nj3O+6EMXNDpll5lJ+WoK6Hbh6e6U1Tqa7Ksqio3We
 Ygz4Fqw0SBeKJPcieIl09Ue7q1Qmg8A4TS6BpdcIlF31IzRR5ux9fpFKMYhdReK6I13CsXKxM
 jKreAOuMOzymEugvg/C+fMuO5vQS+3gC5fD+IEJQOu+N3vy36kKqXxDkoX7/0LMbTJJVKMpDk
 BWF3MM25NWyfQx7+GzMlZuBW7865G6/d37m+08VNj/4pMjpW8nKjiz97tVeph1oU45Hxk2No0
 qqKASTrMFvgyc3qMQgFk3I68sP5nqqYzBPBOlFBpJ++PPWPQFPzZyG9zeqCq4legHfwjEMy0w
 qYp5N0VMAkK2TzL5MT68XCpEtooPUDtrpZ0PHEkak3MYArTBqqe9ezL+VC/UurChWaEmpmxez
 truY62bEW7zG6WJIrsTnJDQTreEcSYs5WYvaWKI8MYFtbIyqZZM87CSS4nmvP+ocWfUfTpF39
 ruFWdkv/fuFO1VYBvkYpLdLpWUn1H+aNt1bbHaxf8Bb4w6RJiOqUTTJSFJW/aBCDqDUkZQvd/
 v316s8kXx1RltMi+BI/tw1ph9JIB4Ic8eCU5JhLYBt+1LwDGy9vkDeRRonsC30QAiwR1Zim6F
 75i/T29gs2aBTmh7WqWmIFuICQO4j80OPS5/NhvheA8VfydyTrQE9FfKOaxdmtjOIdSCBk7Te
 wsFExYRp3b0yCXEZTW2/kWbBJHEkoXAe+kvVDaixmdIu0A+LBtT7ujQa5syZ1dUU/PKb0C//4
 go7OTJkNn0RGHjez0U289o17+tU7C24NgmLqkFjBmJSPZF5CpAFlyD7+U+UqhIMHkzQEjSCk+
 wg5eDofsJAWHnWym4k+LToAPEoY20CbcxbnktMRESx959GiEDdEIc2f6ksA3MeSIPHv5mtgh6
 3Nc8eVD5weRtI+QRAiNXGM7DCtTlcwtyJv2ztfWDJUOGASXQ3iydDZbIOGECW4scfEYwpv4YG
 TRao5ny40GKFjZa8dwLOAeMyOVoUBd92tsx22TLwtr/JemnPd1ABXUxQhvbFDeC408ZOwCgKK
 wC+AbMq8Ut5MAzWkAQIjaEIkGLNaN4HiNjOMjRiUg5RUvkb0Wh95DEy/gDGPK+Pke0RE+5F+2
 JQeW1qhBA/SGEzXWeU1FwWlqt1tTzDoRz+w4a/8XXyYU0EquAZhmIlorev1O8d1b8SbE75QmN
 IBJvTUbvxRK3ARBuzoF8yRJzHXtB1a6Vtjaezh3O36ScfvvRZCeyTdeXpedS8999A6nU+F6PU
 iy+9pBdEm/SuMTiIYk7+D+FENN9X2yx8rU3o4BaO443MkQtRmNTTe4ej93oGq+v/+3sCVv85G
 /2CNl8dBsbQ3FZfBgo48ZrrpQAe6OvaUeYvTHtM7eBHLQd5B2kX0joLztzArbLEPJ3XADlBsC
 IOaEThqed1jn8o2ZP4vQROP42+EafOODA1/GTjszjZQt+FxE7wvdXEXBApi0HqJuS4+J8l0NI
 AKWRgvHZsym9jTa5zAaGAtazBKIZlU2w2gnKYglcjsyUFtFAauxzvGCVw74+TK/hjYlGYtkLW
 vLFf2lVdMYs1mhtH8E48dS+vMrO+jEDO0rjiOvyXNgskKq970mPqac49TvUSL4cmn39lMNgeV
 A3Hy+4cLU2ATy/5VKjy//Q40WZPs9rZzA4xYRb8eWBzXyMb2j9scJt6BwK1deo+DSfeQuRSOY
 cSN0ZcUTYkN5IRipn07+vEN4v/wVjzNu7yp+b/xs39g5/L3/7Rlj/ObwbUr5mRn+ahTTNrrld
 W1K/QsjpGpczMlOvoN8PejhVTGCFGxA1Wkrs9S+WxBSEThH1+SyK5lMfwxxrP3L+GNQ8RE3Zx
 eCSy4zPBK8/y6rJUYJcgGTdR2MPeB00jfS0NvnzImgAsYQqbaTwLxXtT5fqPTU2uRWiTzPvv7
 bmkKJgYd9gZPkiPg+JZsgxSXljqs0qsrNhdJ53UBSJx9POB7tavkwL6fu2JlyzX/XaSPH8MN1
 bu2CxjYaRgcNCE6aCutuD93Lxv/8qCTSOMD73xZFYBofGsSClmUoPey+zthBlKM4uS+3WO8S+
 Ss6WPLDh9ozrsC0qiQnTCbcSumycoGS3ccDQudCLVG8M4Gqwk7gFAGZrdc4hWIpUtP9qG//5h
 eqlNoy74APjTZ7j3rQFeHNFZ4OaL9Pc3OPqelLjGoapmenv9TR2aJMTh/i97AYJHnkArRtMK0
 yKHEKu9jqY+xA7ggHISfjf5MA50Khvnzz+wUnO5kku19x4B2I/juzm1kbzGqc6ENfECtx3Oft
 xR5dMG6KrZQS0W0V+MAgv6HbBwrIotP5zjVJ8F8OCXsRgiYPzwv18et6tdRHE/NhpxGBEF2GB
 YRw1WhxqWFOpFe2J7YEFy9Jp3rXlDQQrESXf/8ez+59n+4OLJpkvpnif0+OYHzkn2Acg9WVLv
 iWiyfEsVZOyPTW7D+8B6IY5cjKcikRlAsbHTWcVeGLp5+V8Z3BiATIjH1Lhk4kh4FDMHREg0r
 WTMXLsUzIKLa9N2i6FKxU+ZG7muxfUnteCCqSMd7ZjJYtmeaI2jRfjjhC62WD92NlPcGl9VUv
 58c+n6MEXw5D2JNiSnv6WBf8P33Di2s5z5Fr7XnKBFxdwcSS3UKC+sxiND8lo//I2tQxiS8fm
 UubCDzpJiakA+NECS5rnZhcpZxu5wfnYJv6Hb2cOBcm9sKGooUmiuDJhdnKEzJqMpcrcNrN3A
 EH2X+bnGvy0fL7dEkwHupDMYZn4Re/lj82dmrHBcoJ/XWVpbuc5Z6l+8E2JiaLbK2xcrc9363
 xgE6R3K6Vrv9OzY+s+Dica+zipI58XMFaD5kcHw+RbBjcKjpLts6tvh2lDIYeKwyDv/XnDLBi
 dxBKJbUt+l5ko43k5SFXdp29V2Lz/cJg1FCCWhhF4aRAhIRDX6RzbhL0P+lnumHfjmRYUkH4z
 kmiun0pbIvdf2l3+ex+OXvo3oiMmwQuGZwGelJsCVzc5cb/qp96+denjtuSkWTmsoMqOADCmT
 b4MF//l06SHNjFHdC/N3iQjky0Ko8lTzndGHTYy6k634yUxTUnO4sMMuCe5Vs42QQKmDVdYiD
 mmCwuMa6BABEnsn2lJttXYuLq63xkAkyzrP7tuX1BnLOAHBWeLr0FxOCzTAly5HzrZrOa0KcV
 uUUhqoq7g1Bg6NoWplhHxi3+Z7Gvx1uBFvprSOyNCNZNJv2laK4AHeDclDvSqQjKoKfJb0vt8
 iw07QKxx4jN26p5QBD8QRc2KoDIbZ944/Oid1CXR7Ag085Cl5um1RYXRin3sMal5BzCaX2ujI
 84z6DoaZCk+sh9QejxLWF5uw+q9p2oK+1cObxZo7UeiKmk4aOTXH9G8UyQuIXSadMuW13ETSu
 7Qn83xLrUnCkv5EWUg=

On 6/1/26 10:17 AM, Kristofer Karlsson via GitGitGadget wrote:
>    =20
>     Changes since v1:
>    =20
>      * Kept sift_down_root() and prio_queue_replace() completely unchang=
ed,
>        preserving Ren=C3=A9's optimization that avoids the get+put overh=
ead for
>        replace. The cascade approach now only applies to prio_queue_get(=
).

The prospect of no longer needing prio_queue_replace() had me excited in
round 1.  The benchmarks from commits that added its callers [1][2][3]
did show performance regressions with your patch 1 plus changes to
revert prio_queue_peek()+prio_queue_replace() to prio_queue_get()+
prio_queue_put(), but for two of them low enough to be in the noise.
'git describe $(git rev-list v2.41.0..v2.47.0)' took a 50%+ hit, though.

[1] a79e3519d6 (commit: use prio_queue_replace() in pop_most_recent_commit=
(), 2025-07-18)
[2] 08bb69d70f (describe: use prio_queue_replace(), 2025-08-03)
[3] abf05d856f (show-branch: use prio_queue, 2025-12-26)

>      * Extracted the new logic into a separate sift_up_rebalance() funct=
ion
>        rather than inlining it in prio_queue_get().
>    =20
>      * Updated benchmark numbers for ascending, descending and random
>        insertion ordering. No regressions in any scenario.

I don't see any regression for the benchmarks mentioned above with
patch 2 alone, unsurprisingly.  The describe command still takes that
50%+ performance hit after reverting [2] on top.

Would you be interested in benchmarking the following patch for making
prio_queue_replace() unnecessary by doing its optimization
automatically?  I get a 1% performance hit for the describe command
that I can't explain.  And it leaves the heap unbalanced after a
prio_queue_get(), which complicates things, so I found it lacking.
But I wonder how it stacks up against your cascade approach for your
use case and if there's anything to salvage.

Ren=C3=A9


=2D--
 prio-queue.c | 60 +++++++++++++++++++++++++++++++++++++++++--------------=
=2D----
 prio-queue.h |  1 +
 2 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/prio-queue.c b/prio-queue.c
index 9748528ce6..ba6b460a46 100644
=2D-- a/prio-queue.c
+++ b/prio-queue.c
@@ -34,12 +34,46 @@ void clear_prio_queue(struct prio_queue *queue)
 	queue->nr =3D 0;
 	queue->alloc =3D 0;
 	queue->insertion_ctr =3D 0;
+	queue->sift_down_root_pending =3D false;
+}
+
+static void sift_down_root(struct prio_queue *queue)
+{
+	size_t ix, child;
+
+	/* Push down the one at the root */
+	for (ix =3D 0; ix * 2 + 1 < queue->nr; ix =3D child) {
+		child =3D ix * 2 + 1; /* left */
+		if (child + 1 < queue->nr &&
+		    compare(queue, child, child + 1) >=3D 0)
+			child++; /* use right child */
+
+		if (compare(queue, ix, child) <=3D 0)
+			break;
+
+		swap(queue, child, ix);
+	}
+	queue->sift_down_root_pending =3D false;
 }
=20
 void prio_queue_put(struct prio_queue *queue, void *thing)
 {
 	size_t ix, parent;
=20
+	if (queue->sift_down_root_pending) {
+		/*
+		 * Restore the original heap size.  The last item is
+		 * still in the right place.
+		 */
+		queue->nr++;
+
+		/* Now fill the hole at the root with the new item. */
+		queue->array[0].ctr =3D queue->insertion_ctr++;
+		queue->array[0].data =3D thing;
+		sift_down_root(queue);
+		return;
+	}
+
 	/* Append at the end */
 	ALLOC_GROW(queue->array, queue->nr + 1, queue->alloc);
 	queue->array[queue->nr].ctr =3D queue->insertion_ctr++;
@@ -58,24 +92,6 @@ void prio_queue_put(struct prio_queue *queue, void *thi=
ng)
 	}
 }
=20
-static void sift_down_root(struct prio_queue *queue)
-{
-	size_t ix, child;
-
-	/* Push down the one at the root */
-	for (ix =3D 0; ix * 2 + 1 < queue->nr; ix =3D child) {
-		child =3D ix * 2 + 1; /* left */
-		if (child + 1 < queue->nr &&
-		    compare(queue, child, child + 1) >=3D 0)
-			child++; /* use right child */
-
-		if (compare(queue, ix, child) <=3D 0)
-			break;
-
-		swap(queue, child, ix);
-	}
-}
-
 void *prio_queue_get(struct prio_queue *queue)
 {
 	void *result;
@@ -85,12 +101,14 @@ void *prio_queue_get(struct prio_queue *queue)
 	if (!queue->compare)
 		return queue->array[--queue->nr].data; /* LIFO */
=20
+	if (queue->sift_down_root_pending)
+		sift_down_root(queue);
 	result =3D queue->array[0].data;
 	if (!--queue->nr)
 		return result;
=20
 	queue->array[0] =3D queue->array[queue->nr];
-	sift_down_root(queue);
+	queue->sift_down_root_pending =3D true;
 	return result;
 }
=20
@@ -100,6 +118,8 @@ void *prio_queue_peek(struct prio_queue *queue)
 		return NULL;
 	if (!queue->compare)
 		return queue->array[queue->nr - 1].data;
+	if (queue->sift_down_root_pending)
+		sift_down_root(queue);
 	return queue->array[0].data;
 }
=20
@@ -111,6 +131,8 @@ void prio_queue_replace(struct prio_queue *queue, void=
 *thing)
 		queue->array[queue->nr - 1].ctr =3D queue->insertion_ctr++;
 		queue->array[queue->nr - 1].data =3D thing;
 	} else {
+		if (queue->sift_down_root_pending)
+			sift_down_root(queue);
 		queue->array[0].ctr =3D queue->insertion_ctr++;
 		queue->array[0].data =3D thing;
 		sift_down_root(queue);
diff --git a/prio-queue.h b/prio-queue.h
index da7fad2f1f..5977fba438 100644
=2D-- a/prio-queue.h
+++ b/prio-queue.h
@@ -32,6 +32,7 @@ struct prio_queue {
 	void *cb_data;
 	size_t alloc, nr;
 	struct prio_queue_entry *array;
+	bool sift_down_root_pending;
 };
=20
 /*

