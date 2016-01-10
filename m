From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] format-patch: introduce format.outputDirectory configuration
Date: Sat, 9 Jan 2016 22:47:26 -0500
Message-ID: <CAPig+cQ9kObgd5-OGRZH-YuZVnBX72ukS=kKD8OfTN51dQ0SRA@mail.gmail.com>
References: <CAPig+cTOG7QP25TyJbbm70NBXN6Z0nZPJyjxFp1y147WQmKEDg@mail.gmail.com>
	<1452393019-2852-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Alexander Kuleshov <kuleshovmail@gmail.com>
To: "Stephen P. Smith" <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Sun Jan 10 04:47:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aI6yb-0006vF-UT
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jan 2016 04:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756778AbcAJDr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2016 22:47:28 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36834 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756765AbcAJDr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2016 22:47:27 -0500
Received: by mail-vk0-f65.google.com with SMTP id e64so1336980vkg.3
        for <git@vger.kernel.org>; Sat, 09 Jan 2016 19:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Vmi1ypzaw0wTObQtbgqbcbXwwQVUv+lQHx/vGyvYvys=;
        b=Xtg6M9FI/kY4J1C3bxln4zSca6r57WmIU9CrMbiPDYuMmE62NFCLKuPEpIZpjN61QL
         D5uZQoRay73mmywTUVR61SKwqSbJxXT6MAHS29QH/cJKa1GG7y5n4mzlocrnuRppFMFp
         nMiCYUM0/SkUbIgrmt2s6T8PviHYtsrDM3M55u/lXmqtE5sEHi6vyY3PoT5hgeSxEgK0
         kYairfl6MoJXhazC8acWh9g9l4L/sz1wbgD9KY+7zY8HDHJlmllBDwQrvhR16H3Fpqyf
         uhQxeDOU3BFwFjJWMo5lACYEoaqYk+fxBzD/Sc6hjKR/mL1hCJhNh/uy/KsjfEUgW+EP
         EeEQ==
X-Received: by 10.31.47.130 with SMTP id v124mr83284595vkv.117.1452397646508;
 Sat, 09 Jan 2016 19:47:26 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 9 Jan 2016 19:47:26 -0800 (PST)
In-Reply-To: <1452393019-2852-1-git-send-email-ischis2@cox.net>
X-Google-Sender-Auth: gnVsNqOUVSyQYcFSjRvMtwD3zCg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283613>

Thanks for reviving this abandoned patch. Please see review comments
below, some of which repeat comments from the previous attempt[1], and
some of which are new. Most of the new ones are minor, although there
is at least one major problem.

On Sat, Jan 9, 2016 at 9:30 PM, Stephen P. Smith <ischis2@cox.net> wrote:
> From: Alexander Kuleshov <kuleshovmail@gmail.com>
>
> We can pass -o/--output-directory to the format-patch command to
> store patches not in the working directory. This patch introduces

s/not in/in some place other than/

> format.outputDirectory configuration option for same purpose.
>
> The case of usage of this configuration option can be convinience

>From [1]: s/convinience/convenience/

> to not pass everytime -o/--output-directory if an user has pattern

Also[1]: s/everytime/every time/
or: s/everytime/each time/

> to store all patches in the /patches directory for example.
>
> The format.outputDirectory has lower priority than command line
> option, so if user will set format.outputDirectory and pass the
> command line option, a result will be stored in a directory that
> passed to command line option.
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> Signed-off-by: Stephen P. Smith <ischis2@cox.net>

[1]: http://article.gmane.org/gmane.comp.version-control.git/272199

> ---
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> @@ -57,7 +57,11 @@ The names of the output files are printed to standard
>  output, unless the `--stdout` option is specified.
>
>  If `-o` is specified, output files are created in <dir>.  Otherwise
> -they are created in the current working directory.
> +they are created in the current working directory. The default path
> +can be set with the setting 'format.outputDirectory' configuration option.

s/setting//

> +If `-o` is specified and 'format.outputDirectory' is set, output files
> +will be stored in a <dir> that passed to `-o`. When 'format.outputDirectory'
> +is set, to get default behaviour back is to pass './' to the `-o`.

This is difficult to read. How about replacing these two sentences
with something like this:

    The `-o` option takes precedence over `format.outputDirectory`.
    To store patches in the current working directory even when
    `format.outputDirectory` points elsewhere, use `-o .`.

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> @@ -40,6 +40,19 @@ test_expect_success setup '

Rather than adding new tests at the very top of the script, it's more
common to add them to the bottom or at least to insert them after
other similar tests.

> +test_expect_success "format-patch format.outputDirectory option" '

Use single- rather than double-quotes: s/"/'/

> +       test_config format.outputDirectory "patches/" &&

We can drop the unnecessary quotes around "patches".
Also, can we drop the unnecessary "/"?

> +       git format-patch master..side &&

Since this test is about verifying that the "patches" directory got
created and used, you want to be more careful about ensuring that
detritus from preceding tests won't muck up your results; for
instance, if an earlier test had also used a directory named "patches"
and had dumped 42 files there instead of the 3 expected by this test.
Therefore, you should insert "rm -fr patches &&" before the
git-format-patch invocation.

> +       cnt=$(ls patches | wc -l) &&
> +       test $cnt = 3

Periodically, we have trouble with the output of "wc -l" on Mac OS X
since the output has leading spaces. This code doesn't trip over that
problem since it doesn't quote the output, but it still feels fragile
to be comparing the it against a number using the string equality test
'='. How about using the '-eq' numeric equality test instead?

Moreover, there is no need for the temporary 'cnt' variable. Instead:

    test $(ls patches | wc -l) -eq 3 &&

Depending upon taste, you might alternately use:

    ls patches >actual &&
    test_line_count = 3 actual

which would give you more useful debugging output upon failure.

> +'
> +
> +test_expect_success "format-patch format.outputDirectory overwritten with -o" '

Use single- rather than double-qoutes: s/"/'/
Also, how about rewording it?

    'format-patch -o overrides format.outputDirectory'

> +       test_config format.outputDirectory "patches/" &&

Style: drop unnecessary quotes around "patches"
Style: drop unnecessary "/"

> +       git format-patch master..side -o "." &&

Style: drop unnecessary quotes around "."

> +       test_path_is_missing patches/

Style: drop unnecessary "/"

There is a rather severe problem with this test in that it fails
unconditionally. It wants to verify that -o takes precedence over
format.outputDirectory by checking that the directory "patches" did
not get created by git-format-patch, however, that directory already
exists since it was created by the previous test, thus
test_path_is_missing() fails. Therefore, you should insert "rm -fr
patches &&" before the git-format-patch invocation.

It also might not hurt to make the test a bit more robust by verifying
not only that the directory specified by format.outputDirectory did
not get created, but that the directory named by -o did get created,
which means giving -o an argument other than ".". So, the final test
might look like this:

    test_config format.outputDirectory patches &&
    rm -fr patches patchset &&
    git format-patch master..side -o patchset &&
    test_path_is_missing patches &&
    test_path_is_dir patchset

> +'
> --
> 2.7.0-rc2
