Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2B9C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 23:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C397C24672
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 23:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JyPWdR9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfLPXkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 18:40:43 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33661 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfLPXkm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 18:40:42 -0500
Received: by mail-pj1-f68.google.com with SMTP id r67so3713278pjb.0
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 15:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4nevVIX/EzvKD8MrFZqSTR/8gr//o2YenLW6v1Hv7FY=;
        b=JyPWdR9I8clOluQdBuTctex6zIogOoyq8lgrBlW1cFtAv/jBAZbXO3IgWC0NFZWzru
         UlbHewKAZSh0/i3gan+9/PBdqlwaaQwUIyjNL2wm3d1U59uSLdcvY4N2WssJa6dSQLIy
         PI8pd1nH2FwZD0ugqRky0XEgEnMvlAfz7Yy6A8m3eVTPul7zc6pvZuqzB5sU9HQB3Rh5
         fCCwEo0Ouu6Zozgc5Dqj9I5/IJwEN+a6bumZ287sYBS6VQSGJLKYJhBnpy9XaE00O5cf
         s5v/e5DI5EGBfc25WAh+0TGN6hL8drCEBfQB3jYQn2t4TyGlYe4pDYVqVbScakBWmY12
         vngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4nevVIX/EzvKD8MrFZqSTR/8gr//o2YenLW6v1Hv7FY=;
        b=HJX5Fx3lmBql9vnlum5LMf9o1QlhxvPbAfNg5omLuniA+q0PNjbRq56mqBEkBVvADl
         D7aNgnIOtSYUhXPhO1DgT6xX+K2rfp7/O83IhC9YNCq5YZIl2BCtuEtc94Vna50dtOXK
         FJXSsTevL99UwBGbdVv1jk4J8XtpL4oQOOb0a0D5rqWmKVpYNCpWdPEMRwFuuXeye6oW
         THZU+ChDKW28jsWxzAWEZhlvEyxNuTTl3WiSIs9cEiLAYYCDVj3/uJ0tMJjhKcr7E9PX
         eUJajU/Jm6GyHPbHczNErB2iJAvbc92Kn5oY+gIEO2sfxTCIghrL/woKKCMWTueeAxB0
         6waw==
X-Gm-Message-State: APjAAAVn4B9w4LWQ+KHfW1EvX1aSUwEW/JA4bZWx0Q9Tmo7fewUH4x2+
        sgQx7CA9ONzsuN1xO94su1AhJcUglws=
X-Google-Smtp-Source: APXvYqxpqR/jYFT/3A/8bBn8QozzvQmVFTMcvHqrFOZWD8nIcAFqhvCI+ihS7iHLnQS1T9ejlhlFXQ==
X-Received: by 2002:a17:90b:941:: with SMTP id dw1mr2406143pjb.21.1576539641891;
        Mon, 16 Dec 2019 15:40:41 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id u7sm269294pfh.128.2019.12.16.15.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 15:40:41 -0800 (PST)
Date:   Mon, 16 Dec 2019 15:40:36 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 10/15] bugreport: add config values from safelist
Message-ID: <20191216234036.GK135450@google.com>
References: <20191213004312.169753-1-emilyshaffer@google.com>
 <20191213004312.169753-11-emilyshaffer@google.com>
 <xmqq4ky3j3w4.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ky3j3w4.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 13, 2019 at 01:45:47PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Teach bugreport to gather the values of config options which are present
> > in 'bugreport-config-safelist.h'.
> >
> > Many config options are sensitive, and many Git add-ons use config
> > options which git-core does not know about; it is better only to gather
> > config options which we know to be safe, rather than excluding options
> > which we know to be unsafe.
> >
> > Taking the build-time generated array and putting it into a set saves us
> > time - since git_config_bugreport() is called for every option the user
> > has configured, performing option lookup in constant time is a useful
> > optimization.
> 
> Interesting.  I actually was expecting the look-up to go the other
> way around.  We know the safe keys, so iterate over them and grab
> their values, if defined.  No need for hashes or anything, but just
> a simple linear list of safe stuff.

Hm. Without looking at the code, I said to myself,
"repo_config_get_value() will open all the available config files to
find the resolved value, so I don't want to do n*4 file open/closes, I
only want to do 4 total."

Now I look at the code and see that the configs are already being read
into a hashset before now. So you're right that it doesn't make sense
for me to do it this way....

> 
> But that is too simple-minded.  If we wanted to safelist foo.*.bar,
> where '*' can be anything, walking on the list of safe variables
> would not work.  We must have a hash table that knows "foo.*.bar" is
> allowed, and while walking all the configuration keys, when we see
> foo.a.bar, we consult "foo.*.bar" as well as "foo.a.bar" to see if
> it is whitelisted, or something like that.

...unless we want to use wildcards like you suggest.

But I'm not sure it's a good idea. I envision someone writing another
Git add-on, which offers someone to specify "user.password" and
automagically do some Bitbucket interaction, or something. (An extreme
and misguided example, but I hope the point remains.) Then if I say,
"all the user.* configs I can see in 'git help config' are safe, so I
will just safelist user.*," I'm not accounting for this other tool's
known configs which are a superset of what Git knows and expects.

The point of this safelist-generation exercise is to avoid accidentally
printing some sensitive user config, and the point of using a safelist
instead of a blocklist is to avoid printing a third-party config we
didn't know about (or messing up our pattern matching). So I suggest we
avoid pattern matching entirely.

> 
> But then I am not sure if this implementation does something like
> this for three-level names.  If not, I do not see much point in use
> of the hash there either.
> 
> Puzzled.

I'd prefer to solve it by iterating over the compile-time-generated
safelist using get_config_value_multi(), which I clock at O(n) for n =
safelist length: performing n calls to an O(1) hashset lookup. That
saves us the O(n*log(n)) hashset population, and the implementation of
Yet Another Set in the source.

Thanks.

 - Emily
