Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1751B1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 21:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfBUVZ0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 16:25:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38778 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfBUVZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 16:25:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so82589wrw.5
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 13:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sCu4DgdnXbaBXDeMflcnceMsImVi0D0TAZiObdo3Bzk=;
        b=j13u2IpJ9o53rMySdNDt1PUzTCOjEQOq31C8RBAhOf0wV/82fZz2zf1dQFQPPfmxQf
         uJ3Xf80Dz6I8sZjq/tHne1oiLVcnI0t5XQspL4jCv0n8PvQmyOB5dG35taT+ltpB9q3c
         Cudcib8crj7pdyDI9d02RHtyooOGECMeShN9CIJYmgatxrU5had4REiEaWNNFHr6/p2U
         fYH/o/AJ32jtjKPrHmBIv9vtB5LqC++0kHd5kizmxi/Yhi4x44g0C86UQ9DDxyhryw1g
         No39booL+xnFFpghlG8AatfZsvE2h8IjFsEJHd4yx9QNXRGzQ80fPEa4YgX8CeTXYQn8
         H0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sCu4DgdnXbaBXDeMflcnceMsImVi0D0TAZiObdo3Bzk=;
        b=BQsQxdSElDgnlaWXj+HcB+wH0hPkYfoTtku1lHRd05q7zTNbymROR6cuNtnsGyG+PU
         gVPwbXCh4rNsfBiLwkFA9XehHOraYIrvCTxhgUtiiSrYPPdM1/5uxRb0XuaIp4cGCPgk
         9hxv0NjpmnIieDwMUPjNZN1iu/FGAuaPnA/4+uM3lVzFxpI3DVfTuIhQUjgUXVfeazpL
         qQ7LHGoaohEw+SKe7LSUqingCQZaopCJS8wCoNtrFyMDqO72wOBTveofy0XM7z6Y4zc3
         eSYypdl/XbccG//+Aup4NncdxRHdgZfCE+lYpS8ujm7cJ4ZAusRLzJrSErVvbl+1eh+t
         9oiw==
X-Gm-Message-State: AHQUAuYsJrDeezChuaS49LALBBK9x/E+ydcjM2f+kZMX+XZZ8AYURVV3
        irRBjQhueOuisKGEok62Sgo=
X-Google-Smtp-Source: AHgI3Ia3pUQkuArRg3e9OnyHnUkDVsz1a8Rxmw36rkKODHAk7Ts5vq51LekenEhJsx+VVNAj9X1tBg==
X-Received: by 2002:a05:6000:1252:: with SMTP id j18mr376717wrx.11.1550784324307;
        Thu, 21 Feb 2019 13:25:24 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id d15sm51537366wrw.36.2019.02.21.13.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 13:25:23 -0800 (PST)
Date:   Thu, 21 Feb 2019 21:25:22 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC][PATCH 2/2] clone: use dir-iterator to avoid explicit dir
 traversal
Message-ID: <20190221212522.GO6085@hank.intra.tgummerer.com>
References: <20190215154913.18800-1-matheus.bernardino@usp.br>
 <20190215154913.18800-3-matheus.bernardino@usp.br>
 <20190216143824.GJ6085@hank.intra.tgummerer.com>
 <CAHd-oW60a+zz9J+u0HiRuTy-FKYN4s95fCcR3mgJz0hUokhTCQ@mail.gmail.com>
 <20190218233541.GK6085@hank.intra.tgummerer.com>
 <CAHd-oW6m6JSgxwdE6U5vBw=DcPigK+P8eODoie0_Mag3Lg_eYw@mail.gmail.com>
 <20190219234506.GL6085@hank.intra.tgummerer.com>
 <CAHd-oW6VPrHMo1QjAXn6G8P_gmJOQ91LVO+UDK1a8T7uhuM9uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd-oW6VPrHMo1QjAXn6G8P_gmJOQ91LVO+UDK1a8T7uhuM9uQ@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/21, Matheus Tavares Bernardino wrote:
> Ok, I think I'm almost there and I should be able to send a v2 on the
> weekend. But again, a few questions arose while I'm coding v2. Please,
> see inline.
> 
> On Tue, Feb 19, 2019 at 8:45 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > On 02/19, Matheus Tavares Bernardino wrote:
> > > Ok, I agree. I noticed copy_or_link_directory only skips hidden
> > > directories, not hidden files. And I couldn't think why we would want
> > > to skip one but not the other... Could that be unintentional? I mean,
> > > maybe the idea was to skip just "." and ".."? If that is the case, I
> > > don't even need to make an if check at copy_or_link_directory, since
> > > dir-iterator already skips "." and "..". What do you think about that?
> 
> [...]
> 
> > I feel like you are probably right in that it could be unintentional,
> > and I don't think anyone should be messing with the objects
> > directory.  However that is no guarantee that changing this wouldn't
> > break *something*.
> >
> > For the purpose of this change I would try to keep the same behaviour
> > as we currently have where possible, to not increase the scope too
> > much.
> >
> 
> I understand your point, but to make copy_or_link_directory() skip
> just hidden directories using dir-iterator seems, now, a little
> tricker than I though before. The "if (iter->basename[0] != '.')"
> statement in the patch I sent for v1 only skips the hidden directories
> creation, but it does not avoid the attempt to copy the hidden
> directory contents (which would obviously fail). If we were to do
> that, we would need to check every directory in the relative path
> string of each iteration entry looking for a hidden directory. That
> seems a little too much, IMHO. Because of that and the intuition that
> skipping over hidden dirs was an unintentional operation, I think we
> could modify copy_or_link_directory() to skip '.' and '..', only.
> Also, hidden dirs/files are not expected to be at .git/objects anyway,
> are they?

No, as far as I know hidden dirs/files should not be in .git/objects.
The only reason they would be there is if somebody would create them
manually.  I didn't think of hidden child directories, which as you
noticed should be excluded as well to keep current behaviour.

With that in mind, I think I agree with the change of only excluding
'.' and '..', for which we don't need to do anything in your
dir-iterator patches.  Also thinking of what the worst case that could
happen is, it's that while cloning a repository locally a few more
directories could be copied, which is not all that bad.

So I think I was overly paranoid here and am on board with skipping
'.' and '..' only.  I even think that this can be just described in
detail in the commit message, rather than being done in a separate
patch, though others may disagree with that.  

> And to have copy_or_link_directory()'s behaviour changed as little as
> possible, I could add the option to not follow hidden paths (dirs and
> regular files) at dir-iterator.c and use it at
> copy_or_link_directory() (now that I'm adding the 'pedantic' option,
> this won't be so difficult, anyway). Would these suggestions be a good
> plan?

I think this would be a valid plan as well, however thinking this
through again I don't feel like it is necessary.  I'm happy with
whichever way you prefer here.

> Thanks,
> Matheus Tavares
