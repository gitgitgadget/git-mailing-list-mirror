Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HvNfeUfR"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D96FC
	for <git@vger.kernel.org>; Sun,  3 Dec 2023 05:15:11 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 189F41B5960;
	Sun,  3 Dec 2023 08:15:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AO+Zt/aaelndcEhz6a4Ft7SZI5cjx1PelsNe5Y
	Ur3bk=; b=HvNfeUfRNIA8AZ9a+lG2YsNUxxveHCTfl2Znczh3OiVnytPHnckA4+
	/bj3YtgEmV+rO1TK9VgitqKVlvuRctdUk2NFB55Fbzoej8Wm9oJiCwwOMklxpdOr
	Egh0mU1gS9NNBrDUaAodG7cV2aBHWMiJHCuOSSLaObGSBB/AU/Tio=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 093051B595F;
	Sun,  3 Dec 2023 08:15:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D0221B595E;
	Sun,  3 Dec 2023 08:15:08 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  SZEDER
 =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 4/4] completion: avoid user confusion in non-cone mode
In-Reply-To: <89501b366ff0476c1b3d36ff9b6b7c80fa6fc98f.1701583024.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Sun, 03 Dec 2023
	05:57:04 +0000")
References: <pull.1349.v2.git.1700985086.gitgitgadget@gmail.com>
	<pull.1349.v3.git.1701583024.gitgitgadget@gmail.com>
	<89501b366ff0476c1b3d36ff9b6b7c80fa6fc98f.1701583024.git.gitgitgadget@gmail.com>
Date: Sun, 03 Dec 2023 22:15:07 +0900
Message-ID: <xmqqv89f4eck.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FB6749B2-91DD-11EE-93AF-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -1581,7 +1581,12 @@ test_expect_success 'non-cone mode sparse-checkout uses bash completion' '
>  		# expected to be empty since we have not configured
>  		# custom completion for non-cone mode
>  		test_completion "git sparse-checkout set f" <<-\EOF
> -
> +		/folder1/0/1/t.txt 
> +		/folder1/expected 
> +		/folder1/out 
> +		/folder1/out_sorted 
> +		/folder2/0/t.txt 
> +		/folder3/t.txt 
>  		EOF

The "test_completion" helper strips "Z" at the end of its input
lines so that a hunk like this can be written without having to
worry about mail transport eating trailing whitespaces.

I'll squash the following while queuing.

Thanks.

 t/t9902-completion.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 5634b78fc5..aa9a614de3 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1581,12 +1581,12 @@ test_expect_success 'non-cone mode sparse-checkout gives rooted paths' '
 		# expected to be empty since we have not configured
 		# custom completion for non-cone mode
 		test_completion "git sparse-checkout set f" <<-\EOF
-		/folder1/0/1/t.txt
-		/folder1/expected
-		/folder1/out
-		/folder1/out_sorted
-		/folder2/0/t.txt
-		/folder3/t.txt
+		/folder1/0/1/t.txt Z
+		/folder1/expected Z
+		/folder1/out Z
+		/folder1/out_sorted Z
+		/folder2/0/t.txt Z
+		/folder3/t.txt Z
 		EOF
 	)
 '
