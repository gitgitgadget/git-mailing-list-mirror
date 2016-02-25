From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2] git: submodule honor -c credential.* from command line
Date: Wed, 24 Feb 2016 22:23:28 -0800
Message-ID: <CA+P7+xpfuPkwcdeXVTiTdqRCX16J4pus-wmxe7Sipu_GXCNSoA@mail.gmail.com>
References: <1456358352-28939-1-git-send-email-jacob.e.keller@intel.com> <20160225014149.GA31616@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 25 07:23:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYpL7-0002uD-9a
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 07:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757180AbcBYGXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 01:23:50 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:33659 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847AbcBYGXt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 01:23:49 -0500
Received: by mail-io0-f175.google.com with SMTP id z135so79217734iof.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 22:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DEco/UDVn27TEI54VxkeaJISlf9xq9y0kUQZuHEX9So=;
        b=xnKT8Sg3tktRfMsnMMp8qfvZwkctbRMUaF2dl5CzsRpe+uzgHvS/SyghWpTzwdCqst
         Rfqe0S5mwKB56m0wVrKxJUw8DPXHDh36CV2x8cQ8dXqIhI6js4pGe6xxolHrnbSrRjdc
         h3QXm5hBJ2Hy89Y/FS7WXin04xtaLKeH3mSFKhvAeeA77SRcQqiIsb7Is2yX9z/J7puD
         VJzhMjFD3EEqx6OgR8gCIsWgvfy+B8NCs2c5XTYPiHeZ880wFkSPjAbUpKJZQmZLGv3r
         WXB00rM7fiHQhFmIIzd+IMhAujTBWSZWoM9BXIks1CUQIqs6uW6yya2ul3GMvWrOnKX2
         E2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DEco/UDVn27TEI54VxkeaJISlf9xq9y0kUQZuHEX9So=;
        b=YdPz5G8jPI5DdyPcT1JEchQ/Q2W9TQj0INQTMconEypfPRXcIc/lLK31+FwU+bfXdS
         bMqkKuHV6uXUXzTY7PCbY7YpQzkdWKYEKGVVJKHUyngqaWCpgE9RhisySJAQcfDXY1nS
         CRjRM7lbpW+WwBu8Vr/Iim6Loksj1zOgf4DK1Ze8vSJniuvIqqFNMnuoU9OSQH3R+Qs0
         ZCYsf4Umiz22QX8ug6bgQux3ZZGDggrWSLiYxrE46Qati1JYnnmHyC7DmzDV9RUoXCoi
         NmXbGo+cCmoDULtecy2TwSSJEKdUaAdSZc2rncymaeLcI0E4/Q49xQtTnAGLsibFeeX7
         vA9Q==
X-Gm-Message-State: AG10YOQcDUFpeDGk92BfYXS0HIuwBjvIC7fAl6CEwPZc9jLXUjzW9offmeV3+qb/8vJAlL/VC8bmRru6/hoG6g==
X-Received: by 10.107.170.79 with SMTP id t76mr1755511ioe.71.1456381428250;
 Wed, 24 Feb 2016 22:23:48 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Wed, 24 Feb 2016 22:23:28 -0800 (PST)
In-Reply-To: <20160225014149.GA31616@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287334>

On Wed, Feb 24, 2016 at 5:41 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 24, 2016 at 03:59:12PM -0800, Jacob Keller wrote:
>
>> +int sanitize_submodule_config(const char *var, const char *value, void *data)
>> +{
>> +     struct strbuf quoted = STRBUF_INIT;
>> +     struct strbuf *out = data;
>> +
>> +     if (submodule_config_ok(var)) {
>> +             if (out->len)
>> +                     strbuf_addch(out, ' ');
>> +
>> +             /* combined all the values before we quote them */
>> +             strbuf_addstr(&quoted, var);
>> +             strbuf_addch(&quoted, '=');
>> +             strbuf_addstr(&quoted, value);
>> +
>> +             /* safely quote them for shell use */
>> +             sq_quote_buf(out, quoted.buf);
>> +     }
>> +     return 0;
>> +}
>
> This leaks "quoted", doesn't it?
>

