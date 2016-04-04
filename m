From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] rev-parse: fix --git-common-dir when executed from
 subpath of main tree
Date: Mon, 4 Apr 2016 02:01:04 -0400
Message-ID: <CAPig+cSDMD_MjRVh534YfWeY0E1VykWW08oML9oe7QVuxRC72g@mail.gmail.com>
References: <1459734143-95832-1-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 08:01:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amxZY-0003xc-KE
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 08:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbcDDGBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 02:01:07 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:32854 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbcDDGBF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 02:01:05 -0400
Received: by mail-ig0-f170.google.com with SMTP id ma7so74755384igc.0
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 23:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=LfXBcgbhCQn6vI405xc4cGh9zPjE8XXMTpXW+THTvtM=;
        b=MV0zp3hJhRn3PVvyTWflAyRGipV1BVXccW4FcXkQruf0ypKIVBOA9LSHM5le/r2KfP
         RmO4L3aALK/DDEOc5cJ4nibjjG3M9gVCBRgcRxVq7kNvApHAaY//5mEq6drg8+SFWvaM
         +ofY1T9PEHto5GFU21k9iAC8TvaKjyBXzI8Sc9Z3orr4iL1rM/E/FwV8d4/HRDonIDof
         SKH0TtxBL0ODOPvnYeJv8yv24zoYfkBJClqvfq+oYYZUC2UJW1TyVDtu7k7OgihYjl2W
         jPae2FTVUqw/xi1wtNMcfqI55Lg6d3ktPlLtpya4dGKYiGwM/YAr2iE7A+6gJhoJ+p5p
         wv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=LfXBcgbhCQn6vI405xc4cGh9zPjE8XXMTpXW+THTvtM=;
        b=g7lj42hjfq6OKrpnmuNFtEYmVqvyYqiH0gcowXQW1jBHsWCNSM1LdPIclBNNaKtSR0
         cU+0Ki+14txQCcc6IhFUAorREdkKWtUafJCQTkkxKvMILQ9/RSQjQAbdCu/BPOiRXE7T
         MUU07ndFa1s2oYiQG9VgCdXDjeobHBNaLh09Ozs3Teer0otbENG7Huz60s2wsWRSkWWF
         2MO6xgJtVVlsncIRiHmTPN9XSpULJtaoGno2jKlg1AWVX5Xyh9rZGOYpWj6GfBgZ4hxP
         ezen+BLAIahbQ74VCdv3jRRcb627iXSWdJgFLRfh75iXhra6OAJ8VKDvENgJ1QWK59pd
         Et6g==
X-Gm-Message-State: AD7BkJKwV9w90iiA23iDEmsiJO4l20wRo0k8EfVX7b19ITLpnJxQ/z42U/49qddinRuJwSzvXxtxMJXlhcdU5w==
X-Received: by 10.50.138.8 with SMTP id qm8mr979231igb.17.1459749664735; Sun,
 03 Apr 2016 23:01:04 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Sun, 3 Apr 2016 23:01:04 -0700 (PDT)
In-Reply-To: <1459734143-95832-1-git-send-email-rappazzo@gmail.com>
X-Google-Sender-Auth: zSB4IxmR4kZoQt0_e47IK6mxMdI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290678>

On Sun, Apr 3, 2016 at 9:42 PM, Michael Rappazzo <rappazzo@gmail.com> wrote:
> Executing `git-rev-parse --git-common-dir` from the root of the main
> worktree results in '.git', which is the relative path to the git dir.
> When executed from a subpath of the main tree it returned somthing like:

s/returned/returns/
s/somthing/something/

It would be clearer if you stated explicitly that the subpath result
is incorrect. For instance:

    When executed from a subdirectory of the main tree,
    however, it incorrectly returns:

More below...

> 'sub/path/.git'.  Change this to return the proper relative path to the
> git directory (similar to `--show-cdup`).
>
> Add as test to t1500-rev-parse.sh for this case and adjust another test
> in t2027-worktree-list.sh to use this expectation.
>
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> @@ -787,8 +787,18 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>                         if (!strcmp(arg, "--git-common-dir")) {
> -                               const char *pfx = prefix ? prefix : "";
> -                               puts(prefix_filename(pfx, strlen(pfx), get_git_common_dir()));
> +                               const char *git_common_dir = get_git_common_dir();
> +                               if (prefix && !is_absolute_path(git_common_dir)) {
> +                                       const char *pfx = prefix;
> +                                       while (pfx) {
> +                                               pfx = strchr(pfx, '/');
> +                                               if (pfx) {
> +                                                       pfx++;
> +                                                       printf("../");
> +                                               }
> +                                       }
> +                               }
> +                               printf("%s\n", git_common_dir);

How about simplifying this entire chunk of code to?

    struct strbuf sb = STRBUF_INIT;
    puts(relative_path(get_git_common_dir(), prefix, &sb));
    strbuf_release(&sb);

No need to check NULL prefix or absolute common dir.

>                                 continue;
>                         }
> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> @@ -3,6 +3,16 @@
>  test_description='test git rev-parse'
>  . ./test-lib.sh
>
> +test_expect_success 'git-common-dir inside sub-dir' '
> +   (

Strange indentation. Use TAB rather than spaces.

> +               mkdir -p path/to/child &&

Nit: Although functionally the same, typically 'mkdir' is outside the subshell.

> +               cd path/to/child &&
> +               echo "$(git rev-parse --show-cdup).git" >expect &&
> +               git rev-parse --git-common-dir >actual &&
> +               test_cmp expect actual
> +       )
> +'

I guess you added this new test to the top of the script rather than
the bottom (as is more customary) because this script is ancient and
cd's all around the place with wild abandon and leaks environment
variables; thus you avoided having to prefix this new test with:

    cd .. || exit 1
    sane_unset GIT_DIR GIT_CONFIG

which would have been needed had it been added to at the bottom of the script.

It probably wouldn't hurt to add tests to also verify correct behavior
at the root of the main tree, as well as at the root and within a
subdirectory of a linked worktree (though the latter two tests would
probably go in a worktree-related test script).

Thanks.
