From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/3] submodule clone: pass along `local` option
Date: Mon, 25 Apr 2016 10:15:50 -0700
Message-ID: <CAGZ79kZ-jszUtk4R+nWidmjGBFwAwymgr+nzghGSyUVqx=Y5-Q@mail.gmail.com>
References: <1460504929-19208-1-git-send-email-sbeller@google.com>
	<1460504929-19208-2-git-send-email-sbeller@google.com>
	<65302315-2C33-4801-887C-9AF3CB2F6BB6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 19:15:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auk72-0002Zl-Mn
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 19:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932927AbcDYRPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 13:15:52 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:34568 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932130AbcDYRPv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 13:15:51 -0400
Received: by mail-io0-f169.google.com with SMTP id 2so190728564ioy.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 10:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=EkDJyGpTIVjZNssag4hJNTX+2sAWb/L0snWO7qdAnJs=;
        b=Y1K79SKuCXzAORC+j2CgasfTTym6QPjjsJjdhfS3Vd0t8hj9Z2Fatf574r6/fJcV39
         ETybrgzUKj1g2qamxx+sZQJF43R7/AtYz0PFhhsEvgaGN9YX1IDulphg1eAMOSPJYOsQ
         MXaz7tflSeMl01XktE1819ak/uAeR4BVjDXdc2BRNLeWYYNDNVFPOXwbmE+bV463t7sB
         BH1BKfyjNMls3ANul288sqr08+8BI6wuSFgZ1KD8L+BPnuKiIBorWyLIjT1V6Ri09aCQ
         ZUc2DDVPCZxtzOzZwIBxNijhTIgWvHNIjq/hS6FI44zA00yT9lYpRGLaz1xvaaW4awTI
         N6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=EkDJyGpTIVjZNssag4hJNTX+2sAWb/L0snWO7qdAnJs=;
        b=WXHTEkI9EUTNrvhpsfCvkNHnfMCdVReAnDG5sKXnpVsxqe4UsnPRTgxblnt0XugX5A
         UlmayCwE1LXLS0rxBKH0//QHvzCfJOkQsf+7Tiwr+nCp8QqDWHYNCJHTfSie1TXAiol3
         BzpvR4WT5fJsYBFQBDD5HR8NzWWeoCUbVZ7UBeqb3jg4dyTMDb0Sx43slEzuzKdcCJJW
         /4ayqvsBUvoCd5pTyCbMigayRpx/3ol8p5ML0xJd5G+eS1DOv1EDh/wVECF1ed1iZeRW
         72AVkvCY/nvm7qcrtD2SyPPxpnQtBsEEZA2JOwXaNbUg/RnpzWqn88LlJPA2TZ/GjvBG
         5ifA==
X-Gm-Message-State: AOPr4FW1xwoAO5BS4eYl6zDhAA+ExPpXt6xF7dKCbDmgfRr6pED4eqJNpRxMJA12khJqG0lpmrv3YDk4FpUgP7zS
X-Received: by 10.107.161.68 with SMTP id k65mr45192588ioe.110.1461604550412;
 Mon, 25 Apr 2016 10:15:50 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 25 Apr 2016 10:15:50 -0700 (PDT)
In-Reply-To: <65302315-2C33-4801-887C-9AF3CB2F6BB6@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292527>

On Mon, Apr 25, 2016 at 5:18 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>> @@ -140,6 +141,10 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
>>               argv_array_pushl(&cp.args, "--reference", reference, NULL);
>>       if (gitdir && *gitdir)
>>               argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
>> +     if (local == 1)
> bikeshedding: Why do you use == 1 here and !local below? I would either compare both against
> integers or none ("if (local)" should work here, too, no?). Or is this a Git coding guideline
> that I am not yet aware of?

"if (local)" doesn't work as it includes -1 as well.
What I want to express here is:

    switch (local) {
    case 1: argv_array_push(&cp.args, "--local"); break; /* local == 1
did that */
    case 0: argv_array_push(&cp.args, "--no-local"); break; /* !local*/
    case -1: default: /* pass nothing */
    }

This seems to be more expressive now, so I'll replace with that?

>> @@ -180,6 +186,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>>               OPT_STRING(0, "depth", &depth,
>>                          N_("string"),
>>                          N_("depth for shallow clones")),
>> +             OPT_BOOL(0, "local", &local,
>> +                      N_("to clone from a local repository")),
> TBH I think "local" could be misleading here. How about "--pass-transfer-protocol-on-to-submodules"
> or something? If I understand this option correctly then this could be useful for other cases besides
> "local". Imagine you clone a repo via HTTPS that has references to SSH submodules on the same
> server. If you don't have a proper SSH setup then the submodule clone will fail.

Good point. We just converted an internal repository to use relative
path for submodules instead of
absolute paths and that broke the auth (they used different protocols,
which we were unaware of)

However  "--pass-transfer-protocol-on-to-submodules" would mean more
than just "--[no-]local,
but also passing on the protocol prefix (which can be http://,
https://, ssh://, git:// or more),
so it would enlarge the scope of this series a lot. (Original purpose
of this patch was to allow
not using the explicit file:// protocol in the test for the next
patch. But I see passing on the protocol
as a new issue worth resolving :)
