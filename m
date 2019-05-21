Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F0E71F462
	for <e@80x24.org>; Tue, 21 May 2019 20:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfEUUd7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 16:33:59 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:26674 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbfEUUd7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 16:33:59 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 457nXx6RBBz5tlG;
        Tue, 21 May 2019 22:33:53 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 12877489B;
        Tue, 21 May 2019 22:33:53 +0200 (CEST)
Subject: Re: [PATCH v4] userdiff: add built-in pattern for rust
To:     marcandre.lureau@redhat.com
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>
References: <20190521105820.28511-1-marcandre.lureau@redhat.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <6d2cf89d-315e-f202-92cd-c7d9c5458164@kdbg.org>
Date:   Tue, 21 May 2019 22:33:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521105820.28511-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.05.19 um 12:58 schrieb marcandre.lureau@redhat.com:
> From: Marc-André Lureau <mlureau@redhat.com>
> 
> This adds xfuncname and word_regex patterns for Rust, a quite
> popular programming language. It also includes test cases for the
> xfuncname regex (t4018) and updated documentation.
> 
> The word_regex pattern finds identifiers, integers, floats and
> operators, according to the Rust Reference Book.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Acked-by: Johannes Sixt <j6t@kdbg.org>

> ---
>  Documentation/gitattributes.txt | 2 ++
>  t/t4018-diff-funcname.sh        | 1 +
>  t/t4018/rust-fn                 | 5 +++++
>  t/t4018/rust-impl               | 5 +++++
>  t/t4018/rust-nested-fn          | 6 ++++++
>  t/t4018/rust-struct             | 5 +++++
>  t/t4018/rust-trait              | 5 +++++
>  t/t4018/rust-trait-default      | 8 ++++++++
>  t/t4018/rust-unsafe             | 6 ++++++
>  userdiff.c                      | 6 ++++++
>  10 files changed, 49 insertions(+)
>  create mode 100644 t/t4018/rust-fn
>  create mode 100644 t/t4018/rust-impl
>  create mode 100644 t/t4018/rust-nested-fn
>  create mode 100644 t/t4018/rust-struct
>  create mode 100644 t/t4018/rust-trait
>  create mode 100644 t/t4018/rust-trait-default
>  create mode 100644 t/t4018/rust-unsafe
> 
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 4fb20cd0e9..07da08fb27 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -833,6 +833,8 @@ patterns are available:
>  
>  - `ruby` suitable for source code in the Ruby language.
>  
> +- `rust` suitable for source code in the Rust language.
> +
>  - `tex` suitable for source code for LaTeX documents.
>  
>  
> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index 22f9f88f0a..9261d6d3a0 100755
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -43,6 +43,7 @@ diffpatterns="
>  	php
>  	python
>  	ruby
> +	rust
>  	tex
>  	custom1
>  	custom2
> diff --git a/t/t4018/rust-fn b/t/t4018/rust-fn
> new file mode 100644
> index 0000000000..cbe02155f1
> --- /dev/null
> +++ b/t/t4018/rust-fn
> @@ -0,0 +1,5 @@
> +pub(self) fn RIGHT<T>(x: &[T]) where T: Debug {
> +    let _ = x;
> +    // a comment
> +    let a = ChangeMe;
> +}
> diff --git a/t/t4018/rust-impl b/t/t4018/rust-impl
> new file mode 100644
> index 0000000000..09df3cd93b
> --- /dev/null
> +++ b/t/t4018/rust-impl
> @@ -0,0 +1,5 @@
> +impl<'a, T: AsRef<[u8]>>  std::RIGHT for Git<'a> {
> +
> +    pub fn ChangeMe(&self) -> () {
> +    }
> +}
> diff --git a/t/t4018/rust-nested-fn b/t/t4018/rust-nested-fn
> new file mode 100644
> index 0000000000..ca5cca3292
> --- /dev/null
> +++ b/t/t4018/rust-nested-fn
> @@ -0,0 +1,6 @@
> +fn foo() {
> +    fn RIGHT() {
> +        // must catch nested function
> +        ChangeMe;
> +    }
> +}
> diff --git a/t/t4018/rust-struct b/t/t4018/rust-struct
> new file mode 100644
> index 0000000000..76aff1c0d8
> --- /dev/null
> +++ b/t/t4018/rust-struct
> @@ -0,0 +1,5 @@
> +#[derive(Debug)]
> +pub(super) struct RIGHT<'a> {
> +    name: &'a str,
> +    age: ChangeMe,
> +}
> diff --git a/t/t4018/rust-trait b/t/t4018/rust-trait
> new file mode 100644
> index 0000000000..ea397f09ed
> --- /dev/null
> +++ b/t/t4018/rust-trait
> @@ -0,0 +1,5 @@
> +unsafe trait RIGHT<T> {
> +    fn len(&self) -> u32;
> +    fn ChangeMe(&self, n: u32) -> T;
> +    fn iter<F>(&self, f: F) where F: Fn(T);
> +}
> diff --git a/t/t4018/rust-trait-default b/t/t4018/rust-trait-default
> new file mode 100644
> index 0000000000..e667d22ca4
> --- /dev/null
> +++ b/t/t4018/rust-trait-default
> @@ -0,0 +1,8 @@
> +trait RIGHT {
> +
> +    fn new(name: &'static str) -> Self;
> +
> +    fn ChangeMe(&self) {
> +        // should skip "new", and return trait name
> +    }
> +}
> diff --git a/t/t4018/rust-unsafe b/t/t4018/rust-unsafe
> new file mode 100644
> index 0000000000..fd4661a934
> --- /dev/null
> +++ b/t/t4018/rust-unsafe
> @@ -0,0 +1,6 @@
> +unsafe fn RIGHT(inc: u32) {
> +    unsafe {
> +        // don't catch unsafe block
> +        ChangeMe += inc;
> +    }
> +}
> diff --git a/userdiff.c b/userdiff.c
> index 3a78fbf504..2bcf105caf 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -130,6 +130,12 @@ PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
>  	 "(@|@@|\\$)?[a-zA-Z_][a-zA-Z0-9_]*"
>  	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
>  	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
> +PATTERNS("rust",
> +	 "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl)[< \t]+[^;]*)$",
> +	 /* -- */
> +	 "[a-zA-Z_][a-zA-Z0-9_]*"
> +	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
> +	 "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::"),
>  PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
>  	 "[={}\"]|[^={}\" \t]+"),
>  PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
> 
> base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
> 