Yes this was an oversight. Will fix it.

> I was confused by the "combine all the values" comment. We just have
> _one_ config key/value here, right (I had thought originally that you
> were putting multiple keys into a single sq-quoted string, which would be
> wrong)?
>

Hah, that would be confusing. The comment will be dropped in v3.

>> +static int module_sanitize_config(int argc, const char **argv, const char *prefix)
>> +{
>> +     struct strbuf sanitized_config = STRBUF_INIT;
>> +
>> +     struct option module_sanitize_config_options[] = {
>> +             OPT_END()
>> +     };
>> +
>> +     const char *const git_submodule_helper_usage[] = {
>> +             N_("git submodule--helper sanitize-config"),
>> +             NULL
>> +     };
>> +
>> +     argc = parse_options(argc, argv, prefix, module_sanitize_config_options,
>> +                          git_submodule_helper_usage, 0);
>> +
>> +     git_config_from_parameters(sanitize_submodule_config, &sanitized_config);
>> +     if (sanitized_config.len)
>> +             printf("%s\n", sanitized_config.buf);
>> +
>> +     return 0;
>> +}
>
> The empty option list looked funny to me for a minute, but I guess you
> use it to complain about:
>
>   git submodule--helper sanitize-config --foo
>
> Should we also warn about:
>
>   git submodule--helper sanitize-config foo
>
> I think you could catch both with just:
>
>   if (argc > 1)
>         usage(...);
>
> (though I do not mind the empty option list staying in that case, as it
> provides the necessary boilerplate for later).
>

I don't think there will be a later, but I didn't think to check argc,
since a few other submodule--helpers fail to check it. I will clean
this out, and possibly provide a second patch which cleans up the
other case(s?) of missed argc checks as well. I think it was only the
submodule--helper list subcommand, but I don't recall right now.

>> +# Sanitize the local git environment for use within a submodule. We
>> +# can't simply use clear_local_git_env since we want to preserve some
>> +# of the settings from GIT_CONFIG_PARAMETERS.
>> +sanitize_local_git_env()
>> +{
>> +     local sanitized_config = $(git submodule--helper sanitize-config)
>> +     clear_local_git_env
>> +     GIT_CONFIG_PARAMETERS=$sanitized_config
>> +}
>
> Do we need to export GIT_CONFIG_PARAMETERS? I guess not; if it is
> already exported, we don't need, and if it isn't, then by definition
> $sanitized_config will be empty.
>

How does modifying an exported variable work?

> The name of this function isn't very descriptive (it's easy to see what
> it does from the implementation, but in the callers, it's unclear what
> the difference between "clear" and "sanitize" is). Should it maybe be
> "sanitize_submodule_env" or something to make it clear that this is
> about passing through things for child submodules?
>
> Probably not that big a deal as its local to this script

Wouldn't hurt, I was trying to come up with a good name as well, but I
like sanitize_submodule_env better.

>
>> diff --git a/t/t7412-submodule--helper.sh b/t/t7412-submodule--helper.sh
>> new file mode 100755
>> index 000000000000..376f58afe967
>> --- /dev/null
>> +++ b/t/t7412-submodule--helper.sh
>
> In the long run I think we want to kill off submodule--helper, as it's
> just an implementation detail until git-submodule is all in C. I do not
> mind these tests in the meantime, as they can act as unit tests. But it
> would be nice to also (or instead, if you like) test the actual
> user-visible effects. Otherwise, once git-submodule turns into C, these
> behaviors are likely to end up completely untested (and it's during that
> conversion that you you're most likely to run into regressions!).
>
> -Peff

I 100% agree. I think the test file is useful for now, and there are
(currently) no other tests for submodule--helper, so I'd like to get
them all confined to this test. I think we need a real way to test the
change here, but I think figuring out how to test the
credential.helper is a bit outside the scope of what i had time for
today. I can try to find some cycles to check out tomorrow. You
mentioned we'd need a test in the same idea as one of the http clone
tests? I don't know where to start with something like this though.

Regards,
Jake
