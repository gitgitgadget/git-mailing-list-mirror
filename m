Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B7DFA373E
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 15:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJUPsV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 11:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiJUPsD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 11:48:03 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E32D26C443
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:47:28 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id l22so7401742edj.5
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=umF4L1APDLnSM6qw4/x1bZqT9VzqCB0DwWt7lDMpYIE=;
        b=iV8nRMIG+55GqPWrd7HpgqYb8w/bh098s96KLV+RYnwqxOSHKjJNY6ZJLZqlbh9hZO
         o0myj4jQ0yRAp1gGr+jcNHb/cUad2iiYvtM7YabixdJsJheoXqolqEvDV7ilmksWoMVA
         fAnO/Jou72I2C9EYelgXomNdIevbIt02fYPO5MliqJMEnrXNsefMMeLSabgJdU/VPnHZ
         UkzO1Kx0UpTtmdHbASjDZcYJGXwxMMORNPUa39GzfcmPGQHULfRJVCUP011VygKotlBm
         t88SZNdIVtMq1ILtdNaEjweNrVig+zHHMKEs3VonWIkrPozK5kuRHg++N5UB/wcPaMqO
         iM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=umF4L1APDLnSM6qw4/x1bZqT9VzqCB0DwWt7lDMpYIE=;
        b=pAJMq/vTyaD7l2pBnwmAQxvU2VjAUJISuil7yI9jctKZ1g80IzQcNsb8vXPUTKHajh
         PyhlTY11xE1mb4Ywx5l3u6V52s8Z6oBT/cL7sFCqmn5CoFgvTITMIP2yEa6XXf4vvtp6
         /MZEf7Ts6tbGepg+vGIBozwjoAbxaY8TN8JgvdNdHJz802Hc5DPi7SLvxCZJKC/vxR4O
         oTBe+Qy9sP/5gI7g+px0iHnunWWRU//J21x6sBRvOWM/hhC2ufI7zulalGEcO79MH/9g
         IKU+26oGLo9fWlp7xx5FWu+QmmUpIueiTfPRnX6oQ3wpWzvsGXxB3kjsUJ7Cml9/jPjX
         QECA==
X-Gm-Message-State: ACrzQf2BZSArbuELAhg2uYPSEFGm1d+8h9tes9wZiOovQpiGLgpO02hv
        8YTtYrBTJhR0VRKqXYs8Gns=
X-Google-Smtp-Source: AMsMyM7ak4DBo/gafJ8KXxKLmS7CjCR5B2A9rvw95A+vmil3haRIiEhoGkSusFKeSHnKk+eIAxVh7A==
X-Received: by 2002:a17:907:1b1e:b0:783:8e33:2d1c with SMTP id mp30-20020a1709071b1e00b007838e332d1cmr15923196ejc.304.1666367107588;
        Fri, 21 Oct 2022 08:45:07 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id e11-20020a056402104b00b00459f4974128sm13856134edu.50.2022.10.21.08.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 08:45:06 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oluCn-00742x-2b;
        Fri, 21 Oct 2022 17:45:05 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH 6/9] cmake: use GIT_TEST_BUILD_DIR instead of editing hack
Date:   Fri, 21 Oct 2022 16:43:18 +0200
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
 <patch-6.9-45f1a4e6f93-20221021T091013Z-avarab@gmail.com>
 <d6e2baab-be26-66d1-f07c-134eb6fe06fd@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <d6e2baab-be26-66d1-f07c-134eb6fe06fd@dunelm.org.uk>
Message-ID: <221021.868rl9faf2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 21 2022, Phillip Wood wrote:

> On 21/10/2022 10:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> When cmake builds git in "contrib/buildsystems/out" it will create a
>> "t/" directory there containing only the "t/helper/test-tool", but for
>> running the tests with "cmake" it cd's to the "real" t/ directory, and
>> runs the tests from there.
>> To get the test-lib.sh to locate "git" and other binaries in
>> "../contrib/buildsystems/out/" rather than "../" we have since [1]
>> been editing the "GIT_BUILD_DIR" assignment in test-lib.sh in-place.
>> This has meant that when testing cmake we've had to "git reset
>> --hard"
>> before running "make" again.
>> What this build infrastructure really wanted was some feature like
>> the
>> "GIT_TEST_BUILD_DIR" variable added in the preceding commit, so let's
>> make use of it.
>
> Lets squash that commit into this one, so we can see how it is used
> when it is added.

Heh, I did that to begin with, but found that the commit message &
change was too long & trying to explain two different things.

