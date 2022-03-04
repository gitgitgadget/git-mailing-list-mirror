Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73185C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 20:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiCDUob (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 15:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiCDUoa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 15:44:30 -0500
Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E96223BD9
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 12:43:41 -0800 (PST)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id QEj6nYESYN0saQEj8nn4vZ; Fri, 04 Mar 2022 20:40:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1646426438; bh=Qq+Yvtugopy9upQyfYMtiqXhQvFicP9bYlh3eAGV7zg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=VOWS/WfiietkOmlpCba1BF12L4FtDcDN4tCAFG7dY97ac9DsfTRYDCgv587sEdx8+
         pgYZ+N/rUD8yANjk35uFNRRFYXyChO2bzDLogrlSgfMCqLdgGLBJuf725j+IAuDBZ/
         Gz8j/QnpgcM+ThFkxGpeAYP23r4lfMhT0j0k9BJCFXcUyRb8yOZ3XcDCASIxEPFQnb
         bGy/NCSwYQtPrK4AFKOcmCqJGewacR+piam0BshhB1zpY9S+txOrnImtzxxqaPx0mu
         xtvW/kri4YLFqk1FDPJrvtzzv98KMqzmRgUlSWOYNevIFQrAhqajnV2Rok84QJIPYl
         cAHQpBEC7lfUA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=Ecqr/NqC c=1 sm=1 tr=0 ts=62227946
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8 a=XVM1iQslriXvo_aB_QgA:9 a=QEXdDO2ut3YA:10
 a=RfR_gqz1fSpA9VikTjo0:22
X-AUTH: ramsayjones@:2500
Message-ID: <95cbca4c-ec26-853e-243f-461a365d9f71@ramsayjones.plus.com>
Date:   Fri, 4 Mar 2022 20:40:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] terminal: use flags for save_term()
Content-Language: en-GB
To:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Cc:     carenas@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220304131126.8293-2-phillip.wood123@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20220304131126.8293-2-phillip.wood123@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDkMbQJH0RmmVksZgYDnIw94mAnbictHDEcV7BuJ2+jACKK+jwNtUq2KEt/apHUtY0vNkTXoIpL2TDqTuMOaIvQBtSSkKoe4FeUQZI7DQzDJKmkwHdtu
 5Hykra9t+djx6SRYNbSbH5Vxi7nqwaR/pmdNWhjF+jThTFXDFrEr4hk38ehazN9u81E3Sdikrw0heB5zO9GgxpIKABPrNDpfYUQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

I have not studied/applied your patches, they are just floating
past my inbox, so please ignore me if I have misunderstood ...

On 04/03/2022 13:11, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> The next commit will add another flag in addition to the existing
> full_duplex so change the function signature to take an unsigned flags
> argument. Also alter the functions that call save_term() so that they
> can pass flags down to it.
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  compat/terminal.c | 41 +++++++++++++++++++++--------------------
>  compat/terminal.h |  5 ++++-
>  2 files changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/compat/terminal.c b/compat/terminal.c
> index d882dfa06e..bad8e04cd8 100644
> --- a/compat/terminal.c
> +++ b/compat/terminal.c
> @@ -34,7 +34,7 @@ void restore_term(void)
>  	sigchain_pop_common();
>  }
>  
> -int save_term(int full_duplex)
> +int save_term(unsigned flags)
>  {
>  	if (term_fd < 0)
>  		term_fd = open("/dev/tty", O_RDWR);
> @@ -47,11 +47,11 @@ int save_term(int full_duplex)
>  	return 0;
>  }
>  
> -static int disable_bits(tcflag_t bits)
> +static int disable_bits(unsigned flags, tcflag_t bits)

.. you add the 'flags' as the new first parameter ...

