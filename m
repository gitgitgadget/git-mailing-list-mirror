Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F35C433ED
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 05:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC43E610CB
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 05:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhDCFQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 01:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhDCFQs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 01:16:48 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1065C0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 22:16:44 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so5445837pjc.2
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 22:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=s/VFZt3JIlR0dcB20Fo5Fle5f06DOq18lcyO9TU+WM4=;
        b=Gi6MunlZrItPTWXJGFp6bWqPZDsUP5BI4fByunQD6OqGy+4dS3nO8h/iTDS7EzHsR0
         luv2EJ3yPk7B3n6bWOqYWUWcuQJwjqmm2jYSa3eb1edbpW+V284B5OuNKNtYKmjrraSV
         bczUm1wqobeDen0vvCnDs8N7WRtV036F2TaHqYGk8r4Kf3ZY7cqgji4IsHoXcB0djgVQ
         i21GQGXUaDI7IKHJDTP6/koWyPJfnwJMoh5fWxuVBChufRESR7xDGUSgM6iLhL/RQAsD
         Y+Fv5nwTLwDCA2KWNlDrmRUNZ8j6C13u6v8Ounf2H+zWRbLwqKX+yVXNcNO0sZ6Uz6Ln
         7Xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=s/VFZt3JIlR0dcB20Fo5Fle5f06DOq18lcyO9TU+WM4=;
        b=N5378US040QgWiVz1rlWie2rlk2JCCYqzcBxPVwhYuuiOU93OfysWfk63ZysfVZqhw
         Ajc+lJqE2fbZ1akD0lZXJ+Mfbr0bGHvMTsI+2j4LKdmb9MoC4cZcL6+ok1CiffQrdNrD
         2m0l2GApkBnsD3vk8QWiQ07V7SiTDojNBjwT4GyBXihFMjMzeLaR6fvd239UVb+eCluF
         YE1qXMumXngr1oMOegsL67h74SZV9XcvOt1ShFZOYfq1O9hJJondAi1x44PdkyjzuDvY
         0Sv9Dl/ZRC6PlhlCjUxis7CaG16n9NklM+wK6hO08E7yk12RBvy1ics0WvLcteMxOCmi
         m4Rw==
X-Gm-Message-State: AOAM530DxtRbmaasOglVsWhBXK/ZA46raMjgUzyL/A9/jqnNw/Cweo9f
        vqy4vulnJeuy69M6Get1u/MH/5LaNZBVhQ==
X-Google-Smtp-Source: ABdhPJz91pVr2YT9y+CmF72D4DhL1Yu95VCOOIEXgZxBZefHZG07EuVa6bpqc/lYby5O3TM4xotplQ==
X-Received: by 2002:a17:90b:4aca:: with SMTP id mh10mr16201855pjb.185.1617427004414;
        Fri, 02 Apr 2021 22:16:44 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-50.three.co.id. [116.206.28.50])
        by smtp.gmail.com with ESMTPSA id i4sm9873559pfo.14.2021.04.02.22.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 22:16:44 -0700 (PDT)
Subject: Re: [PATCH][GSoC] user-manual.txt: fix empty heading of introduction
To:     Junio C Hamano <gitster@pobox.com>,
        Firmin Martin <firminmartin24@gmail.com>
Cc:     git@vger.kernel.org
References: <20210402121303.344914-1-firminmartin24@gmail.com>
 <xmqqwntk2xgy.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <7530f132-cd72-bb6f-21f1-1ee23ca5e20f@gmail.com>
Date:   Sat, 3 Apr 2021 12:16:40 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqwntk2xgy.fsf@gitster.g>
Content-Type: multipart/mixed;
 boundary="------------12A88B567543E19DC53F339E"
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------12A88B567543E19DC53F339E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/04/21 04.22, Junio C Hamano wrote:
> I would have expected to see "before and after".  Is it too obvious
> what the postimage would be?  Otherwise, a better presentation would
> be to show (an excerpt from) diff between preimage and postimage
> output.
> 
> Thanks.
> 
Attached is `diff -u` of generated HTML output, before and after this
patch. The HTML is generated using Asciidoctor.

It seems like from the output, this patch actually add missing header
for intro chapter (in line with title of this patch).

Anyway, thanks.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

--------------12A88B567543E19DC53F339E
Content-Type: text/x-patch; charset=UTF-8;
 name="before-after.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="before-after.diff"

--- user-manual.html	2021-04-03 11:58:44.937710623 +0700
+++ user-manual.patched.html	2021-04-03 12:01:01.634421455 +0700
@@ -1,17 +1,17 @@
 <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/=
