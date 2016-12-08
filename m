Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9D811FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 17:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbcLHRuw (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 12:50:52 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34988 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752669AbcLHRuv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 12:50:51 -0500
Received: by mail-pg0-f52.google.com with SMTP id p66so176228180pga.2
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 09:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RuDEe2o+yNvZYAgQUB//QiyLIyWC/vkgXiEugnS3yN8=;
        b=J3G0J5cGlDKTqTk8U0syVbnc+yu+GE8Jc6M6O2OEZosaeZBjT1nCU1Wy1bAvKzXwEz
         VxWxfte+ZYupr6LHPyIyspagUFQm9/k5gdzcN7q/4d6XtWClp2VR9sn7kv5J00uD/23e
         Ttl97jyVDvyo9bo+lk1jdM9UqaZBajtZyCLI+H9xMicvjhICpmprZ5K35KZcOxYROPIi
         6tDYepHfRH9eP61Y/sq4pf6R4wg8rL46daBKrVuEjnCEsTOnhviYtU6uQAfMNHtw/nhK
         o8Ip8f+u/re8zo3DGxuMRpMdA9HPe6GZ4as4qI8DUL4S0jANsz4n1+dTfYAifK10MqhP
         9PNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RuDEe2o+yNvZYAgQUB//QiyLIyWC/vkgXiEugnS3yN8=;
        b=dxGg+xV2OePGuZ9DFPtRguZXmMO/b4NqiSEXwCF4mDjcm4cy6V8OIwGmgkEl6ZXl/N
         Edg/t8+Lgwm0Zh8QetsZ4VExLaKKKc+doMZ9N/MFl93XmTwiD7ulaQvxMrEEdzjcWnpj
         vtLHFtH7V7ETxccr7EaQ9Y2Wh9HUDlNqadrLLmBSrOgv1DvJfFeg+abQlZuTR+1g4CJl
         70EbD8VJsRG/sedFTF/92Ww/Umk6f19jicSLrx6fBZHP0SShbNfP6B/1MbrwRdSsE75w
         qd3f3my7EJupTziCMMXuYISNqA/nKLnUmh6AAPmuI7/oMpgig/VYh2JDC/Gj84M8q7GF
         9vEQ==
X-Gm-Message-State: AKaTC00xIqkNJaeYh98CV0DnE70asUEW4r6EU6bPm4x4/dFpaGgZ8/IKz078s6gyfgq2ouZn
X-Received: by 10.99.159.26 with SMTP id g26mr133535196pge.62.1481219450589;
        Thu, 08 Dec 2016 09:50:50 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:5c3f:7794:7672:2048])
        by smtp.gmail.com with ESMTPSA id a7sm51619273pfl.87.2016.12.08.09.50.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 09:50:49 -0800 (PST)
Date:   Thu, 8 Dec 2016 09:50:48 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] real_path: make real_path thread-safe
Message-ID: <20161208175048.GN116201@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1480964316-99305-2-git-send-email-bmwill@google.com>
 <CAGZ79katWewdwU3ZDYDj-QZEeersx9XDPZuTdMJG_u_62YwMsg@mail.gmail.com>
 <20161205201619.GE68588@google.com>
 <CACsJy8BdUsGD-Bx=-qiP3cWt2AjwD1P3NTbqEnjnKa1v0TvySQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8BdUsGD-Bx=-qiP3cWt2AjwD1P3NTbqEnjnKa1v0TvySQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/08, Duy Nguyen wrote:
> On Tue, Dec 6, 2016 at 3:16 AM, Brandon Williams <bmwill@google.com> wrote:
> > On 12/05, Stefan Beller wrote:
> >> >  static const char *real_path_internal(const char *path, int die_on_error)
> >> >  {
> >> > -       static struct strbuf sb = STRBUF_INIT;
> >> > +       static struct strbuf resolved = STRBUF_INIT;
> >>
> >> Also by having this static here, it is not quite thread safe, yet.
> >>
> >> By removing the static here we cannot do the early cheap check as:
> >>
> >> >         /* We've already done it */
> >> > -       if (path == sb.buf)
> >> > +       if (path == resolved.buf)
> >> >                 return path;
> >>
> >> I wonder how often we run into this case; are there some callers explicitly
> >> relying on real_path_internal being cheap for repeated calls?
> >> (Maybe run the test suite with this early return instrumented? Not sure how
> >> to assess the impact of removing the cheap out return optimization)
> >>
> >> The long tail (i.e. the actual functionality) should actually be
> >> faster, I'd imagine
> >> as we do less than with using chdir.
> >
> > Depends on how expensive the chdir calls were.  And I'm working to get
> > rid of the static buffer.  Just need have the callers own the memory
> > first.
> 
> I suggest you turn this real_path_internal into strbuf_real_path. In
> other words, it takes a strbuf and writes the result there, allocating
> memory if needed.
> 
> This function can replace the two strbuf_addstr(..., real_path(..));
> we have in setup.c and sha1_file.c. real_path() can own a static
> strbuf buffer to retain current behavior. We could also have a new
> wrapper real_pathdup() around strbuf_real_path(), which can replace 9
> instances of xstrdup(real_path(...)) (and Stefan is adding a few more;
> that's what led me back to these mails)

Sounds like a plan, thanks for the advice.

-- 
Brandon Williams
