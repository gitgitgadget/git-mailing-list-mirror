Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB41AC54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C382098B
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzIGk411"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgDXRUD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgDXRUD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 13:20:03 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD35C09B047
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 10:20:02 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v2so3960913plp.9
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=efFcQYIfkR5yoYUoaG6RByEi9+2d78PZAikLo2VYA4Q=;
        b=ZzIGk411naMCxE7cDmUOs3llVW8WuOuDkZvlLSbFCGs+fSyghT4GHhNBCp3Q64pmIs
         uzJ8nknCMrff03IKW8dU3zrgbrCwyVWgDxX9dmFxrGZVB3AcKxTv9XvlRjMMUffgiUdH
         gUFcrFm3zh7LJCmO4Jv/OP8nFqXP3iJqHMwVkyYoCADUqMwgGlrY48KQZ6DhRlcA/aqL
         5fKiy4ZRG0NP0tdyAzTbEeb55V1ailbVgsTpGU6NUFmkhpFWxgmnlLrJGSSAjfi7g43w
         uDKjd1ORQxUXjHG4JexJye3snEPZCr0tlstbvwmIzWT4xuAaj+/u/DU0GZYKAP1OcyDQ
         s63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=efFcQYIfkR5yoYUoaG6RByEi9+2d78PZAikLo2VYA4Q=;
        b=UR1LIsSMNofxZEDB5Tkmh4E+zmiCnv3se/TH+lMdG1lygC3kjyt50Mg7IRXRdM/XxI
         W5GqlUyqwoio/S5MB7DrdUyxCooBGdWgH3MTHBXEp6BmKDa1f6Mnq7M6CO0nqCv5vxQC
         e1ztRUPUB8SmqdOogkfF+x1nnHThDEmDcCshN9Oh1H/K5MSCC5+Ca55o0q/aQ1AXy+tZ
         7aCTmWUspyevQpEw4D9io34TkdRzJ0G7cpXWCv0drcyrkO06J+YRW6lM2FSakbIKb3qb
         PDaEdFGNUbiWFHSKCShCaHqdho2RrWrOWfeCRSI9ZjNHPyq/R1+hnTAiSavCosIYgarO
         59CA==
X-Gm-Message-State: AGi0PuYIViTwncMA94akRdddRiFT68trWjUv6CisS7ePm1UqtB6/Gusm
        eIoPbWPKqjCHlXS7KjV3kgD7BFlZPps=
X-Google-Smtp-Source: APiQypIr5reTD5+QfsTnUXN7utta2MQDPGZET7RwVshRdXF0NA8bsx1Cj9U6L5qXum1VMJjra6YU6A==
X-Received: by 2002:a17:90a:d17:: with SMTP id t23mr7625545pja.77.1587748801521;
        Fri, 24 Apr 2020 10:20:01 -0700 (PDT)
Received: from localhost ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id 18sm5095232pjf.30.2020.04.24.10.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 10:20:01 -0700 (PDT)
Date:   Sat, 25 Apr 2020 00:19:59 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH 2/8] cmake: generate the shell/perl/python scripts and
 templates, translations
Message-ID: <20200424171959.GI1949@danh.dev>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <ca242cf5bda74aafca6c169ad53ce33a62761027.1587700897.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca242cf5bda74aafca6c169ad53ce33a62761027.1587700897.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-24 04:01:31+0000, Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> 
> This patch implements the placeholder substitution to generate, say,
> `git-request-pull` from `git-request-pull.sh`.
> 
> The shell/perl/python scripts and template are generated using CMake
> (very similar to what sed does).
> 
> The text translations are only build if `msgfmt` is found in your path.
> 
> NOTE: The scripts and templates are generated during configuration.
> 
> Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> ---
>  CMakeLists.txt | 107 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 106 insertions(+), 1 deletion(-)
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index 73703bd321f..788b53be873 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -51,6 +51,11 @@ endif()
>  
>  find_program(SH_EXE sh)
>  
> +find_program(MSGFMT_EXE msgfmt)

I suppose find_package(Gettext) can do most of this work?

> +if(NOT MSGFMT_EXE)
> +	message(WARNING "Text Translations won't be build")
> +endif()
> +
>  #default behaviour
>  include_directories(${CMAKE_SOURCE_DIR})
>  add_compile_definitions(GIT_HOST_CPU="${CMAKE_SYSTEM_PROCESSOR}")
> @@ -525,4 +530,104 @@ endif()
>  add_custom_command(OUTPUT ${git_links} ${git_http_links}
>  		COMMAND ${CMAKE_COMMAND} -P ${CMAKE_BINARY_DIR}/CreateLinks.cmake
>  		DEPENDS git git-remote-http)
> -add_custom_target(git-links ALL DEPENDS ${git_links} ${git_http_links})
> \ No newline at end of file

No newline at end of file?

> +add_custom_target(git-links ALL DEPENDS ${git_links} ${git_http_links})
> +
> +
> +#creating required scripts
> +set(SHELL_PATH /bin/sh)
> +set(PERL_PATH /usr/bin/perl)

Really?
Have you tried on, let's say FreeBSD?

