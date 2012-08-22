From: Brandon Casey <drafnel@gmail.com>
Subject: Re: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 11:24:34 -0700
Message-ID: <CA+sFfMdNmT5+sVdiRsWyBYNUwF+nkPcAiBswGsTjp3Yr4yZLUQ@mail.gmail.com>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de>
	<CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com>
	<004701cd771e$21b7cbb0$65276310$@schmitz-digital.de>
	<CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com>
	<01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de>
	<7v628epzia.fsf@alter.siamese.dyndns.org>
	<000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de>
	<7vy5l9lj6m.fsf@alter.siamese.dyndns.org>
	<001801cd7eee$24f95a50$6eec0ef0$@schmitz-digital.de>
	<7v4nnxld24.fsf@alter.siamese.dyndns.org>
	<002a01cd8083$69fb9960$3df2cc20$@schmitz-digital.de>
	<CA+sFfMdnixrUekh40Sde05tkap7Oj19=5D6J6aYVVD1krqPZkw@mail.gmail.com>
	<503519B3.1020403@kdbg.org>
	<CA+sFfMedWVAgqvHS67V6L=ROjdN6M3p3pYTUDk98xgozX4djEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	rsbecker@nexbridge.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Aug 22 20:24:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Fbe-0008Io-G6
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 20:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933227Ab2HVSYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 14:24:37 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:36270 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933220Ab2HVSYf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 14:24:35 -0400
Received: by vcbfk26 with SMTP id fk26so1362943vcb.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 11:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=N18jJIei19fW9x0QPLCqFRNtjexWk/v/fPkaYV49hwM=;
        b=wxIKS6wUBJ0QynW/ZMG4h1ON0Xn+P0BT07dF/BUtpA25MbLFNuCNUGBTdfzUskKelo
         KeCiLk5QDDG3xvFQ+/NiJ0NRq6hcI+JaXoDQB7v5JePz2o0vDmvcQKc6rxXxRbVQywRX
         e0k4xOt+qPFEzgQIZwHKAPjSR+cnCYacD2T7qrwKiqemWJvK6jlQ1u9KFiChravN4wUU
         BRT48KEwnbIRnHWC9oTdHkTpX0XqDcrztIIOc9o/Kduy/98YT/wwLtdgWDb+E9NUEbKZ
         how5vT0AkAu0d183U2OgFeR6SvdY9d6pqR3iIxgjZJ7sPd6mDHf0kLo7tC8a8I/rBlSg
         RGTQ==
Received: by 10.58.33.234 with SMTP id u10mr18680123vei.49.1345659874969; Wed,
 22 Aug 2012 11:24:34 -0700 (PDT)
Received: by 10.58.29.233 with HTTP; Wed, 22 Aug 2012 11:24:34 -0700 (PDT)
In-Reply-To: <CA+sFfMedWVAgqvHS67V6L=ROjdN6M3p3pYTUDk98xgozX4djEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204060>

On Wed, Aug 22, 2012 at 11:09 AM, Brandon Casey <drafnel@gmail.com> wrote:
> On Wed, Aug 22, 2012 at 10:41 AM, Johannes Sixt <j6t@kdbg.org> wrote:

>> Don't use x* wrappers in the compat layer, at least not those that
>> allocate memory: They behave unpredictably due to try_to_free_routine
>> and may lead to recursive invocations.
>
> I thought that rule only applied to die handlers.  i.e. don't use the
> x* wrappers to allocate memory in a die handler like
> compat/win32/syslog.c.  At least that's what I wrote in 040a6551 when
> you pointed out this issue back then.
>
> Admittedly, it could get pretty sticky trying to trace the die
> handlers to ensure they don't invoke your new compat/ function.  So,
> yeah, adopting this rule of not using x* wrappers that allocate memory
> in compat/ generally seems like a good idea.
>
> Should we also try to detect recursive invocation of die and friends?
> In theory recursion could be triggered by any die handler that makes
> use of a code path that calls an x* wrapper that allocates memory,
> couldn't it?

Perhaps something like:

diff --git a/usage.c b/usage.c
index a2a6678..2d0ff35 100644
--- a/usage.c
+++ b/usage.c
@@ -80,8 +80,15 @@ void NORETURN usage(const char *err)

 void NORETURN die(const char *err, ...)
 {
+       static int dying;
        va_list params;

+       if (dying) {
+               fputs("fatal: recursion detected in die handler\n", stderr);
+               exit(128);
+       }
+       dying = 1;
+
        va_start(params, err);
        die_routine(err, params);
        va_end(params);
@@ -89,11 +96,18 @@ void NORETURN die(const char *err, ...)

 void NORETURN die_errno(const char *fmt, ...)
 {
+       static int dying;
        va_list params;
        char fmt_with_err[1024];
        char str_error[256], *err;
        int i, j;

+       if (dying) {
+               fputs("fatal: recursion detected in die handler\n", stderr);
+               exit(128);
+       }
+       dying = 1;
+
        err = strerror(errno);
        for (i = j = 0; err[i] && j < sizeof(str_error) - 1; ) {
                if ((str_error[j++] = err[i++]) != '%')

-Brandon
