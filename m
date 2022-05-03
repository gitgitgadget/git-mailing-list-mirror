Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98FDC433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 01:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiECBNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 21:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiECBN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 21:13:29 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF684093A
        for <git@vger.kernel.org>; Mon,  2 May 2022 18:09:51 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id e3so13925465ios.6
        for <git@vger.kernel.org>; Mon, 02 May 2022 18:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SvdNLRA2s1qzR9Moj6Me5a5/SRkWLPY3U/IPji5HmZs=;
        b=CMfLW+N9O2/0AUEqc9X9gWLO5uMIjkW0uiZgHQADPtpUcUcCT2WvfzIeAYUaDK/CF6
         KHSUs+OvobNL75iAVAO/Q8puv1+fqbBX5590ynIG0MoqdfLolEfsCwaca6cESwRVN60L
         92W9gU+GvsosfzHCC1+vmfd7diuDs44o93bnVQyrcLzd3Q/B2GhDFBHkE7Kbhc0RJjUs
         mWyFvAr74JFEL+WA9r9JcApcCy6G3LGgn4bN76gOX9f53giiEqFYF02b5NpPc0dedUVg
         vvl3VHEsMBd84CvC0ScyAo9qN3Gp7C1orRm1wi1UlstHWyqBhaoxf8uUgIx8bd7n2zeQ
         WbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SvdNLRA2s1qzR9Moj6Me5a5/SRkWLPY3U/IPji5HmZs=;
        b=SOuoO6VuO+sh8AKyWYNnXcLCy9kL6s35dek2ANmG+LZ3MF4xhOOAiT1yijl67MXTmp
         VMYw+KcxJ8FWbe3Uw1XVGQp7mz5EEfo7aJWH2Mw3wSLD1bLMbrIn9Isg6uMseRwFqv9Z
         1+Mx1b9ZbBNzgEVwkGQYSdq4BwjnSrPqVUfkpm2jkYkGEnBZy47knAp6sDn8EdGukimz
         1DWxA+9VJdLhQAV+XzweJepUs8eJwigubmOLoS4R8xl0khGLzf4AvcGq0eZvrPhN1fts
         yL65aRLVRl19pxX8mudsgbuXUUxAB4tsunWOfoYmuDob1qE+MGMsP0K0lcWjeMOM9dkt
         z5yA==
X-Gm-Message-State: AOAM530Q3zZslph16wG7JqYuuuI/348hFdlxZmi93ab19wR+sF6J7sgz
        lxXxv2LibWXITb3TYL9/wnGRMkC0A5Ghm2t/
X-Google-Smtp-Source: ABdhPJzGcRwJ/yvGAtlZfrCeTQDLLE7Qy9AiNMfLCndmRBBdP9q+Q+UQIyzegZUAV/+sVJf3ixFYTQ==
X-Received: by 2002:a05:6638:617:b0:32a:de4f:7772 with SMTP id g23-20020a056638061700b0032ade4f7772mr5988984jar.155.1651539774752;
        Mon, 02 May 2022 18:02:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v15-20020a056e020f8f00b002cde6e352d1sm3096341ilo.27.2022.05.02.18.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 18:02:54 -0700 (PDT)
Date:   Mon, 2 May 2022 21:02:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brad Beam <brad.beam@b-rad.info>, git@vger.kernel.org
Subject: Re: Bug report - ssh signing causes git tag -l malloc failed
Message-ID: <YnB/Pam2ti1A8c0e@nand.local>
References: <16668F1B-7670-4136-8AAF-ABAAA802C7D4@b-rad.info>
 <xmqq7d73y97i.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7d73y97i.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 02, 2022 at 01:24:01PM -0700, Junio C Hamano wrote:
> Brad Beam <brad.beam@b-rad.info> writes:
>
> Thanks for a report.
>
> > What did you do before the bug happened? (Steps to reproduce your
> > issue)
> >
> > When using ssh signing `git tag -l --format='%(contents:body)'
> > <tag>` returns `fatal: Out of memory, malloc failed (tried to
> > allocate 18446744073709551323 bytes)`
>
> An obvious first follow-up question is if there is any difference in
> behaviour if another kind of signing (like PGP) is used.

It works when using gpg.format=openpgp, and breaks reliably when signing
using OpenSSH. The simplest reproduction I could come up with is:

    git init repo
    (
      cd repo
      >foo
      git add foo
      git commit -m "$(date)"
      git tag -sam foo foo
    )

I think the difference is that when signing with OpenPGP, the "foo" tag
looks like this:

    $ git -C repo cat-file -p foo
    object d9b42c39c8520b2b9d62d67aa4138e1a28ce7aee
    type commit
    tag foo
    tagger Taylor Blau <me@ttaylorr.com> 1651538928 -0400

    foo
    -----BEGIN PGP SIGNATURE-----

    iQEzBAABCgAdFiEEuSAhSeE5DcWB+EsnUHZwBbY/KHsFAmJwe/AACgkQUHZwBbY/
    [...]

and with OpenSSH, the tag object looks like:

    $ git -C repo cat-file -p foo
    object 64303f1200e1114d91f250cede3245364b07fce7
    type commit
    tag foo
    tagger Taylor Blau <me@ttaylorr.com> 1651538975 -0400

    foo
    -----BEGIN SSH SIGNATURE-----
    U1NIU0lHAAAAAQAAARcAAAAHc3NoLXJzYQAAAAMBAAEAAAEBAPKMdi3zhEm/soWtUUR9bZ
    [...]

note the missing newline after "-----BEGIN SSH SIGNATURE-----", which
confuses ref-filter.c:find_subpos(). In particular, it seems to confuse
the code near the comment "subject goes to first empty line before
signature begins", since the OpenSSH-signed version of "foo" treats the
entire message (including the signature itself) as the subject.

That puts buf after sigstart, meaning that *nonsiglen gets assigned to a
negative number and overflows. Luckily this just results in a bogus
malloc call which crashes us, so I don't think this is meaningfully
exploitable.

The following diff seems to do the trick by restoring the intent of our
"scooch batch 'eol' if it goes beyond 'sigstart'" to the case where we
just assume the whole message is the subject. Folks more familiar with
this code are more than welcome to chime in ;).

--- 8< ---
diff --git a/ref-filter.c b/ref-filter.c
index 7838bd22b8..1d69e28d68 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1376,12 +1376,14 @@ static void find_subpos(const char *buf,
 	*sub = buf;
 	/* subject goes to first empty line before signature begins */
 	if ((eol = strstr(*sub, "\n\n"))) {
-		eol = eol < sigstart ? eol : sigstart;
+		;
 	/* check if message uses CRLF */
 	} else if (! (eol = strstr(*sub, "\r\n\r\n"))) {
 		/* treat whole message as subject */
 		eol = strrchr(*sub, '\0');
 	}
+	if (sigstart < eol)
+		eol = sigstart;
 	buf = eol;
 	*sublen = buf - *sub;
 	/* drop trailing newline, if present */
--- >8 ---

Thanks,
Taylor