html4/strict.dtd">
-<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; char=
set=3DUTF-8"><title>Git User Manual</title><link rel=3D"stylesheet" type=3D=
"text/css" href=3D"docbook-xsl.css"><meta name=3D"generator" content=3D"D=
ocBook XSL Stylesheets V1.79.1"></head><body bgcolor=3D"white" text=3D"bl=
ack" link=3D"#0000FF" vlink=3D"#840084" alink=3D"#0000FF"><div lang=3D"en=
" class=3D"book"><div class=3D"titlepage"><div><div><h1 class=3D"title"><=
a name=3D"id-1"></a>Git User Manual</h1></div></div><hr></div><div class=3D=
"toc"><p><b>Table of Contents</b></p><dl class=3D"toc"><dt><span class=3D=
"preface"><a href=3D"#id-1.2"></a></span></dt><dt><span class=3D"chapter"=
><a href=3D"#repositories-and-branches">1. Repositories and Branches</a><=
/span></dt><dd><dl><dt><span class=3D"section"><a href=3D"#how-to-get-a-g=
it-repository">How to get a Git repository</a></span></dt><dt><span class=
=3D"section"><a href=3D"#how-to-check-out">How to check out a different v=
ersion of a project</a></span></dt><dt><span class=3D"section"><a href=3D=
"#understanding-commits">Understanding History: Commits</a></span></dt><d=
d><dl><dt><span class=3D"section"><a href=3D"#understanding-reachability"=
>Understanding history: commits, parents, and reachability</a></span></dt=
><dt><span class=3D"section"><a href=3D"#history-diagrams">Understanding =
history: History diagrams</a></span></dt><dt><span class=3D"section"><a h=
ref=3D"#what-is-a-branch">Understanding history: What is a branch?</a></s=
pan></dt></dl></dd><dt><span class=3D"section"><a href=3D"#manipulating-b=
ranches">Manipulating branches</a></span></dt><dt><span class=3D"section"=
><a href=3D"#detached-head">Examining an old version without creating a n=
ew branch</a></span></dt><dt><span class=3D"section"><a href=3D"#examinin=
g-remote-branches">Examining branches from a remote repository</a></span>=
</dt><dt><span class=3D"section"><a href=3D"#how-git-stores-references">N=
aming branches, tags, and other references</a></span></dt><dt><span class=
=3D"section"><a href=3D"#Updating-a-repository-With-git-fetch">Updating a=20
repository with git fetch</a></span></dt><dt><span class=3D"section"><a h=
ref=3D"#fetching-branches">Fetching branches from other repositories</a><=
/span></dt></dl></dd><dt><span class=3D"chapter"><a href=3D"#exploring-gi=
t-history">2. Exploring Git history</a></span></dt><dd><dl><dt><span clas=
s=3D"section"><a href=3D"#using-bisect">How to use bisect to find a regre=
ssion</a></span></dt><dt><span class=3D"section"><a href=3D"#naming-commi=
ts">Naming commits</a></span></dt><dt><span class=3D"section"><a href=3D"=
#creating-tags">Creating tags</a></span></dt><dt><span class=3D"section">=
<a href=3D"#browsing-revisions">Browsing revisions</a></span></dt><dt><sp=
an class=3D"section"><a href=3D"#generating-diffs">Generating diffs</a></=
span></dt><dt><span class=3D"section"><a href=3D"#viewing-old-file-versio=
ns">Viewing old file versions</a></span></dt><dt><span class=3D"section">=
<a href=3D"#history-examples">Examples</a></span></dt><dd><dl><dt><span c=
lass=3D"section"><a href=3D"#counting-commits-on-a-branch">Counting the n=
umber of commits on a branch</a></span></dt><dt><span class=3D"section"><=
a href=3D"#checking-for-equal-branches">Check whether two branches point =
at the same history</a></span></dt><dt><span class=3D"section"><a href=3D=
"#finding-tagged-descendants">Find first tagged version including a given=20
fix</a></span></dt><dt><span class=3D"section"><a href=3D"#showing-commit=
s-unique-to-a-branch">Showing commits unique to a given branch</a></span>=
</dt><dt><span class=3D"section"><a href=3D"#making-a-release">Creating a=20
changelog and tarball for a software release</a></span></dt><dt><span cla=
ss=3D"section"><a href=3D"#Finding-commits-With-given-Content">Finding co=
mmits referencing a file with given content</a></span></dt></dl></dd></dl=
></dd><dt><span class=3D"chapter"><a href=3D"#Developing-With-git">3. Dev=
eloping with Git</a></span></dt><dd><dl><dt><span class=3D"section"><a hr=
ef=3D"#telling-git-your-name">Telling Git your name</a></span></dt><dt><s=
pan class=3D"section"><a href=3D"#creating-a-new-repository">Creating a n=
ew repository</a></span></dt><dt><span class=3D"section"><a href=3D"#how-=
to-make-a-commit">How to make a commit</a></span></dt><dt><span class=3D"=
section"><a href=3D"#creating-good-commit-messages">Creating good commit =
messages</a></span></dt><dt><span class=3D"section"><a href=3D"#ignoring-=
files">Ignoring files</a></span></dt><dt><span class=3D"section"><a href=3D=
"#how-to-merge">How to merge</a></span></dt><dt><span class=3D"section"><=
a href=3D"#resolving-a-merge">Resolving a merge</a></span></dt><dd><dl><d=
t><span class=3D"section"><a href=3D"#conflict-resolution">Getting confli=
ct-resolution help during a merge</a></span></dt></dl></dd><dt><span clas=
s=3D"section"><a href=3D"#undoing-a-merge">Undoing a merge</a></span></dt=
><dt><span class=3D"section"><a href=3D"#fast-forwards">Fast-forward merg=
es</a></span></dt><dt><span class=3D"section"><a href=3D"#fixing-mistakes=
">Fixing mistakes</a></span></dt><dd><dl><dt><span class=3D"section"><a h=
ref=3D"#reverting-a-commit">Fixing a mistake with a new commit</a></span>=
</dt><dt><span class=3D"section"><a href=3D"#fixing-a-mistake-by-rewritin=
g-history">Fixing a mistake by rewriting history</a></span></dt><dt><span=20
class=3D"section"><a href=3D"#checkout-of-path">Checking out an old versi=
on of a file</a></span></dt><dt><span class=3D"section"><a href=3D"#inter=
rupted-work">Temporarily setting aside work in progress</a></span></dt></=
dl></dd><dt><span class=3D"section"><a href=3D"#ensuring-good-performance=
">Ensuring good performance</a></span></dt><dt><span class=3D"section"><a=20
href=3D"#ensuring-reliability">Ensuring reliability</a></span></dt><dd><d=
l><dt><span class=3D"section"><a href=3D"#checking-for-corruption">Checki=
ng the repository for corruption</a></span></dt><dt><span class=3D"sectio=
n"><a href=3D"#recovering-lost-changes">Recovering lost changes</a></span=
></dt></dl></dd></dl></dd><dt><span class=3D"chapter"><a href=3D"#sharing=
-development">4. Sharing development with others</a></span></dt><dd><dl><=
dt><span class=3D"section"><a href=3D"#getting-updates-With-git-pull">Get=
ting updates with git pull</a></span></dt><dt><span class=3D"section"><a =
href=3D"#submitting-patches">Submitting patches to a project</a></span></=
dt><dt><span class=3D"section"><a href=3D"#importing-patches">Importing p=
atches to a project</a></span></dt><dt><span class=3D"section"><a href=3D=
"#public-repositories">Public Git repositories</a></span></dt><dd><dl><dt=
><span class=3D"section"><a href=3D"#setting-up-a-public-repository">Sett=
ing up a public repository</a></span></dt><dt><span class=3D"section"><a =
href=3D"#exporting-via-git">Exporting a Git repository via the Git protoc=
ol</a></span></dt><dt><span class=3D"section"><a href=3D"#exporting-via-h=
ttp">Exporting a git repository via HTTP</a></span></dt><dt><span class=3D=
"section"><a href=3D"#pushing-changes-to-a-public-repository">Pushing cha=
nges to a public repository</a></span></dt><dt><span class=3D"section"><a=20
href=3D"#forcing-push">What to do when a push fails</a></span></dt><dt><s=
pan class=3D"section"><a href=3D"#setting-up-a-shared-repository">Setting=20
up a shared repository</a></span></dt><dt><span class=3D"section"><a href=
=3D"#setting-up-gitweb">Allowing web browsing of a repository</a></span><=
/dt></dl></dd><dt><span class=3D"section"><a href=3D"#how-to-get-a-git-re=
pository-with-minimal-history">How to get a Git repository with minimal h=
istory</a></span></dt><dt><span class=3D"section"><a href=3D"#sharing-dev=
elopment-examples">Examples</a></span></dt><dd><dl><dt><span class=3D"sec=
tion"><a href=3D"#maintaining-topic-branches">Maintaining topic branches =
for a Linux subsystem maintainer</a></span></dt></dl></dd></dl></dd><dt><=
span class=3D"chapter"><a href=3D"#cleaning-up-history">5. Rewriting hist=
ory and maintaining patch series</a></span></dt><dd><dl><dt><span class=3D=
"section"><a href=3D"#patch-series">Creating the perfect patch series</a>=
</span></dt><dt><span class=3D"section"><a href=3D"#using-git-rebase">Kee=
ping a patch series up to date using git rebase</a></span></dt><dt><span =
class=3D"section"><a href=3D"#rewriting-one-commit">Rewriting a single co=
mmit</a></span></dt><dt><span class=3D"section"><a href=3D"#reordering-pa=
tch-series">Reordering or selecting from a patch series</a></span></dt><d=
t><span class=3D"section"><a href=3D"#interactive-rebase">Using interacti=
ve rebases</a></span></dt><dt><span class=3D"section"><a href=3D"#patch-s=
eries-tools">Other tools</a></span></dt><dt><span class=3D"section"><a hr=
ef=3D"#problems-With-rewriting-history">Problems with rewriting history</=
a></span></dt><dt><span class=3D"section"><a href=3D"#bisect-merges">Why =
bisecting merge commits can be harder than bisecting linear history</a></=
span></dt></dl></dd><dt><span class=3D"chapter"><a href=3D"#advanced-bran=
ch-management">6. Advanced branch management</a></span></dt><dd><dl><dt><=
span class=3D"section"><a href=3D"#fetching-individual-branches">Fetching=20
individual branches</a></span></dt><dt><span class=3D"section"><a href=3D=
"#fetch-fast-forwards">git fetch and fast-forwards</a></span></dt><dt><sp=
an class=3D"section"><a href=3D"#forcing-fetch">Forcing git fetch to do n=
on-fast-forward updates</a></span></dt><dt><span class=3D"section"><a hre=
f=3D"#remote-branch-configuration">Configuring remote-tracking branches</=
a></span></dt></dl></dd><dt><span class=3D"chapter"><a href=3D"#git-conce=
pts">7. Git concepts</a></span></dt><dd><dl><dt><span class=3D"section"><=
a href=3D"#the-object-database">The Object Database</a></span></dt><dd><d=
l><dt><span class=3D"section"><a href=3D"#commit-object">Commit Object</a=
></span></dt><dt><span class=3D"section"><a href=3D"#tree-object">Tree Ob=
ject</a></span></dt><dt><span class=3D"section"><a href=3D"#blob-object">=
Blob Object</a></span></dt><dt><span class=3D"section"><a href=3D"#trust"=
>Trust</a></span></dt><dt><span class=3D"section"><a href=3D"#tag-object"=
>Tag Object</a></span></dt><dt><span class=3D"section"><a href=3D"#pack-f=
iles">How Git stores objects efficiently: pack files</a></span></dt><dt><=
span class=3D"section"><a href=3D"#dangling-objects">Dangling objects</a>=
</span></dt><dt><span class=3D"section"><a href=3D"#recovering-from-repos=
itory-corruption">Recovering from repository corruption</a></span></dt></=
dl></dd><dt><span class=3D"section"><a href=3D"#the-index">The index</a><=
/span></dt></dl></dd><dt><span class=3D"chapter"><a href=3D"#submodules">=
8. Submodules</a></span></dt><dd><dl><dt><span class=3D"section"><a href=3D=
"#pitfalls-with-submodules">Pitfalls with submodules</a></span></dt></dl>=
</dd><dt><span class=3D"chapter"><a href=3D"#low-level-operations">9. Low=
-level Git operations</a></span></dt><dd><dl><dt><span class=3D"section">=
<a href=3D"#object-manipulation">Object access and manipulation</a></span=
></dt><dt><span class=3D"section"><a href=3D"#the-workflow">The Workflow<=
/a></span></dt><dd><dl><dt><span class=3D"section"><a href=3D"#working-di=
rectory-to-index">working directory =E2=86=92 index</a></span></dt><dt><s=
pan class=3D"section"><a href=3D"#index-to-object-database">index =E2=86=92=20
object database</a></span></dt><dt><span class=3D"section"><a href=3D"#ob=
ject-database-to-index">object database =E2=86=92 index</a></span></dt><d=
t><span class=3D"section"><a href=3D"#index-to-working-directory">index =E2=
=86=92 working directory</a></span></dt><dt><span class=3D"section"><a hr=
ef=3D"#tying-it-all-together">Tying it all together</a></span></dt></dl><=
/dd><dt><span class=3D"section"><a href=3D"#examining-the-data">Examining=20
the data</a></span></dt><dt><span class=3D"section"><a href=3D"#merging-m=
ultiple-trees">Merging multiple trees</a></span></dt><dt><span class=3D"s=
ection"><a href=3D"#merging-multiple-trees-2">Merging multiple trees, con=
tinued</a></span></dt></dl></dd><dt><span class=3D"chapter"><a href=3D"#h=
acking-git">10. Hacking Git</a></span></dt><dd><dl><dt><span class=3D"sec=
tion"><a href=3D"#object-details">Object storage format</a></span></dt><d=
t><span class=3D"section"><a href=3D"#birdview-on-the-source-code">A bird=
s-eye view of Git=E2=80=99s source code</a></span></dt></dl></dd><dt><spa=
n class=3D"chapter"><a href=3D"#glossary">11. Git Glossary</a></span></dt=
><dd><dl><dt><span class=3D"section"><a href=3D"#git-explained">Git expla=
ined</a></span></dt></dl></dd><dt><span class=3D"appendix"><a href=3D"#gi=
t-quick-start">A. Git Quick Reference</a></span></dt><dd><dl><dt><span cl=
ass=3D"section"><a href=3D"#quick-creating-a-new-repository">Creating a n=
ew repository</a></span></dt><dt><span class=3D"section"><a href=3D"#mana=
ging-branches">Managing branches</a></span></dt><dt><span class=3D"sectio=
n"><a href=3D"#exploring-history">Exploring history</a></span></dt><dt><s=
pan class=3D"section"><a href=3D"#making-changes">Making changes</a></spa=
n></dt><dt><span class=3D"section"><a href=3D"#merging">Merging</a></span=
></dt><dt><span class=3D"section"><a href=3D"#sharing-your-changes">Shari=
ng your changes</a></span></dt><dt><span class=3D"section"><a href=3D"#re=
pository-maintenance">Repository maintenance</a></span></dt></dl></dd><dt=
><span class=3D"appendix"><a href=3D"#todo">B. Notes and todo list for th=
is manual</a></span></dt><dd><dl><dt><span class=3D"section"><a href=3D"#=
todo-list">Todo list</a></span></dt></dl></dd></dl></div>
+<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; char=
set=3DUTF-8"><title>Git User Manual</title><link rel=3D"stylesheet" type=3D=
"text/css" href=3D"docbook-xsl.css"><meta name=3D"generator" content=3D"D=
ocBook XSL Stylesheets V1.79.1"></head><body bgcolor=3D"white" text=3D"bl=
ack" link=3D"#0000FF" vlink=3D"#840084" alink=3D"#0000FF"><div lang=3D"en=
" class=3D"book"><div class=3D"titlepage"><div><div><h1 class=3D"title"><=
a name=3D"id-1"></a>Git User Manual</h1></div></div><hr></div><div class=3D=
"toc"><p><b>Table of Contents</b></p><dl class=3D"toc"><dt><span class=3D=
"chapter"><a href=3D"#introduction">1. Introduction</a></span></dt><dt><s=
pan class=3D"chapter"><a href=3D"#repositories-and-branches">2. Repositor=
ies and Branches</a></span></dt><dd><dl><dt><span class=3D"section"><a hr=
ef=3D"#how-to-get-a-git-repository">How to get a Git repository</a></span=
></dt><dt><span class=3D"section"><a href=3D"#how-to-check-out">How to ch=
eck out a different version of a project</a></span></dt><dt><span class=3D=
"section"><a href=3D"#understanding-commits">Understanding History: Commi=
ts</a></span></dt><dd><dl><dt><span class=3D"section"><a href=3D"#underst=
anding-reachability">Understanding history: commits, parents, and reachab=
ility</a></span></dt><dt><span class=3D"section"><a href=3D"#history-diag=
rams">Understanding history: History diagrams</a></span></dt><dt><span cl=
ass=3D"section"><a href=3D"#what-is-a-branch">Understanding history: What=20
is a branch?</a></span></dt></dl></dd><dt><span class=3D"section"><a href=
=3D"#manipulating-branches">Manipulating branches</a></span></dt><dt><spa=
n class=3D"section"><a href=3D"#detached-head">Examining an old version w=
ithout creating a new branch</a></span></dt><dt><span class=3D"section"><=
a href=3D"#examining-remote-branches">Examining branches from a remote re=
pository</a></span></dt><dt><span class=3D"section"><a href=3D"#how-git-s=
tores-references">Naming branches, tags, and other references</a></span><=
/dt><dt><span class=3D"section"><a href=3D"#Updating-a-repository-With-gi=
t-fetch">Updating a repository with git fetch</a></span></dt><dt><span cl=
ass=3D"section"><a href=3D"#fetching-branches">Fetching branches from oth=
er repositories</a></span></dt></dl></dd><dt><span class=3D"chapter"><a h=
ref=3D"#exploring-git-history">3. Exploring Git history</a></span></dt><d=
d><dl><dt><span class=3D"section"><a href=3D"#using-bisect">How to use bi=
sect to find a regression</a></span></dt><dt><span class=3D"section"><a h=
ref=3D"#naming-commits">Naming commits</a></span></dt><dt><span class=3D"=
section"><a href=3D"#creating-tags">Creating tags</a></span></dt><dt><spa=
n class=3D"section"><a href=3D"#browsing-revisions">Browsing revisions</a=
></span></dt><dt><span class=3D"section"><a href=3D"#generating-diffs">Ge=
nerating diffs</a></span></dt><dt><span class=3D"section"><a href=3D"#vie=
wing-old-file-versions">Viewing old file versions</a></span></dt><dt><spa=
n class=3D"section"><a href=3D"#history-examples">Examples</a></span></dt=
><dd><dl><dt><span class=3D"section"><a href=3D"#counting-commits-on-a-br=
anch">Counting the number of commits on a branch</a></span></dt><dt><span=20
class=3D"section"><a href=3D"#checking-for-equal-branches">Check whether =
two branches point at the same history</a></span></dt><dt><span class=3D"=
section"><a href=3D"#finding-tagged-descendants">Find first tagged versio=
n including a given fix</a></span></dt><dt><span class=3D"section"><a hre=
f=3D"#showing-commits-unique-to-a-branch">Showing commits unique to a giv=
en branch</a></span></dt><dt><span class=3D"section"><a href=3D"#making-a=
-release">Creating a changelog and tarball for a software release</a></sp=
an></dt><dt><span class=3D"section"><a href=3D"#Finding-commits-With-give=
n-Content">Finding commits referencing a file with given content</a></spa=
n></dt></dl></dd></dl></dd><dt><span class=3D"chapter"><a href=3D"#Develo=
ping-With-git">4. Developing with Git</a></span></dt><dd><dl><dt><span cl=
ass=3D"section"><a href=3D"#telling-git-your-name">Telling Git your name<=
/a></span></dt><dt><span class=3D"section"><a href=3D"#creating-a-new-rep=
ository">Creating a new repository</a></span></dt><dt><span class=3D"sect=
ion"><a href=3D"#how-to-make-a-commit">How to make a commit</a></span></d=
t><dt><span class=3D"section"><a href=3D"#creating-good-commit-messages">=
Creating good commit messages</a></span></dt><dt><span class=3D"section">=
<a href=3D"#ignoring-files">Ignoring files</a></span></dt><dt><span class=
=3D"section"><a href=3D"#how-to-merge">How to merge</a></span></dt><dt><s=
pan class=3D"section"><a href=3D"#resolving-a-merge">Resolving a merge</a=
></span></dt><dd><dl><dt><span class=3D"section"><a href=3D"#conflict-res=
olution">Getting conflict-resolution help during a merge</a></span></dt><=
/dl></dd><dt><span class=3D"section"><a href=3D"#undoing-a-merge">Undoing=20
a merge</a></span></dt><dt><span class=3D"section"><a href=3D"#fast-forwa=
rds">Fast-forward merges</a></span></dt><dt><span class=3D"section"><a hr=
ef=3D"#fixing-mistakes">Fixing mistakes</a></span></dt><dd><dl><dt><span =
class=3D"section"><a href=3D"#reverting-a-commit">Fixing a mistake with a=20
new commit</a></span></dt><dt><span class=3D"section"><a href=3D"#fixing-=
a-mistake-by-rewriting-history">Fixing a mistake by rewriting history</a>=
</span></dt><dt><span class=3D"section"><a href=3D"#checkout-of-path">Che=
cking out an old version of a file</a></span></dt><dt><span class=3D"sect=
ion"><a href=3D"#interrupted-work">Temporarily setting aside work in prog=
ress</a></span></dt></dl></dd><dt><span class=3D"section"><a href=3D"#ens=
uring-good-performance">Ensuring good performance</a></span></dt><dt><spa=
n class=3D"section"><a href=3D"#ensuring-reliability">Ensuring reliabilit=
y</a></span></dt><dd><dl><dt><span class=3D"section"><a href=3D"#checking=
-for-corruption">Checking the repository for corruption</a></span></dt><d=
t><span class=3D"section"><a href=3D"#recovering-lost-changes">Recovering=20
lost changes</a></span></dt></dl></dd></dl></dd><dt><span class=3D"chapte=
r"><a href=3D"#sharing-development">5. Sharing development with others</a=
></span></dt><dd><dl><dt><span class=3D"section"><a href=3D"#getting-upda=
tes-With-git-pull">Getting updates with git pull</a></span></dt><dt><span=20
class=3D"section"><a href=3D"#submitting-patches">Submitting patches to a=20
project</a></span></dt><dt><span class=3D"section"><a href=3D"#importing-=
patches">Importing patches to a project</a></span></dt><dt><span class=3D=
"section"><a href=3D"#public-repositories">Public Git repositories</a></s=
pan></dt><dd><dl><dt><span class=3D"section"><a href=3D"#setting-up-a-pub=
lic-repository">Setting up a public repository</a></span></dt><dt><span c=
lass=3D"section"><a href=3D"#exporting-via-git">Exporting a Git repositor=
y via the Git protocol</a></span></dt><dt><span class=3D"section"><a href=
=3D"#exporting-via-http">Exporting a git repository via HTTP</a></span></=
dt><dt><span class=3D"section"><a href=3D"#pushing-changes-to-a-public-re=
pository">Pushing changes to a public repository</a></span></dt><dt><span=20
class=3D"section"><a href=3D"#forcing-push">What to do when a push fails<=
/a></span></dt><dt><span class=3D"section"><a href=3D"#setting-up-a-share=
d-repository">Setting up a shared repository</a></span></dt><dt><span cla=
ss=3D"section"><a href=3D"#setting-up-gitweb">Allowing web browsing of a =
repository</a></span></dt></dl></dd><dt><span class=3D"section"><a href=3D=
"#how-to-get-a-git-repository-with-minimal-history">How to get a Git repo=
sitory with minimal history</a></span></dt><dt><span class=3D"section"><a=20
href=3D"#sharing-development-examples">Examples</a></span></dt><dd><dl><d=
t><span class=3D"section"><a href=3D"#maintaining-topic-branches">Maintai=
ning topic branches for a Linux subsystem maintainer</a></span></dt></dl>=
</dd></dl></dd><dt><span class=3D"chapter"><a href=3D"#cleaning-up-histor=
y">6. Rewriting history and maintaining patch series</a></span></dt><dd><=
dl><dt><span class=3D"section"><a href=3D"#patch-series">Creating the per=
fect patch series</a></span></dt><dt><span class=3D"section"><a href=3D"#=
using-git-rebase">Keeping a patch series up to date using git rebase</a><=
/span></dt><dt><span class=3D"section"><a href=3D"#rewriting-one-commit">=
Rewriting a single commit</a></span></dt><dt><span class=3D"section"><a h=
ref=3D"#reordering-patch-series">Reordering or selecting from a patch ser=
ies</a></span></dt><dt><span class=3D"section"><a href=3D"#interactive-re=
base">Using interactive rebases</a></span></dt><dt><span class=3D"section=
"><a href=3D"#patch-series-tools">Other tools</a></span></dt><dt><span cl=
ass=3D"section"><a href=3D"#problems-With-rewriting-history">Problems wit=
h rewriting history</a></span></dt><dt><span class=3D"section"><a href=3D=
"#bisect-merges">Why bisecting merge commits can be harder than bisecting=20
linear history</a></span></dt></dl></dd><dt><span class=3D"chapter"><a hr=
ef=3D"#advanced-branch-management">7. Advanced branch management</a></spa=
n></dt><dd><dl><dt><span class=3D"section"><a href=3D"#fetching-individua=
l-branches">Fetching individual branches</a></span></dt><dt><span class=3D=
"section"><a href=3D"#fetch-fast-forwards">git fetch and fast-forwards</a=
></span></dt><dt><span class=3D"section"><a href=3D"#forcing-fetch">Forci=
ng git fetch to do non-fast-forward updates</a></span></dt><dt><span clas=
s=3D"section"><a href=3D"#remote-branch-configuration">Configuring remote=
-tracking branches</a></span></dt></dl></dd><dt><span class=3D"chapter"><=
a href=3D"#git-concepts">8. Git concepts</a></span></dt><dd><dl><dt><span=20
class=3D"section"><a href=3D"#the-object-database">The Object Database</a=
></span></dt><dd><dl><dt><span class=3D"section"><a href=3D"#commit-objec=
t">Commit Object</a></span></dt><dt><span class=3D"section"><a href=3D"#t=
ree-object">Tree Object</a></span></dt><dt><span class=3D"section"><a hre=
f=3D"#blob-object">Blob Object</a></span></dt><dt><span class=3D"section"=
><a href=3D"#trust">Trust</a></span></dt><dt><span class=3D"section"><a h=
ref=3D"#tag-object">Tag Object</a></span></dt><dt><span class=3D"section"=
><a href=3D"#pack-files">How Git stores objects efficiently: pack files</=
a></span></dt><dt><span class=3D"section"><a href=3D"#dangling-objects">D=
angling objects</a></span></dt><dt><span class=3D"section"><a href=3D"#re=
covering-from-repository-corruption">Recovering from repository corruptio=
n</a></span></dt></dl></dd><dt><span class=3D"section"><a href=3D"#the-in=
dex">The index</a></span></dt></dl></dd><dt><span class=3D"chapter"><a hr=
ef=3D"#submodules">9. Submodules</a></span></dt><dd><dl><dt><span class=3D=
"section"><a href=3D"#pitfalls-with-submodules">Pitfalls with submodules<=
/a></span></dt></dl></dd><dt><span class=3D"chapter"><a href=3D"#low-leve=
l-operations">10. Low-level Git operations</a></span></dt><dd><dl><dt><sp=
an class=3D"section"><a href=3D"#object-manipulation">Object access and m=
anipulation</a></span></dt><dt><span class=3D"section"><a href=3D"#the-wo=
rkflow">The Workflow</a></span></dt><dd><dl><dt><span class=3D"section"><=
a href=3D"#working-directory-to-index">working directory =E2=86=92 index<=
/a></span></dt><dt><span class=3D"section"><a href=3D"#index-to-object-da=
tabase">index =E2=86=92 object database</a></span></dt><dt><span class=3D=
"section"><a href=3D"#object-database-to-index">object database =E2=86=92=20
index</a></span></dt><dt><span class=3D"section"><a href=3D"#index-to-wor=
king-directory">index =E2=86=92 working directory</a></span></dt><dt><spa=
n class=3D"section"><a href=3D"#tying-it-all-together">Tying it all toget=
her</a></span></dt></dl></dd><dt><span class=3D"section"><a href=3D"#exam=
ining-the-data">Examining the data</a></span></dt><dt><span class=3D"sect=
ion"><a href=3D"#merging-multiple-trees">Merging multiple trees</a></span=
></dt><dt><span class=3D"section"><a href=3D"#merging-multiple-trees-2">M=
erging multiple trees, continued</a></span></dt></dl></dd><dt><span class=
=3D"chapter"><a href=3D"#hacking-git">11. Hacking Git</a></span></dt><dd>=
<dl><dt><span class=3D"section"><a href=3D"#object-details">Object storag=
e format</a></span></dt><dt><span class=3D"section"><a href=3D"#birdview-=
on-the-source-code">A birds-eye view of Git=E2=80=99s source code</a></sp=
an></dt></dl></dd><dt><span class=3D"chapter"><a href=3D"#glossary">12. G=
it Glossary</a></span></dt><dd><dl><dt><span class=3D"section"><a href=3D=
"#git-explained">Git explained</a></span></dt></dl></dd><dt><span class=3D=
"appendix"><a href=3D"#git-quick-start">A. Git Quick Reference</a></span>=
</dt><dd><dl><dt><span class=3D"section"><a href=3D"#quick-creating-a-new=
-repository">Creating a new repository</a></span></dt><dt><span class=3D"=
section"><a href=3D"#managing-branches">Managing branches</a></span></dt>=
<dt><span class=3D"section"><a href=3D"#exploring-history">Exploring hist=
ory</a></span></dt><dt><span class=3D"section"><a href=3D"#making-changes=
">Making changes</a></span></dt><dt><span class=3D"section"><a href=3D"#m=
erging">Merging</a></span></dt><dt><span class=3D"section"><a href=3D"#sh=
aring-your-changes">Sharing your changes</a></span></dt><dt><span class=3D=
"section"><a href=3D"#repository-maintenance">Repository maintenance</a><=
/span></dt></dl></dd><dt><span class=3D"appendix"><a href=3D"#todo">B. No=
tes and todo list for this manual</a></span></dt><dd><dl><dt><span class=3D=
"section"><a href=3D"#todo-list">Todo list</a></span></dt></dl></dd></dl>=
</div>
=20
-<div class=3D"preface"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"id-1.2"></a></h1></div></div></div>
+<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"introduction"></a>Chapter=C2=A01.=C2=A0Introduction</h1>=
</div></div></div>
=20
 <p>Git is a fast distributed revision control system.</p>
 <p>This manual is designed to be readable by someone with basic UNIX
 command-line skills, but no previous knowledge of Git.</p>
