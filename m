Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A70BB20323
	for <e@80x24.org>; Thu, 16 Mar 2017 23:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754076AbdCPX1T (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 19:27:19 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35315 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbdCPX1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 19:27:16 -0400
Received: by mail-pf0-f175.google.com with SMTP id x63so25707902pfx.2
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 16:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8LBRW16LohjeHl/1gr5U60HsSx/3gkMWPGQQHk03Un8=;
        b=qYBgLxKDMeWcIYASrno6p5PPFFKIY2F89oZ4Zpiy9TVyMbYv0OwP5p5IHawDdfpY86
         tBlywFzzWP8jaQI7n4X7ryq2shCjdBRBsX7bzI499Oji3cG5kVihOXT+qmEUJ3Zkp3f/
         F/pRt+8wC7VK+ad/hLm8idLecaDivLXxgvbdfIXENnp5gLRJzbjBbyUG8RfiQ6vc+BxG
         tbRVM+ZLF6T+UtqnufFE4yv9rlgyeqEJOaM2ebhsvL1KGV150HI5pLAPfQawR0wYZb0r
         TlhxvGOhMhNt76Ip9DrP5kA5OFB3MKYAUvE5zuHng19DGkf3PQjn3TqJG21aewLOMpEZ
         uAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8LBRW16LohjeHl/1gr5U60HsSx/3gkMWPGQQHk03Un8=;
        b=j7Fw4D6W0rDMuECQjCckbzFmb1WFaeHVNns4TUevja4z0GSMMY7tnosHZwiSD37i8E
         Em4U13jUDYvNsmDnK/8val3JFPgsd37OLXBwl3cXas6qJSz9sNFESFkTFbODcF0+OWs9
         ajWDOSn3J0hPcvcyPftJZ34ThaqJyzr8S5PDlYArBoMnkK/tAa2687nI5BUUvWmAzlIQ
         rNPZpJTr50TumqvTxhELKbtpoYjgFP7O1oSxqDw300rxqXd3x9uswl639eATkfnMJJd6
         80VS3mF9P/uBBUiZKAJ25Dy4k7aQcVLNWD9hPPF8lOPc/r0PxX1M2RP73T5+W6Jw5KQR
         Vj/w==
X-Gm-Message-State: AFeK/H35oZWyl+M5m6QeALcq8BvNR0C5BUl6eOcc9q91T8Szs7cpQXrU1eGfgm7FCeqCTc6N
X-Received: by 10.99.130.193 with SMTP id w184mr5345008pgd.157.1489706799615;
        Thu, 16 Mar 2017 16:26:39 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:5992:ad5b:4930:50b4])
        by smtp.gmail.com with ESMTPSA id n189sm12550427pfn.108.2017.03.16.16.26.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Mar 2017 16:26:38 -0700 (PDT)
Date:   Thu, 16 Mar 2017 16:26:37 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 03/10] submodule sync: skip work for inactive
 submodules
Message-ID: <20170316232637.GB168812@google.com>
References: <20170313214341.172676-1-bmwill@google.com>
 <20170316222952.53801-1-bmwill@google.com>
 <20170316222952.53801-4-bmwill@google.com>
 <CAGZ79kaP9ob+qvso=pV=PPaB5guaW18w297xA+bfDFASV0zibg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaP9ob+qvso=pV=PPaB5guaW18w297xA+bfDFASV0zibg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/16, Stefan Beller wrote:
> On Thu, Mar 16, 2017 at 3:29 PM, Brandon Williams <bmwill@google.com> wrote:
> > Sync does some work determining what URLs should be used for a submodule
> > but then throws this work away if the submodule isn't active.  Instead
> > perform the activity check earlier and skip inactive submodule in order
> > to avoid doing unnecessary work.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> 
> > +               # skip inactive submodules
> > +               if ! git config "submodule.$name.url" >/dev/null 2>/dev/null
> 
> As a stand alone patch, this would look good to me.
> But with the goal of this patch series in mind (which is to add
> more options to enable a submodules "active" state), this
> should rather be "submodule--helper is-active" here?

Junio mentioned do this as a preparatory step to make it easier to
review.  The next patch changes that to use 'is-active' instead of the
URL.

> 
> 
> > +               then
> > +                       continue
> > +               fi
> > +
> 
> The changes below here are just de-dented, no behavioral change?

Yeah no behavioral change, just short circuiting earlier.
> 
> >
> > -               if git config "submodule.$name.url" >/dev/null 2>/dev/null
> > +               displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
> > +               say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
> > +               git config submodule."$name".url "$super_config_url"
> > +
> > +               if test -e "$sm_path"/.git
> >                 then
> > -                       displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
> > -                       say "$(eval_gettext "Synchronizing submodule url for '\$displaypath'")"
> > -                       git config submodule."$name".url "$super_config_url"
> > +               (
> > +                       sanitize_submodule_env
> > +                       cd "$sm_path"
> > +                       remote=$(get_default_remote)
> > +                       git config remote."$remote".url "$sub_origin_url"
> >
> > -                       if test -e "$sm_path"/.git
> > +                       if test -n "$recursive"
> >                         then
> > -                       (
> > -                               sanitize_submodule_env
> > -                               cd "$sm_path"
> > -                               remote=$(get_default_remote)
> > -                               git config remote."$remote".url "$sub_origin_url"
> > -
> > -                               if test -n "$recursive"
> > -                               then
> > -                                       prefix="$prefix$sm_path/"
> > -                                       eval cmd_sync
> > -                               fi
> > -                       )
> > +                               prefix="$prefix$sm_path/"
> > +                               eval cmd_sync
> >                         fi
> > +               )

-- 
Brandon Williams
