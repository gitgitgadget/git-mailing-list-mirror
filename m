Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DF3C47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 21:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA9D20736
	for <git@archiver.kernel.org>; Mon, 11 May 2020 21:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BDVTjftQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgEKV05 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 17:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725810AbgEKV05 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 17:26:57 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECECC061A0C
        for <git@vger.kernel.org>; Mon, 11 May 2020 14:26:55 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b12so2543663plz.13
        for <git@vger.kernel.org>; Mon, 11 May 2020 14:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mOQl0XOFS4c+akaGAzY86a25WPoBIAvh5ZFxnS7Yj7c=;
        b=BDVTjftQmBnrNUaHnHIluD7hamLoSX1eS13C5Yp8GORDCC3ElMIrvkM0B6kUAE3XQ6
         n5E585twPF/fQb2wmInAuLh/fLBxNxE53ATNwUu7ydeM7c+3D16YSX2z+hmzn7k0NmEF
         YS+p7edzNsPyW+62Q6bwIYKZrBwl9/6B1/n3W3CEWkdLhVF9zT+7pXwhhv40GQHe60zZ
         XCrXqSWnc29QLY7jsrFJgpVJwcv4yuBeLunqZ7Z6OQIXLhmR2qpRJEAWtqbDqnVwUCot
         OWdkfACILpQIa9tvUuXcb8asrw7q6t3VDBGzPZazcHuTBi9iYXhYziABALD7QaboJZXS
         C22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mOQl0XOFS4c+akaGAzY86a25WPoBIAvh5ZFxnS7Yj7c=;
        b=Q/ErrIfSs7f8MfXTQwv1xN/XHpIzlcskIO3J9zVyArPeaeZc+L/WmihPTByX39hVOW
         KAxSmys8ty+TLvmsALwuGHGI7fBOI2nMM6alZ+0nwN8vjakdk5XufBpo9VzJJ2muAkmX
         aWpvCr/PiVhXuHtsWwtsJMvhQmtSI1HHBXS6tx0oEutKZkifYzAiCljTk/01KDHuGHBe
         coA/JS5+iMdy9o5OrjXf0LBrYg7WDo3u0pguWkV1/hLh04tAxnac8HBCozeivrdJyF1x
         xzmijFh3fX3WT/NULift3p6Hcm0ScZNwq3+fOx15kK1ySzPliXf/2uKlbWoEOP87jsY7
         lTQA==
X-Gm-Message-State: AGi0PuZpDsc+EsN91mLzJSZVJpSpRiGaDoLCEzB8VW0VJUUrupM7aia/
        q4i+UzBSk9BDS4WOlZCSkUfKSm8XWZ0=
X-Google-Smtp-Source: APiQypIHIJLNJvkOc+YWLCPuVED1BDYxjnGx7+TNk6uV9nxYpR+fMWxw7Fwho1uYYIy+Y1SjTqvHGQ==
X-Received: by 2002:a17:902:c403:: with SMTP id k3mr17156142plk.12.1589232414895;
        Mon, 11 May 2020 14:26:54 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id d10sm8304172pgo.10.2020.05.11.14.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 14:26:54 -0700 (PDT)
Date:   Mon, 11 May 2020 14:26:49 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] bugreport: collect list of populated hooks
Message-ID: <20200511212649.GJ77802@google.com>
References: <20200427233820.179891-1-emilyshaffer@google.com>
 <20200430012425.209122-1-emilyshaffer@google.com>
 <20200430015049.GA115238@google.com>
 <xmqqv9lgswar.fsf@gitster.c.googlers.com>
 <xmqqwo5wpqvg.fsf@gitster.c.googlers.com>
 <20200507210849.GH77802@google.com>
 <xmqqa72j2vmh.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa72j2vmh.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 07, 2020 at 04:06:14PM -0700, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> >>  test_expect_success 'indicates populated hooks' '
> >> -	test_when_finished rm git-bugreport-hooks.txt &&
> >> -	test_when_finished rm -fr .git/hooks &&
> >
> > I'm not sure it's necessary to lose these two lines. Especially the
> > generated bugreport I'd like to clean up.
> 
> I do not care either way, actually.  I left it so that it would be
> easier to debug the test by looking at the output.

That's a good point, although I was worried about the junk left behind
for other tests. I think I'd rather delete the junk, as people should
still be able to debug the test with "test_pause &&" and see the
contents of the temporary hook directory (verified locally).

> 
> >> +	rm -fr .git/hooks &&
> >>  	mkdir .git/hooks &&
> >> -	write_script .git/hooks/applypatch-msg &&
> >> -	write_script .git/hooks/prepare-commit-msg.sample &&
> >> +	for hook in applypatch-msg prepare-commit-msg.sample
> >> +	do
> >> +		write_script ".git/hooks/$hook" <<-\EOF || return 1
> >> +		echo "hook $hook exists"
> >> +		EOF
> >> +	done &&
> >
> > I like this placeholder script a lot.
> 
> I actually don't.  At least the final version should not quote EOF
> (otherwise $hook will appear verbatim).

ACK.

New patch inbound as discussed in standup.
 - Emily