-<p><a class=3D"xref" href=3D"#repositories-and-branches" title=3D"Chapte=
r=C2=A01.=C2=A0Repositories and Branches">Chapter=C2=A01, <i>Repositories=20
and Branches</i></a> and <a class=3D"xref" href=3D"#exploring-git-history=
" title=3D"Chapter=C2=A02.=C2=A0Exploring Git history">Chapter=C2=A02, <i=
>Exploring Git history</i></a> explain how
+<p><a class=3D"xref" href=3D"#repositories-and-branches" title=3D"Chapte=
r=C2=A02.=C2=A0Repositories and Branches">Chapter=C2=A02, <i>Repositories=20
and Branches</i></a> and <a class=3D"xref" href=3D"#exploring-git-history=
" title=3D"Chapter=C2=A03.=C2=A0Exploring Git history">Chapter=C2=A03, <i=
>Exploring Git history</i></a> explain how
 to fetch and study a project using git=E2=80=94=E2=80=8Bread these chapt=
ers to learn how
 to build and test a particular version of a software project, search for=

 regressions, and so on.</p>
 <p>People needing to do actual development will also want to read
-<a class=3D"xref" href=3D"#Developing-With-git" title=3D"Chapter=C2=A03.=
=C2=A0Developing with Git">Chapter=C2=A03, <i>Developing with Git</i></a>=20
and <a class=3D"xref" href=3D"#sharing-development" title=3D"Chapter=C2=A0=
4.=C2=A0Sharing development with others">Chapter=C2=A04, <i>Sharing devel=
opment with others</i></a>.</p>
+<a class=3D"xref" href=3D"#Developing-With-git" title=3D"Chapter=C2=A04.=
=C2=A0Developing with Git">Chapter=C2=A04, <i>Developing with Git</i></a>=20
and <a class=3D"xref" href=3D"#sharing-development" title=3D"Chapter=C2=A0=
5.=C2=A0Sharing development with others">Chapter=C2=A05, <i>Sharing devel=
opment with others</i></a>.</p>
 <p>Further chapters cover more specialized topics.</p>
 <p>Comprehensive reference documentation is available through the man
 pages, or <a class=3D"ulink" href=3D"git-help.html" target=3D"_top">git-=
