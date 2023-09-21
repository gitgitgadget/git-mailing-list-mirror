Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074D8E7D0AA
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 21:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjIUVcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 17:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjIUVcg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 17:32:36 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B347EA17
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 14:08:42 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c5bf7871dcso12318165ad.1
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 14:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695330522; x=1695935322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AM+4mCx/WYRuQ/e4iZPpF/FL8yIYZ0T5DzhUcgxGgJk=;
        b=xbV98ZQ4O+6op7y5nGpQR85lndCOM1lg6jJyo2+KPZN8DIg+h8w1yVeznhSkGlj9HY
         JFNoMF8GhmCUb+I0F/uoYLPRwW21En7g/cZDIU6CTmEMWP4iYN3j2a/J796jXay8VIB1
         7QqESA0EVEOQ3zZ1vjdz5XXhwgM9FzvdUFI/dwiNExip2vJlBbsVi0VLc26iHfYPT9L/
         PsONJwFt5cvte0qutyuvp8UyL990pDWwyqp6p5BDbUVnJkwPjGakc2NAkmEq2EEKod16
         q2tVwSXjw2S2EHZMJMRIrL8XtVMhW45D0DuaISByNdvctZepou8VnqJDGxD/Z3tluLhg
         0VPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695330522; x=1695935322;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AM+4mCx/WYRuQ/e4iZPpF/FL8yIYZ0T5DzhUcgxGgJk=;
        b=CjbO5SbWJCGEFaPdO6knEELoezhvQLqJyzs3ir/XJwFtUxDIxgtfE/qFLuZvC4K8IM
         js/vWNtK6PEi2P4MS0JkIe9EXdwVxQqlN5jzaXALEFS9KKpWRkJFrDp6AJiZyOpolImQ
         YsC3Rd988L3lf8K42+q3MVoToo3Aa5ZQJ4eVCutLOVjBliSHpNwXWc8CD7g3txhzqeof
         qIW7TIsgoasq1jAIEV4m3LZX/JxVNP/O6N0tP6TutPVqDPWbLNaNLctuEmCb4pJkMdpx
         FlYGHPYVR1Lrwo9jJSG++wmv4iw69FW6OEd7IwISKS1k3Tqvphv28/ylTbjf1k66urm8
         tgIw==
X-Gm-Message-State: AOJu0YyIa2fPbXIkFvqv1uR9X7TgqmdiUH3ZJ5zf5HLY6DUg7JVyZcRX
        lUM/HShOqqIsVffvERYwvbNv5X0D15b+P4p6Cq9XFA==
X-Google-Smtp-Source: AGHT+IFd7Xpr211Mjl5amEW4SgfAQ1GyqFixINl9H6Hi0146SanywenPxnnUZQXY7rf3z/sVPj+oHA==
X-Received: by 2002:a17:903:278b:b0:1bd:edac:af44 with SMTP id jw11-20020a170903278b00b001bdedacaf44mr5915904plb.51.1695330521710;
        Thu, 21 Sep 2023 14:08:41 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:828c:91e1:20c5:c8f])
        by smtp.gmail.com with ESMTPSA id ji21-20020a170903325500b001b392bf9192sm1994976plb.145.2023.09.21.14.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 14:08:41 -0700 (PDT)
Date:   Thu, 21 Sep 2023 14:08:36 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        calvinwan@google.com, glencbz@gmail.com
Subject: Re: [PATCH v2 1/4] config: split out config_parse_options
Message-ID: <ZQyw1OcKmOeAEFPM@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        jonathantanmy@google.com, calvinwan@google.com, glencbz@gmail.com
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
 <cover.1692827403.git.steadmon@google.com>
 <5c676fbac370a2ba9d499ae2ef003e75b1d70081.1692827403.git.steadmon@google.com>
 <xmqq4jkpe3we.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4jkpe3we.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023.08.23 16:26, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > From: Glen Choo <chooglen@google.com>
> >
> > "struct config_options" is a disjoint set of options options used by the
> > config parser (e.g. event listners) and options used by
> > config_with_options() (e.g. to handle includes, choose which config
> > files to parse).
> 
> There is some punctuation missing on the first line.  Perhaps an em-dash
> between "options---options" or something like that?

Cleaned up this and an additional typo in the description.

> > Split parser-only options into config_parse_options.
> >
> > Signed-off-by: Glen Choo <chooglen@google.com>
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> >  bundle-uri.c |  2 +-
> >  config.c     | 14 +++++++-------
> >  config.h     | 37 ++++++++++++++++++++-----------------
> >  fsck.c       |  2 +-
> >  4 files changed, 29 insertions(+), 26 deletions(-)
> 
> > diff --git a/bundle-uri.c b/bundle-uri.c
> > index 4b5c49b93d..f93ca6a486 100644
> > --- a/bundle-uri.c
> > +++ b/bundle-uri.c
> > @@ -237,7 +237,7 @@ int bundle_uri_parse_config_format(const char *uri,
> >  				   struct bundle_list *list)
> >  {
> >  	int result;
> > -	struct config_options opts = {
> > +	struct config_parse_options opts = {
> >  		.error_action = CONFIG_ERROR_ERROR,
> >  	};
> 
> OK, and this one only needs the parse_options half, and presumably
> all hunks (other than the one that splits the struct into two in
> config.h) are about turning the users of config_options that only
> need config_parse_options half.
> 
> As we do not see any funny casts in the patch text, compilers should
> catch all questionable conversion in this step, if there were any.
> 
> OK.
