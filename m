Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90495C636CC
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 15:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjBTPdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 10:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjBTPdH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 10:33:07 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5175B7EF6
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 07:32:55 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d5so925823qtn.13
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 07:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676907174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gF8Rnl2iLIhdutTgdSeT7YV/IhqrhRkdEol7jvce9Nk=;
        b=nOlhONX0YtvNdwOLrWUdYwTzf8xC1POJ+QzzXhcSLojvXb/gc1leJhpWXlIpFhIGiW
         2Ct2I1lxo58lNpVwYj02uFNGaXmR5Bw6Br5HT5y80dKbI7t8NkP2+SfzwF5O6KXXQlp+
         QNTnkp/f8kK4oaXLI//eqn1aJ4Haf8DYilgjaCak4+8nos2zb1ivlEc1m9lGTK78s2oH
         CyVRvEGwEA//Km43yEDGcCBExQVlIGFYFTY08S66G06oItW8Z6VeeogpieNsn/kh2Z1+
         oLpmRxddSP7WLb591LZoYaTFwdAsRPDtubEa/JDx9aY07od2ZEF5dpuMYUFn0heksvzK
         nFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676907174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gF8Rnl2iLIhdutTgdSeT7YV/IhqrhRkdEol7jvce9Nk=;
        b=EJ6xsijRnmilHmwfzvx6bzRB8/ZTJ/UGaYNgxjLyhogTtllhDZpGqOg3cUJjHkJDAL
         gA/2HUdB7mXKnoOjdvPIm1RApEly7XhAqSvwL9hd8akYToCLg+hwYUwnRhGH24C57xIV
         FspQazRFg9FO9T1wIVtCDdChBLcht0GVx6c7Q3IMkZGaji25ljwYog8Hmzhr3kCjsxvB
         myN121x0uC1OwHG1iB5qSBxVRb7VcvCMVWxPF4hQ1dHk2T/APDn0XypeuvZeT47iyhL4
         7VB2eG37y/lQEnbyhiNGXDJ6iRbKpshqgSoWwlFlt+KGw0tG7zRjDlqoraizUJE7aOOn
         bKPw==
X-Gm-Message-State: AO0yUKVfUv4KXdZLpmESSSLdI8Jc62rLBbugY9cPhiPHQJez1rAZh6W/
        s/8hubdugFGlu8LQxRIhdQY=
X-Google-Smtp-Source: AK7set+UCrTTGmyokmYS3f12JED1707E1XzYI0rIef7OIlUtY1niMWf74AX0Oqgyk+p1kgYKpLndmw==
X-Received: by 2002:a05:622a:118f:b0:39c:da22:47b8 with SMTP id m15-20020a05622a118f00b0039cda2247b8mr3655228qtk.1.1676907173974;
        Mon, 20 Feb 2023 07:32:53 -0800 (PST)
Received: from [192.168.1.211] ([2600:4041:4542:c100:8905:dad0:53aa:3ab7])
        by smtp.gmail.com with ESMTPSA id a4-20020ac84344000000b003b2957fb45bsm869908qtn.8.2023.02.20.07.32.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Feb 2023 07:32:53 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] diff: teach diff to read algorithm from diff driver
Date:   Mon, 20 Feb 2023 10:32:52 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <EE7565DF-BE70-4C45-AF0B-95C85050DFA4@gmail.com>
In-Reply-To: <CABPp-BFCMpA=nHtb5RuQL7ACbkhSEKtvmRxKwMuktcf24uQJtQ@mail.gmail.com>
References: <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
 <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
 <b330222ce83bdf03c20085ff10fcff8a090474d5.1676665285.git.gitgitgadget@gmail.com>
 <CABPp-BFCMpA=nHtb5RuQL7ACbkhSEKtvmRxKwMuktcf24uQJtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On 17 Feb 2023, at 21:56, Elijah Newren wrote:

> On Fri, Feb 17, 2023 at 12:21 PM John Cai via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: John Cai <johncai86@gmail.com>
>>
>> It can be useful to specify diff algorithms per file type. For example=
,
>> one may want to use the minimal diff algorithm for .json files, anothe=
r
>> for .c files, etc.
>>
>> The diff machinery already checks attributes for a diff driver. Teach
>> the diff driver parser a new type "algorithm" to look for in the
>> config, which will be used if a driver has been specified through the
>> attributes.
>>
>> Enforce precedence of the diff algorithm by favoring the command line
>> option, then looking at the driver attributes & config combination, th=
en
>> finally the diff.algorithm config.
>>
>> To enforce precedence order, use a new `ignore_driver_algorithm` membe=
r
>> during options pasing to indicate the diff algorithm was set via comma=
nd
>> line args.
>
> s/pasing/parsing/