help(1)</a> command.  For example, for the command
@@ -26,7 +26,7 @@
 <p>Finally, see <a class=3D"xref" href=3D"#todo" title=3D"Appendix=C2=A0=
B.=C2=A0Notes and todo list for this manual">Appendix=C2=A0B, <i>Notes an=
d todo list for this manual</i></a> for ways that you can help make this =
manual more
 complete.</p>
 </div>
-<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"repositories-and-branches"></a>Chapter=C2=A01.=C2=A0Repo=
sitories and Branches</h1></div></div></div><div class=3D"toc"><p><b>Tabl=
e of Contents</b></p><dl class=3D"toc"><dt><span class=3D"section"><a hre=
f=3D"#how-to-get-a-git-repository">How to get a Git repository</a></span>=
</dt><dt><span class=3D"section"><a href=3D"#how-to-check-out">How to che=
ck out a different version of a project</a></span></dt><dt><span class=3D=
"section"><a href=3D"#understanding-commits">Understanding History: Commi=
ts</a></span></dt><dd><dl><dt><span class=3D"section"><a href=3D"#underst=
anding-reachability">Understanding history: commits, parents, and reachab=
ility</a></span></dt><dt><span class=3D"section"><a href=3D"#history-diag=
rams">Understanding history: History diagrams</a></span></dt><dt><span cl=
ass=3D"section"><a href=3D"#what-is-a-branch">Understanding history: What=20
is a branch?</a></span></dt></dl></dd><dt><span class=3D"section"><a href=
=3D"#manipulating-branches">Manipulating branches</a></span></dt><dt><spa=
n class=3D"section"><a href=3D"#detached-head">Examining an old version w=
ithout creating a new branch</a></span></dt><dt><span class=3D"section"><=
a href=3D"#examining-remote-branches">Examining branches from a remote re=
pository</a></span></dt><dt><span class=3D"section"><a href=3D"#how-git-s=
tores-references">Naming branches, tags, and other references</a></span><=
/dt><dt><span class=3D"section"><a href=3D"#Updating-a-repository-With-gi=
t-fetch">Updating a repository with git fetch</a></span></dt><dt><span cl=
ass=3D"section"><a href=3D"#fetching-branches">Fetching branches from oth=
er repositories</a></span></dt></dl></div>
+<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"repositories-and-branches"></a>Chapter=C2=A02.=C2=A0Repo=
sitories and Branches</h1></div></div></div><div class=3D"toc"><p><b>Tabl=
e of Contents</b></p><dl class=3D"toc"><dt><span class=3D"section"><a hre=
f=3D"#how-to-get-a-git-repository">How to get a Git repository</a></span>=
</dt><dt><span class=3D"section"><a href=3D"#how-to-check-out">How to che=
ck out a different version of a project</a></span></dt><dt><span class=3D=
"section"><a href=3D"#understanding-commits">Understanding History: Commi=
ts</a></span></dt><dd><dl><dt><span class=3D"section"><a href=3D"#underst=
anding-reachability">Understanding history: commits, parents, and reachab=
ility</a></span></dt><dt><span class=3D"section"><a href=3D"#history-diag=
rams">Understanding history: History diagrams</a></span></dt><dt><span cl=
ass=3D"section"><a href=3D"#what-is-a-branch">Understanding history: What=20
is a branch?</a></span></dt></dl></dd><dt><span class=3D"section"><a href=
=3D"#manipulating-branches">Manipulating branches</a></span></dt><dt><spa=
n class=3D"section"><a href=3D"#detached-head">Examining an old version w=
ithout creating a new branch</a></span></dt><dt><span class=3D"section"><=
a href=3D"#examining-remote-branches">Examining branches from a remote re=
pository</a></span></dt><dt><span class=3D"section"><a href=3D"#how-git-s=
tores-references">Naming branches, tags, and other references</a></span><=
/dt><dt><span class=3D"section"><a href=3D"#Updating-a-repository-With-gi=
t-fetch">Updating a repository with git fetch</a></span></dt><dt><span cl=
ass=3D"section"><a href=3D"#fetching-branches">Fetching branches from oth=
er repositories</a></span></dt></dl></div>
=20
 <div class=3D"section"><div class=3D"titlepage"><div><div><h2 class=3D"t=