Since GIT_TEST_BUILD_DIR (like GIT_TEST_INSTALLED) is something you can
use stand-alone I prefer to keep it this way. The commit message shows
how you can use it without anything to do with cmake, and then later
(here) we can use it for cmake...

>> Even though "ctest" will work with this approach, one advantage of the
>> previous arrangement was that we could:
>> 	A. Build with cmake
>> 	B. cd t
>> 	C. Run a test
>> And have the test itself know to locate and use the cmake binaries,
>> this workflow was documented in [2]. The "t/test-lib".sh modification
>> here is so that we can support this use-case.
>> As [3] notes "contrib/buildsystems/out" isn't just the directory
>> that
>> happens to be documented in "contrib/buildsystems/CMakeLists.txt", but
>> the one that VS will use when building git.
>
> That may be the directory that VS uses when building git, but it is
> possible to specify a different build directory when running cmake.

Possible, but important enough to care? It's what it does by default,
and we have /contrib/buildsystems/out in the top-level .gitignore.

I could bring it back, basically the GIT-BUILD-DIR again, but is the
edge case worth worrying about? This DWIM behavior of "build with cmake,
cd and run the the test" is something I think we can safely assume is OK
to restrict to the defaults.

Once you're off the defaults and e.g. want a dir in /run/user or
whatever it's also easy to set GIT_TEST_BUILD_DIR to that. The
"contrib/buildsystem/out" assumption is just so it works by default
without tweaking.

>>   	file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PATH=3D\"$PATH:$TE=
ST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
>>   endif()
>>   -#Make the tests work when building out of the source tree
>> -get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMake=
Cache.txt ABSOLUTE)
>> -if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
>> -	file(RELATIVE_PATH BUILD_DIR_RELATIVE ${CMAKE_SOURCE_DIR} ${CMAKE_BINA=
RY_DIR}/CMakeCache.txt)
>> -	string(REPLACE "/CMakeCache.txt" "" BUILD_DIR_RELATIVE ${BUILD_DIR_REL=
ATIVE})
>> -	#Setting the build directory in test-lib.sh before running tests
>> -	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
>> -		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh GIT_BUILD_DIR_REPL RE=
GEX \"GIT_BUILD_DIR=3D(.*)\")\n"
>> -		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh content NEWLINE_CONSU=
ME)\n"
>> -		"string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=3D\\\"$TES=
T_DIRECTORY/../${BUILD_DIR_RELATIVE}\\\"\" content \"\${content}\")\n"
>> -		"file(WRITE ${CMAKE_SOURCE_DIR}/t/test-lib.sh \${content})")
>> -endif()
>> -
>>   file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
>>     #test
>>   foreach(tsh ${test_scipts})
>>   	add_test(NAME ${tsh}
>> -		COMMAND ${SH_EXE} ${tsh}
>> +		COMMAND env GIT_TEST_BUILD_DIR=3D${CMAKE_BINARY_DIR} ${SH_EXE} ${tsh}
>
> I'm not sure about using env on windows,=20

In general, if it didn't work a lot of our test suite would fail, so
it's definitely supported, and since this is only used to run tests it
should be OK with portability.

But I don't have a Windows dev environment other than the CI, are you
able to test this & check if it works?

> can we use ${SH_EXE} -c
> instead to avoid creating an extra process?
>
> 	COMMAND ${SH_EXE} -c [[GIT_TEST_BUILD_DIR=3D"$1"; . "$2"]]
> 	"${tsh}" "${CMAKE_BINARY_DIR}" "${tsh}"

Neat, so that "[[...]]" syntax makes sure we don't have any quoting
issues?

>
>>   		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
>>   endforeach()
>>   diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 41b1ddc96ff..284b619708a 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -47,9 +47,21 @@ fi
>>   # its build directory.
>>   GIT_SOURCE_DIR=3D"${TEST_DIRECTORY%/t}"
>>   GIT_BUILD_DIR=3D"$GIT_SOURCE_DIR"
>> +GIT_AUTO_CONTRIB_BUILDSYSTEMS_OUT=3D
>>   if test -n "$GIT_TEST_BUILD_DIR"
>>   then
>>   	GIT_BUILD_DIR=3D"$GIT_TEST_BUILD_DIR"
>> +elif ! test -x "$GIT_BUILD_DIR/git" &&
>> +     test -x "$GIT_BUILD_DIR/contrib/buildsystems/out/git"
>
> I'm really not keen on hard coding the CMAKE_BINARY_DIR. One of the
> positive things about dscho's approach is that it does not hard code
> the build directory. I'm not convinced this approach is an
> improvement.

See above.

Thanks for the careful review!
