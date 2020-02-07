Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677A0C04EB5
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 15:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFEB22464
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 15:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfVXwrHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgBGPar (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:30:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33217 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgBGPar (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 10:30:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id u6so3213388wrt.0
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 07:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TXh6NF2Kdx1kUn6r/NtaSfMcIJzCp8avPTK9snFiCME=;
        b=pfVXwrHNsyY6ylD+OfS28fknoOwulNkNl3cd7QSstTB0B4bBpMcHNPZVBOuWs7UzCq
         pK/VvbO+dOmB48qEnRwQuBKwC4G2EkFPnFyUzKO7io2JdwxSZ94ashtqR7O85yYKvav/
         o5P+QzILehQL2at3dyzXJeSlVFcf6bRIN0bEoVTgzFJEMGEgE1fJfUH62pTiACliv/1P
         +NE/ZykpDDg9ukdZdnXu2D4XLQpQZ911RV2/iJgOj/2q1WYUsjzPuD/RidnDOpxi5k/k
         i/EqU5iYZy+DbLbGLNJT3lwBm4cxYJRpXFRX9awARBGlw1kgd1ACz58uWfPmO3wxXZ50
         HAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TXh6NF2Kdx1kUn6r/NtaSfMcIJzCp8avPTK9snFiCME=;
        b=raB0enVpjg+kasiVKxRh3ibpOtNtVwl2lcRgt/NRlwdtSM30OJzLAYhTIbUNVOifW7
         H+t8VrYrPR2XvmvscjABuob7BSD8EpqQh+T06W4XBcXk+XHISCi5T8GngYYwwWq3wByJ
         UUaYc05AbyCebcHy0qmTcRumkxGrk9Bhxed0siMAebeC+vdYBlQs4rBgfOwxh1zYnuB5
         mpbq+wzNLLoA4PlZS0S0DDupp4fdxrZN838qihLmGr3bpmfL0GkYp0K6FILoLx9HeiO6
         ByLW7rN0uWfUuIhqxSRnGh8fof7PWo00JzBK0nCsGtA45ykxJK2h4+g2uedOefNwrKRP
         8jGQ==
X-Gm-Message-State: APjAAAUEhkxDrBjOiNX23tU9D5QXb2oTCGC8FfsxeazacCBCfU3d2R1y
        H/bn+GLSqGHIejqO/dKiuEA=
X-Google-Smtp-Source: APXvYqzpdF4lRarL8phMZ6HBo4107s4ovS94ZvUkRXTDMWEQwrygIN6EivHXAP5c2PqsnCVwPeNhLg==
X-Received: by 2002:adf:e984:: with SMTP id h4mr5328093wrm.275.1581089445255;
        Fri, 07 Feb 2020 07:30:45 -0800 (PST)
Received: from szeder.dev (x4db318d8.dyn.telefonica.de. [77.179.24.216])
        by smtp.gmail.com with ESMTPSA id z19sm3673886wmi.35.2020.02.07.07.30.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2020 07:30:44 -0800 (PST)
Date:   Fri, 7 Feb 2020 16:30:42 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 09/15] bugreport: generate config safelist based on
 docs
Message-ID: <20200207153042.GI2868@szeder.dev>
References: <20200206004108.261317-1-emilyshaffer@google.com>
 <20200206004108.261317-10-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200206004108.261317-10-emilyshaffer@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 05, 2020 at 04:41:02PM -0800, Emily Shaffer wrote:
> Add a new step to the build to generate a safelist of git-config
> variables which are appropriate to include in the output of
> git-bugreport. New variables can be added to the safelist by annotating
> their documentation in Documentation/config with the "annotate" macro,
> which is a no-op in AsciiDoc and AsciiDoctor.
> 
> Some configs are private in nature, and can contain remote URLs,
> passwords, or other sensitive information. In the event that a user
> doesn't notice their information while reviewing a bugreport, that user
> may leak their credentials to other individuals, mailing lists, or bug
> tracking tools inadvertently. Heuristic blocklisting of configuration
> keys is imperfect and prone to false negatives; given the nature of the
> information which can be leaked, a safelist is more reliable.
> 
> However, it's possible that in some situations, an organization may be
> less concerned with privacy of things like remote URLs and branch names,
> and more concerned with ease of diagnosis for their support staff. In
> those cases, it may make more sense for that organization to modify the
> code to use a blocklist. To that end, we should try to mark configs which
> are definitely safe, and configs which are definitely unsafe, and leave
> blank configs which are somewhere in between. To mark a config as safe,
> add "annotate:bugreport[include]" to the corresponding line in the
> config documentation; to mark it as unsafe, add
> "annotate:bugreport[exclude]" instead.
> 
> Generating bugreport-config-safelist.h at build time by grepping the
> documentation for this new macro helps us prevent staleness. The macro
> itself is a no-op and should not alter the appearance of the
> documentation in either AsciiDoc or AsciiDoctor, confirmable by running:
> 
>   cd Documentation
>   ./doc-diff --asciidoctor HEAD^ HEAD
>   ./doc-diff --asciidoc HEAD^ HEAD
> 
> Diffing the rendered HTML shows that only inline comments were added,
> which shouldn't be a problem.
> 
> Additionally, add annotations to the sendemail config documentation in
> order to demonstrate a proof of concept.
> 
> Helped-by: Martin Ågren <martin.agren@gmail.com>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  .gitignore                              |  1 +
>  Documentation/asciidoc.conf             |  9 ++++
>  Documentation/asciidoctor-extensions.rb |  5 +++
>  Documentation/config/sendemail.txt      | 56 ++++++++++++-------------
>  Makefile                                |  7 ++++
>  generate-bugreport-config-safelist.sh   | 17 ++++++++
>  6 files changed, 67 insertions(+), 28 deletions(-)
>  create mode 100755 generate-bugreport-config-safelist.sh
> 
> diff --git a/.gitignore b/.gitignore
> index d89bf9e11e..bd2f49b996 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -192,6 +192,7 @@
>  /gitweb/static/gitweb.min.*
>  /config-list.h
>  /command-list.h
> +/bugreport-config-safelist.h
>  *.tar.gz
>  *.dsc
>  *.deb
> diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
> index 8fc4b67081..663e06481f 100644
> --- a/Documentation/asciidoc.conf
> +++ b/Documentation/asciidoc.conf
> @@ -6,9 +6,14 @@
>  #
>  # Show Git link as: <command>(<section>); if section is defined, else just show
>  # the command.
> +#
> +# The annotate macro does nothing as far as rendering is
> +# concerned -- we just grep for it in the sources to populate
> +# things like the bugreport safelist.
>  
>  [macros]
>  (?su)[\\]?(?P<name>linkgit):(?P<target>\S*?)\[(?P<attrlist>.*?)\]=
> +(?su)[\\]?(?P<name>annotate):(?P<target>\S*?)\[(?P<attrlist>.*?)\]=
>  
>  [attributes]
>  asterisk=&#42;
> @@ -28,6 +33,8 @@ ifdef::backend-docbook[]
>  {0#<citerefentry>}
>  {0#<refentrytitle>{target}</refentrytitle><manvolnum>{0}</manvolnum>}
>  {0#</citerefentry>}
> +[annotate-inlinemacro]
> +{0#}
>  endif::backend-docbook[]
>  
>  ifdef::backend-docbook[]
> @@ -94,4 +101,6 @@ ifdef::backend-xhtml11[]
>  git-relative-html-prefix=
>  [linkgit-inlinemacro]
>  <a href="{git-relative-html-prefix}{target}.html">{target}{0?({0})}</a>
> +[annotate-inlinemacro]
> +<!-- -->
>  endif::backend-xhtml11[]
> diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
> index d906a00803..382bd8f6f4 100644
> --- a/Documentation/asciidoctor-extensions.rb
> +++ b/Documentation/asciidoctor-extensions.rb
> @@ -37,6 +37,10 @@ module Git
>            output = output.sub(/<\/refmeta>/, new_tags + "</refmeta>")
>          end
>          output
> +
> +    class AnnotateProcessor < Asciidoctor::Extensions::InlineMacroProcessor
> +      def process(parent, target, attrs)
> +        ""

This change breaks building the documentation with Asciidoctor v1.5.8:

  /home/travis/.rvm/rubies/ruby-2.5.3/lib/ruby/site_ruby/2.5.0/rubygems/core_ext/kernel_require.rb:59:in `require': /home/travis/build/git/git/Documentation/asciidoctor-extensions.rb:41: class definition in method body (SyntaxError)
  
  ...xtensions::InlineMacroProcessor
  
  ...                               ^
  
  /home/travis/build/git/git/Documentation/asciidoctor-extensions.rb:53: syntax error, unexpected end-of-input, expecting keyword_end


  https://travis-ci.org/git/git/jobs/647093871#L1127

>        end
>      end
>    end
> @@ -45,4 +49,5 @@ end
>  Asciidoctor::Extensions.register do
>    inline_macro Git::Documentation::LinkGitProcessor, :linkgit
>    postprocessor Git::Documentation::DocumentPostProcessor
> +  inline_macro Git::Documentation::AnnotateProcessor, :annotate
>  end