itle" style=3D"clear: both"><a name=3D"how-to-get-a-git-repository"></a>H=
ow to get a Git repository</h2></div></div></div>
=20
@@ -139,7 +139,7 @@
 has that commit at all).  Since the object name is computed as a hash ov=
er the
 contents of the commit, you are guaranteed that the commit can never cha=
nge
 without its name also changing.</p>
-<p>In fact, in <a class=3D"xref" href=3D"#git-concepts" title=3D"Chapter=
=C2=A07.=C2=A0Git concepts">Chapter=C2=A07, <i>Git concepts</i></a> we sh=
all see that everything stored in Git
+<p>In fact, in <a class=3D"xref" href=3D"#git-concepts" title=3D"Chapter=
=C2=A08.=C2=A0Git concepts">Chapter=C2=A08, <i>Git concepts</i></a> we sh=
all see that everything stored in Git
 history, including file data and directory contents, is stored in an obj=
ect
 with a name that is a hash of its contents.</p>
 <div class=3D"section"><div class=3D"titlepage"><div><div><h3 class=3D"t=
itle"><a name=3D"understanding-reachability"></a>Understanding history: c=
ommits, parents, and reachability</h3></div></div></div>
@@ -351,7 +351,7 @@
 <a class=3D"ulink" href=3D"git-config.html" target=3D"_top">git-config(1=
)</a> for details.)</p>
 </div>
 </div>
-<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"exploring-git-history"></a>Chapter=C2=A02.=C2=A0Explorin=
g Git history</h1></div></div></div><div class=3D"toc"><p><b>Table of Con=
tents</b></p><dl class=3D"toc"><dt><span class=3D"section"><a href=3D"#us=
ing-bisect">How to use bisect to find a regression</a></span></dt><dt><sp=
an class=3D"section"><a href=3D"#naming-commits">Naming commits</a></span=
></dt><dt><span class=3D"section"><a href=3D"#creating-tags">Creating tag=
s</a></span></dt><dt><span class=3D"section"><a href=3D"#browsing-revisio=
ns">Browsing revisions</a></span></dt><dt><span class=3D"section"><a href=
=3D"#generating-diffs">Generating diffs</a></span></dt><dt><span class=3D=
"section"><a href=3D"#viewing-old-file-versions">Viewing old file version=
s</a></span></dt><dt><span class=3D"section"><a href=3D"#history-examples=
">Examples</a></span></dt><dd><dl><dt><span class=3D"section"><a href=3D"=
#counting-commits-on-a-branch">Counting the number of commits on a branch=
</a></span></dt><dt><span class=3D"section"><a href=3D"#checking-for-equa=
l-branches">Check whether two branches point at the same history</a></spa=
n></dt><dt><span class=3D"section"><a href=3D"#finding-tagged-descendants=
">Find first tagged version including a given fix</a></span></dt><dt><spa=
n class=3D"section"><a href=3D"#showing-commits-unique-to-a-branch">Showi=
ng commits unique to a given branch</a></span></dt><dt><span class=3D"sec=
tion"><a href=3D"#making-a-release">Creating a changelog and tarball for =
a software release</a></span></dt><dt><span class=3D"section"><a href=3D"=
#Finding-commits-With-given-Content">Finding commits referencing a file w=
ith given content</a></span></dt></dl></dd></dl></div>
+<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"exploring-git-history"></a>Chapter=C2=A03.=C2=A0Explorin=
g Git history</h1></div></div></div><div class=3D"toc"><p><b>Table of Con=
tents</b></p><dl class=3D"toc"><dt><span class=3D"section"><a href=3D"#us=
ing-bisect">How to use bisect to find a regression</a></span></dt><dt><sp=
an class=3D"section"><a href=3D"#naming-commits">Naming commits</a></span=
></dt><dt><span class=3D"section"><a href=3D"#creating-tags">Creating tag=
s</a></span></dt><dt><span class=3D"section"><a href=3D"#browsing-revisio=
ns">Browsing revisions</a></span></dt><dt><span class=3D"section"><a href=
=3D"#generating-diffs">Generating diffs</a></span></dt><dt><span class=3D=
"section"><a href=3D"#viewing-old-file-versions">Viewing old file version=
s</a></span></dt><dt><span class=3D"section"><a href=3D"#history-examples=
">Examples</a></span></dt><dd><dl><dt><span class=3D"section"><a href=3D"=
#counting-commits-on-a-branch">Counting the number of commits on a branch=
</a></span></dt><dt><span class=3D"section"><a href=3D"#checking-for-equa=
l-branches">Check whether two branches point at the same history</a></spa=
n></dt><dt><span class=3D"section"><a href=3D"#finding-tagged-descendants=
">Find first tagged version including a given fix</a></span></dt><dt><spa=
n class=3D"section"><a href=3D"#showing-commits-unique-to-a-branch">Showi=
ng commits unique to a given branch</a></span></dt><dt><span class=3D"sec=
tion"><a href=3D"#making-a-release">Creating a changelog and tarball for =
a software release</a></span></dt><dt><span class=3D"section"><a href=3D"=
#Finding-commits-With-given-Content">Finding commits referencing a file w=
ith given content</a></span></dt></dl></dd></dl></div>
=20
 <p>Git is best thought of as a tool for storing the history of a
 collection of files.  It does this by storing compressed snapshots of