thanks for noticing this!

>
>> Signed-off-by: John Cai <johncai86@gmail.com>
>> ---
>>  Documentation/gitattributes.txt | 37 ++++++++++++++++++++++++++++++++=

>>  diff.c                          | 33 ++++++++++++++++++++--------
>>  diff.h                          |  1 +
>>  t/lib-diff-alternative.sh       | 38 ++++++++++++++++++++++++++++++++=
-
>>  userdiff.c                      |  4 +++-
>>  userdiff.h                      |  1 +
>>  6 files changed, 103 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattrib=
utes.txt
>> index c19e64ea0ef..f212079a131 100644
>> --- a/Documentation/gitattributes.txt
>> +++ b/Documentation/gitattributes.txt
>> @@ -758,6 +758,43 @@ with the above configuration, i.e. `j-c-diff`, wi=
th 7
>>  parameters, just like `GIT_EXTERNAL_DIFF` program is called.
>>  See linkgit:git[1] for details.
>>
>> +Setting the internal diff algorithm
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +The diff algorithm can be set through the `diff.algorithm` config key=
, but
>> +sometimes it may be helpful to set the diff algorithm by path. For ex=
ample, one
>> +might wish to set a diff algorithm automatically for all `.json` file=
s such that
>> +the user would not need to pass in a separate command line `--diff-al=
gorithm`
>> +flag each time.
>> +
>> +First, in `.gitattributes`, assign the `diff` attribute for paths.
>> +
>> +------------------------
>> +*.json diff=3D<name>
>> +------------------------
>> +
>> +Then, define a "diff.<name>.algorithm" configuration to specify the d=
iff
>
> Should there be a link to `git-config` right after "configuration"?
> Otherwise, users may think that they are being told to specify
> additional configuration within the .gitattributes file.
>
>> +algorithm, choosing from `meyers`, `patience`, `minimal`, or `histogr=
am`.
>
> s/meyers/myers/

likewise.

>
>> +
>> +----------------------------------------------------------------
>> +[diff "<name>"]
>> +  algorithm =3D histogram
>> +----------------------------------------------------------------
>
> It's pretty easy to assume the above is meant to be part of the
> .gitattributes file instead of the .git/config file.  Don't most users
> run `git config` commands directly rather than edit the .git/config
> file?  Should we provide a sample command rather than showing what the
> config file will contain?

Not sure--I think I was was just following what I saw in the existing
documentation for driver configuration. But would be interested to see wh=
at
other folks think.

>
>> +
>> +This diff algorithm applies to user facing diff output like git-diff(=
1),
>> +git-show(1) and is used for the `--stat` output as well. The merge ma=
chinery
>> +will not use the diff algorithm set through this method.
>
> Yaay, thanks for including this!
>
>
> I'm still curious if this should this also include warnings/caveats, su=
ch as:
>   * The diff attribute specified in .gitattributes will be ignored in
> a bare clone
>   * The diff attribute specified in .gitattributes will be ignored if
> it is only specified in another branch (e.g. on a branch "special-file
> diff=3Dpatience" recorded in .gitattributes, then checkout master but
> run `git log -1 -p $branch`)
>   * When a file is renamed, the diff attribute for the pre-image name
> is the only one the system pays attention to (thus adding "-R" can
> flip which diff algorithm is run for the renamed file).

I would be fine with adding that--though originally I was thinking that t=
hese
can be inferred from the way that gitattributes are documented in [1]. Ca=
lling
these out would make it more clear though, so I could go either way.

>
> Also, since I tested the three items above to verify they are valid
> warnings, I'm a bit confused.  I thought your intent was to use this
> server-side[1], so isn't the bare clone aspect a deal-breaker for your
> intended usecase?
>
> [1] https://lore.kernel.org/git/7852AC7B-7A4E-4DD0-ADEA-CFFD5D16C595@gm=
ail.com/

yes, indeed. I was planning on adding bare repository support in a separa=
te
patch series, since the additions in [2] allows .gitattributes to be read=
 from a
bare repository.

1. https://git-scm.com/docs/gitattributes
2. https://lore.kernel.org/git/0ca8b2458921fc40269b0c43b5ec86eba77d6b54.1=
673684790.git.karthik.188@gmail.com/

thanks!
John

