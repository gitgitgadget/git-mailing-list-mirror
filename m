Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B0DC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiGMNAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiGMNAM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:00:12 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86634B6A
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:00:10 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n185so6460873wmn.4
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t59yX4Jn7d3+rWQzjPaPvBAnkhMSq2FfYDhm6TkZISk=;
        b=MfWigL1f3FFUcEyq6w5QcRMWZtg7sPoSJ0+nCV0uaoTBeibH0gs/X7xAjbtfJa1pyN
         4nYO5dblXT7cHk8rEqx5WfMuokT0lHvuHT9wWzzdBRUPpnNZ0W1yQcph3PMRa22rJM6i
         9bTmEl+k8tdnhYMtB/Dw5aSuzmCs9Y8kyUpyWMbTV4LIhHhohrJLNyphOUyojZLrqRIn
         yLr2arK+K5u9lU8VyaVH3/QAegy99V8UDlIBHwPjVawJj/lj5eoORyIgmW5fk99t1oh7
         hJ5453F8ZXQ2Qe12isuHEWL8i4hr0d7RIg091qay38Kf7+xPhUV+r3jbBDJuSG4npWWb
         rCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t59yX4Jn7d3+rWQzjPaPvBAnkhMSq2FfYDhm6TkZISk=;
        b=13Wcs/SWdeuWGA6HZGByktr1U52y1vvTAeGrn+6VtsL4+JkXVuzj1jlk4H8yZ0p3ZU
         hAeat51IY2Fxo8HMuxK9hWmq/RvUptcrpbA46opXDmVWMxuQ0K+impCL6+c8vb3uu6Pr
         mqLZMrwlKwMW/J2Bz+vK7OJO6ixrhAXi5Pute4ECWCyFpaaj1uzXMjJyVpCo0klZhkAf
         396r6lnWjTUBhmt79qM9znF5EkcO/NtnzguylQfk3HNe6af4Kr9UGsTznVxy5lWkHs0k
         /AFT4NK66sIuA0bQ+wTsXkEgZWUdAUeOoYQgiGnu6q5ThuMxQGazagbTFzkNMk1jQXq+
         cimw==
X-Gm-Message-State: AJIora8Ni3tuBkKynh99apGW45LJyOcATNISgnb/0SGf7SKFbUhnx1Ry
        3Enf8lhspAq2ZacuIQqcC6k=
X-Google-Smtp-Source: AGRyM1upZPTs8fE73DA09g3164nEnJ42lXCOEkFSYIelKCL/zfS3K0FqZZVTz48nd/YU9KQ+6anj7g==
X-Received: by 2002:a05:600c:a41:b0:39c:1512:98bd with SMTP id c1-20020a05600c0a4100b0039c151298bdmr9810176wmq.88.1657717208803;
        Wed, 13 Jul 2022 06:00:08 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id r1-20020a5d6941000000b00210bac248c8sm11112641wrw.11.2022.07.13.06.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 06:00:08 -0700 (PDT)
Message-ID: <bbfa1340-9cab-35d7-2245-f6f8369d5cd4@gmail.com>
Date:   Wed, 13 Jul 2022 14:00:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 7/7] xdiff: remove xdl_free(), use free() instead
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com>
 <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
 <patch-7.7-a1bf9a94f0a-20220708T140354Z-avarab@gmail.com>
 <6b8fc0e8-c446-1275-12f3-e6520de9584d@gmail.com>
 <220708.86czef9t6y.gmgdl@evledraar.gmail.com>
 <dcde61a3-4d96-6cd5-f05e-45781599f8bd@gmail.com>
 <220711.865yk47x54.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220711.865yk47x54.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/07/2022 11:02, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Jul 11 2022, Phillip Wood wrote:
> 
>> Hi Ævar
>>
>> On 08/07/2022 22:26, Ævar Arnfjörð Bjarmason wrote:
>>> On Fri, Jul 08 2022, Phillip Wood wrote:
>>>
>>>> Hi Ævar
>>>>
>>>> On 08/07/2022 15:20, Ævar Arnfjörð Bjarmason wrote:
>>>>> Remove the xdl_free() wrapper macro in favor of using free()
>>>>> directly. The wrapper macro was brought in with the initial import of
>>>>> xdiff/ in 3443546f6ef (Use a *real* built-in diff generator,
>>>>> 2006-03-24).
>>>>> As subsequent discussions on the topic[1] have made clear there's no
>>>>> reason to use this wrapper.
>>>>
>>>> That link is to a message where you assert that there is no reason for
>>>> the wrapper, you seem to be the only person in that thread making that
>>>> argument. The libgit2 maintainer and others are arguing that it is
>>>> worth keeping to make it easy to swap the allocator.
>>> Arguing that it's not needed for a technical reason, but an
>>> "aesthetic
>>> and ergonomic one", per:
>>> https://lore.kernel.org/git/20220217225804.GC7@edef91d97c94/;
>>> Perhaps I misread it, but I took this as Junio concurring with what
>>> I
>>> was pointing out there:
>>> https://lore.kernel.org/git/xmqqfsohbdre.fsf@gitster.g/
>>>
>>>>> Both git itself as well as any external
>>>>> users such as libgit2 compile the xdiff/* code as part of their own
>>>>> compilation, and can thus find the right malloc() and free() at
>>>>> link-time.
>>>>
>>>> I'm struggling to see how that is simpler than the current situation
>>>> with xdl_malloc().
>>> It's simpler because when maintaining that code in git.git it's less
>>> of
>>> a special case, e.g. we have coccinelle rules that match free(), now
>>> every such rule needs to account for the xdiff special-case.
>>> And it's less buggy because if you're relying on us always using a
>>> wrapper bugs will creep in, current master has this:
>>> 	
>>> 	$ git -P grep '\bfree\(' -- xdiff
>>> 	xdiff/xdiff.h:#define xdl_free(ptr) free(ptr)
>>> 	xdiff/xmerge.c:         free(c);
>>> 	xdiff/xmerge.c: free(next_m);
>>>
>>>> Perhaps you could show how you think libgit2 could
>>>> easily make xdiff use git__malloc() instead of malloc() without
>>>> changing the malloc() calls (the message you linked to essentially
>>>> suggests they do a search and replace). If people cannot swap in
>>>> another allocator without changing the code then you are imposing a
>>>> barrier to them contributing patches back to git's xdiff.
>>> I was suggesting that if libgit2 wanted to maintain a copy of xdiff
>>> that
>>> catered to the asthetic desires of the maintainer adjusting whatever
>>> import script you use to apply a trivial coccinelle transformation would
>>> give you what you wanted. Except without a maintenance burden on
>>> git.git, or the bugs you'd get now since you're not catching those two
>>> free() cases (or any future such cases).
>>> But just having the code use malloc() and free() directly and
>>> getting
>>> you what you get now is easy, and doesn't require any such
>>> search-replacement.
>>> Here's how:
>>> I imported the xdiff/*.[ch] files at the tip of my branch into
>>> current
>>> libgit2.git's src/libgit2/xdiff/, and then applied this on top, which is
>>> partially re-applying libgit2's own monkeypatches, and partially
>>> adjusting for upstream changes (including this one):
>>> 	
>>> 	diff --git a/src/libgit2/xdiff/git-xdiff.h b/src/libgit2/xdiff/git-xdiff.h
>>> 	index b75dba819..2e00764d4 100644
>>> 	--- a/src/libgit2/xdiff/git-xdiff.h
>>> 	+++ b/src/libgit2/xdiff/git-xdiff.h
>>> 	@@ -14,6 +14,7 @@
>>> 	 #ifndef INCLUDE_git_xdiff_h__
>>> 	 #define INCLUDE_git_xdiff_h__
>>> 	
>>> 	+#include <regex.h>
>>> 	 #include "regexp.h"
>>> 	
>>> 	 /* Work around C90-conformance issues */
>>> 	@@ -27,11 +28,10 @@
>>> 	 # endif
>>> 	 #endif
>>> 	
>>> 	-#define xdl_malloc(x) git__malloc(x)
>>> 	-#define xdl_free(ptr) git__free(ptr)
>>> 	-#define xdl_realloc(ptr, x) git__realloc(ptr, x)
>>> 	+#define malloc(x) git__malloc(x)
>>> 	+#define free(ptr) git__free(ptr)
>>> 	
>>> 	-#define XDL_BUG(msg) GIT_ASSERT(msg)
>>> 	+#define BUG(msg) GIT_ASSERT(msg)
>>> 	
>>> 	 #define xdl_regex_t git_regexp
>>> 	 #define xdl_regmatch_t git_regmatch
>>> 	@@ -50,4 +50,17 @@ GIT_INLINE(int) xdl_regexec_buf(
>>> 	 	return -1;
>>> 	 }
>>> 	
>>> 	+static inline size_t st_mult(size_t a, size_t b)
>>> 	+{
>>> 	+	return a * b;
>>> 	+}
>>> 	+
>>> 	+static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
>>> 	+			      size_t nmatch, regmatch_t pmatch[], int eflags)
>>> 	+{
>>> 	+	assert(nmatch > 0 && pmatch);
>>> 	+	pmatch[0].rm_so = 0;
>>> 	+	pmatch[0].rm_eo = size;
>>> 	+	return regexec(preg, buf, nmatch, pmatch, eflags | REG_STARTEND);
>>> 	+}
>>> 	 #endif
>>> 	diff --git a/src/libgit2/xdiff/xdiff.h b/src/libgit2/xdiff/xdiff.h
>>> 	index a37d89fcd..5e5b525c2 100644
>>> 	--- a/src/libgit2/xdiff/xdiff.h
>>> 	+++ b/src/libgit2/xdiff/xdiff.h
>>> 	@@ -23,6 +23,8 @@
>>> 	 #if !defined(XDIFF_H)
>>> 	 #define XDIFF_H
>>> 	
>>> 	+#include "git-xdiff.h"
>>> 	+
>>> 	 #ifdef __cplusplus
>>> 	 extern "C" {
>>> 	 #endif /* #ifdef __cplusplus */
>>> 	diff --git a/src/libgit2/xdiff/xinclude.h b/src/libgit2/xdiff/xinclude.h
>>> 	index a4285ac0e..79812ad8a 100644
>>> 	--- a/src/libgit2/xdiff/xinclude.h
>>> 	+++ b/src/libgit2/xdiff/xinclude.h
>>> 	@@ -23,7 +23,8 @@
>>> 	 #if !defined(XINCLUDE_H)
>>> 	 #define XINCLUDE_H
>>> 	
>>> 	-#include "git-compat-util.h"
>>> 	+#include "git-xdiff.h"
>>> 	+#include "git-shared-util.h"
>>> 	 #include "xmacros.h"
>>> 	 #include "xdiff.h"
>>> 	 #include "xtypes.h"
>>> If you then build it and run e.g.:
>>> 	gdb -args ./libgit2_tests -smerge::files
>>> You'll get stack traces like this if you break on stdalloc__malloc
>>> (which it uses for me in its default configuration):
>>> 	
>>> 	(gdb) bt
>>> 	#0  stdalloc__malloc (len=144, file=0x87478d "/home/avar/g/libgit2/src/libgit2/xdiff/xutils.c", line=101) at /home/avar/g/libgit2/src/util/allocators/stdalloc.c:14
>>> 	#1  0x00000000006ec15c in xdl_cha_alloc (cha=0x7fffffffcaa8) at /home/avar/g/libgit2/src/libgit2/xdiff/xutils.c:101
>>> 	#2  0x00000000006eaee9 in xdl_prepare_ctx (pass=1, mf=0x7fffffffcc98, narec=13, xpp=0x7fffffffcca8, cf=0x7fffffffc7d0, xdf=0x7fffffffcaa8)
>>> 	    at /home/avar/g/libgit2/src/libgit2/xdiff/xprepare.c:194
>>> IOW this was all seamlessly routed to your git__malloc() without us
>>> having to maintain an xdl_{malloc,free}().
>>
>> Thanks for showing this, it is really helpful to see a concrete
>> example. I was especially interested to see how you went about the
>> conversion without redefining standard library functions or
>> introducing non-namespaced identifiers in files that included
>> xdiff.h. Unfortunately you have not done that and so I don't think the
>> approach above is viable   for a well behaved library.
> 
> Why? Because there's some header where doing e.g.:
> 
> 	#include "git2/something.h"
> 
> Will directly include git-xdiff.h by proxy into the user's program?

No because you're redefining malloc() and introducing ALLOC_GROW() etc 
in 
src/libgit2/{Blame_git.c,Diff_xdiff.c,Merge_file.c,Patch_generate.c,Checkout.c} 
and
Test/libgit2/merge/files.c. It is not expected that including xdiff.h 
will change a bunch of symbols in the file it is included in.

Best Wishes

Phillip

> 
> I admit I didn't check that, and assumed that these were only included
> by other *.c files in libgit2 itself. I.e. it would compile xdiff for
> its own use, but then expose its own API.
> 
> Anyway, if it is directly included in some user-exposed *.h file then
> yes, you don't want to overwrite their "malloc", but that's a small
> matter of doing an "#undef malloc" at the end (which as the below
> linked-to patch shows we'd support by having macros like
> SHA1DC_CUSTOM_TRAILING_INCLUDE_UBC_CHECK_C).
> 
> Aside from what I'm proposing here doing such "undef at the end" seems
> like a good idea in any case, because if there is any macro leakage here
> you're e.g. re-defining "XDL_BUG" and other things that aren't clearly
> in the libgit2 namespace now, no?
> 
>>> Now, I think that's obviously worth adjusting, e.g. the series I've got
>>> here could make this easier for libgit2 by including st_mult() at least,
>>> I'm not sure what you want to do about regexec_buf().
>>> For the monkeypatching you do now of creating a "git-xdiff.h" I
>>> think it
>>> would be very good to get a patch like what I managed to get
>>> sha1collisiondetection.git to accept for our own use-case, which allows
>>> us to use their upstream code as-is from a submodule:
>>> 	https://github.com/cr-marcstevens/sha1collisiondetection/commit/b45fcef
>>
>> Thanks for the link, That's a really good example where all the
>> identifiers are namespaced and the public include file does not
>> pollute the code that is including it. If you come up with something
>> like that where the client code can set up same #defines for malloc,
>> calloc, realloc and free that would be a good way forward.
> 
> I don't need to come up with that, you've got the linker to do that.
> 
> I.e. for almost any "normal" use of xdiff you'd simply compile it with
> its reference to malloc(), and then you either link that library that
> already links to libc into your program.
> 
> So if you use a custom malloc the xdiff code might still use libc
> malloc, or you'd link the two together and link the resulting program
> with your own custom malloc.
> 
> As explained in the previous & linked-to threads this is how almost
> everyone would include & use such a library, and indeed that's how git
> itself can use malloc() and free() in its sources, but have options to
> link to libc malloc, nedmalloc etc.
> 
> But instead of using the linker to resolve "malloc" to git__malloc you'd
> like to effectively include the upstream *.[ch] files directly, and
> pretend as though the upstream source used git__malloc() or whatever to
> begin with.
> 
> I don't really understand why you can't just do that at the linker
> level, especially as doing so guards you better against namespace
> pollution. But whatever, the suggestion(s) above assume you've got a
> good reason, but show that we don't need to prefix every standard
> function just to accommodate that.
> 
> Instead we can just provide a knob to include a header of yours after
> all others have been included (which the libgit2 monkeypatches to xdiff
> already include), and have that header define "malloc" as "git__malloc",
> "BUG" as "GIT_ASSERT" etc.
> 
> And yes, if you're in turn providing an interface where others will then
> include your header that's doing that you'll need to apply some
> namespacing paranoia, namely to "#undef malloc" etc.
> 
> But none of that requires git to carry prefixed versions of standard
> functions you'd wish to replace, which the patches here show.
> 
>> I do not think we should require projects to be defining there own
>> versions of [C]ALLOC_*() and BUG() just to use xdiff.
> 
> No, I don't think so either. I.e. the idea with these patches is that we
> could bundle up xdiff/* and git-shared-util.h into one distributed
> libgit, which down the road we could even roll independent releases for
> (as upstream seems to have forever gone away).
> 
> Whereas the proposals coming out of libgit2[1] for generalizing xdiff/
> for general use seem to stop just short of the specific hacks we need to
> get it running for libgit2, but e.g. leave "xdl_malloc" defined as
> "xmalloc".
> 
> That isn't a standard library function, and therefore the first thing
> you'd need to do when using it as a library is to find out how git.git
> uses that, and copy/paste it or define your own replacement.
> 
> Whereas I think it should be the other way around, we should e.g. ship a
> shimmy BUG() that calls fprintf(stderr, ...) and abort(), but for
> advanced users such as libgit2 guard those with "ifndef" or whatever, so
> you can have it call GIT_ASSERT() and the like instead.
> 
> 1. https://lore.kernel.org/git/20220209013354.GB7@abe733c6e288/