@@ -679,7 +679,7 @@
 </div>
 </div>
 </div>
-<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"Developing-With-git"></a>Chapter=C2=A03.=C2=A0Developing=20
with Git</h1></div></div></div><div class=3D"toc"><p><b>Table of Contents=
</b></p><dl class=3D"toc"><dt><span class=3D"section"><a href=3D"#telling=
-git-your-name">Telling Git your name</a></span></dt><dt><span class=3D"s=
ection"><a href=3D"#creating-a-new-repository">Creating a new repository<=
/a></span></dt><dt><span class=3D"section"><a href=3D"#how-to-make-a-comm=
it">How to make a commit</a></span></dt><dt><span class=3D"section"><a hr=
ef=3D"#creating-good-commit-messages">Creating good commit messages</a></=
span></dt><dt><span class=3D"section"><a href=3D"#ignoring-files">Ignorin=
g files</a></span></dt><dt><span class=3D"section"><a href=3D"#how-to-mer=
ge">How to merge</a></span></dt><dt><span class=3D"section"><a href=3D"#r=
esolving-a-merge">Resolving a merge</a></span></dt><dd><dl><dt><span clas=
s=3D"section"><a href=3D"#conflict-resolution">Getting conflict-resolutio=
n help during a merge</a></span></dt></dl></dd><dt><span class=3D"section=
"><a href=3D"#undoing-a-merge">Undoing a merge</a></span></dt><dt><span c=
lass=3D"section"><a href=3D"#fast-forwards">Fast-forward merges</a></span=
></dt><dt><span class=3D"section"><a href=3D"#fixing-mistakes">Fixing mis=
takes</a></span></dt><dd><dl><dt><span class=3D"section"><a href=3D"#reve=
rting-a-commit">Fixing a mistake with a new commit</a></span></dt><dt><sp=
an class=3D"section"><a href=3D"#fixing-a-mistake-by-rewriting-history">F=
ixing a mistake by rewriting history</a></span></dt><dt><span class=3D"se=
ction"><a href=3D"#checkout-of-path">Checking out an old version of a fil=
e</a></span></dt><dt><span class=3D"section"><a href=3D"#interrupted-work=
">Temporarily setting aside work in progress</a></span></dt></dl></dd><dt=
><span class=3D"section"><a href=3D"#ensuring-good-performance">Ensuring =
good performance</a></span></dt><dt><span class=3D"section"><a href=3D"#e=
nsuring-reliability">Ensuring reliability</a></span></dt><dd><dl><dt><spa=
n class=3D"section"><a href=3D"#checking-for-corruption">Checking the rep=
ository for corruption</a></span></dt><dt><span class=3D"section"><a href=
=3D"#recovering-lost-changes">Recovering lost changes</a></span></dt></dl=
></dd></dl></div>
+<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"Developing-With-git"></a>Chapter=C2=A04.=C2=A0Developing=20
with Git</h1></div></div></div><div class=3D"toc"><p><b>Table of Contents=
</b></p><dl class=3D"toc"><dt><span class=3D"section"><a href=3D"#telling=
-git-your-name">Telling Git your name</a></span></dt><dt><span class=3D"s=
ection"><a href=3D"#creating-a-new-repository">Creating a new repository<=
/a></span></dt><dt><span class=3D"section"><a href=3D"#how-to-make-a-comm=
it">How to make a commit</a></span></dt><dt><span class=3D"section"><a hr=
ef=3D"#creating-good-commit-messages">Creating good commit messages</a></=
span></dt><dt><span class=3D"section"><a href=3D"#ignoring-files">Ignorin=
g files</a></span></dt><dt><span class=3D"section"><a href=3D"#how-to-mer=
ge">How to merge</a></span></dt><dt><span class=3D"section"><a href=3D"#r=
esolving-a-merge">Resolving a merge</a></span></dt><dd><dl><dt><span clas=
s=3D"section"><a href=3D"#conflict-resolution">Getting conflict-resolutio=
n help during a merge</a></span></dt></dl></dd><dt><span class=3D"section=
"><a href=3D"#undoing-a-merge">Undoing a merge</a></span></dt><dt><span c=
lass=3D"section"><a href=3D"#fast-forwards">Fast-forward merges</a></span=
></dt><dt><span class=3D"section"><a href=3D"#fixing-mistakes">Fixing mis=
takes</a></span></dt><dd><dl><dt><span class=3D"section"><a href=3D"#reve=
rting-a-commit">Fixing a mistake with a new commit</a></span></dt><dt><sp=
an class=3D"section"><a href=3D"#fixing-a-mistake-by-rewriting-history">F=
ixing a mistake by rewriting history</a></span></dt><dt><span class=3D"se=
ction"><a href=3D"#checkout-of-path">Checking out an old version of a fil=
e</a></span></dt><dt><span class=3D"section"><a href=3D"#interrupted-work=
">Temporarily setting aside work in progress</a></span></dt></dl></dd><dt=
><span class=3D"section"><a href=3D"#ensuring-good-performance">Ensuring =
good performance</a></span></dt><dt><span class=3D"section"><a href=3D"#e=
nsuring-reliability">Ensuring reliability</a></span></dt><dd><dl><dt><spa=
n class=3D"section"><a href=3D"#checking-for-corruption">Checking the rep=
ository for corruption</a></span></dt><dt><span class=3D"section"><a href=
=3D"#recovering-lost-changes">Recovering lost changes</a></span></dt></dl=
></dd></dl></div>
=20
 <div class=3D"section"><div class=3D"titlepage"><div><div><h2 class=3D"t=
itle" style=3D"clear: both"><a name=3D"telling-git-your-name"></a>Telling=20
Git your name</h2></div></div></div>
=20
@@ -1023,7 +1023,7 @@
 that case.</p>
 <p>It is also possible to replace commits further back in the history, b=
ut
 this is an advanced topic to be left for
-<a class=3D"link" href=3D"#cleaning-up-history" title=3D"Chapter=C2=A05.=
=C2=A0Rewriting history and maintaining patch series">another chapter</a>=
=2E</p>
+<a class=3D"link" href=3D"#cleaning-up-history" title=3D"Chapter=C2=A06.=
=C2=A0Rewriting history and maintaining patch series">another chapter</a>=
=2E</p>
 </div>
 <div class=3D"section"><div class=3D"titlepage"><div><div><h3 class=3D"t=
itle"><a name=3D"checkout-of-path"></a>Checking out an old version of a f=
ile</h3></div></div></div>
=20
@@ -1155,7 +1155,7 @@
 </div>
 </div>
 </div>
-<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"sharing-development"></a>Chapter=C2=A04.=C2=A0Sharing de=
velopment with others</h1></div></div></div><div class=3D"toc"><p><b>Tabl=
e of Contents</b></p><dl class=3D"toc"><dt><span class=3D"section"><a hre=
f=3D"#getting-updates-With-git-pull">Getting updates with git pull</a></s=
pan></dt><dt><span class=3D"section"><a href=3D"#submitting-patches">Subm=
itting patches to a project</a></span></dt><dt><span class=3D"section"><a=20
href=3D"#importing-patches">Importing patches to a project</a></span></dt=
><dt><span class=3D"section"><a href=3D"#public-repositories">Public Git =
repositories</a></span></dt><dd><dl><dt><span class=3D"section"><a href=3D=
"#setting-up-a-public-repository">Setting up a public repository</a></spa=
n></dt><dt><span class=3D"section"><a href=3D"#exporting-via-git">Exporti=
ng a Git repository via the Git protocol</a></span></dt><dt><span class=3D=
"section"><a href=3D"#exporting-via-http">Exporting a git repository via =
HTTP</a></span></dt><dt><span class=3D"section"><a href=3D"#pushing-chang=
es-to-a-public-repository">Pushing changes to a public repository</a></sp=
an></dt><dt><span class=3D"section"><a href=3D"#forcing-push">What to do =
when a push fails</a></span></dt><dt><span class=3D"section"><a href=3D"#=
setting-up-a-shared-repository">Setting up a shared repository</a></span>=
</dt><dt><span class=3D"section"><a href=3D"#setting-up-gitweb">Allowing =
web browsing of a repository</a></span></dt></dl></dd><dt><span class=3D"=
section"><a href=3D"#how-to-get-a-git-repository-with-minimal-history">Ho=
w to get a Git repository with minimal history</a></span></dt><dt><span c=
lass=3D"section"><a href=3D"#sharing-development-examples">Examples</a></=
span></dt><dd><dl><dt><span class=3D"section"><a href=3D"#maintaining-top=
ic-branches">Maintaining topic branches for a Linux subsystem maintainer<=
/a></span></dt></dl></dd></dl></div>
+<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"sharing-development"></a>Chapter=C2=A05.=C2=A0Sharing de=
velopment with others</h1></div></div></div><div class=3D"toc"><p><b>Tabl=
e of Contents</b></p><dl class=3D"toc"><dt><span class=3D"section"><a hre=
f=3D"#getting-updates-With-git-pull">Getting updates with git pull</a></s=
pan></dt><dt><span class=3D"section"><a href=3D"#submitting-patches">Subm=
itting patches to a project</a></span></dt><dt><span class=3D"section"><a=20
href=3D"#importing-patches">Importing patches to a project</a></span></dt=
><dt><span class=3D"section"><a href=3D"#public-repositories">Public Git =
repositories</a></span></dt><dd><dl><dt><span class=3D"section"><a href=3D=
"#setting-up-a-public-repository">Setting up a public repository</a></spa=
n></dt><dt><span class=3D"section"><a href=3D"#exporting-via-git">Exporti=
ng a Git repository via the Git protocol</a></span></dt><dt><span class=3D=
"section"><a href=3D"#exporting-via-http">Exporting a git repository via =
HTTP</a></span></dt><dt><span class=3D"section"><a href=3D"#pushing-chang=
es-to-a-public-repository">Pushing changes to a public repository</a></sp=
an></dt><dt><span class=3D"section"><a href=3D"#forcing-push">What to do =
when a push fails</a></span></dt><dt><span class=3D"section"><a href=3D"#=
setting-up-a-shared-repository">Setting up a shared repository</a></span>=
</dt><dt><span class=3D"section"><a href=3D"#setting-up-gitweb">Allowing =
web browsing of a repository</a></span></dt></dl></dd><dt><span class=3D"=
section"><a href=3D"#how-to-get-a-git-repository-with-minimal-history">Ho=
w to get a Git repository with minimal history</a></span></dt><dt><span c=
lass=3D"section"><a href=3D"#sharing-development-examples">Examples</a></=
span></dt><dd><dl><dt><span class=3D"section"><a href=3D"#maintaining-top=
ic-branches">Maintaining topic branches for a Linux subsystem maintainer<=
/a></span></dt></dl></dd></dl></div>
=20
 <div class=3D"section"><div class=3D"titlepage"><div><div><h2 class=3D"t=
