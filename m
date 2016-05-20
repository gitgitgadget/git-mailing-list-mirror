From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v6 3/3] bisect--helper: `write_terms` shell function in C
Date: Fri, 20 May 2016 13:12:01 +0530
Message-ID: <CAFZEwPPp+CWpnW-RMz5aYsgYDfdVVSZqCCXQQp0z=uC5QE140g@mail.gmail.com>
References: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-4-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cS=zcSVLwARZ5A8hdiE0wqgYPU2Jwnr0OcjDXZFO--cZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 20 09:42:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3f4T-00076I-60
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 09:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719AbcETHmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 03:42:04 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36621 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbcETHmD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 03:42:03 -0400
Received: by mail-yw0-f196.google.com with SMTP id u62so13695876ywe.3
        for <git@vger.kernel.org>; Fri, 20 May 2016 00:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=lgOi0OCAx+XsKEQjMkESCcljrjoVxb1NYX7qi3pX31g=;
        b=F1TeURkPw6DvkQSzvEgD/xh0FSnAG5Z32/UtaTR2H2nh5vveBO7jE+/q8NYbViW3zB
         nk+6VO6PDu3/zYGHc3YTuVF7T5xEttYd4Q88q71xcy9ECP5JNbJixGzvXC4rlYVQU4xF
         0w7nazqvYAX/fNf2BeQWQKUi8shBnZLRBDXp09J0rU/2HN+3K7K7ukBPvVXO14xUyeVk
         SzB3ijAbzEpsgb082m9cwLt9vNuDWzMUh+TjbyTN/+SvrzcRClJr7nETYF/1tB7oFF9b
         T3gZSbWGNVRfLzpsDHbCJolT7MMPd+MZPd+VnNieXuB2pvt+JQBcs8nl7eCUEtDtJiwu
         APJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=lgOi0OCAx+XsKEQjMkESCcljrjoVxb1NYX7qi3pX31g=;
        b=DxWnbv9kXspnPQnbzIeoaHSxkMjp5Vd8VVIep/GaFpSuBvafDGGvi+vjQPxYnG4GoE
         JT2PhxxLz61d+x3QYPw3RiNbvSO1RWJUCEtDP2BM+CW7TlI+j9nh36LVJjjG0MSnVPA+
         w8LpQVYhTHMoBjI4pn7ek2DKc/sORdO7diI9ZmmZ2jJ2bi74W4cXqydCPHGS7i6LM9SU
         0a0drN7vqHbp005TN/7R5l44KqQpiogg1+Psn21NmkQrs7imGf8PG6tiICLUUDRepJML
         wJAilhfZl+NMvzx6qZtTt5dYbmiTnE+NsDUX0BeTVjIAMXLI8GEZQ8j8RbGconxJ38SS
         ufRg==
X-Gm-Message-State: AOPr4FXmRSBFdOep9BJmPLTl+Oo7U+uswkBrQ9ZWnHtlASUxIJrkOPk5mhSSyU+Zc5Hki1UKtzTJBTHWmr+Wpw==
X-Received: by 10.37.44.131 with SMTP id s125mr856108ybs.21.1463730121753;
 Fri, 20 May 2016 00:42:01 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Fri, 20 May 2016 00:42:01 -0700 (PDT)
In-Reply-To: <CAPig+cS=zcSVLwARZ5A8hdiE0wqgYPU2Jwnr0OcjDXZFO--cZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295155>

Hey Eric,

On Mon, May 16, 2016 at 12:58 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, May 12, 2016 at 1:32 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Reimplement the `write_terms` shell function in C and add a `write-terms`
>> subcommand to `git bisect--helper` to call it from git-bisect.sh . Also
>> remove the subcommand `--check-term-format` as it can now be called from
>> inside the function write_terms() C implementation.
>>
>> Using `--write-terms` subcommand is a temporary measure to port shell
>> function to C so as to use the existing test suite. As more functions
>> are ported, this subcommand will be retired and will be called by some
>> other method.
>>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> @@ -56,18 +56,41 @@ static int check_term_format(const char *term, const char *orig_term)
>> +int write_terms(const char *bad, const char *good)
>
> s/^/static/

Sure. Will include this in re-roll.

>> +{
>> +       struct strbuf content = STRBUF_INIT;
>> +       FILE *fp;
>> +       int res;
>> +
>> +       if (!strcmp(bad, good))
>> +               return error(_("please use two different terms"));
>> +
>> +       if (check_term_format(bad, "bad") || check_term_format(good, "good"))
>> +               return -1;
>> +
>> +       strbuf_addf(&content, "%s\n%s\n", bad, good);
>
> What's the point of the strbuf when you could more easily emit this
> same content directly to the file via:
>
>     fprintf(fp, "%s\n%s\n", bad, good);

fprintf seems way better and it is also extensively used in git's
source code. Will update.

>> +       fp = fopen(".git/BISECT_TERMS", "w");
>
> Hardcoding ".git/" is wrong for a variety of reasons: It won't be
> correct with linked worktrees, or when GIT_DIR is pointing elsewhere,
> or when ".git" is a symbolic link, etc. Check out the get_git_dir(),
> get_git_common_dir(), etc. functions in cache.h instead.
>
>> +       if (!fp){
>
> Style: space before '{'

Sorry. Might have missed this. Will include this in re-roll

>> +               strbuf_release(&content);
>> +               die_errno(_("could not open the file to read terms"));
>
> "read terms"? I thought this was writing.

Ya. It should be "write terms".

> Is dying here correct? I thought we established previously that you
> should be reporting failure via normal -1 return value rather than
> dying. Indeed, you're doing so below when strbuf_write() fails.

I was confused about this. I thought not able to open a file is an
exceptional situation (because it has never happened with me) and thus
I used die(). I will use error() as further justified by Johannes.

>> +       }
>> +       res = strbuf_write(&content, fp);
>> +       fclose(fp);
>> +       strbuf_release(&content);
>> +       return (res < 0) ? -1 : 0;
>> +}
>>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>
> Style: insert blank line between functions

Sure.

Regards,
Pranit Bauva
