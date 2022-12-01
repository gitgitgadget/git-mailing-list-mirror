Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD62C4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 19:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiLATCC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 14:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiLATCA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 14:02:00 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D2CC23F4
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 11:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669921308; bh=Fm70v5O5in7uMXD8BdYEuXP+Fga0njGT6rzdMyaKXBA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=jzX4YnYeEy4KFfUXLEhqCumM7MIg9KzIHIQxCXLYXAcp5aFfb5fWDjQaRKAlvqddX
         72m80ukf3MyPKHYbIk5dCQ0jnN9AxHzaF7nWlHVYc/sM6fBF9yxfdKOy8wIo2jYZ2d
         1EiNgvUuEFX+ZAmo5fK+CKcsQ4IUhbYWNdnZymg5QRswTgq3aigbLvOPx0gx20a4QV
         Zk/i4n/KXd5a1Asejfp3f8AEtDFKM8RVG7qJCNYcHdRZ7K0R4Y4uy7Qbh4JQ63zO1w
         W13S4CuHDRtIIy5lwnEIoiGCNn61P2C7ARcNvWyDxyAf1tfQiofbOSyZAceroPPxJS
         vLmsFkfnpaKXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.34] ([91.47.154.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOUtg-1pMAug19ws-00QMMB; Thu, 01
 Dec 2022 20:01:48 +0100
Message-ID: <572e29a2-3f19-e946-d152-009999651084@web.de>
Date:   Thu, 1 Dec 2022 20:01:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 0/3] diff: build parseopts array on demand
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
References: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
 <ea838ae7-b635-d4d2-d9df-e96b3d8980af@web.de>
 <221201.86r0xjgicc.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221201.86r0xjgicc.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z61T0yCBlEKKOMP6s918bebfDg0xBg35GyMj+OxL1FTxFSFSBLp
 xu+y/MJFzEakD6mRIN6/ggHp2vWClYwajMjLTktOmW0DtkOYxNlhI5HWiEuBADyV2JW0UCH
 MiCNeCNSIGzVnkxKEnDtpShiKALWyTq6/LiQQxmWKaMjlvSV8N5AF6X58RzTOUkW5xOh6ne
 cyxPmPeBewjrm+p7XGDCw==
UI-OutboundReport: notjunk:1;M01:P0:kiYPVZiPOYc=;5Xm5IWAImbDF/0yf/6GD4QZmwAN
 WHSanEQ481NPlcwH3dI+UPNh2xuR6gTDMcyu9o81PPp/kjYLW9qhN6kVMIo0OYqr7N83IxtyD
 kfpC2Oz9gmlTUImlQ0zvJx86AgnO8Sd5/6xQ52BzFZ5JNW6JcpIX+dy2usjAbyda+Aubrcvkt
 PkUZeGbgR/UQS681/kgMR3Uh7eg0BwqrQuPVhC9YCIIVnlKxtWucS0IKPCPdogl7E9mHFI1Ud
 EAjqHAqxxtkd5vqd3yZQHc6kCG3CDxyA+edEwNj+WVGI2sOZGTm04Wt5ZXMpfir9cn4FrUwkg
 +TeXTFkXafGcqQSHDdKFd2ZnoSUAtwFbyZg2t+rclwQz39wfGxKnuwSylCyOXVYvSqyvbYs8k
 iyJYSAoBTWWaiwkYHffIwvUEEkAMrdqavpFwrrZmOmKt1OTENXlha3WFqxEcanyyevQhipqe1
 hSNmKbyP/fv57QD9DYsZngnNI9oh8SksFLymaJOkQmL1+0lLGL8pRAz4h2bjFiHz6D8V2u53l
 disBpNAktkYD4f9wtpSavt+sFTRrGQo4CKIJcpTtr/zKnWqVjd671/Qd08WExB/C65V5PkrDg
 NPbFZAnQ1YtRjqFhSFpDwWkVeqlmUKLqdlsngtY7RY6sTwoc5/RnwGwPpkC2YDOwqXE1HKWs2
 ykXHCBXVamK+022IpVz4jfXjbUaWcFCI1c3XJsvtbWLhtnFrWIpBos8lyNOf1giCHFTBCFWkf
 DjhTsDPo6naYyb2ujV0CHOwvu1VM7RHlsOxLrigtpxryLcelo4UZiiT0yF8nuVcVk0qqwHh7T
 p80cGNgVDkar97L3ibU3CPoBtMMHiV1CUTi1TauuSo6TEo72kbalkkQpYcBDjssKym1ts3NXX
 zw70SwvOCsc9ZUbfe0vZxbpEjqd/rTyabvkVqz94VxNh1VrcOA01p0HyA1byZK6/VE5LNHrjZ
 290tbXqm3KSATKZ29slHRk5/Zpc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.12.2022 um 17:54 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Thu, Dec 01 2022, Ren=C3=A9 Scharfe wrote:
>
>> Calling repo_init_revisions() and release_revisions() in that order
>> leaks the memory allocated for the parseopts array in the embedded
>> struct diff_options member.  Get rid of that leak by reducing the
>> lifetime of that array.
>>
>> Original patch:
>> https://lore.kernel.org/git/4fd82dc6-e0f8-0638-5b10-16bfef39a171@web.de=
/
>>
>> Submitted separately from that thread because it's independent enough.
>>
>> Change since v1:
>> - Actually remove the parseopts member.  Its removal got lost during
>>   refactoring in v1.  Thank you for spotting that, Junio!
>>
>>   diff: factor out add_diff_options()
>>   diff: let prep_parse_options() return parseopt array
>>   diff: remove parseopts member from struct diff_options
>>
>>  builtin/range-diff.c |  2 +-
>>  diff-no-index.c      |  3 +--
>>  diff.c               | 26 +++++++++++++++-----------
>>  diff.h               |  2 +-
>>  4 files changed, 18 insertions(+), 15 deletions(-)
>>
>> Range-Diff gegen v1:
>> 1:  630f95320f =3D 1:  4dc8b2632b diff: factor out add_diff_options()
>> 2:  4b56fa795c =3D 2:  10903d355e diff: let prep_parse_options() return=
 parseopt array
>> 3:  7e54e4370a ! 3:  24bd18ae79 diff: remove parseopts member from stru=
ct diff_options
>>     @@ diff.c: void diff_free(struct diff_options *options)
>>       }
>>
>>       void diff_flush(struct diff_options *options)
>>     +
>>     + ## diff.h ##
>>     +@@ diff.h: struct diff_options {
>>     + 	unsigned color_moved_ws_handling;
>>     +
>>     + 	struct repository *repo;
>>     +-	struct option *parseopts;
>>     + 	struct strmap *additional_path_headers;
>>     +
>>     + 	int no_free;
>
> This looks good to me. Would you mind running the tests with:
>
> 	GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck GIT_TEST_SANITIZE_LEAK_LOG=3Dtru=
e make SANITIZE=3Dleak
>
> And then marking up the ones that now pass with
> TEST_PASSES_SANITIZE_LEAK=3Dtrue. I think it's all except one of these
> (one isn't marked on "master", I forget which one):
>
> 	Test Summary Report
> 	-------------------
> 	t1022-read-tree-partial-clone.sh                 (Wstat: 256 Tests: 1 F=
ailed: 0)
> 	  Non-zero exit status: 1
> 	t2012-checkout-last.sh                           (Wstat: 256 Tests: 22 =
Failed: 0)
> 	  Non-zero exit status: 1
> 	t3210-pack-refs.sh                               (Wstat: 256 Tests: 30 =
Failed: 0)
> 	  Non-zero exit status: 1
> 	t4053-diff-no-index.sh                           (Wstat: 256 Tests: 19 =
Failed: 0)
> 	  Non-zero exit status: 1
> 	t5554-noop-fetch-negotiator.sh                   (Wstat: 256 Tests: 1 F=
ailed: 0)
> 	  Non-zero exit status: 1
> 	t5613-info-alternate.sh                          (Wstat: 256 Tests: 13 =
Failed: 0)
> 	  Non-zero exit status: 1
> 	t6021-rev-list-exclude-hidden.sh                 (Wstat: 256 Tests: 42 =
Failed: 0)
> 	  Non-zero exit status: 1
> 	t6415-merge-dir-to-symlink.sh                    (Wstat: 256 Tests: 24 =
Failed: 0)
> 	  Non-zero exit status: 1
> 	t7403-submodule-sync.sh                          (Wstat: 256 Tests: 18 =
Failed: 0)
> 	  Non-zero exit status: 1
> 	t7504-commit-msg-hook.sh                         (Wstat: 256 Tests: 30 =
Failed: 0)
> 	  Non-zero exit status: 1
> 	t9115-git-svn-dcommit-funky-renames.sh           (Wstat: 256 Tests: 12 =
Failed: 0)
> 	  Non-zero exit status: 1
> 	t9146-git-svn-empty-dirs.sh                      (Wstat: 256 Tests: 14 =
Failed: 0)
> 	  Non-zero exit status: 1
> 	t9160-git-svn-preserve-empty-dirs.sh             (Wstat: 256 Tests: 12 =
Failed: 0)
> 	  Non-zero exit status: 1
>
> I.e. this makes a lot more tests pass leak-free, yay!

With -rc1 (i.e. without this series) I get:

t1022-read-tree-partial-clone.sh                 (Wstat: 256 Tests: 1 Fail=
ed: 0)
  Non-zero exit status: 1
t2016-checkout-patch.sh                          (Wstat: 256 Tests: 16 Fai=
led: 0)
  Non-zero exit status: 1
t2012-checkout-last.sh                           (Wstat: 256 Tests: 22 Fai=
led: 0)
  Non-zero exit status: 1
t4023-diff-rename-typechange.sh                  (Wstat: 256 Tests: 4 Fail=
ed: 0)
  Non-zero exit status: 1
t4053-diff-no-index.sh                           (Wstat: 256 Tests: 19 Fai=
led: 0)
  Non-zero exit status: 1
t4058-diff-duplicates.sh                         (Wstat: 256 Tests: 16 Fai=
led: 0)
  Non-zero exit status: 1
t4205-log-pretty-formats.sh                      (Wstat: 256 Tests: 21 Fai=
led: 0)
  Non-zero exit status: 1
  Parse errors: No plan found in TAP output
t5406-remote-rejects.sh                          (Wstat: 256 Tests: 3 Fail=
ed: 0)
  Non-zero exit status: 1
t5507-remote-environment.sh                      (Wstat: 256 Tests: 5 Fail=
ed: 0)
  Non-zero exit status: 1
t5554-noop-fetch-negotiator.sh                   (Wstat: 256 Tests: 1 Fail=
ed: 0)
  Non-zero exit status: 1
t6001-rev-list-graft.sh                          (Wstat: 256 Tests: 14 Fai=
led: 0)
  Non-zero exit status: 1
t6021-rev-list-exclude-hidden.sh                 (Wstat: 256 Tests: 42 Fai=
led: 0)
  Non-zero exit status: 1
t6401-merge-criss-cross.sh                       (Wstat: 256 Tests: 4 Fail=
ed: 0)
  Non-zero exit status: 1
t6407-merge-binary.sh                            (Wstat: 256 Tests: 3 Fail=
ed: 0)
  Non-zero exit status: 1
t6415-merge-dir-to-symlink.sh                    (Wstat: 256 Tests: 24 Fai=
led: 0)
  Non-zero exit status: 1
t7006-pager.sh                                   (Wstat: 256 Tests: 109 Fa=
iled: 0)
  Non-zero exit status: 1
t7008-filter-branch-null-sha1.sh                 (Wstat: 256 Tests: 6 Fail=
ed: 0)
  Non-zero exit status: 1
t7504-commit-msg-hook.sh                         (Wstat: 256 Tests: 30 Fai=
led: 0)
  Non-zero exit status: 1
t7517-per-repo-email.sh                          (Wstat: 256 Tests: 16 Fai=
led: 0)
  Non-zero exit status: 1
t7605-merge-resolve.sh                           (Wstat: 256 Tests: 4 Fail=
ed: 0)
  Non-zero exit status: 1

There is some overlap with your results, but also several differences.
I wonder why so many more tests appear to be leak-free for me.  I used
Debian clang version 11.0.1-2.

In any case it seems we need to update the marks before we can
attribute which tests are made leak-free by any new patches.

The TAP error in t4205-log-pretty-formats.sh is fixed by the following
patch, but I can't explain it:

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index e448ef2928..0404491d6e 100755
=2D-- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -156,7 +156,7 @@ test_expect_success 'NUL termination with --reflog --p=
retty=3Doneline' '
 	for r in $revs
 	do
 		git show -s --pretty=3Doneline "$r" >raw &&
-		cat raw | lf_to_nul || exit 1
+		cat raw | lf_to_nul || return 1
 	done >expect &&
 	# the trailing NUL is already produced so we do not need to
 	# output another one

> To nitpick a bit: I didn't find that splitting this up into three
> patches helped to read it, e.g. 2/3 adds code that promptly goes away in
> 3/3.
>
> I also wondered why add two API functions for this, instead of just
> teaching the "prep options" to concat passed-in options with the user
> options?

Only add_diff_options() is exported.

get_diff_parseopts() is more flexible than a function that concatenates.
Callers can choose the order, or not concatenate at all.

An inter-diff would have been nice.  Let's see if I can find the
relevant parts.

> That also avoids a parse_options_dup(). I.e. with that squashed
> in the whole thing is:
>
>  builtin/range-diff.c |  2 +-
>  diff-no-index.c      |  3 +--
>  diff.c               | 19 ++++++++-----------
>  diff.h               |  3 ++-
>  4 files changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> index e2a74efb42a..8fcd6663b89 100644
> --- a/builtin/range-diff.c
> +++ b/builtin/range-diff.c
> @@ -47,7 +47,7 @@ int cmd_range_diff(int argc, const char **argv, const =
char *prefix)
>
>  	repo_diff_setup(the_repository, &diffopt);
>
> -	options =3D parse_options_concat(range_diff_options, diffopt.parseopts=
);
> +	options =3D add_diff_parseopts(range_diff_options, &diffopt);
>  	argc =3D parse_options(argc, argv, prefix, options,
>  			     builtin_range_diff_usage, PARSE_OPT_KEEP_DASHDASH);
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 18edbdf4b59..efac1d38b38 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -255,8 +255,7 @@ int diff_no_index(struct rev_info *revs,
>  	};
>  	struct option *options;
>
> -	options =3D parse_options_concat(no_index_options,
> -				       revs->diffopt.parseopts);
> +	options =3D add_diff_parseopts(no_index_options, &revs->diffopt);
>  	argc =3D parse_options(argc, argv, revs->prefix, options,
>  			     diff_no_index_usage, 0);
>  	if (argc !=3D 2) {
> diff --git a/diff.c b/diff.c
> index 1054a4b7329..e186fc91802 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4615,8 +4615,6 @@ static void run_checkdiff(struct diff_filepair *p,=
 struct diff_options *o)
>  	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
>  }
>
> -static void prep_parse_options(struct diff_options *options);
> -
>  void repo_diff_setup(struct repository *r, struct diff_options *options=
)
>  {
>  	memcpy(options, &default_diff_options, sizeof(*options));
> @@ -4662,8 +4660,6 @@ void repo_diff_setup(struct repository *r, struct =
diff_options *options)
>
>  	options->color_moved =3D diff_color_moved_default;
>  	options->color_moved_ws_handling =3D diff_color_moved_ws_default;
> -
> -	prep_parse_options(options);
>  }
>
>  static const char diff_status_letters[] =3D {
> @@ -4821,8 +4817,6 @@ void diff_setup_done(struct diff_options *options)
>  			options->filter =3D ~filter_bit[DIFF_STATUS_FILTER_AON];
>  		options->filter &=3D ~options->filter_not;
>  	}
> -
> -	FREE_AND_NULL(options->parseopts);
>  }
>
>  int parse_long_opt(const char *opt, const char **argv,
> @@ -5419,7 +5413,8 @@ static int diff_opt_rotate_to(const struct option =
*opt, const char *arg, int uns
>  	return 0;
>  }
>
> -static void prep_parse_options(struct diff_options *options)
> +struct option *add_diff_parseopts(struct option *useropts,
> +				  struct diff_options *options)

You rename add_diff_options() to add_diff_parseopts().  OK.

>  {
>  	struct option parseopts[] =3D {
>  		OPT_GROUP(N_("Diff output format options")),
> @@ -5689,22 +5684,25 @@ static void prep_parse_options(struct diff_optio=
ns *options)
>  		OPT_END()
>  	};
>
> -	ALLOC_ARRAY(options->parseopts, ARRAY_SIZE(parseopts));
> -	memcpy(options->parseopts, parseopts, sizeof(parseopts));
> +	return parse_options_concat(useropts, parseopts);

You bring back the concatenate from my demo patch.

>  }
>
>  int diff_opt_parse(struct diff_options *options,
>  		   const char **av, int ac, const char *prefix)
>  {
> +	struct option no_options[] =3D { OPT_END() };
> +	struct option *diff_parseopts =3D add_diff_parseopts(no_options, optio=
ns);

This kinda open-codes parse_options_dup().  The reduced flexibility of
the concatenating variant is easily worked around here and it avoids the
need for slightly awkward manual concatenation.

Well, the get_diff_parseopts() variant feels cleaner, but baking the
concat in is simpler overall.

> +
>  	if (!prefix)
>  		prefix =3D "";
>
> -	ac =3D parse_options(ac, av, prefix, options->parseopts, NULL,
> +	ac =3D parse_options(ac, av, prefix, diff_parseopts, NULL,
>  			   PARSE_OPT_KEEP_DASHDASH |
>  			   PARSE_OPT_KEEP_UNKNOWN_OPT |
>  			   PARSE_OPT_NO_INTERNAL_HELP |
>  			   PARSE_OPT_ONE_SHOT |
>  			   PARSE_OPT_STOP_AT_NON_OPTION);
> +	free(diff_parseopts);
>
>  	return ac;
>  }
> @@ -6513,7 +6511,6 @@ void diff_free(struct diff_options *options)
>  	diff_free_file(options);
>  	diff_free_ignore_regex(options);
>  	clear_pathspec(&options->pathspec);
> -	FREE_AND_NULL(options->parseopts);
>  }
>
>  void diff_flush(struct diff_options *options)
> diff --git a/diff.h b/diff.h
> index fd33caeb25d..56704d3de22 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -394,7 +394,6 @@ struct diff_options {
>  	unsigned color_moved_ws_handling;
>
>  	struct repository *repo;
> -	struct option *parseopts;
>  	struct strmap *additional_path_headers;
>
>  	int no_free;
> @@ -539,6 +538,8 @@ int git_diff_ui_config(const char *var, const char *=
value, void *cb);
>  #define diff_setup(diffopts) repo_diff_setup(the_repository, diffopts)
>  #endif
>  void repo_diff_setup(struct repository *, struct diff_options *);
> +struct option *add_diff_parseopts(struct option *useropts,
> +				  struct diff_options *options);
>  int diff_opt_parse(struct diff_options *, const char **, int, const cha=
r *);
>  void diff_setup_done(struct diff_options *);
>  int git_config_rename(const char *var, const char *value);

