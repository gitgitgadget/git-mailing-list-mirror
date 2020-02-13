Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCE5C352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 22:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875BE20873
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 22:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ESjAaRYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgBMW6l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:58:41 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43831 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgBMW6l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 17:58:41 -0500
Received: by mail-pg1-f193.google.com with SMTP id u12so3546509pgb.10
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 14:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mrXp2lHXpVoViZQXJIaAKH76DEz/hpcaRSROR4BEVJI=;
        b=ESjAaRYfOS0VSsZ3XOAYWkne3qv4Boo0O7P41cldGQ9mxFmmwGCFc8lbNRgkbuUrgB
         alyUb3rmd+xgvGRn8NZNNkSZNYGMwABLJAPYemaglUGjC4fK3i9koj7/nKVOpbzXKdVi
         /g97lPUfE9Quki+gxBJR0t/0JNnnL+5Pca6gMLPZZJaWuyMLm5ZhYrx5UnMptY/iIe7R
         0qkwZzkSSolpmHXdMpUcGhM4d5h1N0uWgOXOgnEOceVlEbeVGaVUbJZKwmO7BRe+0DxM
         PK8n3dW/9Z1zp9Exvg3+9i665zy5FVXtjsYaivYo+BLr4UCOsQzwYXdZFJcZXn12gbfD
         yeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mrXp2lHXpVoViZQXJIaAKH76DEz/hpcaRSROR4BEVJI=;
        b=MeugYWtqoSpZcZW9sg1c9yWAMH7xGlw2ayjXKnUHBWcJu0C3s/4xEGaT2D2uJBHWnr
         BmwLeWWX3y0ACyUdBc7tGmvVZEYFarQv5zPisT3YkhIKWwCVqVQcG7v+f4P2UrskM3Vx
         HhyDoNowS2SeKErz9vAdCzR0oVgtlVXSNMKQ3S2oCxby5YtN73C1Zwj7UU5W7g+OtviP
         rJJgudT1OnaWhtbXGIt6vvd36UMnQZwD4jZapfn6DURay2oJBDq48A98g+goO+SMebdM
         VAe4F2cozbMuN6XgIoeUl57WkU2OR4jAMKtjXI+QVxZ+luNSk8cFCHTn/YlkiYZhR6UN
         kxwg==
X-Gm-Message-State: APjAAAWNXiSvFImvBJGmwHU1o38jfb49RwWkj7UC0NTzLQCwRTS5nxbK
        acLUQzTflUIDEUG8r88TObnVTVJdsCo=
X-Google-Smtp-Source: APXvYqxKJMXYBpuSNfpfKWZCdBpKoevAlCwXp9/KUSxwaFYrLm4uTCE/UmBooRCx0V65igLvS9W96w==
X-Received: by 2002:aa7:93a6:: with SMTP id x6mr151500pff.72.1581634719806;
        Thu, 13 Feb 2020 14:58:39 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id e10sm4211340pgt.78.2020.02.13.14.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 14:58:38 -0800 (PST)
Date:   Thu, 13 Feb 2020 14:58:34 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 01/15] help: move list_config_help to builtin/help
Message-ID: <20200213225834.GI190927@google.com>
References: <20200206004108.261317-1-emilyshaffer@google.com>
 <20200206004108.261317-2-emilyshaffer@google.com>
 <20200206013533.GA3993@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206013533.GA3993@danh.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 06, 2020 at 08:35:33AM +0700, Danh Doan wrote:
> On 2020-02-05 16:40:54-0800, Emily Shaffer <emilyshaffer@google.com> wrote:
> > diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> > index 71158f7d8b..45fecf8bdf 100755
> > --- a/generate-cmdlist.sh
> > +++ b/generate-cmdlist.sh
> > @@ -76,23 +76,6 @@ print_command_list () {
> >  	echo "};"
> >  }
> >  
> > -print_config_list () {
> > -	cat <<EOF
> > -static const char *config_name_list[] = {
> > -EOF
> > -	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/config/*.txt |
> > -	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
> > -	sort |
> > -	while read line
> > -	do
> > -		echo "	\"$line\","
> > -	done
> > -	cat <<EOF
> > -	NULL,
> > -};
> > -EOF
> > -}
> > -
> >  exclude_programs=
> >  while test "--exclude-program" = "$1"
> >  do
> > @@ -113,5 +96,3 @@ echo
> >  define_category_names "$1"
> >  echo
> >  print_command_list "$1"
> > -echo
> > -print_config_list
> > diff --git a/generate-configlist.sh b/generate-configlist.sh
> > new file mode 100755
> > index 0000000000..eca6a00c30
> > --- /dev/null
> > +++ b/generate-configlist.sh
> > @@ -0,0 +1,24 @@
> > +#!/bin/sh
> > +
> > +echo "/* Automatically generated by generate-configlist.sh */"
> > +echo
> > +
> > +print_config_list () {
> > +	cat <<EOF
> > +static const char *config_name_list[] = {
> > +EOF
> > +	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/config/*.txt |
> > +	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
> > +	sort |
> > +	while read line
> > +	do
> > +		echo "	\"$line\","
> > +	done
> 
> This while-read-echo was moved from generate-cmdlist.sh,
> which has some logic to work with read-variable.
> 
> We're moving it out, I think apply this diff on top of it will make the code easier to read.
> 
> diff --git a/generate-configlist.sh b/generate-configlist.sh
> index eca6a00c30..163dbf30bb 100755
> --- a/generate-configlist.sh
> +++ b/generate-configlist.sh
> @@ -10,10 +10,7 @@ EOF
>  	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/config/*.txt |
>  	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
>  	sort |
> -	while read line
> -	do
> -		echo "	\"$line\","
> -	done
> +	sed 's/^/	"/; s/$/",/'
>  	cat <<EOF
>  	NULL,
>  };

Thanks for the suggestion. You're right that I didn't look into the
contents of this script much, because I was just moving it; I modified
your sed expression slightly so it performs just one operation:

  sed 's/^.*$/    "\0",/'

 - Emily