itle" style=3D"clear: both"><a name=3D"getting-updates-With-git-pull"></a=
>Getting updates with git pull</h2></div></div></div>
=20
@@ -1492,7 +1492,7 @@
 and can be updated using <a class=3D"ulink" href=3D"git-fetch.html" targ=
et=3D"_top">git-fetch(1)</a>; you can track other
 public trees using <a class=3D"ulink" href=3D"git-remote.html" target=3D=
"_top">git-remote(1)</a> to set up a "remote" and
 <a class=3D"ulink" href=3D"git-fetch.html" target=3D"_top">git-fetch(1)<=
/a> to keep them up to date; see
-<a class=3D"xref" href=3D"#repositories-and-branches" title=3D"Chapter=C2=
=A01.=C2=A0Repositories and Branches">Chapter=C2=A01, <i>Repositories and=20
Branches</i></a>.</p>
+<a class=3D"xref" href=3D"#repositories-and-branches" title=3D"Chapter=C2=
=A02.=C2=A0Repositories and Branches">Chapter=C2=A02, <i>Repositories and=20
Branches</i></a>.</p>
 <p>Now create the branches in which you are going to work; these start o=
ut
 at the current tip of origin/master branch, and should be set up (using
 the <code class=3D"literal">--track</code> option to <a class=3D"ulink" =
href=3D"git-branch.html" target=3D"_top">git-branch(1)</a>) to merge chan=
ges in from
@@ -1679,7 +1679,7 @@
 </div>
 </div>
 </div>
-<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"cleaning-up-history"></a>Chapter=C2=A05.=C2=A0Rewriting =
history and maintaining patch series</h1></div></div></div><div class=3D"=
toc"><p><b>Table of Contents</b></p><dl class=3D"toc"><dt><span class=3D"=
section"><a href=3D"#patch-series">Creating the perfect patch series</a><=
/span></dt><dt><span class=3D"section"><a href=3D"#using-git-rebase">Keep=
ing a patch series up to date using git rebase</a></span></dt><dt><span c=
lass=3D"section"><a href=3D"#rewriting-one-commit">Rewriting a single com=
mit</a></span></dt><dt><span class=3D"section"><a href=3D"#reordering-pat=
ch-series">Reordering or selecting from a patch series</a></span></dt><dt=
><span class=3D"section"><a href=3D"#interactive-rebase">Using interactiv=
e rebases</a></span></dt><dt><span class=3D"section"><a href=3D"#patch-se=
ries-tools">Other tools</a></span></dt><dt><span class=3D"section"><a hre=
f=3D"#problems-With-rewriting-history">Problems with rewriting history</a=
></span></dt><dt><span class=3D"section"><a href=3D"#bisect-merges">Why b=
isecting merge commits can be harder than bisecting linear history</a></s=
pan></dt></dl></div>
+<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"cleaning-up-history"></a>Chapter=C2=A06.=C2=A0Rewriting =
history and maintaining patch series</h1></div></div></div><div class=3D"=
toc"><p><b>Table of Contents</b></p><dl class=3D"toc"><dt><span class=3D"=
section"><a href=3D"#patch-series">Creating the perfect patch series</a><=
/span></dt><dt><span class=3D"section"><a href=3D"#using-git-rebase">Keep=
ing a patch series up to date using git rebase</a></span></dt><dt><span c=
lass=3D"section"><a href=3D"#rewriting-one-commit">Rewriting a single com=
mit</a></span></dt><dt><span class=3D"section"><a href=3D"#reordering-pat=
ch-series">Reordering or selecting from a patch series</a></span></dt><dt=
><span class=3D"section"><a href=3D"#interactive-rebase">Using interactiv=
e rebases</a></span></dt><dt><span class=3D"section"><a href=3D"#patch-se=
ries-tools">Other tools</a></span></dt><dt><span class=3D"section"><a hre=
f=3D"#problems-With-rewriting-history">Problems with rewriting history</a=
></span></dt><dt><span class=3D"section"><a href=3D"#bisect-merges">Why b=
isecting merge commits can be harder than bisecting linear history</a></s=
pan></dt></dl></div>
=20
 <p>Normally commits are only added to a project, never taken away or
 replaced.  Git is designed with this assumption, and violating it will
@@ -1923,7 +1923,7 @@
 publishing.</p>
 </div>
 </div>
-<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"advanced-branch-management"></a>Chapter=C2=A06.=C2=A0Adv=
anced branch management</h1></div></div></div><div class=3D"toc"><p><b>Ta=
ble of Contents</b></p><dl class=3D"toc"><dt><span class=3D"section"><a h=
ref=3D"#fetching-individual-branches">Fetching individual branches</a></s=
pan></dt><dt><span class=3D"section"><a href=3D"#fetch-fast-forwards">git=20
fetch and fast-forwards</a></span></dt><dt><span class=3D"section"><a hre=
f=3D"#forcing-fetch">Forcing git fetch to do non-fast-forward updates</a>=
</span></dt><dt><span class=3D"section"><a href=3D"#remote-branch-configu=
ration">Configuring remote-tracking branches</a></span></dt></dl></div>
+<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"advanced-branch-management"></a>Chapter=C2=A07.=C2=A0Adv=
anced branch management</h1></div></div></div><div class=3D"toc"><p><b>Ta=
ble of Contents</b></p><dl class=3D"toc"><dt><span class=3D"section"><a h=
ref=3D"#fetching-individual-branches">Fetching individual branches</a></s=
pan></dt><dt><span class=3D"section"><a href=3D"#fetch-fast-forwards">git=20
fetch and fast-forwards</a></span></dt><dt><span class=3D"section"><a hre=
f=3D"#forcing-fetch">Forcing git fetch to do non-fast-forward updates</a>=
</span></dt><dt><span class=3D"section"><a href=3D"#remote-branch-configu=
ration">Configuring remote-tracking branches</a></span></dt></dl></div>
=20
 <div class=3D"section"><div class=3D"titlepage"><div><div><h2 class=3D"t=
itle" style=3D"clear: both"><a name=3D"fetching-individual-branches"></a>=
Fetching individual branches</h2></div></div></div>
=20
@@ -2012,7 +2012,7 @@
 the refspec syntax.</p>
 </div>
 </div>
-<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"git-concepts"></a>Chapter=C2=A07.=C2=A0Git concepts</h1>=
</div></div></div><div class=3D"toc"><p><b>Table of Contents</b></p><dl c=
lass=3D"toc"><dt><span class=3D"section"><a href=3D"#the-object-database"=
>The Object Database</a></span></dt><dd><dl><dt><span class=3D"section"><=
a href=3D"#commit-object">Commit Object</a></span></dt><dt><span class=3D=
"section"><a href=3D"#tree-object">Tree Object</a></span></dt><dt><span c=
lass=3D"section"><a href=3D"#blob-object">Blob Object</a></span></dt><dt>=
<span class=3D"section"><a href=3D"#trust">Trust</a></span></dt><dt><span=20
class=3D"section"><a href=3D"#tag-object">Tag Object</a></span></dt><dt><=
span class=3D"section"><a href=3D"#pack-files">How Git stores objects eff=
iciently: pack files</a></span></dt><dt><span class=3D"section"><a href=3D=
"#dangling-objects">Dangling objects</a></span></dt><dt><span class=3D"se=
ction"><a href=3D"#recovering-from-repository-corruption">Recovering from=20
repository corruption</a></span></dt></dl></dd><dt><span class=3D"section=
"><a href=3D"#the-index">The index</a></span></dt></dl></div>
+<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"git-concepts"></a>Chapter=C2=A08.=C2=A0Git concepts</h1>=
</div></div></div><div class=3D"toc"><p><b>Table of Contents</b></p><dl c=
lass=3D"toc"><dt><span class=3D"section"><a href=3D"#the-object-database"=
>The Object Database</a></span></dt><dd><dl><dt><span class=3D"section"><=
a href=3D"#commit-object">Commit Object</a></span></dt><dt><span class=3D=
"section"><a href=3D"#tree-object">Tree Object</a></span></dt><dt><span c=
lass=3D"section"><a href=3D"#blob-object">Blob Object</a></span></dt><dt>=
<span class=3D"section"><a href=3D"#trust">Trust</a></span></dt><dt><span=20
class=3D"section"><a href=3D"#tag-object">Tag Object</a></span></dt><dt><=
span class=3D"section"><a href=3D"#pack-files">How Git stores objects eff=
iciently: pack files</a></span></dt><dt><span class=3D"section"><a href=3D=
"#dangling-objects">Dangling objects</a></span></dt><dt><span class=3D"se=
ction"><a href=3D"#recovering-from-repository-corruption">Recovering from=20
repository corruption</a></span></dt></dl></dd><dt><span class=3D"section=
"><a href=3D"#the-index">The index</a></span></dt></dl></div>
=20
 <p>Git is built on a small number of simple but powerful ideas.  While i=
