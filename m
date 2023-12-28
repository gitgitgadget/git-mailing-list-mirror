Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D492B10780
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 20:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F3MmEhLF"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 341A51F5C5;
	Thu, 28 Dec 2023 15:33:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WaQSW7+rNIJ8hF/NkAor/cd3+I8bW8Waip/OFK
	hO720=; b=F3MmEhLFv3Fq9nRHXSRZT+suks07mBqTiFnH9e1C7jNkwVDBu13st7
	9l8b/IP5MoYOEj5vs6RyE3/dsQmKFix9XWgv1KhZ3sEnJT2IENx7HhtJyB1Aurus
	HfNVE//CI3iNSrCzxqd1ISkrgp8IT1d7YcAG4nIO0Pabo7gOx7nno=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C4871F5C4;
	Thu, 28 Dec 2023 15:33:51 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CA1C61F5C3;
	Thu, 28 Dec 2023 15:33:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  Chandra
 Pratap <chandrapratap376@gmail.com>,  Chandra Pratap
 <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v4] sideband.c: remove redundant 'NEEDSWORK' tag
In-Reply-To: <pull.1625.v4.git.1703750460527.gitgitgadget@gmail.com> (Chandra
	Pratap via GitGitGadget's message of "Thu, 28 Dec 2023 08:01:00
	+0000")
References: <pull.1625.v3.git.1703672407895.gitgitgadget@gmail.com>
	<pull.1625.v4.git.1703750460527.gitgitgadget@gmail.com>
Date: Thu, 28 Dec 2023 12:33:46 -0800
Message-ID: <xmqq8r5egj85.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 672E3B56-A5C0-11EE-B3C6-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH v4] sideband.c: remove redundant 'NEEDSWORK' tag

The reason for removal is not that it was redundant and we said the
same thing elsewhere.  Rather, what it claimed to be necessary has
turned to be unwanted.  So something like

    Subject: sideband.c: update stale NEEDSWORK comment

    If we really wanted to change the type of the parameter to this
    function to "size_t", we should also update its callers to hold
    the values they use to compute the parameter also in "size_t".

    But in this callchain, "int" is wide enough.  Avoid tempting
    future developers into wasting their time on using "size_t"
    around this function.

or along that line would be more appropriate, perhaps?

Thanks.

> From: Chandra Pratap <chandrapratap3519@gmail.com>
>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>     sideband.c: replace int with size_t for clarity
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1625%2FChand-ra%2Fdusra-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1625/Chand-ra/dusra-v4
> Pull-Request: https://github.com/gitgitgadget/git/pull/1625
>
> Range-diff vs v3:
>
>  1:  273415aa6a4 ! 1:  8c003256e5b sideband.c: remove redundant 'NEEDSWORK' tag
>      @@ sideband.c: void list_config_color_sideband_slots(struct string_list *list, cons
>         *
>       - * NEEDSWORK: use "size_t n" instead for clarity.
>       + * It is fine to use "int n" here instead of "size_t n" as all calls to this
>      -+ * function pass an 'int' parameter.
>      ++ * function pass an 'int' parameter. Additionally, the buffer involved in
>      ++ * storing these 'int' values takes input from a packet via the pkt-line
>      ++ * interface, which is capable of transferring only 64kB at a time.
>         */
>        static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
>        {
>
>
>  sideband.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/sideband.c b/sideband.c
> index 6cbfd391c47..266a67342be 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -69,7 +69,10 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
>   * of the line. This should be called for a single line only, which is
>   * passed as the first N characters of the SRC array.
>   *
> - * NEEDSWORK: use "size_t n" instead for clarity.
> + * It is fine to use "int n" here instead of "size_t n" as all calls to this
> + * function pass an 'int' parameter. Additionally, the buffer involved in
> + * storing these 'int' values takes input from a packet via the pkt-line
> + * interface, which is capable of transferring only 64kB at a time.
>   */
>  static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
>  {
>
> base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