> +set(LOCALEDIR ${FALLBACK_RUNTIME_PREFIX}/share/locale)
> +set(GITWEBDIR ${FALLBACK_RUNTIME_PREFIX}/share/locale)
> +set(INSTLIBDIR ${FALLBACK_RUNTIME_PREFIX}/share/perl5)
> +
> +#shell scripts
> +set(git_shell_scripts
> +	git-bisect git-difftool--helper git-filter-branch
> +	git-merge-octopus git-merge-one-file git-merge-resolve
> +	git-mergetool git-quiltimport
> +	git-request-pull git-submodule git-web--browse
> +	git-mergetool--lib git-parse-remote git-rebase--preserve-merges
> +	git-sh-setup git-sh-i18n git-instaweb)
> +
> +foreach(script ${git_shell_scripts})
> +	file(STRINGS ${CMAKE_SOURCE_DIR}/${script}.sh content NEWLINE_CONSUME)
> +	string(REPLACE "@SHELL_PATH@" "${SHELL_PATH}" content "${content}")
> +	string(REPLACE "@@DIFF@@" "diff" content "${content}")
> +	string(REPLACE "@LOCALEDIR@" "${LOCALEDIR}" content "${content}")
> +	string(REPLACE "@GITWEBDIR@" "${GITWEBDIR}" content "${content}")
> +	string(REPLACE "@@NO_CURL@@" "" content "${content}")
> +	string(REPLACE "@@USE_GETTEXT_SCHEME@@" "" content "${content}")
> +	string(REPLACE "# @@BROKEN_PATH_FIX@@" "" content "${content}")
> +	string(REPLACE "@@PERL@@" "${PERL_PATH}" content "${content}")
> +	string(REPLACE "@@SANE_TEXT_GREP@@" "-a" content "${content}")
> +	string(REPLACE "@@PAGER_ENV@@" "LESS=FRX LV=-c" content "${content}")
> +	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
> +endforeach()

I assume this do most of sed magic?

> +
> +#perl scripts
> +set(git_perl_scripts
> +	git-add--interactive git-archimport git-cvsexportcommit
> +	git-cvsimport git-cvsserver git-send-email git-svn)
> +
> +#create perl header
> +file(STRINGS ${CMAKE_SOURCE_DIR}/perl/header_templates/fixed_prefix.template.pl perl_header )
> +string(REPLACE "@@PATHSEP@@" ":" perl_header "${perl_header}")
> +string(REPLACE "@@INSTLIBDIR@@" "${INSTLIBDIR}" perl_header "${perl_header}")
> +
> +foreach(script ${git_perl_scripts})
> +	file(STRINGS ${CMAKE_SOURCE_DIR}/${script}.perl content NEWLINE_CONSUME)
> +	string(REPLACE "#!/usr/bin/perl" "#!/usr/bin/perl\n${perl_header}\n" content "${content}")

Hoped that this is tried on BSD?

> +	string(REPLACE "@@GIT_VERSION@@" "${PROJECT_VERSION}" content "${content}")
> +	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
> +endforeach()
> +
> +#python script
> +file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
> +string(REPLACE "#!/usr/bin/env python" "#!/usr/bin/python" content "${content}")
> +file(WRITE ${CMAKE_BINARY_DIR}/git-p4 ${content})
> +
> +#perl modules
> +file(GLOB_RECURSE perl_modules "${CMAKE_SOURCE_DIR}/perl/*.pm")
> +
> +foreach(pm ${perl_modules})
> +	string(REPLACE "${CMAKE_SOURCE_DIR}/perl/" "" file_path ${pm})

So, the real source code have reference to CMAKE_SOURCE_DIR?
I don't think so? It's purely my guess from previous patch, this
function will do
string(REPLACE from to file something_I_have_not_checked)

> +	file(STRINGS ${pm} content NEWLINE_CONSUME)
> +	string(REPLACE "@@LOCALEDIR@@" "${LOCALEDIR}" content "${content}")
> +	string(REPLACE "@@NO_PERL_CPAN_FALLBACKS@@" "" content "${content}")
> +	file(WRITE ${CMAKE_BINARY_DIR}/perl/build/lib/${file_path} ${content})
> +#test-lib.sh requires perl/build/lib to be the build directory of perl modules
> +endforeach()
> +
> +
> +#templates
> +file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/branches) #create branches
> +set(hooks_templates
> +	applypatch-msg.sample pre-applypatch.sample pre-push.sample
> +	commit-msg.sample pre-commit.sample pre-rebase.sample
> +	fsmonitor-watchman.sample pre-merge-commit.sample pre-receive.sample
> +	post-update.sample prepare-commit-msg.sample update.sample)

Too much things merged into one line, I hate it.

> +
> +#templates have @.*@ replacement so use configure_file instead
> +#hooks
> +foreach(tm ${hooks_templates})
> +	configure_file(${CMAKE_SOURCE_DIR}/templates/hooks--${tm} ${CMAKE_BINARY_DIR}/templates/blt/hooks/${tm} @ONLY)
> +endforeach()

What does this really means?

> +
> +#info
> +configure_file(${CMAKE_SOURCE_DIR}/templates/info--exclude ${CMAKE_BINARY_DIR}/templates/blt/info/exclude @ONLY)
> +
> +#this
> +configure_file(${CMAKE_SOURCE_DIR}/templates/this--description ${CMAKE_BINARY_DIR}/templates/blt/description @ONLY)
> +
> +
> +#translations
> +if(MSGFMT_EXE)
> +	set(po_files bg  ca  de  el  es  fr  is  it  ko  pt_PT  ru  sv  tr  vi  zh_CN  zh_TW)

hard coded, so this is a regression, compared to old Makefile?

> +	foreach(po ${po_files})
> +		file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES)
> +		add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo
> +				COMMAND ${MSGFMT_EXE} --check --statistics -o ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo ${CMAKE_SOURCE_DIR}/po/${po}.po)

find_package(Gettext) defines MSGFMT_EXECUTABLE, I think.
Have you check Solaris option?
Or is this tranlated from current Makefile?
I haven't checked current source code!

> +		list(APPEND po_gen ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo)
> +	endforeach()
> +	add_custom_target(po-gen ALL DEPENDS ${po_gen})
> +endif()
> -- 
> gitgitgadget
> 

-- 
Danh