t
 is possible to get things done without understanding them, you will find=

@@ -2141,7 +2141,7 @@
 between two related tree objects, since it can ignore any entries with
 identical object names.</p>
 <p>(Note: in the presence of submodules, trees may also have commits as
-entries.  See <a class=3D"xref" href=3D"#submodules" title=3D"Chapter=C2=
=A08.=C2=A0Submodules">Chapter=C2=A08, <i>Submodules</i></a> for document=
ation.)</p>
+entries.  See <a class=3D"xref" href=3D"#submodules" title=3D"Chapter=C2=
=A09.=C2=A0Submodules">Chapter=C2=A09, <i>Submodules</i></a> for document=
ation.)</p>
 <p>Note that the files all have mode 644 or 755: Git actually only pays
 attention to the executable bit.</p>
 </div>
@@ -2258,7 +2258,7 @@
 objects.  They are not a problem.</p>
 <p>The most common cause of dangling objects is that you=E2=80=99ve reba=
sed a
 branch, or you have pulled from somebody else who rebased a branch=E2=80=
=94=E2=80=8Bsee
-<a class=3D"xref" href=3D"#cleaning-up-history" title=3D"Chapter=C2=A05.=
=C2=A0Rewriting history and maintaining patch series">Chapter=C2=A05, <i>=
Rewriting history and maintaining patch series</i></a>.  In that case, th=
e old head of the original
+<a class=3D"xref" href=3D"#cleaning-up-history" title=3D"Chapter=C2=A06.=
=C2=A0Rewriting history and maintaining patch series">Chapter=C2=A06, <i>=
Rewriting history and maintaining patch series</i></a>.  In that case, th=
e old head of the original
 branch still exists, as does everything it pointed to. The branch
 pointer itself just doesn=E2=80=99t, since you replaced it with another =
one.</p>
 <p>There are also other situations that cause dangling objects. For
@@ -2437,7 +2437,7 @@
 information as long as you have the name of the tree that it described.<=
/p>
 </div>
 </div>
-<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"submodules"></a>Chapter=C2=A08.=C2=A0Submodules</h1></di=
v></div></div><div class=3D"toc"><p><b>Table of Contents</b></p><dl class=
=3D"toc"><dt><span class=3D"section"><a href=3D"#pitfalls-with-submodules=
">Pitfalls with submodules</a></span></dt></dl></div>
+<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"submodules"></a>Chapter=C2=A09.=C2=A0Submodules</h1></di=
v></div></div><div class=3D"toc"><p><b>Table of Contents</b></p><dl class=
=3D"toc"><dt><span class=3D"section"><a href=3D"#pitfalls-with-submodules=
">Pitfalls with submodules</a></span></dt></dl></div>
=20
 <p>Large projects are often composed of smaller, self-contained modules.=20
 For
 example, an embedded Linux distribution=E2=80=99s source tree would incl=
ude every
@@ -2629,7 +2629,7 @@
 warning about not being able switch from a dirty branch.</p>
 </div>
 </div>
-<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"low-level-operations"></a>Chapter=C2=A09.=C2=A0Low-level=20
Git operations</h1></div></div></div><div class=3D"toc"><p><b>Table of Co=
ntents</b></p><dl class=3D"toc"><dt><span class=3D"section"><a href=3D"#o=
bject-manipulation">Object access and manipulation</a></span></dt><dt><sp=
an class=3D"section"><a href=3D"#the-workflow">The Workflow</a></span></d=
t><dd><dl><dt><span class=3D"section"><a href=3D"#working-directory-to-in=
dex">working directory =E2=86=92 index</a></span></dt><dt><span class=3D"=
section"><a href=3D"#index-to-object-database">index =E2=86=92 object dat=
abase</a></span></dt><dt><span class=3D"section"><a href=3D"#object-datab=
ase-to-index">object database =E2=86=92 index</a></span></dt><dt><span cl=
ass=3D"section"><a href=3D"#index-to-working-directory">index =E2=86=92 w=
orking directory</a></span></dt><dt><span class=3D"section"><a href=3D"#t=
ying-it-all-together">Tying it all together</a></span></dt></dl></dd><dt>=
<span class=3D"section"><a href=3D"#examining-the-data">Examining the dat=
a</a></span></dt><dt><span class=3D"section"><a href=3D"#merging-multiple=
-trees">Merging multiple trees</a></span></dt><dt><span class=3D"section"=
><a href=3D"#merging-multiple-trees-2">Merging multiple trees, continued<=
/a></span></dt></dl></div>
+<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"low-level-operations"></a>Chapter=C2=A010.=C2=A0Low-leve=
l Git operations</h1></div></div></div><div class=3D"toc"><p><b>Table of =
Contents</b></p><dl class=3D"toc"><dt><span class=3D"section"><a href=3D"=
#object-manipulation">Object access and manipulation</a></span></dt><dt><=
span class=3D"section"><a href=3D"#the-workflow">The Workflow</a></span><=
/dt><dd><dl><dt><span class=3D"section"><a href=3D"#working-directory-to-=
index">working directory =E2=86=92 index</a></span></dt><dt><span class=3D=
"section"><a href=3D"#index-to-object-database">index =E2=86=92 object da=
tabase</a></span></dt><dt><span class=3D"section"><a href=3D"#object-data=
base-to-index">object database =E2=86=92 index</a></span></dt><dt><span c=
lass=3D"section"><a href=3D"#index-to-working-directory">index =E2=86=92 =
working directory</a></span></dt><dt><span class=3D"section"><a href=3D"#=
tying-it-all-together">Tying it all together</a></span></dt></dl></dd><dt=
><span class=3D"section"><a href=3D"#examining-the-data">Examining the da=
ta</a></span></dt><dt><span class=3D"section"><a href=3D"#merging-multipl=
e-trees">Merging multiple trees</a></span></dt><dt><span class=3D"section=
"><a href=3D"#merging-multiple-trees-2">Merging multiple trees, continued=
</a></span></dt></dl></div>
=20
 <p>Many of the higher-level commands were originally implemented as shel=
l
 scripts using a smaller core of low-level Git commands.  These can still=

@@ -2891,7 +2891,7 @@
 <p>and that is what higher level <code class=3D"literal">git merge -s re=
solve</code> is implemented with.</p>
 </div>
 </div>
-<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"hacking-git"></a>Chapter=C2=A010.=C2=A0Hacking Git</h1><=
/div></div></div><div class=3D"toc"><p><b>Table of Contents</b></p><dl cl=
ass=3D"toc"><dt><span class=3D"section"><a href=3D"#object-details">Objec=
t storage format</a></span></dt><dt><span class=3D"section"><a href=3D"#b=
irdview-on-the-source-code">A birds-eye view of Git=E2=80=99s source code=
</a></span></dt></dl></div>
+<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"hacking-git"></a>Chapter=C2=A011.=C2=A0Hacking Git</h1><=
/div></div></div><div class=3D"toc"><p><b>Table of Contents</b></p><dl cl=
ass=3D"toc"><dt><span class=3D"section"><a href=3D"#object-details">Objec=
t storage format</a></span></dt><dt><span class=3D"section"><a href=3D"#b=
irdview-on-the-source-code">A birds-eye view of Git=E2=80=99s source code=
</a></span></dt></dl></div>
=20
 <p>This chapter covers internal details of the Git implementation which
 probably only Git developers need to understand.</p>
@@ -3072,7 +3072,7 @@
 itself!</p>
 </div>
 </div>
-<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"glossary"></a>Chapter=C2=A011.=C2=A0Git Glossary</h1></d=
iv></div></div><div class=3D"toc"><p><b>Table of Contents</b></p><dl clas=
s=3D"toc"><dt><span class=3D"section"><a href=3D"#git-explained">Git expl=
ained</a></span></dt></dl></div>
+<div class=3D"chapter"><div class=3D"titlepage"><div><div><h1 class=3D"t=
itle"><a name=3D"glossary"></a>Chapter=C2=A012.=C2=A0Git Glossary</h1></d=
iv></div></div><div class=3D"toc"><p><b>Table of Contents</b></p><dl clas=
s=3D"toc"><dt><span class=3D"section"><a href=3D"#git-explained">Git expl=
ained</a></span></dt></dl></div>
=20
 <div class=3D"section"><div class=3D"titlepage"><div><div><h2 class=3D"t=
itle" style=3D"clear: both"><a name=3D"git-explained"></a>Git explained</=
h2></div></div></div>
=20

--------------12A88B567543E19DC53F339E--
