Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46DCC432C0
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 13:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE9B217D6
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 13:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RHryJvr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfK2Nwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 08:52:41 -0500
Received: from mout.gmx.net ([212.227.17.21]:54213 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbfK2Nwk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 08:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575035548;
        bh=g2yeRpgD8lD0Vs8oYFtELJ4yD1Z2t4CK2ds3oqKLa7Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RHryJvr12REucznJJ5DRCW2P/6Dv77p1ZY7rrole1ZU054tMYdZu8s3CU0+efRHV0
         knjQFMPQ8jbElcetUM54jmYXqgJ3ZPetp1ha7oIVAUH5+D2N0at3GvctwYLpzkzpa4
         CJHZOOVm/Otn6RNYrtvOfLYUNFgD6iW2lOmbYCfM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPXdC-1iO7eY1YzC-00MgRl; Fri, 29
 Nov 2019 14:52:28 +0100
Date:   Fri, 29 Nov 2019 14:52:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] mingw: spawned processes need to inherit only standard
 handles
In-Reply-To: <00ef72f5-b1fa-f449-0e00-23713bed0187@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1911291036320.31080@tvgsbejvaqbjf.bet>
References: <pull.670.git.git.1574433665.gitgitgadget@gmail.com> <feb197792814701bf36cb15b73e1e73aae2baa4d.1574433665.git.gitgitgadget@gmail.com> <00ef72f5-b1fa-f449-0e00-23713bed0187@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SWDVICADj3+lPTUglZVE/md9J1x6oo2crCAvOWMohxZr++uBPGa
 uh9YBcE5mGYAJaGhOk2aB+0qA/smksGQEbvegLrnxXR37+fnW8sQ4aZE+TMqzm23ygnTxQ2
 h3r2O8n2sJKj+1nQ2JS72dEDqH8T93+quGNmMUC8QtcX61GY79KsoTdNlNx5LfyuHbgN19G
 sgn5AzLTsLsu8TIroWiEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+G30dSmYUn8=:lFFI6I+0tHUybOd7UNum7c
 kGAVBydWvUTkr3xejGGVWCAtgnLDap4hSVCJ+4O9OPouQqJPOZrfCCPLH1xBuPZUt0KIfGn/J
 1KAMym1B9OtT55mZkMHKNa9vgv4arVe9VM+5A256XMTDvpfzf4uFsx3MmIVizLaQEFgKA/3f+
 VjHVGwN9ihNw5H2gxlEjd03bJoQFCKnLxI0AQPpSvhiuo1rhknYC/Lohm/WkkhsFmoQ2YU49D
 uqC0UtlBq05f3oXm7qdMbaAkBo7fBDgLL3s1EwEllfe5K3uJ0+TnrFox8EJZoWA12X1ZxDASI
 ffDsnMFmw/gKI3nyN9ajYbzmGeEjqcjXuickNKjSR/Na911nPSF7t96qACgdZe4CnDT3SKTd1
 qzHE2KAlDiE27/g0S3NCz3j755sE054lGYawuuhOtrQvQmzWJNKggJMO3vj7dunypdqSGiRBQ
 i+xFL5h0rVkt4Ltqm6e2OkWBoPaSr+xQKh2aFvarrqjWzaV3W+0xtqAx+pOV5vdCVQHk9sFKG
 f+VgYaWr05I+WCNtumyke44/sKJXubp5I/eEmxaqi8R9uhMOyOQK6+f2neacHbqUQ3+iXAFMx
 2o3lBqNeFJ2zTMPycdTy7hH6KeINsAWWLnDZgsS7CUiJ1FrZGWvQNX7iAXAx7EghyndPhSDeB
 6l1XkgxJAl6bi6COSGjRmV5DAe/s4HpTCt2GTGQw+t6wf66AxizS+i7P2ukwPZafEEcDcKmGm
 uJRev7SKSbMR+MpnUEO4G6+Kb2j9fHKe1Udtc5tYAVjw0s+Ze2YkZGDPyol9na5rs8IYz4PMF
 0UbHyPRkmlAb7zaPn4hd6X/byWJ3CLTg7tvcI2RQb8huYyqdBPDovedbeehy59zIFG8ozr8cM
 wI5BDYcITeV6XwLhwRtIw78yLhAmwbzaIggD85s0ipTJIHwN+L6oYqPVmYV07sYlvj+H8boG1
 chztZDfgeh6qS35PH1cX6r1TrIGGb8iSIUUtPJscEjWOoLUBoGI0r63NBt+eFqoqmr7MVhojm
 nm4sMVGU2eRhQAs0cla6wzM92vVqtYTEsicQbhXj1W5lJUrxZLnEdecmVnIK0Ri5TVsjDtldx
 qbny+rhr5J+3+RCzz+2nRyVRigj9crlI2AKDMjY/K9NnVwWENMfkSHzI8XeA6w5OdsvjC4Xof
 m8UTKuahlnLwNDjy2Efb3glxdlEotBW1YzmcDqaHkjW4AQc1LJFTGkcsCGbAO6U95TDjXNR/5
 mRM1JIshCyLEeZRqK8mUUhd83Irzx5Le514vKjZoS5O0BER1e6VQTjnADFws=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Thu, 28 Nov 2019, Johannes Sixt wrote:

> I'm sorry for being a bit slow lately. I found time to test this patch
> only today.

Out of curiosity: did you apply the patch on `master`, or on anything
different?

I ask because...

> Am 22.11.19 um 15:41 schrieb Johannes Schindelin via GitGitGadget:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > By default, CreateProcess() does not inherit any open file handles,
> > unless the bInheritHandles parameter is set to TRUE. Which we do need =
to
> > set because we need to pass in stdin/stdout/stderr to talk to the chil=
d
> > processes. Sadly, this means that all file handles (unless marked via
> > O_NOINHERIT) are inherited.
> >
> > This lead to problems in VFS for Git, where a long-running read-object
> > hook is used to hydrate missing objects, and depending on the
> > circumstances, might only be called *after* Git opened a file handle.
> >
> > Ideally, we would not open files without O_NOINHERIT unless *really*
> > necessary (i.e. when we want to pass the opened file handle as standar=
d
> > handle into a child process), but apparently it is all-too-easy to
> > introduce incorrect open() calls: this happened, and prevented updatin=
g
> > a file after the read-object hook was started because the hook still
> > held a handle on said file.
> >
> > Happily, there is a solution: as described in the "Old New Thing"
> > https://blogs.msdn.microsoft.com/oldnewthing/20111216-00/?p=3D8873 the=
re
> > is a way, starting with Windows Vista, that lets us define precisely
> > which handles should be inherited by the child process.
> >
> > And since we bumped the minimum Windows version for use with Git for
> > Windows to Vista with v2.10.1 (i.e. a *long* time ago), we can use thi=
s
> > method. So let's do exactly that.
> >
> > We need to make sure that the list of handles to inherit does not
> > contain duplicates; Otherwise CreateProcessW() would fail with
> > ERROR_INVALID_ARGUMENT.
> >
> > While at it, stop setting errno to ENOENT unless it really is the
> > correct value.
>
> I think the new code does not do that correctly. I observe a failure in
> test #2 in t0061, which is this one:
>
> test_expect_success 'start_command reports ENOENT (slash)' '
> 	test-tool run-command start-command-ENOENT ./does-not-exist 2>err &&
> 	test_i18ngrep "\./does-not-exist" err
> '
>
> It does not even get to test_i18ngrep (test-tool fails), and err
> contains this:
>
> error: cannot spawn ./does-not-exist: Result too large
> FAIL start-command-ENOENT
>
> That "Result too large" is ERANGE.
>
> Don't you observe that, too? (I'm testing on Windows 10, BTW.)

No, I don't observe that. And neither does the CI build:
https://github.com/gitgitgadget/git/runs/317137275

This CI build tested the `js/mingw-inherit-only-std-handles` branch that
is mirrored into gitgitgadget/git from https://github.com/gitster/git.

Could you try with that branch, to see whether it "magically" fixes the
issue you are seeing?

> I've done a bit of tracing, see below.

Much appreciated.