>  {
>  	struct termios t;
>  
> -	if (save_term(0) < 0)
> +	if (save_term(flags) < 0)
>  		goto error;
>  
>  	t = old_term;
> @@ -71,14 +71,14 @@ static int disable_bits(tcflag_t bits)
>  	return -1;
>  }
>  
> -static int disable_echo(void)
> +static int disable_echo(unsigned flags)
>  {
> -	return disable_bits(ECHO);
> +	return disable_bits(flags, ECHO);

.. and pass it as first parameter, good, and ...

>  }
>  
> -static int enable_non_canonical(void)
> +static int enable_non_canonical(unsigned flags)
>  {
> -	return disable_bits(ICANON | ECHO);
> +	return disable_bits(flags, ICANON | ECHO);

.. here as well, good, and ...

>  }
>  
>  #elif defined(GIT_WINDOWS_NATIVE)
> @@ -126,15 +126,15 @@ void restore_term(void)
>  	hconin = hconout = INVALID_HANDLE_VALUE;
>  }
>  
> -int save_term(int full_duplex)
> +int save_term(unsigned flags)
>  {
>  	hconin = CreateFileA("CONIN$", GENERIC_READ | GENERIC_WRITE,
>  	    FILE_SHARE_READ, NULL, OPEN_EXISTING,
>  	    FILE_ATTRIBUTE_NORMAL, NULL);
>  	if (hconin == INVALID_HANDLE_VALUE)
>  		return -1;
>  
> -	if (full_duplex) {
> +	if (flags & SAVE_TERM_DUPLEX) {
>  		hconout = CreateFileA("CONOUT$", GENERIC_READ | GENERIC_WRITE,
>  			FILE_SHARE_WRITE, NULL, OPEN_EXISTING,
>  			FILE_ATTRIBUTE_NORMAL, NULL);
> @@ -154,7 +154,7 @@ int save_term(int full_duplex)
>  	return -1;
>  }
>  
> -static int disable_bits(DWORD bits)
> +static int disable_bits(unsigned flags, DWORD bits)

.. Huh? Ah, the DWORD suggests this is in an #ifdef'd windows
part of the file, OK. ...

>  {
>  	if (use_stty) {
>  		struct child_process cp = CHILD_PROCESS_INIT;
> @@ -191,7 +191,7 @@ static int disable_bits(DWORD bits)
>  		use_stty = 0;
>  	}
>  
> -	if (save_term(0) < 0)
> +	if (save_term(flags) < 0)
>  		return -1;
>  
>  	if (!SetConsoleMode(hconin, cmode_in & ~bits)) {
> @@ -204,14 +204,15 @@ static int disable_bits(DWORD bits)
>  	return 0;
>  }
>  
> -static int disable_echo(void)
> +static int disable_echo(unsigned flags)
>  {
> -	return disable_bits(ENABLE_ECHO_INPUT);
> +	return disable_bits(ENABLE_ECHO_INPUT, flags);

.. but here, you pass the flags as the second parameter. ;-)

>  }
>  
> -static int enable_non_canonical(void)
> +static int enable_non_canonical(unsigned flags)
>  {
> -	return disable_bits(ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT);
> +	return disable_bits(ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT,
> +			    flags);

.. ditto here.

ATB,
Ramsay Jones


>  }
>  
>  /*
> @@ -267,7 +268,7 @@ char *git_terminal_prompt(const char *prompt, int echo)
>  		return NULL;
>  	}
>  
> -	if (!echo && disable_echo()) {
> +	if (!echo && disable_echo(0)) {
>  		fclose(input_fh);
>  		fclose(output_fh);
>  		return NULL;
> @@ -361,7 +362,7 @@ int read_key_without_echo(struct strbuf *buf)
>  	static int warning_displayed;
>  	int ch;
>  
> -	if (warning_displayed || enable_non_canonical() < 0) {
> +	if (warning_displayed || enable_non_canonical(0) < 0) {
>  		if (!warning_displayed) {
>  			warning("reading single keystrokes not supported on "
>  				"this platform; reading line instead");
> @@ -413,10 +414,10 @@ int read_key_without_echo(struct strbuf *buf)
>  
>  #else
>  
> -int save_term(int full_duplex)
> +int save_term(unsigned flags)
>  {
> -	/* full_duplex == 1, but no support available */
> -	return -full_duplex;
> +	/* no duplex support available */
> +	return -!!(flags & SAVE_TERM_DUPLEX);
>  }
>  
>  void restore_term(void)
> diff --git a/compat/terminal.h b/compat/terminal.h
> index 0fb9fa147c..f24b91390d 100644
> --- a/compat/terminal.h
> +++ b/compat/terminal.h
> @@ -1,14 +1,17 @@
>  #ifndef COMPAT_TERMINAL_H
>  #define COMPAT_TERMINAL_H
>  
> +/* Save input and output settings */
> +#define SAVE_TERM_DUPLEX (1u << 0)
> +
>  /*
>   * Save the terminal attributes so they can be restored later by a
>   * call to restore_term(). Note that every successful call to
>   * save_term() must be matched by a call to restore_term() even if the
>   * attributes have not been changed. Returns 0 on success, -1 on
>   * failure.
>   */
> -int save_term(int full_duplex);
> +int save_term(unsigned flags);
>  /* Restore the terminal attributes that were saved with save_term() */
>  void restore_term(void);
>  
