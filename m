Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74F0C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 00:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9BB214AF
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 00:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c5OCmulM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgBEApB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:45:01 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53448 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbgBEApB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 19:45:01 -0500
Received: by mail-pj1-f66.google.com with SMTP id n96so184719pjc.3
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 16:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+PXT62p/4mJm467yMR2OTzLDfdOTLw3OK2baqKOknqU=;
        b=c5OCmulMLXMWyYEjZZs/0bzT2nUzEcw8qFEyv6DNTpX223L0ft46sCP+V/RhAYuobR
         GLP5cTa06LP5KM5xUuss5FzHxYaAJS5ZBM8JyVqYT5hRIH6/9GCcTGmn+/b4HCemF4Tu
         kn54cbaaaA2n+wO2U3coi3MD+4wHxHThPeSRETz+Yu30nFxPgVRf52ye4L2CUp+uui/H
         zIR+LuMQ35IeW4zT7Onev8L6uQSHbRGpVzDKV7bZUYHxmsECw7TdHr3+ECxIeHWMI7xI
         g5U27cgcfUUwwmcXjlTNM20kCT4CaHsXmjgKKSn1kOgpvnWHmdX6q3MeymsiNPHD/xlA
         RWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+PXT62p/4mJm467yMR2OTzLDfdOTLw3OK2baqKOknqU=;
        b=RxAQVIQyv4hImq6+OD8khamPS6KTlSgnIHGop16MZZMSZ3cOVabcL4xxFmKpLqMwdn
         mFCA+cGiyNV15DwKLVW441DE4PjZLX/X20xTzUajC4KVB8bDFR2lB7OQxQi+aSeM22ba
         QcMjj79g4F9XMv3zHNHvX+Wmy2XiqHFMe8dnmGEv9kvm9QqD7y2Rdf2y04MNCmx4k/IH
         ZE9qCNOhqiKphpsBgs3mtnyxTcnKdEgk2m40pKumWz1omX1IOJyLrLCho3i1rFRH+dye
         /wqaK016oNFypXsEwx4BLGvJCKRKfFQmdG9zmGs+S0tdXM2NomcZ0ddZEwahKW1rySiK
         xt4g==
X-Gm-Message-State: APjAAAX+6kpSvjmq0SyoEPzTzbuFFtBOvuE0HA5whM0Q5O7CP8XKwSVt
        Hpv8R1QRNTbGdMEOBJsQAbFesUgEbhY=
X-Google-Smtp-Source: APXvYqzdGTwRQCm5jdIBHlyMCwMEeryduGsR7dtGTFwxW935yBLmbjP9Ggmuv3YYXt9cUXyVVelMwQ==
X-Received: by 2002:a17:902:76c7:: with SMTP id j7mr32906526plt.45.1580863500369;
        Tue, 04 Feb 2020 16:45:00 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id 196sm26136732pfy.86.2020.02.04.16.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 16:44:59 -0800 (PST)
Date:   Tue, 4 Feb 2020 16:44:55 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 09/15] bugreport: generate config safelist based on
 docs
Message-ID: <20200205004455.GI87163@google.com>
References: <20200124033436.81097-1-emilyshaffer@google.com>
 <20200124033436.81097-10-emilyshaffer@google.com>
 <CAN0heSq_i4EitqYH-qrZyXBU+=PUNcSXOOJDHLSnJ1ufV0WtaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSq_i4EitqYH-qrZyXBU+=PUNcSXOOJDHLSnJ1ufV0WtaQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 11:34:24PM +0100, Martin Ågren wrote:
> On Fri, 24 Jan 2020 at 04:35, <emilyshaffer@google.com> wrote:
> > Add a new step to the build to generate a safelist of git-config
> > variables which are appropriate to include in the output of
> > git-bugreport. New variables can be added to the safelist by annotating
> > their documentation in Documentation/config with the
> > "bugreport" macro, which is recognized by AsciiDoc and
> > AsciiDoctor.
> >
> > Some configs are private in nature, and can contain remote URLs,
> > passwords, or other sensitive information. In the event that a user
> > doesn't notice their information while reviewing a bugreport, that user
> > may leak their credentials to other individuals, mailing lists, or bug
> > tracking tools inadvertently. Heuristic blocklisting of configuration
> > keys is imperfect and prone to false negatives; given the nature of the
> > information which can be leaked, a safelist is more reliable.
> 
> I sort of wonder whether safelist/blocklist is to prefer over
> whitelist/blacklist, or if it's the other way round. The former are new
> to me, whereas the latter are the terms I would have used. But that's
> just me, of course. I was a little surprised, that's all.

Eh. I think the following things are true:

 - Whitelist/blacklist has a "smell" of discrimination, whether that's
   the true etymology or not.
 - Those with experience in the field can easily understand what
   whitelist or blacklist means.
 - Safelist/blocklist do not "smell" the same way.
 - It is easy to tell what "safelist" means: "a list of stuff which is
   safe." No experience needed.

So, while it's new, I think it's not harmful. I see only a no-op or
positive impact from using this term instead of whitelist/blacklist.
Computer science seems to have quite a few terms which fall into this
long-standing but potentially negative area, so I don't mind looking for
alternatives where it's harmless to do so.

> 
> > Implement a new no-op "bugreport" macro for use as
> > "bugreport:include[x]" to annotate the config keys that should be
> > included in the automatically generated safelist. Use "exclude" for the
> > others.
> >
> > With Asciidoctor, it's ok to say "bugreport:include[]", but AsciiDoc
> > seems to want something between the brackets. A bit unfortunate, but
> > not a huge problem -- we'll just provide an "x".
> 
> I recognize this reasoning :-) and I'm not terribly opposed to it, but
> after some nights' sleeping on this, I have to wonder if
> "annotate:bugreport[include]" wouldn't be better than "bugreport[x]"
> with that ugly "x". Maybe this isn't the biggest problem, but if we
> expect this macro to eventually sit right next to ~90% of all our config
> variables...

Hm. I wanted to say, "Ok, but I don't know how to do that, so can you
help?" But I think that's all the more reason that I should do it ;)

Ok. I will try and change it to annotate:bugreport[include] like you
suggested, and hopefully learn more about asciidoc macros :)

> 
> > "doc-diff" reports that this macro doesn't render at all. That is,
> > these are both empty after this commit:
> >
> >   cd Documentation
> >   ./doc-diff --asciidoctor :/"bugreport: add tool" HEAD
> >   ./doc-diff --asciidoc    :/"bugreport: add tool" HEAD
> 
> That was true in [1], but alas, no more. In that patch, it's sort of
> obvious from the diff how it adds a "class" which "end"s.
> 
> [1] https://lore.kernel.org/git/20190817203846.31609-1-martin.agren@gmail.com/
> 
> > --- a/Documentation/asciidoctor-extensions.rb
> > +++ b/Documentation/asciidoctor-extensions.rb
> > @@ -37,6 +37,10 @@ module Git
> >            output = output.sub(/<\/refmeta>/, new_tags + "</refmeta>")
> >          end
> >          output
> > +
> > +    class BugReportProcessor < Asciidoctor::Extensions::InlineMacroProcessor
> > +      def process(parent, action, attrs)
> > +        ""
> >        end
> >      end
> >    end
> 
> But this one doesn't add an "end", and Asciidoctor trips up badly.

Ok, I'll have a look. I'm sure I copied something badly.

> 
> > +  # The bugreport macro does nothing as far as rendering is
> > +  # concerned -- we just grep for it in the sources.
> > +  inline_macro Git::Documentation::BugReportProcessor, :bugreport
> 
> (I never much liked this copy-paste comment then, and I still don't, to
> be honest.)

I'll see if I can find a reasonable alternative (or remove it).

 - Emily
