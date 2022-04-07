Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA635C433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 11:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238280AbiDGLqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 07:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236594AbiDGLqf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 07:46:35 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0A7176642
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 04:44:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c42so6082051edf.3
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 04:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=373eZBPdQmZGu6Xoos3tGO9Q2O852HJfbvFklN8BTe4=;
        b=OfqyeGmMIlEb2mRcZBs/nYlzkcWTQfEK0fEQ3b9xF54RUsLWNkISy6BT5By6pLUSEw
         ojo2QrGudm5ecnJgIXtuOlOIif7meAhjKfetTCL0m7Sp69aN00RsnOtYbeJzEDZTWMwW
         iKXDoIlDZ2+o8rIhytOYuZFP+zQjspSQ4VDZXah9TMmtMoOYR9+5Ae07/P+n8k57wyed
         ocNl9bXafiITCK7DL1W4iX5CPsIN6OG//7nq1Lynm5CXbmiv79D8n2gEUK92j+OsxbA0
         +JwEFzo3Dkx+leFw3V7grpZaeYNG57nxaF+syXKROHuPQ2TJRY5JZ7fl3YELT2V2W8N2
         Xy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=373eZBPdQmZGu6Xoos3tGO9Q2O852HJfbvFklN8BTe4=;
        b=MdRpGJPO8QL7oLQj6JNZsWLvrzrccbkQ9CcJU00pl68AY4+5UbF5Nnx8cNoS3pxv4C
         xdw7gwUicCl8UFuW68NYiDvmvolQiq1Vc+M9FY1vsj1UFSX3XTD3gZrJgTaKAI4TMS2+
         S1mXZUA4wdwoeHqPkKobFOXcXVrM39sHzNQBURf72japjAaV8aAxrnkaEDDgxvR696iV
         /WIV0WxrxdvgPfqguSbO+bNASjcLXs8R61O0UPjASq3KCyKeqLfE7y6DIYdbxTNBFF/I
         Hvuh7dV+hQJPFhSg01rRPQXkf/h4hdjGfYEbUmP54EQTB5+SHgN5eDSRkM0M6XNA6FQO
         Mm9w==
X-Gm-Message-State: AOAM5315g01gn4bwYPvD2qmskeN3lapGnZW4m/xx46B73P80+vrrAbHD
        4aKdznAQqL45dvZEnhivAjY=
X-Google-Smtp-Source: ABdhPJxM9dN+b8QH4hI4ydsi/JLASNNH+sIoRajCKMPKLZDyvte7N/dt3zUbfQMfikraK+gm5A+zYQ==
X-Received: by 2002:a05:6402:1541:b0:41c:bfb9:d56b with SMTP id p1-20020a056402154100b0041cbfb9d56bmr13596345edx.344.1649331870555;
        Thu, 07 Apr 2022 04:44:30 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u10-20020a50d94a000000b004131aa2525esm9197964edj.49.2022.04.07.04.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 04:44:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ncQYv-000vyW-C8;
        Thu, 07 Apr 2022 13:44:29 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     COGONI Guillaume <cogoni.guillaume@gmail.com>
Cc:     gitster@pobox.com, Matthieu.Moy@univ-lyon1.fr,
        derrickstolee@github.com, git.jonathan.bressat@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] contrib/vscode/: debugging with VS Code and gdb
Date:   Thu, 07 Apr 2022 13:17:20 +0200
References: <xmqqbkxex8oy.fsf@gitster.g>
 <20220406233946.45778-1-cogoni.guillaume@gmail.com>
 <20220406233946.45778-2-cogoni.guillaume@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220406233946.45778-2-cogoni.guillaume@gmail.com>
Message-ID: <220407.86tub5ce3m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[Partially in reply to Matthieu Moy's
https://lore.kernel.org/git/6a5152c1-7bb4-220c-cdce-33e93ea9c7c6@univ-lyon1=
.fr/,
but it seems more useful to continue here in the v3 thread]

On Thu, Apr 07 2022, COGONI Guillaume wrote:

> Add a mention to the README and the init.sh in Documentation/
> MyFirstContribution.txt and a part to convince a newcomer that VS Code
> can be helpful.

Aside from this specific addition of a section about VSCode it says at
the top of of Documentation/MyFirstContribution.txt:
=09
	This tutorial aims to summarize the following documents, but the reader ma=
y find
	useful additional context:
=09
	- `Documentation/SubmittingPatches`
	- `Documentation/howto/new-command.txt`

Should we have anything in MyFirstContribution.txt that isn't already
covered there per that statement at the top?

[Combining replies at this point]

On Thu, Apr 07 2022, Matthieu Moy wrote:

