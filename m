Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5C9C432C3
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 20:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0792075C
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 20:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AUGTe08a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfK2Uki (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 15:40:38 -0500
Received: from mout.gmx.net ([212.227.15.18]:55897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbfK2Ukh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 15:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575060029;
        bh=gzHbFroTJVs5jU6PmgtKkoEmPRCrkplGDfDaBzIJUjg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AUGTe08a0l2CfiWEUipM78FkSqYEfvGP7J/dtPrWh6FI0OWF4H3JiqgEXI6/vyJM9
         n0Zio2rVklGe/UEi2bpOG3hYIc+aeay/jpJhJKEWS5YUWQkfxW2ThVEC3YxHBUqUgS
         lUHyM7jA0IEwl6xLwNq+WLWwJJIDVl8dwhhKXUeI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MG9gE-1iZkqf1FOu-00Gath; Fri, 29
 Nov 2019 21:40:29 +0100
Date:   Fri, 29 Nov 2019 21:40:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] mingw: spawned processes need to inherit only standard
 handles
In-Reply-To: <nycvar.QRO.7.76.6.1911291036320.31080@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1911292017321.31080@tvgsbejvaqbjf.bet>
References: <pull.670.git.git.1574433665.gitgitgadget@gmail.com> <feb197792814701bf36cb15b73e1e73aae2baa4d.1574433665.git.gitgitgadget@gmail.com> <00ef72f5-b1fa-f449-0e00-23713bed0187@kdbg.org> <nycvar.QRO.7.76.6.1911291036320.31080@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:j7wJdC3e/qoJHXU5d+7OqHNXLWufc/osdMnsRAm8l5XI7ergdQM
 /ounpPcpAT871uqWFz3TJ9roQuud8y9iH8YB0uTXu4Met+vo5h+zPEzAvBFczw9k/wj9bwV
 /HiiujVH+xsO8W2rWp15SSzgAM7at2Dsxd2UIu3E94WMNqGUtK1e6oDKpqnA2o88LeB6zs3
 hbVIrs17OTHEGvY9mXRvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hlt6wBLX7xg=:2EHKdeLhSK9nD5YkQwCoqb
 CbcSSjCoaV5AJAvdbmWIdpDmrYthC2RA1xWQVMnEDvx/jiye2EPPm+5ylZV4zukI9Ud0js0+M
 iorFQXHsgu5KynGkjTHMdNUkpFb+Rak2sPcOj3lHQtBVPl/CCTBGXeOxh9f6D/nXG3gcgs8as
 OG+2Zm4l4+OA7nhuhwhGYdtnP5UPTJSJIk7XjGLglduCsbvdPoa9//g/i5e1tUMoJRVe+uEyn
 EBNleVXhXujZ9KKRi9qekv7Vuhir/zkT5VoJ7iV7gR9y3fKYdwMYs+RJWqt6LDOQ75pnbiS5W
 TVlV9cw/BNRlCNY4wuw6uFGyRdtuLpj2zH4VuF3BhPxjXdmsNFa06o2bnCAXtxQJ63RHirjDW
 JOiwmP3j4vL0Js0iGz1idvJKpMPEE/KA7lHbtz8b1Gp8W4L/ay38FWFm95zbcypWo/V5fr2rp
 10Gng82qntXTql/xqxdQyQeJl7BuLFFbEh4fYNqoH60BqmbWsUc7azLs7a/jGZfjTWF8dT1fK
 aeJNvNNe0TUjTSrfBoZ+WLoWcxV8fgymiaQC7NZGOscucX1sYl4fzi+uMnhDhUjE6Uu3iY3RT
 XoWPjgWhHII0wsyZf51eFJ7VWqkAoW2IEHCz3prQ3H5w77kDEM2cvK3f1Joqf1V8D8SrUoUDZ
 tX7PjUtqgyNggu8sZHqW8E9gZZ06RMWuVUKB/TRLs6bUypKa8dEPwbQmZxwtH7tktF/OoJ22S
 gxGbBsvXo1/1GfaUazywBDkL3+KI/RaGb3K/j/UnMCmnMZ71UrjBODJH5+8xd9loT6dXv6/hR
 vl4IWTaCSJVG0EFxqjZn67owchY1RLfRT2LYdH34PfPZheN8h3/xUa43m5ylcOr2xEM0YmIhV
 Izvhw9hQXEf5hFqAgO6hHfiz9HDjBBsCWrG9S55evsiH2/z8KeFnMB8X5gJdXsPzu5JGZ0jWA
 ckzxGrWFWwfONIB0dBx4YLnS82/AI5QBTo6QaNrffXTPM1tzg5NFDwMolrlCdoPkHX/WYAxA5
 hyQkhaxbqkfRWIznBTJns4xwdfwW74vkS/WStghu3+NOAM0+O4/FpBhPWv+eizKbl3V4U9zo/
 2T+Lc/82F1AaSeK3TN6+PmRlPwr0Tgd3WVo7Ko5prOChRUdJBo47b2eaP/0t04T3ZsE7slmbV
 iUTflkoXGQN6asHbH8iz0qAcKMvdNZI5GaFGO59FVgJ5z8v94gTL9kcKN9hRIzPWqSU0IR0of
 4zjIFDBp9au+ukgKY2zD/LMC0wDja+cjwnmmLmARecZE5Xq5q0xz40Npuj+o=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Fri, 29 Nov 2019, Johannes Schindelin wrote:

> On Thu, 28 Nov 2019, Johannes Sixt wrote:
>
> [ ... analyzing a t0061.2 failure ...]
>
> > Am 22.11.19 um 15:41 schrieb Johannes Schindelin via GitGitGadget:
>
> > > @@ -1472,16 +1489,97 @@ static pid_t mingw_spawnve_fd(const char *cm=
d, const char **argv, char **deltaen
> > >  	wenvblk =3D make_environment_block(deltaenv);
> > >
> > >  	memset(&pi, 0, sizeof(pi));
> > > -	ret =3D CreateProcessW(*wcmd ? wcmd : NULL, wargs, NULL, NULL, TRU=
E,
> > > -		flags, wenvblk, dir ? wdir : NULL, &si, &pi);
> > > +	if (restrict_handle_inheritance && stdhandles_count &&
> > > +	    (InitializeProcThreadAttributeList(NULL, 1, 0, &size) ||
> > > +	     GetLastError() =3D=3D ERROR_INSUFFICIENT_BUFFER) &&
> > > +	    (attr_list =3D (LPPROC_THREAD_ATTRIBUTE_LIST)
> > > +			(HeapAlloc(GetProcessHeap(), 0, size))) &&
> > > +	    InitializeProcThreadAttributeList(attr_list, 1, 0, &size) &&
> > > +	    UpdateProcThreadAttribute(attr_list, 0,
> > > +				      PROC_THREAD_ATTRIBUTE_HANDLE_LIST,
> > > +				      stdhandles,
> > > +				      stdhandles_count * sizeof(HANDLE),
> > > +				      NULL, NULL)) {
> > > +		si.lpAttributeList =3D attr_list;
> > > +		flags |=3D EXTENDED_STARTUPINFO_PRESENT;
> > > +	}
> > > +
> > > +	ret =3D CreateProcessW(*wcmd ? wcmd : NULL, wargs, NULL, NULL,
> > > +			     stdhandles_count ? TRUE : FALSE,
> > > +			     flags, wenvblk, dir ? wdir : NULL,
> > > +			     &si.StartupInfo, &pi);
> > > +
> > > +	/*
> > > +	 * On Windows 2008 R2, it seems that specifying certain types of h=
andles
> > > +	 * (such as FILE_TYPE_CHAR or FILE_TYPE_PIPE) will always produce =
an
> > > +	 * error. Rather than playing finicky and fragile games, let's jus=
t try
> > > +	 * to detect this situation and simply try again without restricti=
ng any
> > > +	 * handle inheritance. This is still better than failing to create
> > > +	 * processes.
> > > +	 */
> > > +	if (!ret && restrict_handle_inheritance && stdhandles_count) {
> > > +		DWORD err =3D GetLastError();
> >
> > CreateProcessW failed, so we arrive here. At this point, err is 2
> > (ERROR_FILE_NOT_FOUND) as expected.
> >
> > > +		struct strbuf buf =3D STRBUF_INIT;
> > > +
> > > +		if (err !=3D ERROR_NO_SYSTEM_RESOURCES &&
> >
> > Then this is true, ...
> >
> > > +		    /*
> > > +		     * On Windows 7 and earlier, handles on pipes and character
> > > +		     * devices are inherited automatically, and cannot be
> > > +		     * specified in the thread handle list. Rather than trying
> > > +		     * to catch each and every corner case (and running the
> > > +		     * chance of *still* forgetting a few), let's just fall
> > > +		     * back to creating the process without trying to limit the
> > > +		     * handle inheritance.
> > > +		     */
> > > +		    !(err =3D=3D ERROR_INVALID_PARAMETER &&
> > > +		      GetVersion() >> 16 < 9200) &&
> >
> > ... the bracketed expression is false, but it's negated, so it's true
> > again, ...
> >
> > > +		    !getenv("SUPPRESS_HANDLE_INHERITANCE_WARNING")) {
> >
> > ... and the variable isn't set, so we continue here. (But I don't thin=
k
> > it is important.)
> >
> > > +			DWORD fl =3D 0;
> > > +			int i;
> > > +
> > > +			setenv("SUPPRESS_HANDLE_INHERITANCE_WARNING", "1", 1);
> > > +
> > > +			for (i =3D 0; i < stdhandles_count; i++) {
> > > +				HANDLE h =3D stdhandles[i];
> > > +				strbuf_addf(&buf, "handle #%d: %p (type %lx, "
> > > +					    "handle info (%d) %lx\n", i, h,
> > > +					    GetFileType(h),
> > > +					    GetHandleInformation(h, &fl),
> > > +					    fl);
> > > +			}
> > > +			strbuf_addstr(&buf, "\nThis is a bug; please report it "
> > > +				      "at\nhttps://github.com/git-for-windows/"
> > > +				      "git/issues/new\n\n"
> > > +				      "To suppress this warning, please set "
> > > +				      "the environment variable\n\n"
> > > +				      "\tSUPPRESS_HANDLE_INHERITANCE_WARNING=3D1"
> > > +				      "\n");
> > > +		}
> > > +		restrict_handle_inheritance =3D 0;
> > > +		flags &=3D ~EXTENDED_STARTUPINFO_PRESENT;
> > > +		ret =3D CreateProcessW(*wcmd ? wcmd : NULL, wargs, NULL, NULL,
> > > +				     TRUE, flags, wenvblk, dir ? wdir : NULL,
> > > +				     &si.StartupInfo, &pi);
> >
> > Then this one fails again (with GetLastError() =3D=3D 2, too, as expec=
ted).
> >
> > > +		if (ret && buf.len) {
> > > +			errno =3D err_win_to_posix(GetLastError());
> > > +			warning("failed to restrict file handles (%ld)\n\n%s",
> > > +				err, buf.buf);
> > > +		}
> > > +		strbuf_release(&buf);
> > > +	} else if (!ret)
> > > +		errno =3D err_win_to_posix(GetLastError());
> > > +
> > > +	if (si.lpAttributeList)
> > > +		DeleteProcThreadAttributeList(si.lpAttributeList);
> > > +	if (attr_list)
> > > +		HeapFree(GetProcessHeap(), 0, attr_list);
> > >
> > >  	free(wenvblk);
> > >  	free(wargs);
> > >
> > > -	if (!ret) {
> > > -		errno =3D ENOENT;
> > > +	if (!ret)
> > >  		return -1;
> >
> > And then we take this error exist. At this point, GetLastError() =3D=
=3D 0
> > (probably from the successful cleanup functions), but errno =3D=3D 34
> > (ERANGE), probably a fallout from one of the xutftowcs that we do
> > earlier (I didn't check). The point is, we leave the function with a
> > failure indication, but without having set errno.
> >
> > Any ideas?
>
> Strange. When I debug this, errno is indeed still set from before, but t=
o
> ENOENT.
>
> I wonder how you get that ERANGE when I get an ENOENT (and so do all the
> CI/PR builds that did not catch this).

I am really curious about this now...

As to why it passes on this here machine, the reason is that while looking
for the trace2 config, Git tries to access the xdg and the user config in
https://github.com/git/git/blob/v2.24.0/config.c#L1716 and in
https://github.com/git/git/blob/v2.24.0/config.c#L1719, respectively. In
Git's test suite, `HOME` is re-set to the test directory, and it does not
contain those config files, therefore `errno` is set to `ENOENT` by both
calls, and in my hands, Git does not re-set `errno` in the meantime.

Even after that trace2 code set `errno` (which we could re-set easily in
`t/helper/test-run-command.c`, as the trace2 initialization happens in
`common-main.c`, long before `cmd_main()` is called), there is _yet_
another part of the code path that sets `errno` to `ENOENT`, though: when
`mingw_spawnvpe()` wants to see whether the file in question is a script,
it calls `parse_interpreter()`, which in turn tries to `open()` the file:
https://github.com/git/git/blob/v2.24.0/compat/mingw.c#L1134. Obviously,
this call fails, and sets `errno` to `ENOENT`.

So it would appear that _something_ in your setup sets `errno` to a
different value _after_ the call to `parse_interpreter()`. Or maybe you
disabled that somehow in custom patches? Then that `ERANGE` still must
happen somewhere after the trace2 startup. I wonder what that something
would be that causes that `ERANGE`, but seemingly without causing even so
much as a warning.

> Will send a fix shortly.

Or not so shortly, after all ;-)

Ciao,
Dscho

>
> Thanks,
> Dscho
>
> > And why don't you observe the failure? A coincidence?
> >
> > > -	}
> > > +
> > >  	CloseHandle(pi.hThread);
> > >
> > >  	/*
> > > diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> > > index 473a3405ef..7d599675e3 100755
> > > --- a/t/t0061-run-command.sh
> > > +++ b/t/t0061-run-command.sh
> > > @@ -12,7 +12,7 @@ cat >hello-script <<-EOF
> > >  	cat hello-script
> > >  EOF
> > >
> > > -test_expect_failure MINGW 'subprocess inherits only std handles' '
> > > +test_expect_success MINGW 'subprocess inherits only std handles' '
> > >  	test-tool run-command inherited-handle
> > >  '
> > >
> > >
> >
> > -- Hannes
> >
>
