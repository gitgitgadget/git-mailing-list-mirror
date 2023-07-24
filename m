Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68188C001B0
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 18:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjGXSM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 14:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjGXSMv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 14:12:51 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2754FA
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 11:12:49 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6686ef86110so2559513b3a.2
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 11:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690222369; x=1690827169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=md1hqNhwSDxORK4l7nKi2uokzBW1yBmWb2gx3E/bsqE=;
        b=clv/fUizx6wuEiOspgywLUY2exTQuA/hpXBKGlVnPC+6/DscSUqvjqZj9jd3+baAJ7
         x+dqtqK1PqDXmv5bjN7NGCE81nNwDZ3GJ+9vMjv13jhjrOSm6Jz6tsHXE+B9otWwsGcs
         9hiD0XyXiPt+olCTjEqYuNSKi+PJo4K/1klkPrEwKb/pIpiq4ddQTZN5KyA8J54ffBCD
         BCEwS+1FmGwduUDhCGf/nERzYS4z2VpVaiizxu4x2u7nM4nd+gqTN7Ew0BuqrL1Vfg4T
         c0SCUO8fbjjLtMxtfgps3oOMyRtwbwTW1sYd/cgLiQyoe6Yu5lI9Dg5522Vx7BbNRZ08
         luTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690222369; x=1690827169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=md1hqNhwSDxORK4l7nKi2uokzBW1yBmWb2gx3E/bsqE=;
        b=Uious6P8iEovgWVX7Z2ZOF8slJRMAXb4z296FPvHs7x6k44xBHjpuM6QtHe0AcIK8h
         adboPMVYC5G9nfrZFkCpD/0ocSyRJQA23xjJyAVrAHuY10wbPkDpGXNMi2UaHdGbELKO
         m1PyykDL7nk2fbIEFXAAnq9iyuY3ajFDLyp/7ptcH/KlebMiTblaWjC+R6Tgf6B8WQgr
         zUjjYVF1JBO5WZuA8jwfKqKvYJc5s17fnztdHAlgk1nsRn3PADxy3MIYgPCNCoXNAuqF
         xZtwJgxsPJHiBVDBcjXUHh1Hn9/Io6ri9hcnbmeWMF/RckUYsjWWn+IRaravM/zXQnyG
         1P3w==
X-Gm-Message-State: ABy/qLaljT8zsp+8cUZQ7Xud0Ch5EuR6UcDyJI2N3cTdKp0A4ZyOg7Lb
        p5TKXns5jaVyUDarfLmBY9WMrXrrJqYmqlKc
X-Google-Smtp-Source: APBJJlFTo9QAVChASrmQYBRmEN4Yg/WR6cJ4CMezkC9Rd4yTtx5UWw6sykY+TcQ/puqUV7NFbi48RA==
X-Received: by 2002:a05:6a00:1799:b0:668:69fa:f78f with SMTP id s25-20020a056a00179900b0066869faf78fmr7950985pfg.1.1690222369116;
        Mon, 24 Jul 2023 11:12:49 -0700 (PDT)
Received: from five231003 ([49.37.159.20])
        by smtp.gmail.com with ESMTPSA id k11-20020aa792cb000000b00682868714fdsm8302414pfa.95.2023.07.24.11.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 11:12:48 -0700 (PDT)
Date:   Mon, 24 Jul 2023 23:42:30 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Siddharth Singh <siddhartth@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v4 1/2] ref-filter: add multiple-option parsing functions
Message-ID: <ZL6_DlDIE8Hfl_T6@five231003>
References: <20230719162424.70781-1-five231003@gmail.com>
 <20230723162717.68123-1-five231003@gmail.com>
 <20230723162717.68123-2-five231003@gmail.com>
 <xmqqa5vlqktr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5vlqktr.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2023 at 10:29:52AM -0700, Junio C Hamano wrote:
> Kousik Sanagavarapu <five231003@gmail.com> writes:
> 
> > The functions
> >
> > 	match_placeholder_arg_value()
> > 	match_placeholder_bool_arg()
> >
> > were added in pretty 4f732e0fd7 (pretty: allow %(trailers) options
> > with explicit value, 2019-01-29) to parse multiple options in an
> > argument to --pretty. For example,
> >
> > 	git log --pretty="%(trailers:key=Signed-Off-By,separator=%x2C )"
> >
> > will output all the trailers matching the key and seperates them by
> > a comma followed by a space per commit.
> >
> > Add similar functions,
> >
> > 	match_atom_arg_value()
> > 	match_atom_bool_arg()
> >
> > in ref-filter.
> 
> What are their similarities, and in what way are they different?  If
> they are similar enough, is it reasonable to allow these two pairs
> of helpers to share code (the best case would be we can just call
> the existing ones, possibly changing their names to more suitable
> ones that fit their now-more-general-purpose nature better)?

What do you mean by "share code"?

They are similar in their functionality, that is parsing the option and
grabbing the value (if the option has a value, otherwise we do what we
did here). The difference is the way we do such a parsing.

In pretty, we directly skip_prefix() the placeholder. So we check for ')'
to see if we have reached the end of "to_parse".

In ref-filter (the current patches), we deal directly with the options
("arg" here), that is we can't do a check for ')' to see if we have
exhausted our option list. So we can't really use the same functions, but
there is the possiblity that we can modify them to be used here too.

So the difference is mainly just how we send "to_parse" and how we want
it parsed.

> > There is no atom yet that can use these functions in ref-filter, but we
> > are going to add a new %(describe) atom in a subsequent commit where we
> > parse options like tags=<bool-value> or match=<pattern> given to it.
> >
> > Helped-by: Junio C Hamano <gitster@pobox.com>
> > Mentored-by: Christian Couder <christian.couder@gmail.com>
> > Mentored-by: Hariom Verma <hariom18599@gmail.com>
> > Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> > ---
> >  ref-filter.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 105 insertions(+)
> 
> Asking just out of curiousity, all patches from you seem to have
> "Mentored-by" naming your mentors, but how deeply involved are they
> in each patch you send out?  Is it like you first ask them to review
> and only after addressing the issues their reviews raise, you are
> sending the polished patches to the list?  Or are they not deeply
> involved in the code but offering suggestions on the design

Both actually, the code and the design. I send them the commits which I
push to my fork and they take a look on the code as well as the design
and offer suggestions on how both can be improved or re-did.

> (I am
> curious what their reactions were on your design decision to
> add the two helper functions)?

They suggested doing something similar to what you suggested above but
it is kind of on hold (also because of how we changed the implementation
of "match_atom_arg_value()"). Now that you bring it up, should this
patch be reworked?

Thanks
