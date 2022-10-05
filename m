Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3FEC433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 15:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJEPnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 11:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiJEPnO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 11:43:14 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11DC2E9D4
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 08:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1664984585; bh=BAphlbo+XQHvtEjsROqp8wUwaQy7I56vbhTO9ABprKM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=enp/F2cihfDaz1MnUkxhTbz7E2j1XH2+7P2/bSVsBlRIYlbVttxLPAJ/r537MNqOS
         2BZO92YXZnEO49ro1Iq0LqjqdfIbNeghu5iEHdHM5FuTzDO6IYF/uZ+JGe/NWpjds3
         CQYEmkH5tPdDK+bN2IBVap6F1/DZKgphmlVi7NKEZWgJMMvYlO/s6MhQFFurUrg7h/
         QJD8FV/4UglJLqXrkGkmacp7ayLhPO6ZhCUS3XVPfQ/JFl5EtMlQC9fYaSMWgfdKVe
         nhwqjWL0ldehQFM+DFW9JEDvt/6DRf7esnSK7nl3v6qaLvvKjidVkaKDRvipXkiH2o
         A6EjQxZHTVmkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.26.45]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MpTxm-1oyeaz2gLE-00q01R; Wed, 05
 Oct 2022 17:43:05 +0200
Message-ID: <04d393cc-d8c7-ddf7-b235-12082f81c560@web.de>
Date:   Wed, 5 Oct 2022 17:43:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Subject: Re: PATCH] bisect--helper: plug strvec leak in bisect_start()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <5c6a4c30-d454-51b6-ec57-9af036b9c4e0@web.de>
 <221005.8635c2u3k5.gmgdl@evledraar.gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221005.8635c2u3k5.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y+ONX1Arjn50qbGCOh0lBiJbgrLZhV11kJtQwX1EL/IR4OptRjD
 7LMtn7TlxZxXHPqPINWwWdLdQ5d92WBUNM7T17eHILPMEJPplEJRbaoOIxHbR7dff+9Ew/r
 eliETCCHsUgEjSFcM4ZQPRyHYQhUCJqYpX9w4IvW5eYNJyqN1HOYqCqrKKDo2u63nweXehK
 KA4S4nl1CdqyXUvA0AGBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iEUuOuDygW8=:oQviaA13lgDBQWQ/KCNbOB
 cObNXFMZdCB1DrT6lidTMEndbWdVQz1OQUs2dUBge5vrVwzq/0dnYwEF92bnT22OjbaPdsThi
 up6pGwwvuRNjGE4zvyDtcU1H8FOTaipPcRWn3nmuWh1u6JQtzAw7CRQX4B0dYCK3bIzggL9uS
 dnEQ37wMAcxMYM86nh6LjMDTSlGSKpYMYzaQGgKRZVS7VZYEiRvaGdNyZ5g+NQPHrkI2pqUWA
 GusaNSHrrXX3biS7slWsbWOYU5smXdFawvsiOjtfdANXZi196OuruZ5e+D8T6AzzEom4ADO1y
 73oc6pWlJ0YKiG0LbaFz2ulrTP9857EVOQBAdnkwwddqOLAig0PSmHU+kffkdWpfjeUGCYPaB
 5KRiWIKcswzbdO8scx21O/+2OHF5faIPd/CPrZa5A/kYaigX+qRw6bZBVojgIvKtbIAeRnXO4
 wJi06AstA0ASZJE0+Rqc4LIgLZgKF08xtAOmG+1+gz7rMlPjU8AUlfMO7QZjJMCXjPQpkuLjy
 9cbRTJLeiv+WiePPbxhVgqIo4kU793EUYVMz+gpbWtxdDZ0Mp0YVxpG0OeYjKVghr8J3wz1V/
 +MlNI/Qm8zrJXtLdcZHtTMpA6JqKOGaIkDn3sLxyMob/cS/E9e/oA+VhKf5yb7EJfbvD1qEz3
 Ke2kugj44CDt0XyOizgyfhBmGSR9QMYp85TMSS54a+mj+MT2tGxQRkElSdCLrLmQubZ5CK8Zu
 ebnj00gNmsksL6A5TnkPJkHwSnpBB3I+t1UBE7XbrvngUXBISk98wdsWwFh7fCrcJqYa3HU3l
 vLzCOXz39bnBKSNA4Zl27nd4MAnV31NkebpvMb0mk52IrnOvv/PPauVz2fSxluyHlDhalTNz+
 3zsIARMEjBGfHdpcURreVn8vsSna1hHGBLl0Wk2//QJGR2eabSc+ImLCxWGuCDVpmU4idju3R
 KHtkdL1XyWqT++/ztJyM35TpuSZcu5AtZZ3gUtNTCU7g5jqhLNJnrZ1jSch55IxxdDUN/Jj9+
 ukSeVs8V7ukGc3mdVJj2UjCfXzflLlvrLtc61AeC8gnDbTWxpThivunMhc8J5uaGoroccsIVc
 nlocc24dPQTF9dbeEO/R6dkdvQuF7dJv+tkuUx4E/7w3KXzHgXPwZ/Bd48xlFPGzfMW20f+tO
 gVYU6G/DcM5PVS01BpjeF+2R/mwJzxk+qybQKxApjAeN1nS6q6m0UCQuLilQgbkNi29RRTccp
 jxvC5xXYOPVfBPCyg1CqnybkaLGI8KdUDgkqKYWkqIRGOwVFwFYzmdW+tQ4TV6xjQAYdtXB2q
 IldZwn23rSabCzZMBsTq1Hpy06MKpLALgayWu0KxrQ0Uu6XiKcYugkCdYGoknRP3+XYGzjy70
 4ZfOxtvBkl46zBe3ObBzo43rxlADirgbc/lzheB4wjndC+O5POyi/e00lfVY3qBUQI/GnfWQZ
 5nRw8DPvqiLKerROGwkTwkEwib7ivB4tzhIvvvzqA89oRX7Nzy/x879IQsENaYySkpBhWhMKv
 rpwmUR2oTkZ+kPchEWZkexeg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.10.22 um 09:29 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Tue, Oct 04 2022, Ren=C3=A9 Scharfe wrote:
