Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78854C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 23:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D3CF22447
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 23:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jR5qhrc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbgFSXBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 19:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbgFSXBo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 19:01:44 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F4BC06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 16:01:44 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i12so4703841pju.3
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 16:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NJmghY0wprSIB+AVvRQurn+g+88jDT+qaEdADDbS3zU=;
        b=jR5qhrc8e4AievX9xOHMsiGIwcEwIc0+GPRMySLmMg8dHxhaQZZq1Y1D0T3Fx6S2/i
         bBCp+dIXLNFOUFWbIFCIGyffzlDnIuWGL8KVNhiAqhhIXX5FwinpH2Euc3o+XN3UV33t
         npyWOEWfi9BmNr0oIRBhq3qOwCJQCFNSMHzHzvyo9ybHJB5dRCbVKzgkHIrOBqmGKT5y
         ppgfrAiJmFIuMkT0QSCrfueV8cYgN7CEeqC73CosvZOHdTG7pkvYs2cFXkmfCW23BciG
         +SzBK7EURpTMTNxrsq5ZvgG6PkwMDCsy9fPejAbTz+s5cgoqFdfANCntLvhBhpFpkyYu
         06EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NJmghY0wprSIB+AVvRQurn+g+88jDT+qaEdADDbS3zU=;
        b=hQv7Jts3zvY0JZ4W7LJPgOANE9/1P9zed7Cww/sUe6QZBG8Ox0S7sSYt0F3qcZwctw
         zSwVFX6oLvbv9PArP6Y5dbSiZCqenfQWBWVkWz3jVu+JGZLJTmNWnkhQdaPVS8KfBSdr
         oO8BE4D1nhwE4ZCLC4IUjgHbInZYBtKk/9P87DsBRjSg5OcA6IyLpoJlQsLe25X+IaIy
         1ePU423XmdxHLIvXv1MAb4HVnFFaYDFU1YYyoqvTbOjy/zkxbJAqURTzH2l01z6UMBjj
         8aWGQeL0hrSVwuRdnlRNI9YYJTOrNd7OLmuoeiEbqU3hy3vkjhX8rouveKov9kAdLpIJ
         mB+A==
X-Gm-Message-State: AOAM533DAh0RqcqiyGb5QDTnm74vDg6u1JvHtDK06nXXr/L2FjEeXjaR
        MCslY9p9TaFo/braw6rk9b24yxWn
X-Google-Smtp-Source: ABdhPJyy5BJAADgBUIEMlJsAQ4G2E/WQNfM//L/eq2JYoiZIAN0QI36m0961tWH47WwkUTfFtHyPyA==
X-Received: by 2002:a17:902:848d:: with SMTP id c13mr9875524plo.289.1592607704204;
        Fri, 19 Jun 2020 16:01:44 -0700 (PDT)
Received: from localhost ([2402:800:6375:a18c:ce1a:d70b:8a27:2927])
        by smtp.gmail.com with ESMTPSA id 84sm6127423pfu.167.2020.06.19.16.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 16:01:43 -0700 (PDT)
Date:   Sat, 20 Jun 2020 06:01:41 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     randall.s.becker@rogers.com, git@vger.kernel.org
Subject: Re: [Patch v1 1/3] bugreport.c: replace strbuf_write_fd with
 write_in_full
Message-ID: <20200619230141.GC5027@danh.dev>
References: <20200619150445.4380-1-randall.s.becker@rogers.com>
 <20200619150445.4380-2-randall.s.becker@rogers.com>
 <20200619163530.GB5027@danh.dev>
 <02a501d6465d$80366680$80a33380$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02a501d6465d$80366680$80a33380$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-06-19 13:17:19-0400, "Randall S. Becker" <rsbecker@nexbridge.com> wrote:
> On June 19, 2020 12:36 PM, Đoàn Trần Công Danh wrote:
> > On 2020-06-19 11:04:43-0400, randall.s.becker@rogers.com wrote:
> > > From: "Randall S. Becker" <rsbecker@nexbridge.com>
> > >
> > > The strbuf_write_fd method did not provide checks for buffers larger
> > > than MAX_IO_SIZE. Replacing with write_in_full ensures the entire
> > > buffer will always be written to disk or report an error and die.
> > >
> > > Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> > > ---
> > >  bugreport.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/bugreport.c b/bugreport.c index aa8a489c35..bc359b7fa8
> > > 100644
> > > --- a/bugreport.c
> > > +++ b/bugreport.c
> > > @@ -174,7 +174,10 @@ int cmd_main(int argc, const char **argv)
> > >  		die(_("couldn't create a new file at '%s'"), report_path.buf);
> > >  	}
> > >
> > > -	strbuf_write_fd(&buffer, report);
> > > +	if (write_in_full(report, buffer.buf, buffer.len) < 0) {
> > > +		die(_("couldn't write report contents '%s' to file '%s'"),
> > > +			buffer.buf, report_path.buf);
> > 
> > Doesn't this dump the whole report to the stderr?
> > If it's the case, the error would be very hard to grasp.
> 
> Where else can we put the error? By this point, we're likely out of
> disk or virtual memory.

Sorry, I forgot to suggest an alternatives.

I was thinking about ignore the report when writing the last email.

Since, the report is likely consists of multiple lines of text,
and they likely contains some single quote themselves.

Now, I think a bit more, I think it's way better to write as:

	if (write_in_full(report, buffer.buf, buffer.len) < 0)
		die(_("couldn't write the report contents to file '%s'.\n\n"
		"The original report was:\n\n"
		"%s\n"), report_path.buf, buffer.buf);

> > Nit: We wouldn't want the pair of {}.
> > 
> > > +	}
> > >  	close(report);
> 
> I'm not sure what you mean in this nit? {} are balanced. You mean in the error message?

Our style guides says we wouldn't want this pair of {} if it's single
statement.


-- 
Danh