> On 4/6/22 10:47, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Wed, Apr 06 2022, COGONI Guillaume wrote:
>> I really don't mind having some guide for VSCode in our developer
>> documentation, but I think if we (as a free software project) are
>> recommending proprietary software we should put that in some context
>> where we explain if/why it's needed, and if free alternatives are also
>> suitable.
>
> Note that VS Code is mostly open source (the pre-compiled binaries are
> proprietary, but the source code is MIT licenced,=20
> https://github.com/Microsoft/vscode). Not to be confused with Visual
> Studio, which is fully proprietary, but is a totally different tool=20
> (AFAIK, they only share the name).

This patch specifically proposed to link to the propriterary version.

Is there a reason we wouldn't at least recommend the fully-free version
at https://github.com/VSCodium/vscodium, or at least mention it as
prominently?

>> I haven't used the VSCode integration you're documenting, but from the
>> diff and the "gdb" mention I gather that this isn't using some "native"
>> debugger of MSVC/VS's, but just using the VSCode editor as a wrapper for
>> gdb?
>
> Yes (gdb or lldb under the hood). As usual, it adds a GUI layer, but
> also a configuration layer where you specify how to launch the
> debugger in a launch.json file, and this is where the little script in
> contrib/ is handy to generate a launch.json adapted for Git.
>
>> If that's the case wouldn't it suffice to link to some generic getting
>> started guide for debuggers? And e.g. recommend the GDB manual, maybe
>> there's a better online reference (I read it locally), but e.g.:
>> https://www.sourceware.org/gdb/current/onlinedocs/gdb.html
>
> To me the point of the doc within Git's repo is to document
> git-specific aspects, and I agree that pointing to a generic doc is
> better than re-writing one. If I had written the patch I'd have made
> the general paragraph on debugger benefits a bit shorter, but it's
> already rather short so I'm OK with the patch in its current state.
>
>> Then if we're recommending GUI wrappers those are a dime a dozen,
>> e.g. Emacs's GUD mode:
>> https://www.gnu.org/software/emacs/manual/html_node/emacs/Debuggers.html
>
> To me this is out of the scope of the patch (the real point to me was
> to increase the discoverability of contrib/vscode), but sure,
> documenting other GUI wrappers would be nice.
> [...]
> +
> +[[Bonus-useful-tools]]
> +=3D=3D Bonus - useful tools
> +
> +=3D=3D=3D Visual Studio Code (VS Code)
> +
> +The contrib/vscode/init.sh script creates configuration files that enable
> +several valuable VS Code features. See contrib/vscode/README.md for more
> +information on using the script.
> +
> +In particular, this script enables using the VS Code visual debugger, in=
cluding
> +setting breakpoints, logpoints, conditional breakpoints in the editor.
> +In addition, it includes the ability to see the call stack, the line of =
code that
> +is executing and more. It is possible to visualize the variables and the=
ir values
> +and change them during execution.
> +
> +In sum, using the built-in debugger can be particularly helpful to under=
stand
> +how Git works internally.
> +It can be used to isolate certain parts of code, with this you may be ab=
le to ask
> +more precises question when you are stuck. (See getting-help sections).
> diff --git a/contrib/vscode/README.md b/contrib/vscode/README.md
> index 8202d62035..f383c95e1f 100644
> --- a/contrib/vscode/README.md
> +++ b/contrib/vscode/README.md
> @@ -6,7 +6,11 @@ code editor which runs on your desktop and is available =
for
>  [Windows](https://code.visualstudio.com/docs/setup/windows),
>  [macOS](https://code.visualstudio.com/docs/setup/mac) and
>  [Linux](https://code.visualstudio.com/docs/setup/linux). Among other lan=
guages,
> -it has [support for C/C++ via an extension](https://github.com/Microsoft=
/vscode-cpptools).
> +it has [support for C/C++ via an extension](https://github.com/Microsoft=
/vscode-cpptools) with
> +[debugging support](https://code.visualstudio.com/docs/editor/debugging)
> +
> +To get help about "how to personalize your settings" read:
> +[How to set up your settings](https://code.visualstudio.com/docs/getstar=
ted/settings)

Two things:

First I think (disclaimer: being on the Git PLC this is just my opinion)
that as a prominent free software project, and being under the Software
Freedom Conservancy umbrella whose mission is
(https://sfconservancy.org/):

    [...] fostering free and open source software (FOSS) projects,
    driving initiatives that actively make technology more inclusive,
    and advancing policy strategies that defend FOSS (such as copyleft).

So, maybe I'm just an old free software radical, but I believe in
interpreting that broadly. I.e. if we're recommending third-party
software we should prefer free alternatives, which doesn't mean that we
can't mention proprietary software, just that we shouldn't be
encouraging it when a free alternative will do.

But secondly, and everything here would apply if VSCode were replaced by
GNU Emacs and its GUD mode, so it's not about free software on VSCode at
all: This whole addition just seems like it's recommending a needlessly
complex way to get to having a C debugger installed.

Leaving aside completely *where* we should put such a thing I'd expect
something much more like:
=09
	BEGIN QUOTE
=09
	=3D=3D Using debuggers =3D=3D
=09
	You'll probably find it useful to use a debugger to
	interactively inspect your code as it's running.
=09
	There's numerous such debuggers, and you may even have one installed
	already along with your development toolchain.
=09
	The GNU debugger (gdb) is probably the most common one command-line
	debugger, along with the LLDB debugger (lldb):
=09
		https://www.sourceware.org/gdb/
		https://lldb.llvm.org/
=09
	=3D=3D=3D GUIs =3D=3D=3D
=09
	Some users find using such a debugger to be rather "bare bones" on the
	command-line, but there's numerous GUIs or "front-ends" for them
	available. You may even find that your editort (e.g. GNU emacs) ships
	with such a frontend already. You may find a listing of some at (some of
	these work with lldb as well as gdb):
=09
	    http://sourceware.org/gdb/wiki/GDB%20Front%20Ends
=09
	We also have helper code in-tree to launch debuggers from some
	editors. If you use on of these editors you may find that handy:
=09
		VSCode: contrib/vscode/README.md
=09
	=3D=3D=3D Debugging test failures =3D=3D=3D
=09
	If you'd like to start an interactive debugger at the ponit where a test
	fails you may find the "debug" wrapper in t/test-lib-functions.sh useful
	for that.
=09
	END QUOTE

I.e. it really shouldn't be the goal of a section on debuggers to
"convince a newcomer that VS Code can be helpful", or that Emacs is
helpful or whatever. Let's instead discuss the general topic at hand.

The proposed addition buries the lede in that regard. I.e. it's not made
clear to the reader that we're just suggesting yet another interface for
gdb, so a beginning contributor might go through it, only to find that
all they needed was gdb, and they had that installed already.
