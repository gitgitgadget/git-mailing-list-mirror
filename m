Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E5AC433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 23:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B97611BE
	for <git@archiver.kernel.org>; Fri, 14 May 2021 23:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbhENXc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 19:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhENXc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 19:32:28 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9992C06174A
        for <git@vger.kernel.org>; Fri, 14 May 2021 16:31:15 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso694921otn.3
        for <git@vger.kernel.org>; Fri, 14 May 2021 16:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=7sKJq4iFXLlfG7etyargmPGZ0+QvRPj6WFgIgzRHPmA=;
        b=UQj4EtskwvFkL5zsUnT3zVp6SOTC/jOD+dwCTV3/JINxjdLxDYjaad+ViDCkzWtrB1
         O2AqeuAPTrTCf/s9McVAimzoFGO8mAzO3ICSZa4tHOUJMZFnhIJMIV7VU3OmflkvyLNN
         zOePlCv8Cv4MrdNUeXCtXBxnhZ0ucCYGLi6pqDltbHSY5PlLEME709K7YE/6DWgwEX67
         x4SIKnDG95coH/etTQ48LahWQaYu4C+Qzcx6CdGX8sewSL/V5zNaqJ6fwerigp34TfVf
         eq1Xxx+L7pykGKEhnz3Y9Rp0I9QxBT/Msm91IbvObICMFMznPg84rJ69RwEZHKIL8egj
         2+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=7sKJq4iFXLlfG7etyargmPGZ0+QvRPj6WFgIgzRHPmA=;
        b=nsIPJMHZRO2qcISQRbQJLajDqwGlpME//5qDTiTncQJxLdLMEMOOZw0CqC8VHgwzx5
         pAQw9lvPphqS7fSuK4ZkZ+AJ0KvPWdvMUfQm2IEv/pSt+4RVGP7tY4/uHZ4GCq/7vjYb
         HiodKH0kvPjpMAOroorbv1JhF3eoD0MMvnLTOIdKKRXFG8jgYYcP544QwrC0FfjcBF0Y
         +cbMiodHFPjZN1o5mky0eB3LO1aFNCKz4x3fmhXnCq7Jf2PqciFvFFMmFcDfNU3e2thB
         1LXTEghX4SWrc9CnsXUJJS0fxukWn9nff16UhE3zYaM6ethlw4iRr2i9RFFqxhP6Zbb9
         5HqQ==
X-Gm-Message-State: AOAM530C41nFSl3kXoszgQiNr+xXFy4bZ6WrSs4xb5Zc0bvxH/IfrfY/
        ok/VKDrttVmSwlRkYegBgrU=
X-Google-Smtp-Source: ABdhPJz7/PEdtDn7swruG1Pu90bloVrcBxwvPVAy9igQEhZFt8kSNlYFf3lXwPcbjOqD4uVwzo8XwQ==
X-Received: by 2002:a05:6830:16d8:: with SMTP id l24mr26151325otr.106.1621035074891;
        Fri, 14 May 2021 16:31:14 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 186sm1553508oof.14.2021.05.14.16.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 16:31:14 -0700 (PDT)
Date:   Fri, 14 May 2021 18:31:12 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Message-ID: <609f0840eb383_4312720868@natae.notmuch>
In-Reply-To: <YJ7avgek24eu+HHM@camp.crustytoothpaste.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210514003104.94644-1-sandals@crustytoothpaste.net>
 <20210514003104.94644-2-sandals@crustytoothpaste.net>
 <609ed529e2306_431272087@natae.notmuch>
 <YJ7avgek24eu+HHM@camp.crustytoothpaste.net>
Subject: Re: [PATCH v2 1/2] doc: add an option to have Asciidoctor build man
 pages directly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2021-05-14 at 19:53:13, Felipe Contreras wrote:
> > brian m. carlson wrote:
> > > We generally require Asciidoctor 1.5, but versions before 1.5.3 didn't
> > > contain proper handling of the apostrophe, which is controlled normally
> > > by the GNU_ROFF option.  This option for the DocBook toolchain, as well
> > > as newer versions of Asciidoctor, makes groff output an ASCII apostrophe
> > > instead of a Unicode apostrophe in text, so as to make copy and pasting
> > > commands easier.  These newer versions of Asciidoctor (1.5.3 and above)
> > > detect groff and do the right thing in all cases, so the GNU_ROFF option
> > > is obsolete in this case.
> > 
> > I don't see what that paragraph has to do with the patch below.
> 
> It's relevant because it explains why it's acceptable to discount that
> feature that we're not supporting as part of the patch.

It's easier to first drop that feature, and then you don't have to
explain anything.

> > > We also need to update the code that tells Asciidoctor how to format our
> > > linkgit macros so that it can output proper code for man pages.
> > 
> > Yes, but why shove it in this patch? Now this is is doing *two*
> > logically-independent changes.
> 
> This is one logical change: implementing Asciidoctor native support for
> man pages.

By that logic all patch series can be a "logical change": "implement
SHA-256 support".

> > > Be careful to reset the font to the previous after the change.
> > 
> > This is a third change, since the current man pages already don't do
> > this:
> > 
> >   % zcat /usr/share/man/man1/git-add.1.gz | grep '\fB'
> >   you must use the \fBadd\fR command
> 
> As explained downthread, we don't know in the manual pages what font
> styling we're in.  troff has font-change commands, not nesting begin-end
> pairs, for italics and bold.  If the linkgit macro appears in the middle
> of a passage in italics, by not using \fP, we'll force the rest of the
> text which is to be italicized into roman.
> 
> The toolchain, whether Asciidoctor or the XSLT stylesheets, _does_ have
> this context and therefore can explicitly move between bold and roman,
> but our extensions do not.

