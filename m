Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE70CC43334
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 20:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiFTUnj convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 20 Jun 2022 16:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiFTUne (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 16:43:34 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98DC1A3BB
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 13:43:33 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id p2so1339476pls.4
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 13:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NUfYBFqu2/z2gS0ZYyBk7Qg8gIPJNAXxpjst9Qvw140=;
        b=rVNpitHPGwS7wByKiGJfRMkJskmm8biQM+bOPSeT1N57W894GAzE1Ha3l5RkNIhqE8
         GrwJ90CVmMZ0IOQa05kycbprxUMmibyKZGvTQXClet2mdgRj/BWDnEtNMeUPf7sGe0Y/
         eWYpzSBm5NvDs+Cmymq9LFmRDZ/CoausKKfRD4HDxo48bGXs+f+0ZDUs2NiLITlfwKfe
         LX1TgQQLNepWxJZ78day6I67FSCqtAQ3DQ24994bxf0EfN+oYfEpJGmZN4mxZVsuEfWB
         ktEmR1dp966MoZTJEfrwZPnf0VX173IE52iYphtWzPZdMfWb1n326HTwqIW3Qb+lUukc
         xG2A==
X-Gm-Message-State: AJIora8JAuRGxyMXp1ikqi8uRd0U8GY8lAipZt5CY3F4qY+Rn8cT/B/N
        0L5vYmtNCqH83unZDoTeLuoEfIrgo/LJ3umanW0=
X-Google-Smtp-Source: AGRyM1tEbRsvXK1L+VkWCkuCfpkdyoKnmKps0MDBfhLmn5MyOeAnb546JeJ9InxndbEtRSPkjggS7FbAQUOO1Sc5XkE=
X-Received: by 2002:a17:902:da92:b0:168:f947:4fcd with SMTP id
 j18-20020a170902da9200b00168f9474fcdmr24991214plx.91.1655757813094; Mon, 20
 Jun 2022 13:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <00a401d884d0$32885890$979909b0$@nexbridge.com>
 <8d2a0a36-1d2f-c723-db1e-8978e5d03d1d@github.com> <00b501d884d7$d8ed1200$8ac73600$@nexbridge.com>
 <495bd957-43dc-f252-657d-2969bb7ad5f3@github.com> <220620.861qvjvzue.gmgdl@evledraar.gmail.com>
In-Reply-To: <220620.861qvjvzue.gmgdl@evledraar.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Mon, 20 Jun 2022 13:43:21 -0700
Message-ID: <CAPc5daV29NuOkL1rZvzaqhe5fSrY2os42zsQRhtP6p6AJTp2NA@mail.gmail.com>
Subject: Re: Test Failure t5510,t5562 - was RE: [ANNOUNCE] Git v2.37.0-rc1
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was expecting you to use \Q...\E (and passing $remote_url as an
argument to perl script) actually.  If you let $remote_url
interpolated by shell into a script of the host language, whether perl
or sed, you'd be responsible for quoting it appropriately for the host
language yourself, and use of single-quote pair would not necessarily
be sufficient, no?

On Mon, Jun 20, 2022 at 1:34 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Jun 20 2022, Derrick Stolee wrote:
>
> > On 6/20/22 2:59 PM, rsbecker@nexbridge.com wrote:
> >> On June 20, 2022 2:46 PM, Derrick Stolee wrote:
> >
> >>> The issue is this line (some tabs removed):
> >>>
> >>>  new_cmdline=$(printf "%s" "$cmdline" | perl -pe
> >>> 's[origin(?!/)]["'"$remote_url"'"]g')
> >>>
> >>> At this point, $remote_url contains the file path including the @ symbol. However,
> >>> this perl invocation is dropping everything starting at the @ to the next slash.
> >>>
> >>> I'm not sure of a better way to accomplish what is trying to be done here (replace
> >>> 'origin' with that specific url) without maybe causing other issues.
> >>>
> >>> This line was introduced by e1790f9245f (fetch tests: fetch <url> <spec> as well as
> >>> fetch [<remote>], 2018-02-09).
> >>
> >> How about using sed instead of perl for this?
> >
> > I wasn't sure if using sed would create a different kind of replacement
> > problem, but using single-quotes seems to get around that kind of issue.
> >
> > Please see the patch below. I'm currently running CI in a GGG PR [1]
> >
> > [1] https://github.com/gitgitgadget/git/pull/1267
> >
> > Thanks,
> > -Stolee
> >
> >
> > --- >8 ---
> >
> > From 1df4fc66d4a62adc7087d7d22c8d78842b4e9b4d Mon Sep 17 00:00:00 2001
> > From: Derrick Stolee <derrickstolee@github.com>
> > Date: Mon, 20 Jun 2022 15:52:09 -0400
> > Subject: [PATCH] t5510: replace 'origin' with URL more carefully
> >
> > The many test_configured_prune tests in t5510-fetch.sh test many
> > combinations of --prune, --prune-tags, and using 'origin' or an explicit
> > URL. Some machinery was introduced in e1790f9245f (fetch tests: fetch
> > <url> <spec> as well as fetch [<remote>], 2018-02-09) to replace
> > 'origin' with this explicit URL. This URL is a "file:///" URL for the
> > root of the $TRASH_DIRECTORY.
> >
> > However, if the current build tree has an '@' symbol, the replacement
> > using perl fails. It drops the '@' as well as anything else in that
> > directory name.
> >
> > You can verify this locally by cloning git.git into a "victim@03"
> > directory and running the test script.
> >
> > To resolve this issue, replace the perl invocation with two sed
> > commands. These two are used to ensure that we match exactly on the
> > whole word 'origin'. We can guarantee that the word boundaries are
> > spaces in our tests. The reason to use exact words is that sometimes a
> > refspec is supplied, such as "+refs/heads/*:refs/remotes/origin/*" which
> > would cause an incorrect replacement. The two commands are used because
> > there is not a clear POSIX way to match on word boundaries without
> > getting extremely pedantic about what possible characters we could have
> > at the boundaries.
> >
> > Reported-by: Randall Becker <rsbecker@nexbridge.com>
> > Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> > ---
> >  t/t5510-fetch.sh | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> > index 4620f0ca7fa..8ca3aa5e931 100755
> > --- a/t/t5510-fetch.sh
> > +++ b/t/t5510-fetch.sh
> > @@ -853,7 +853,9 @@ test_configured_prune_type () {
> >               then
> >                       new_cmdline=$cmdline_setup
> >               else
> > -                     new_cmdline=$(printf "%s" "$cmdline" | perl -pe 's[origin(?!/)]["'"$remote_url"'"]g')
> > +                     new_cmdline=$(printf "%s" "$cmdline" | \
> > +                                     sed "s~origin ~'$remote_url' ~g" | \
> > +                                     sed "s~ origin~ '$remote_url'~g")
> >               fi
> >
> >               if test "$fetch_prune_tags" = 'true' ||
>
> Thanks for looking at this. Checking this out again this whole quoting
> mess is a bit of a ... mess, I wonder if there's some better way to
> avoid this. Anyway:
>
> So, is this functionally the same as:
>
>         diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>         index 4620f0ca7fa..9cd8b36f835 100755
>         --- a/t/t5510-fetch.sh
>         +++ b/t/t5510-fetch.sh
>         @@ -853,7 +853,9 @@ test_configured_prune_type () {
>                         then
>                                 new_cmdline=$cmdline_setup
>                         else
>         -                       new_cmdline=$(printf "%s" "$cmdline" | perl -pe 's[origin(?!/)]["'"$remote_url"'"]g')
>         +                       new_cmdline=$(printf "%s" "$cmdline" |
>         +                                     perl -pe 's[origin ]["'"$remote_url"'" ]g' |
>         +                                     perl -pe 's[ origin][ "'"$remote_url"'"]g')
>                         fi
>
>                         if test "$fetch_prune_tags" = 'true' ||
>
> ?
>
> I don't mind the migration to "sed", but doing so to fix a bug makes
> this especially hard to analyze. I.e. you've gotten rid of the (?!/), I
> haven't re-looked at this enough to see if/how that's important.
>
> I just came up with the above as a quick hack, but for any proper
> migration to sed can't we do this in one command?
>
> In any case you never need "| \" in your scripts, just end the line with
> "|".
