Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEAE51F462
	for <e@80x24.org>; Tue, 21 May 2019 10:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfEUK5Y convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 21 May 2019 06:57:24 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33430 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfEUK5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 06:57:24 -0400
Received: by mail-oi1-f196.google.com with SMTP id q186so5737668oia.0
        for <git@vger.kernel.org>; Tue, 21 May 2019 03:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8oT8HPjjo248HysjMAmMHHKLSCEs64fXfJYxlTH7NPY=;
        b=GdqU2cFDxiKJ4h0ee7ob3xL4hko9c7Obl7yb/Y/cB3Wk84hzCmnTzh+Mt4uNt7NCPM
         2eOd/4qeHVBu3/NBXdazXghSV+rFiUj0uHjai34QQxgVUlNtA6VVAIjrtVsW5fS4Mj4u
         10nbiCusLa3LuqZZ6csIecD8ogPjr28sCndE0pcL63NUEpK07cCWfZogRfWSqrFmN4k9
         5KGuIrxG4FtdmA75zVfaXR8asFZerYJ5EpAjzcj6e/Nwum3YjLzuiSmL1uLm/hY9Ukr3
         Eq79evJWXGdp+h9eGV6czdHtGT6FeIcLVfkqXT9V3mGAI2D43Y8gHhKkxlmqjgFnKvSi
         igpw==
X-Gm-Message-State: APjAAAW8liHVAHOlpQk6feLx9kVLHenqkrUTkqUh7vrdCD4/TPuvzT0b
        LH4SAee6NohNd6ivhMdnDEwgwd4RVtOkn2yRcWZdiZzTB7A=
X-Google-Smtp-Source: APXvYqwN33Z2sSlv25ULc5fmxYVORsRvNgNcVr8bRKU1FM1lWhPF7sxA8dICBfbByRtBp+Su5cfhIrLeTlBkLy37qSI=
X-Received: by 2002:aca:b344:: with SMTP id c65mr2937576oif.46.1558436243964;
 Tue, 21 May 2019 03:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190520170403.16672-1-marcandre.lureau@redhat.com> <e1c4c2ab-927d-fff9-b9e7-13943cba2273@kdbg.org>
In-Reply-To: <e1c4c2ab-927d-fff9-b9e7-13943cba2273@kdbg.org>
From:   =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date:   Tue, 21 May 2019 12:57:12 +0200
Message-ID: <CAMxuvay3ynFuP3fu57T0f9NEhjbCfM2hCUrdBHvxw-d1Jj54FA@mail.gmail.com>
Subject: Re: [PATCH v3] userdiff: add built-in pattern for rust
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On Mon, May 20, 2019 at 9:52 PM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 20.05.19 um 19:04 schrieb marcandre.lureau@redhat.com:
> > From: Marc-André Lureau <mlureau@redhat.com>
> >
> > This adds xfuncname and word_regex patterns for Rust, a quite
> > popular programming language. It also includes test cases for the
> > xfuncname regex (t4018) and updated documentation.
> >
> > The word_regex pattern finds identifiers, integers, floats and
> > operators, according to the Rust Reference Book.
>
> This looks very good. I have a few questions regarding the hunk header
> regex.
>
> > diff --git a/userdiff.c b/userdiff.c
> > index 3a78fbf504..e45b5920c6 100644
> > --- a/userdiff.c
> > +++ b/userdiff.c
> > @@ -130,6 +130,12 @@ PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
> >        "(@|@@|\\$)?[a-zA-Z_][a-zA-Z0-9_]*"
> >        "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
> >        "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
> > +PATTERNS("rust",
> > +      "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl(<.+>)?)[ \t]+[^;]*)$",
>
> This pattern matches only if there is no semicolon behind the signal
> words on the line. Is that important? Can you show a (test) case where a
> line with a semicolon would be picked incorrectly if '[^;]*' were
> simplified to '.*'?


Ok, I am adding:

trait RIGHT {

    fn new(name: &'static str) -> Self;

    fn ChangeMe(&self) {
        // should skip "new", and return trait name
    }
}

> You permit whitespace at the beginning of an anchor line. I guess that
> is to catch nested definitions. Or is it common style to write indented
> code? Can you show a test case where this makes sense?
>

sure, I thought it was already covered.

fn foo() {
    fn RIGHT() {
        // must catch nested function
        ChangeMe;
    }
}

(a simpler example would be a method implementation)

> Would it be sufficient to simplify
>
>     (struct|enum|union|mod|trait|fn|impl(<.+>)?)[ \t]+
> to
>     (struct|enum|union|mod|trait|fn|impl)[< \t]+
>
> as it is only important to exclude identifiers that start with these
> keywords.

I think that would be fine, ok I am changing it

>
> > +      /* -- */
> > +      "[a-zA-Z_][a-zA-Z0-9_]*"
> > +      "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
> > +      "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::"),
> >  PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
> >        "[={}\"]|[^={}\" \t]+"),
> >  PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
> >
> > base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
>
> -- Hannes