Indeed but it's rare (there's probably zero instances), and it increases
the delta. Yes, it's more correct, but it trades a hypothetical benefit
for a real disadvantage.

Either way I see no point in arguing about this. If you feel strongly
about this I can include it in my version.

> > > Additionally, we don't want to use XML-style escapes for the litdd and
> > > plus macros, so let's only use the XML-style escapes in HTML and XML and
> > > use something different for our man pages.
> > 
> > That's a fourth change now, and one that complicates the Makefile even
> > more, when I've been trying to simplify it.
> 
> I'm sorry that this complicates work you'd like to do, but
> unfortunately, the other option is broken rendering.

Clean and maintainable code is a benefit to the project, not just me.
And the Makefile is code too.

Forget about me, a clean and simple Makefile is better than a cluttered
and complex Makefile. That is the point.

Yes, the rendering is "broken" without the change (that's loaded
language, but OK), we want to know precisely how, and how it got fixed.
We don't wan to sneak in all the fixes in the world in the first patch.

Moreover, there's no dicotomy here; we can fix the "broken" state in
other ways that don't complicate the Makefile, as I did in my patch
series [1].

But in fact, I have an even simpler version now:

 Asciidoctor::Extensions.register do
+  # Override attributes for man pages.
+  # https://github.com/asciidoctor/asciidoctor/issues/4059
+  if document.backend == 'manpage'
+    document.attributes.merge!({ 'litdd' => '\--', 'plus' => '+' })
+  end
+
   inline_macro Git::Documentation::LinkGitProcessor, :linkgit
   postprocessor Git::Documentation::DocumentPostProcessor
 end

> > > If users are using a more modern toolchain or don't care
> > > about the rendering issues, they can enable the option.
> > 
> > What rendering issues?
> 
> They were mentioned upthread.

No. Pepole mentioned issues they *think* existed, nobody pointed out an
actual reproducible issue.

As you experienced with the \e setback, the issue could have been with
their build, or it could be present in v1.5.7, but not v1.5.8. It's hard
to know if nobody spells out what the issue is.

So... What rendering issues?

> > Also, the many should not suffer because of the few.
> > 
> > If a few people doing USE_ASCIIDOCTOR=YesPlease have issues (because of
> > ancient packages in their distribution, and their reluctance to type
> > `gem install`), then *they* can disable USE_ASCIIDOCTOR_MANPAGE (or just
> > disable USE_ASCIIDOCTOR altogether). Most people doing
> > USE_ASCIIDOCTOR=YesPlease should not suffer because of a
> > minority.
> 
> I don't believe we're going to agree on this.  I believe we should
> choose defaults that work with the most popular Linux distributions, and
> you don't.

Untrue.

`make USE_ASCIIDOCTOR= doc` works perfectly fine on Debian stable with
my patches, and that's the default, nobody is changing that.

And so does this:

  gem install asciidoctor && make USE_ASCIIDOCTOR=1 doc

But in fact, so does `make USE_ASCIIDOCTOR=1 doc`, because asciidoctor
1.5.8 works just fine. I just did a doc-diff with v1.5.8, and I
checked everything without finding any serious issue (not present in
2.0.15).

The only issue is that \\ was not handled correctly, but I now have a
workaround for that:

  if document.basebackend?('manpage') and Asciidoctor::VERSION < '2.0.11'
    postprocessor do
      process do |document, output|
        output.gsub("\\(rs\\\\", "\\(rs\\(rs\\")
      end
    end
  end

> I think your approach is unnecessarily hostile to ordinary
> users and developers and understates the value that people derive from
> distributions.

Please tell me exactly how my patches are hostile to "ordinary
developers" (who are not ordinary at all).

 1. Will they be able to build the documentation with default flags?
    Yes
 2. Will they be able to build with USE_ASCIIDOCTOR=1?
    Yes
 3. Will they be able to see a reasonable output?
    Yes
 4. Will they be forced to install a gem?
    No

So where exactly is the hostility?

> > > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > 
> > I most definitely do not sign off this.
> 
> This sign-off is not an approval of the patch.

Yes it is. According to the Developer Certificate of Origin [2] I must:

  agree that a record of the contribution (including my sign-off) is
  maintained indefinitely

Which I don't.

Feel free to disregard my lack of agreement, but I'm stating it for the
record.

> I do want to be clear that I'm aware you don't approve of this patch and
> that's why I submitted a counterproposal: because I don't approve of
> your patch

That happens.

> and you seem unwilling to make changes to it.

Just because I disagree with your changes doesn't mean I'm unwilling to
make changes to my patch, especially since I already agreed on making
changes to my patch.

> I would love nothing more than to remove your name from it entirely,
> but unfortunately, that's not possible with the DCO.

It's not possible *if* 1) you use my code, and 2) you made changes I'm
opposed to. But you are already in violation of the DCO anyway by
disregarding my agreement, which is mandatory.

If you don't want to be in violation of the DCO you could try to fix
either 1) or 2).

Cheers.

[1] https://lore.kernel.org/git/20210514121435.504423-8-felipe.contreras@gmail.com/T/#u
[2] https://developercertificate.org/

-- 
Felipe Contreras