>
>> +
>> +NOTE: If the `command` key also exists, then Git will treat this as a=
n external
>> +diff and attempt to use the value set for `command` as an external pr=
ogram. For
>> +instance, the following config, combined with the above `.gitattribut=
es` file,
>> +will result in `command` favored over `algorithm`.
>> +
>> +----------------------------------------------------------------
>> +[diff "<name>"]
>> +  command =3D j-c-diff
>> +  algorithm =3D histogram
>> +----------------------------------------------------------------
>>
>>  Defining a custom hunk-header
>>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> diff --git a/diff.c b/diff.c
>> index 5efc22ca06b..04469da6d34 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -4456,15 +4456,13 @@ static void run_diff_cmd(const char *pgm,
>>         const char *xfrm_msg =3D NULL;
>>         int complete_rewrite =3D (p->status =3D=3D DIFF_STATUS_MODIFIE=
D) && p->score;
>>         int must_show_header =3D 0;
>> +       struct userdiff_driver *drv =3D NULL;
>>
>> -
>> -       if (o->flags.allow_external) {
>> -               struct userdiff_driver *drv;
>> -
>> +       if (o->flags.allow_external || !o->ignore_driver_algorithm)
>>                 drv =3D userdiff_find_by_path(o->repo->index, attr_pat=
h);
>> -               if (drv && drv->external)
>> -                       pgm =3D drv->external;
>> -       }
>> +
>> +       if (o->flags.allow_external && drv && drv->external)
>> +               pgm =3D drv->external;
>>
>>         if (msg) {
>>                 /*
>> @@ -4481,12 +4479,16 @@ static void run_diff_cmd(const char *pgm,
>>                 run_external_diff(pgm, name, other, one, two, xfrm_msg=
, o);
>>                 return;
>>         }
>> -       if (one && two)
>> +       if (one && two) {
>> +               if (drv && !o->ignore_driver_algorithm && drv->algorit=
hm)
>> +                       set_diff_algorithm(o, drv->algorithm);
>> +
>>                 builtin_diff(name, other ? other : name,
>>                              one, two, xfrm_msg, must_show_header,
>>                              o, complete_rewrite);
>> -       else
>> +       } else {
>>                 fprintf(o->file, "* Unmerged path %s\n", name);
>> +       }
>>  }
>>
>>  static void diff_fill_oid_info(struct diff_filespec *one, struct inde=
x_state *istate)
>> @@ -4583,6 +4585,14 @@ static void run_diffstat(struct diff_filepair *=
p, struct diff_options *o,
>>         const char *name;
>>         const char *other;
>>
>> +       if (!o->ignore_driver_algorithm) {
>> +               struct userdiff_driver *drv =3D userdiff_find_by_path(=
o->repo->index, p->one->path);
>> +
>> +               if (drv && drv->algorithm) {
>> +                       set_diff_algorithm(o, drv->algorithm);
>> +               }
>> +       }
>> +
>>         if (DIFF_PAIR_UNMERGED(p)) {
>>                 /* unmerged */
>>                 builtin_diffstat(p->one->path, NULL, NULL, NULL,
>> @@ -5130,6 +5140,8 @@ static int diff_opt_diff_algorithm(const struct =
option *opt,
>>                 return error(_("option diff-algorithm accepts \"myers\=
", "
>>                                "\"minimal\", \"patience\" and \"histog=
ram\""));
>>
>> +       options->ignore_driver_algorithm =3D 1;
>> +
>>         return 0;
>>  }
>>
>> @@ -5145,6 +5157,8 @@ static int diff_opt_diff_algorithm_no_arg(const =
struct option *opt,
>>                 BUG("available diff algorithms include \"myers\", "
>>                                "\"minimal\", \"patience\" and \"histog=
ram\"");
>>
>> +       options->ignore_driver_algorithm =3D 1;
>> +
>>         return 0;
>>  }
>>
>> @@ -5285,6 +5299,7 @@ static int diff_opt_patience(const struct option=
 *opt,
>>         for (i =3D 0; i < options->anchors_nr; i++)
>>                 free(options->anchors[i]);
>>         options->anchors_nr =3D 0;
>> +       options->ignore_driver_algorithm =3D 1;
>>
>>         return set_diff_algorithm(options, "patience");
>>  }
>> diff --git a/diff.h b/diff.h
>> index 41eb2c3d428..8d770b1d579 100644
>> --- a/diff.h
>> +++ b/diff.h
>> @@ -333,6 +333,7 @@ struct diff_options {
>>         int prefix_length;
>>         const char *stat_sep;
>>         int xdl_opts;
>> +       int ignore_driver_algorithm;
>>
>>         /* see Documentation/diff-options.txt */
>>         char **anchors;
>> diff --git a/t/lib-diff-alternative.sh b/t/lib-diff-alternative.sh
>> index 8d1e408bb58..2dc02bca873 100644
>> --- a/t/lib-diff-alternative.sh
>> +++ b/t/lib-diff-alternative.sh
>> @@ -105,10 +105,46 @@ index $file1..$file2 100644
>>   }
>>  EOF
>>
>> +       cat >expect_diffstat <<EOF
>> + file1 =3D> file2 | 21 ++++++++++-----------
>> + 1 file changed, 10 insertions(+), 11 deletions(-)
>> +EOF
>> +
>>         STRATEGY=3D$1
>>
>> +       test_expect_success "$STRATEGY diff from attributes" '
>> +               echo "file* diff=3Ddriver" >.gitattributes &&
>> +               git config diff.driver.algorithm "$STRATEGY" &&
>> +               test_must_fail git diff --no-index file1 file2 > outpu=
t &&
>> +               cat expect &&
>> +               cat output &&
>> +               test_cmp expect output
>> +       '
>> +
>> +       test_expect_success "$STRATEGY diff from attributes has valid =
diffstat" '
>> +               echo "file* diff=3Ddriver" >.gitattributes &&
>> +               git config diff.driver.algorithm "$STRATEGY" &&
>> +               test_must_fail git diff --stat --no-index file1 file2 =
> output &&
>> +               test_cmp expect_diffstat output
>> +       '
>> +
>>         test_expect_success "$STRATEGY diff" '
>> -               test_must_fail git diff --no-index "--$STRATEGY" file1=
 file2 > output &&
>> +               test_must_fail git diff --no-index "--diff-algorithm=3D=
$STRATEGY" file1 file2 > output &&
>> +               test_cmp expect output
>> +       '
>> +
>> +       test_expect_success "$STRATEGY diff command line precedence be=
fore attributes" '
>> +               echo "file* diff=3Ddriver" >.gitattributes &&
>> +               git config diff.driver.algorithm meyers &&
>
> Is this misspelling of myers intentional?  I think with the typo, the
> code falls back to the default algorithm, which happens to be myers,
> so I think the test works either way, but were you intending to test
> fallback behavior in case of a typo here, or was that accidental?
>
>
>
>> +               test_must_fail git diff --no-index "--diff-algorithm=3D=
$STRATEGY" file1 file2 > output &&
>> +               test_cmp expect output
>> +       '
>> +
>> +       test_expect_success "$STRATEGY diff attributes precedence befo=
re config" '
>> +               git config diff.algorithm default &&
>> +               echo "file* diff=3Ddriver" >.gitattributes &&
>> +               git config diff.driver.algorithm "$STRATEGY" &&
>> +               test_must_fail git diff --no-index file1 file2 > outpu=
t &&
>>                 test_cmp expect output
>>         '
>>
>> diff --git a/userdiff.c b/userdiff.c
>> index d71b82feb74..ff25cfc4b4c 100644
>> --- a/userdiff.c
>> +++ b/userdiff.c
>> @@ -293,7 +293,7 @@ PATTERNS("scheme",
>>          "|([^][)(}{[ \t])+"),
>>  PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
>>          "\\\\[a-zA-Z@]+|\\\\.|[a-zA-Z0-9\x80-\xff]+"),
>> -{ "default", NULL, -1, { NULL, 0 } },
>> +{ "default", NULL, NULL, -1, { NULL, 0 } },
>>  };
>>  #undef PATTERNS
>>  #undef IPATTERN
>> @@ -394,6 +394,8 @@ int userdiff_config(const char *k, const char *v)
>>                 return parse_bool(&drv->textconv_want_cache, k, v);
>>         if (!strcmp(type, "wordregex"))
>>                 return git_config_string(&drv->word_regex, k, v);
>> +       if (!strcmp(type, "algorithm"))
>> +               return git_config_string(&drv->algorithm, k, v);
>>
>>         return 0;
>>  }
>> diff --git a/userdiff.h b/userdiff.h
>> index aee91bc77e6..24419db6973 100644
>> --- a/userdiff.h
>> +++ b/userdiff.h
>> @@ -14,6 +14,7 @@ struct userdiff_funcname {
>>  struct userdiff_driver {
>>         const char *name;
>>         const char *external;
>> +       const char *algorithm;
>>         int binary;
>>         struct userdiff_funcname funcname;
>>         const char *word_regex;
>> --
>> gitgitgadget