> > Also, fall back to not limiting handle inheritance under certain error
> > conditions (e.g. on Windows 7, which is a lot stricter in what handles
> > you can specify to limit to).
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  compat/mingw.c         | 120 +++++++++++++++++++++++++++++++++++++---=
-
> >  t/t0061-run-command.sh |   2 +-
> >  2 files changed, 110 insertions(+), 12 deletions(-)
> >
> > diff --git a/compat/mingw.c b/compat/mingw.c
> > index fe609239dd..cac18cc3da 100644
> > --- a/compat/mingw.c
> > +++ b/compat/mingw.c
> > @@ -1398,8 +1398,13 @@ static pid_t mingw_spawnve_fd(const char *cmd, =
const char **argv, char **deltaen
> >  			      const char *dir,
> >  			      int prepend_cmd, int fhin, int fhout, int fherr)
> >  {
> > -	STARTUPINFOW si;
> > +	static int restrict_handle_inheritance =3D 1;
> > +	STARTUPINFOEXW si;
> >  	PROCESS_INFORMATION pi;
> > +	LPPROC_THREAD_ATTRIBUTE_LIST attr_list =3D NULL;
> > +	HANDLE stdhandles[3];
> > +	DWORD stdhandles_count =3D 0;
> > +	SIZE_T size;
> >  	struct strbuf args;
> >  	wchar_t wcmd[MAX_PATH], wdir[MAX_PATH], *wargs, *wenvblk =3D NULL;
> >  	unsigned flags =3D CREATE_UNICODE_ENVIRONMENT;
> > @@ -1435,11 +1440,23 @@ static pid_t mingw_spawnve_fd(const char *cmd,=
 const char **argv, char **deltaen
> >  		CloseHandle(cons);
> >  	}
> >  	memset(&si, 0, sizeof(si));
> > -	si.cb =3D sizeof(si);
> > -	si.dwFlags =3D STARTF_USESTDHANDLES;
> > -	si.hStdInput =3D winansi_get_osfhandle(fhin);
> > -	si.hStdOutput =3D winansi_get_osfhandle(fhout);
> > -	si.hStdError =3D winansi_get_osfhandle(fherr);
> > +	si.StartupInfo.cb =3D sizeof(si);
> > +	si.StartupInfo.hStdInput =3D winansi_get_osfhandle(fhin);
> > +	si.StartupInfo.hStdOutput =3D winansi_get_osfhandle(fhout);
> > +	si.StartupInfo.hStdError =3D winansi_get_osfhandle(fherr);
> > +
> > +	/* The list of handles cannot contain duplicates */
> > +	if (si.StartupInfo.hStdInput !=3D INVALID_HANDLE_VALUE)
> > +		stdhandles[stdhandles_count++] =3D si.StartupInfo.hStdInput;
> > +	if (si.StartupInfo.hStdOutput !=3D INVALID_HANDLE_VALUE &&
> > +	    si.StartupInfo.hStdOutput !=3D si.StartupInfo.hStdInput)
> > +		stdhandles[stdhandles_count++] =3D si.StartupInfo.hStdOutput;
> > +	if (si.StartupInfo.hStdError !=3D INVALID_HANDLE_VALUE &&
> > +	    si.StartupInfo.hStdError !=3D si.StartupInfo.hStdInput &&
> > +	    si.StartupInfo.hStdError !=3D si.StartupInfo.hStdOutput)
> > +		stdhandles[stdhandles_count++] =3D si.StartupInfo.hStdError;
> > +	if (stdhandles_count)
> > +		si.StartupInfo.dwFlags |=3D STARTF_USESTDHANDLES;
> >
> >  	if (*argv && !strcmp(cmd, *argv))
> >  		wcmd[0] =3D L'\0';
> > @@ -1472,16 +1489,97 @@ static pid_t mingw_spawnve_fd(const char *cmd,=
 const char **argv, char **deltaen
> >  	wenvblk =3D make_environment_block(deltaenv);
> >
> >  	memset(&pi, 0, sizeof(pi));
> > -	ret =3D CreateProcessW(*wcmd ? wcmd : NULL, wargs, NULL, NULL, TRUE,
> > -		flags, wenvblk, dir ? wdir : NULL, &si, &pi);
> > +	if (restrict_handle_inheritance && stdhandles_count &&
> > +	    (InitializeProcThreadAttributeList(NULL, 1, 0, &size) ||
> > +	     GetLastError() =3D=3D ERROR_INSUFFICIENT_BUFFER) &&
> > +	    (attr_list =3D (LPPROC_THREAD_ATTRIBUTE_LIST)
> > +			(HeapAlloc(GetProcessHeap(), 0, size))) &&
> > +	    InitializeProcThreadAttributeList(attr_list, 1, 0, &size) &&
> > +	    UpdateProcThreadAttribute(attr_list, 0,
> > +				      PROC_THREAD_ATTRIBUTE_HANDLE_LIST,
> > +				      stdhandles,
> > +				      stdhandles_count * sizeof(HANDLE),
> > +				      NULL, NULL)) {
> > +		si.lpAttributeList =3D attr_list;
> > +		flags |=3D EXTENDED_STARTUPINFO_PRESENT;
> > +	}
> > +
> > +	ret =3D CreateProcessW(*wcmd ? wcmd : NULL, wargs, NULL, NULL,
> > +			     stdhandles_count ? TRUE : FALSE,
> > +			     flags, wenvblk, dir ? wdir : NULL,
> > +			     &si.StartupInfo, &pi);
> > +
> > +	/*
> > +	 * On Windows 2008 R2, it seems that specifying certain types of han=
dles
> > +	 * (such as FILE_TYPE_CHAR or FILE_TYPE_PIPE) will always produce an
> > +	 * error. Rather than playing finicky and fragile games, let's just =
try
> > +	 * to detect this situation and simply try again without restricting=
 any
> > +	 * handle inheritance. This is still better than failing to create
> > +	 * processes.
> > +	 */
> > +	if (!ret && restrict_handle_inheritance && stdhandles_count) {
> > +		DWORD err =3D GetLastError();
>
> CreateProcessW failed, so we arrive here. At this point, err is 2
> (ERROR_FILE_NOT_FOUND) as expected.
>
> > +		struct strbuf buf =3D STRBUF_INIT;
> > +
> > +		if (err !=3D ERROR_NO_SYSTEM_RESOURCES &&
>
> Then this is true, ...
>
> > +		    /*
> > +		     * On Windows 7 and earlier, handles on pipes and character
> > +		     * devices are inherited automatically, and cannot be
> > +		     * specified in the thread handle list. Rather than trying
> > +		     * to catch each and every corner case (and running the
> > +		     * chance of *still* forgetting a few), let's just fall
> > +		     * back to creating the process without trying to limit the
> > +		     * handle inheritance.
> > +		     */
> > +		    !(err =3D=3D ERROR_INVALID_PARAMETER &&
> > +		      GetVersion() >> 16 < 9200) &&
>
> ... the bracketed expression is false, but it's negated, so it's true
> again, ...
>
> > +		    !getenv("SUPPRESS_HANDLE_INHERITANCE_WARNING")) {
>
> ... and the variable isn't set, so we continue here. (But I don't think
> it is important.)
>
> > +			DWORD fl =3D 0;
> > +			int i;
> > +
> > +			setenv("SUPPRESS_HANDLE_INHERITANCE_WARNING", "1", 1);
> > +
> > +			for (i =3D 0; i < stdhandles_count; i++) {
> > +				HANDLE h =3D stdhandles[i];
> > +				strbuf_addf(&buf, "handle #%d: %p (type %lx, "
> > +					    "handle info (%d) %lx\n", i, h,
> > +					    GetFileType(h),
> > +					    GetHandleInformation(h, &fl),
> > +					    fl);
> > +			}
> > +			strbuf_addstr(&buf, "\nThis is a bug; please report it "
> > +				      "at\nhttps://github.com/git-for-windows/"
> > +				      "git/issues/new\n\n"
> > +				      "To suppress this warning, please set "
> > +				      "the environment variable\n\n"
> > +				      "\tSUPPRESS_HANDLE_INHERITANCE_WARNING=3D1"
> > +				      "\n");
> > +		}
> > +		restrict_handle_inheritance =3D 0;
> > +		flags &=3D ~EXTENDED_STARTUPINFO_PRESENT;
> > +		ret =3D CreateProcessW(*wcmd ? wcmd : NULL, wargs, NULL, NULL,
> > +				     TRUE, flags, wenvblk, dir ? wdir : NULL,
> > +				     &si.StartupInfo, &pi);
>
> Then this one fails again (with GetLastError() =3D=3D 2, too, as expecte=
d).
>
> > +		if (ret && buf.len) {
> > +			errno =3D err_win_to_posix(GetLastError());
> > +			warning("failed to restrict file handles (%ld)\n\n%s",
> > +				err, buf.buf);
> > +		}
> > +		strbuf_release(&buf);
> > +	} else if (!ret)
> > +		errno =3D err_win_to_posix(GetLastError());
> > +
> > +	if (si.lpAttributeList)
> > +		DeleteProcThreadAttributeList(si.lpAttributeList);
> > +	if (attr_list)
> > +		HeapFree(GetProcessHeap(), 0, attr_list);
> >
> >  	free(wenvblk);
> >  	free(wargs);
> >
> > -	if (!ret) {
> > -		errno =3D ENOENT;
> > +	if (!ret)
> >  		return -1;
>
> And then we take this error exist. At this point, GetLastError() =3D=3D =
0
> (probably from the successful cleanup functions), but errno =3D=3D 34
> (ERANGE), probably a fallout from one of the xutftowcs that we do
> earlier (I didn't check). The point is, we leave the function with a
> failure indication, but without having set errno.
>
> Any ideas?

Strange. When I debug this, errno is indeed still set from before, but to
ENOENT.

I wonder how you get that ERANGE when I get an ENOENT (and so do all the
CI/PR builds that did not catch this).

Will send a fix shortly.

Thanks,
Dscho

> And why don't you observe the failure? A coincidence?
>
> > -	}
> > +
> >  	CloseHandle(pi.hThread);
> >
> >  	/*
> > diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
> > index 473a3405ef..7d599675e3 100755
> > --- a/t/t0061-run-command.sh
> > +++ b/t/t0061-run-command.sh
> > @@ -12,7 +12,7 @@ cat >hello-script <<-EOF
> >  	cat hello-script
> >  EOF
> >
> > -test_expect_failure MINGW 'subprocess inherits only std handles' '
> > +test_expect_success MINGW 'subprocess inherits only std handles' '
> >  	test-tool run-command inherited-handle
> >  '
> >
> >
>
> -- Hannes
>
