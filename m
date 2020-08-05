Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C416C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B9F206B6
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="UnGRHHYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgHERmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbgHERkG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:40:06 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998ABC0D941B
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 08:15:09 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b14so40260084qkn.4
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 08:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pWtrNzHuCo7oNBwfl3sALI7aUqszYVwJiow2xXjFHRo=;
        b=UnGRHHYQtFbN/tcLyuhzHVvKR+s6jEz9F1H1aQ0XTnUibo0XHscKV94fi/h3tMk9fa
         5VA0zt1yS2QaJrgT+MOhRGVKcmr8sSFitXR7GfKzVcVsirDVf+MaUXR5peLKof2a2Tvj
         A2Qnw/bS354LdyaHo0Xo47sfJJ3Idv1EYhfXv3iQOOYG//H8CUMYHu5BaFk9UCLny+1u
         mMt8dYBb9Hph+UecNd5VLxJVcWNrbo6bA6Y9dSyQDPTM8zNmbKbK3qY5cXuQhqsDc52K
         z9KZ9ql6H+I/vErt+7FeHRg+wunbOYChuKvixupl0fAwG+7Dkp9W2igpTFZxLSBcPp30
         VfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pWtrNzHuCo7oNBwfl3sALI7aUqszYVwJiow2xXjFHRo=;
        b=Qidh2Ve7T5S1TBWHXnPbpmkaA/DK1MnI24L8Cs6ikw9ou0rV4droAIcuC6fx9l2Dzt
         XWe9MFHfjW3YElGPTQyaEdhFF8B3uUFEc0JzXNM+bIQCnfSzsVRhNEgY6ld7Thy4DVDt
         HZES+H3dCtYYB+KrjXNNCS91/POFTByuA3/tYj0WrN9fYmjI7jdbptj3p3Ti4zdRTcrG
         Yh71OVoari217oY4366majLFexVxRrUpR9dXxlhgNPjEHKvaK0WdyElKA4ShMOdy+b8R
         He3SjIuu5oJtCSR4LJ4N8ewWCRlcpKLwOj9pe2Zy1VEKR/RuE8NCNFGLVvSjOz69F8gk
         1E5g==
X-Gm-Message-State: AOAM533ai7YyM1w3eHPwccaxbnqaWnfB0bEdJSfSzVh9MBvf1R/LfB45
        xv1tIrhnKmMJSx6Irf3K6UyPtA==
X-Google-Smtp-Source: ABdhPJzfAAz06eQ/K2oZXOj/VbfiAKlFOvIxSruBaR5Wekl3Ca3tZ09Q1VZ2XzYvrKIa6JmvjLn5Dg==
X-Received: by 2002:a05:620a:539:: with SMTP id h25mr3807280qkh.151.1596640508735;
        Wed, 05 Aug 2020 08:15:08 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id v45sm2336644qtc.42.2020.08.05.08.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 08:15:08 -0700 (PDT)
Date:   Wed, 5 Aug 2020 11:15:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/3] config: work around gcc-10 -Wstringop-overflow
 warning
Message-ID: <20200805151507.GC9546@syl.lan>
References: <20200804074146.GA190027@coredump.intra.peff.net>
 <20200804074353.GA284046@coredump.intra.peff.net>
 <xmqqv9hys7ag.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqv9hys7ag.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 04, 2020 at 09:30:15AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > Compiling with gcc-10, -O2, and -fsanitize=undefined results in a
> > compiler warning:
> >
> >   config.c: In function ‘git_config_copy_or_rename_section_in_file’:
> >   config.c:3170:17: error: writing 1 byte into a region of size 0 [-Werror=stringop-overflow=]
> >    3170 |       output[0] = '\t';
> >         |       ~~~~~~~~~~^~~~~~
> >   config.c:3076:7: note: at offset -1 to object ‘buf’ with size 1024 declared here
> >    3076 |  char buf[1024];
> >         |       ^~~
> >
> > This is a false positive. The interesting lines of code are:
> >
> >   int i;
> >   char *output = buf;
> >   ...
> >   for (i = 0; buf[i] && isspace(buf[i]); i++)
> >           ; /* do nothing */
> >   ...
> >   int offset;
> >   offset = section_name_match(&buf[i], old_name);
> >   if (offset > 0) {
> >           ...
> >           output += offset + i;
> >           if (strlen(output) > 0) {
> > 		  /*
> > 		   * More content means there's
> > 		   * a declaration to put on the
> > 		   * next line; indent with a
> > 		   * tab
> > 		   */
> > 		  output -= 1;
> > 		  output[0] = '\t';
> > 	  }
> >   }
> >
> > So we do assign output to buf initially. Later we increment it based on
> > "offset" and "i" and then subtract "1" from it. That latter step is what
> > the compiler is complaining about; it could lead to going off the left
> > side of the array if "output == buf" at the moment of the subtraction.
> > For that to be the case, then "offset + i" would have to be 0. But that
> > can't happen:
> >
> >   - we know that "offset" is at least 1, since we're in a conditional
> >     block that checks that
> >
> >   - we know that "i" is not negative, since it started at 0 and only
> >     incremented over whitespace
> >
> > So the sum must be at least 1, and therefore it's OK to subtract one
> > from "output".
> >
> > But that's not quite the whole story. Since "i" is an int, it could in
> > theory be possible to overflow to negative (when counting whitespace on
> > a very large string). But we know that's impossible because we're
> > counting the 1024-byte buffer we just fed to fgets(), so it can never be
> > larger than that.
> >
> > Switching the type of "i" to "unsigned" makes the warning go away, so
> > let's do that.
> >
> > Arguably size_t is an even better type (for this and for the other
> > length fields), but switching to it produces a similar but distinct
> > warning:
> >
> >   config.c: In function ‘git_config_copy_or_rename_section_in_file’:
> >   config.c:3170:13: error: array subscript -1 is outside array bounds of ‘char[1024]’ [-Werror=array-bounds]
> >    3170 |       output[0] = '\t';
> >         |       ~~~~~~^~~
> >   config.c:3076:7: note: while referencing ‘buf’
> >    3076 |  char buf[1024];
> >         |       ^~~
> >
> > If we were to ever switch off of fgets() to strbuf_getline() or similar,
> > we'd probably need to use size_t to avoid other overflow problems. But
> > for now we know we're safe because of the small fixed size of our
> > buffer.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
>
> Thanks.  80 lines of informative log message to explain a one liner
> was surprisingly pleasnt to read.  Nicely done.

Agreed, and sorry that this took me so long to read (I thought that I
had read it when you sent it, but apparently not). Your reasoning is
sensible, and I agree that your fix is appropriate.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

> >  config.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/config.c b/config.c
> > index 8db9c77098..2b79fe76ad 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -3115,7 +3115,7 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
> >  	}
> >
> >  	while (fgets(buf, sizeof(buf), config_file)) {
> > -		int i;
> > +		unsigned i;
> >  		int length;
> >  		int is_section = 0;
> >  		char *output = buf;

Thanks,
Taylor
