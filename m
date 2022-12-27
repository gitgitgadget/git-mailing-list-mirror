Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85F6C4167B
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 21:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiL0VFg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 16:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiL0VFG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 16:05:06 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F614DFB7
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 12:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672174140; bh=kSd9M7bA3Ull1WNBXJBA6t5JsT68yAwpJG1JArLOQdE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=nlh15Dl6lVTgGOJauA2ZofUkKmAKk0cItqFk5eRnPWpEqyV/V05a6hQLuPHN6CYch
         39eX8TfD5TJMYDLQ2Az4kOVn8yDksf55pOapA0tFDgR0aldsKPAIu24VFWGczcX9d5
         4y2WEKrwYCDcXQ6yXfXzEuN18KdbTWA6GmMlisS52AsaAnnFKbZNuS2+iaWA1VPwV9
         t5vZxEGQMyoaDdvgqtdeekM4PKiWKOq24Wsffv0KJociF5E1PqY9ISz9cz+1QegZ4J
         7T+pNaqcqyanr9kDdiqdjv08cTW/IR9ptu2CW+8yCmjK/sLxInKhLBpoiQML3EzD32
         4tLl2b9PL5cJA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwjJo-1ouNSi3XA2-00yHoi; Tue, 27
 Dec 2022 21:36:26 +0100
Message-ID: <9df41c56-40bf-f232-c484-9aedbb22aa2b@web.de>
Date:   Tue, 27 Dec 2022 21:36:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RFC PATCH v2] setup: avoid unconditional open syscall with write
 flags
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     git@vger.kernel.org
References: <20221227143200.1182341-1-cgzones@googlemail.com>
 <221227.86lemsvqmb.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221227.86lemsvqmb.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ngDBv4gymahcCkV94o85HB2PT0Zd6oUnSMlNP2sf0yaYZRUYVAm
 uOsL2gmn5LI1X4FvbJis60FTdPGwLfvyijKGPCqE5lLCH5MgNRdc+0vcWlk9tG3hYA8hKsR
 zET9/S+eYcnDVFo5bPkJYYr8OXDouLcHzo1LzZwEiLEeOxcPG+SNutzCHkaazDjkEEL5LrT
 nxfSaObgvOIaW1FK1WcWA==
UI-OutboundReport: notjunk:1;M01:P0:lChp2QzphiQ=;iH2PPC25STnW9eHWTJY5nR7Z9+n
 3liDetgcsxt1DtANcj5PQGb0I2oeRdnzM5sSd96U03vCNNldKza2E5Cx0CL1g7VuZ0u9LZb+L
 Wk2k8lHjSYwFrzUBGewo9PIWZEuMWCdTDZptIqBvASSF//c3JntGER7zxTO4R/Vv7ZaO9sgS0
 dHERao47uD6S6tiGBDPbrqMi5RKqsOfM9X9aHumJjueufnIMRdZ/DWkxU+ig2Tbu249Nfa4yi
 TFh+jBbIpeahGYtQhsjo3SpfIAo9DnIH3gYcJAe2/eEwJmGagqEUyw7g8IidgwtJr4eSK9ctK
 fKcMd2aCkZc80/fymAUaz5Hn1mxHkrtKgD75dfavSLYnPLIYtUuM59e333G9yjYJ4q5uFcP2Q
 ZUA0WkTyeyPViGHQEPZjiD/YVzXfg5QcWE5N4mKRGlUOroLd09gERrGQU+URWMRf/J/RzuZMk
 pazG0XiS+AeEp8iQd/z23DjuEk9XvaSL2kXBSNoJJm+zq8X9C/e9KdgMayVPpeyyjJk1lufSM
 S1YV+Lj2c/t3AB8J/4mh7fcU5w8y4htEjoeI5aNq5QHPFSnkoTXkT2B6Jh65xWxSUIopcajre
 VGDW0ySi/IMGidtP9BcT8uG/HvnRLtnOAKMkriJdr5xh/3kvpAtd7eMxWN9wRAj7htkz5PcHK
 KIoFXnOcvANcboHt9RudDeNsNZmqo1vRETw3RV+Dn3vrsUyoDR+66ilAnUX2D12fExdOmOh3o
 AdDSqSS6IKaewUP6xFehrrJ567K6ZtZj0RXovRFxDcQG6JGNYL9jaZmNAuQxdS3Hio+M6sN14
 XY4VVS3/aL8xQMFFf8Zx/fjodS0/o9leYsN/c8BJ31fpHyNS2U2mUK4jJMd7UPbsPg/b+C7uG
 PWQduzcQPDpF4nJdOS4HlqwRGBDnNxKyzL/PHNtXc0/sJYGRxBpjk9K/w7nuonE5iC34TNEdr
 pJuqYQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.12.22 um 15:40 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Tue, Dec 27 2022, Christian G=C3=B6ttsche wrote:
>
> When you submit a re-roll to the git ML please use the "--in-reply-to"
> option to format-patch, or equivalent.
>
> I see the original thread is at
> https://lore.kernel.org/git/20221205190019.52829-1-cgzones@googlemail.co=
m/,
> but this is now detached from it.
>
>> Commit 57f5d52a942 ("common-main: call sanitize_stdfds()") added the
>> sanitization for standard file descriptors (stdin, stdout, stderr) to
>> all binaries.  The lead to all binaries unconditionally opening
>> /dev/null with the flag O_RDWR (read and write).  Most of the time the
>> standard file descriptors should be set up properly and the sanitizatio=
n
>> ends up doing nothing.
>>
>> There are many git operations, like `git status` or `git stash list`,
>> which might be called by a parent to gather information about the
>> repository and should work on a read-only repository.  That parent migh=
t
>> run under a seccomp filter to avoid accidental modification or unwanted
>> command execution on memory corruptions.  As part of that seccomp filte=
r
>> open(2) and openat(2) might be only allowed in read-only mode
>> (O_RDONLY), thus preventing git's sanitation and stopping the
>> application.
>>
>> Check the need of sanitization with a file descriptor in read-only mode=
,
>> keep it as replacement for stdin and open replacement file descriptors
>> for stdout and stderr in write-only mode.
>>
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>> ---
>>
>> v2:
>>   - switch to xopen("/dev/null", O_RDONLY) to stay at 2 syscalls in the
>>     common case and use O_WRONLY for stdout and stderr, as suggested
>>     by Ren=C3=A9 Scharfe
>> ---
>>  setup.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/setup.c b/setup.c
>> index cefd5f6..c57582b 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -1669,7 +1669,15 @@ const char *resolve_gitdir_gently(const char *su=
spect, int *return_error_code)
>>  /* if any standard file descriptor is missing open it to /dev/null */
>>  void sanitize_stdfds(void)
>>  {
>> -	int fd =3D xopen("/dev/null", O_RDWR);
>> +	int fd;
>
> Aside from the meaningful part of this change, please change this to
> avoid refactoring the "int fd =3D open(...)" part of this.
>
> In your v1 you needed to do that, as we had code between the "int fd"
> and "xopen".
>
> But in your v2 here that code has gone away, but you kept the
> now-unnecessary refactoring.
>
>> +	fd =3D xopen("/dev/null", O_RDONLY);
>> +	if (fd > 0)
>> +		close(fd);
>> +	if (fd > 2)
>> +		return;
>> +
>> +	fd =3D xopen("/dev/null", O_WRONLY);
>>  	while (fd < 2)
>>  		fd =3D xdup(fd);
>>  	if (fd > 2)
>
> I don't really get this, if it's safe under seccomp to open this
> O_RDONLY wasn't it always redundant to use O_WRONLY, and this change
> should just be switching to O_RDONLY?

File descriptor 0 (stdin) should only be read.  FDs 1 and 2 (stdout and
stderr) should only be written to.  The old code called open(2) once for
all three, thus needed O_RDWR.  The new code uses minimal file access
modes.

> If I just make this function "return;" (and do nothing else) I get test
> failures in t6500-gc.sh, which matches the description of 1d999ddd1da
> (daemon/shell: refactor redirection of 0/1/2 from /dev/null,
> 2013-07-16).
>
> This will have the tests pass:
>
> 	diff --git a/setup.c b/setup.c
> 	index cefd5f63c46..8a218961cb1 100644
> 	--- a/setup.c
> 	+++ b/setup.c
> 	@@ -1669,7 +1669,7 @@ const char *resolve_gitdir_gently(const char *sus=
pect, int *return_error_code)
> 	 /* if any standard file descriptor is missing open it to /dev/null */
> 	 void sanitize_stdfds(void)
> 	 {
> 	-	int fd =3D xopen("/dev/null", O_RDWR);
> 	+	int fd =3D xopen("/dev/null", O_RDONLY);
> 	 	while (fd < 2)
> 	 		fd =3D xdup(fd);
> 	 	if (fd > 2)
>
> Now, I'm not saying that's safe, we may just have missing test coverage,
> but if it isn't safe and results in some subtle issue isn't that the
> issue you're going to be exposing here?

No, sanitized fds 1 and 2 must be writable, and the proposed change uses
O_WRONLY for them.

> Another thing that passes tests for me is:
>
> 	diff --git a/common-main.c b/common-main.c
> 	index 0a22861f1ce..7b6059e4ee0 100644
> 	--- a/common-main.c
> 	+++ b/common-main.c
> 	@@ -30,12 +30,6 @@ int main(int argc, const char **argv)
>
> 	 	trace2_initialize_clock();
>
> 	-	/*
> 	-	 * Always open file descriptors 0/1/2 to avoid clobbering files
> 	-	 * in die().  It also avoids messing up when the pipes are dup'ed
> 	-	 * onto stdin/stdout/stderr in the child processes we spawn.
> 	-	 */
> 	-	sanitize_stdfds();
> 	 	restore_sigpipe_to_default();
>
> 	 	git_resolve_executable_dir(argv[0]);
> 	diff --git a/setup.c b/setup.c
> 	index cefd5f63c46..27828f6f076 100644
> 	--- a/setup.c
> 	+++ b/setup.c
> 	@@ -1695,6 +1695,12 @@ int daemonize(void)
> 	 	close(0);
> 	 	close(1);
> 	 	close(2);
> 	+
> 	+	/*
> 	+	 * Always open file descriptors 0/1/2 to avoid clobbering files
> 	+	 * in die().  It also avoids messing up when the pipes are dup'ed
> 	+	 * onto stdin/stdout/stderr in the child processes we spawn.
> 	+	 */
> 	 	sanitize_stdfds();
> 	 	return 0;
> 	 #endif
>
> Which would avoid changing the behavior away from O_RDWR, but mov it to
> daemonize().
>
> Which again, may be horribly broken, I don't know, I'm just noting these
> for discussion, as it seems to me that your proposed change is
> implicitly suggesting that doing some version of of these is safe.

Not sanitizing the standard file descriptors of commands risks the
consequences described in the moved comment.

How could the proposed change lead to one or more of the standard
file descriptors not being sanitized?

Ren=C3=A9