>
>> The strvec "argv" is used to build a command for run_command_v_opt(),
>> but never freed.  Use the "args" strvec of struct child_process and
>> run_command() instead, which releases the allocated memory both on
>> success and on error.  We just also need to set the "git_cmd" bit
>> directly.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  builtin/bisect--helper.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index 501245fac9..9fe0c08479 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
>> @@ -765,11 +765,12 @@ static enum bisect_error bisect_start(struct bise=
ct_terms *terms, const char **a
>>  		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
>>  		strbuf_trim(&start_head);
>>  		if (!no_checkout) {
>> -			struct strvec argv =3D STRVEC_INIT;
>> +			struct child_process cmd =3D CHILD_PROCESS_INIT;
>>
>> -			strvec_pushl(&argv, "checkout", start_head.buf,
>> +			cmd.git_cmd =3D 1;
>> +			strvec_pushl(&cmd.args, "checkout", start_head.buf,
>>  				     "--", NULL);
>> -			if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
>> +			if (run_command(&cmd)) {
>>  				res =3D error(_("checking out '%s' failed."
>>  						 " Try 'git bisect start "
>>  						 "<valid-branch>'."),
>
> Okey, so we leak the strvec, and instead of adding a strvec_clear()
> you're just switching the lower-level API, which we'd need in some cases
> with this API, and would often be cleaner.
>
> But I don't get it in this case, why not just:
>
> 	diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> 	index 4e97817fba5..f9645a9d0df 100644
> 	--- a/builtin/bisect--helper.c
> 	+++ b/builtin/bisect--helper.c
> 	@@ -763,11 +763,9 @@ static enum bisect_error bisect_start(struct bisec=
t_terms *terms, const char **a
> 	 		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
> 	 		strbuf_trim(&start_head);
> 	 		if (!no_checkout) {
> 	-			struct strvec argv =3D STRVEC_INIT;
> 	+			const char *argv[] =3D { "checkout", start_head.buf, "--", NULL };
>
> 	-			strvec_pushl(&argv, "checkout", start_head.buf,
> 	-				     "--", NULL);
> 	-			if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
> 	+			if (run_command_v_opt(argv, RUN_GIT_CMD)) {
> 	 				res =3D error(_("checking out '%s' failed."
> 	 						 " Try 'git bisect start "
> 	 						 "<valid-branch>'."),

That looks even better.  I didn't think of that because we had a phase
where we could only use constant expressions for initialization.  We do
have a precedent in 359f0d754a (range-diff/format-patch: handle commit
ranges other than A..B, 2021-02-05), though, which does use a variable:

+       char *copy =3D xstrdup(arg); /* setup_revisions() modifies it */
+       const char *argv[] =3D { "", copy, "--", NULL };

(There may be earlier ones, that's just the one I found quickly.) So is
it time for that C99 feature already?  Yay! =F0=9F=A5=B3

> The common pattern for run_command_v_opt() callers that don't need a
> dynamic list is exactly that, e.g.:
>
> 	builtin/difftool.c=3Dstatic int print_tool_help(void)
> 	builtin/difftool.c-{
> 	builtin/difftool.c-     const char *argv[] =3D { "mergetool", "--tool-h=
elp=3Ddiff", NULL };
> 	builtin/difftool.c:     return run_command_v_opt(argv, RUN_GIT_CMD);
> 	builtin/difftool.c-}
>
> And:
>
> 	fsmonitor-ipc.c=3Dstatic int spawn_daemon(void)
> 	fsmonitor-ipc.c-{
> 	fsmonitor-ipc.c-        const char *args[] =3D { "fsmonitor--daemon", "=
start", NULL };
> 	fsmonitor-ipc.c-
> 	fsmonitor-ipc.c:        return run_command_v_opt_tr2(args, RUN_COMMAND_=
NO_STDIN | RUN_GIT_CMD,
> 	fsmonitor-ipc.c-                                    "fsmonitor");
> 	fsmonitor-ipc.c-}
>
> Here we have the "start_head" which we'll need to strbuf_release(), but
> we're not returning directly, and the function is doing that already.
>
> Your version is slightly more memory efficient, i.e. we'll end up having
> to push this to a "struct child_process"'s argv anyway, but this is less
> code & we don't need to carefully eyeball run_command_v_opt_cd_env_tr2()
> to see that it's correct (which I did, your version does the right thing
> too).

Having two ways to set the same flags adds some unnecessary friction.

Ren=C3=A9
