Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDDFE20281
	for <e@80x24.org>; Fri, 15 Sep 2017 21:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751549AbdIOV2e (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 17:28:34 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:49620 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbdIOV2d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 17:28:33 -0400
Received: by mail-it0-f54.google.com with SMTP id w204so3959316itc.4
        for <git@vger.kernel.org>; Fri, 15 Sep 2017 14:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iFz5pv0yzMz2g0G+DoEsiOx5mkl9IioYxwx5DZ69Lq8=;
        b=J1LJp33dxzahfuGMpH7oXg85WCuWutU6lvcnA24NNRiaBgk1ELOxlhBjlty4f1h9l/
         zCXyDX3SSbzzHGLUt2oNsv5KLNgDyLWKwWsBzI7uWo07yiRt1HRQLMyyIhNbkmB6KEIv
         /MTpnhSQd6BRuJTjKjRN0SJNLbhyuefg+lxeRfMifowemoD+KE9rdBhv8FKVoxUoNd8t
         bmZ72qndcK3d43ALVh/EnyzArqGzh+5NCaQJy4BMGCSc2CM08QlOuzXvm6s6FfV1bvtJ
         vI8w70Q16LSRcYrfuNY5ytr7qvYI6SD3A/B/v7C5icbBGuOCUvpacvFTWY3JCMfVthLs
         Kq2A==
X-Gm-Message-State: AHPjjUisQc+152RWemw5HTtmkXEuvIxirvJvqq/71pWgy5T4Ogj67Z1c
        hjMrovrpGUV1p5d0Md/gXcJr/ITmyztxISZ0kTbGZlp28qU=
X-Google-Smtp-Source: AOwi7QCt6XFWz4m3RkHDaT4dj9PNdkVDSFNTP0YzI+dB9PIZZtmjIfSMdcMvG+MIgk15FzgljMummJK+UUYdVkjYs6U=
X-Received: by 10.36.201.196 with SMTP id h187mr6463349itg.42.1505510912984;
 Fri, 15 Sep 2017 14:28:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.166.140 with HTTP; Fri, 15 Sep 2017 14:28:12 -0700 (PDT)
In-Reply-To: <20170915175248.GT27425@aiede.mtv.corp.google.com>
References: <20170915170818.27390-1-jason@redhat.com> <20170915175248.GT27425@aiede.mtv.corp.google.com>
From:   Jason Merrill <jason@redhat.com>
Date:   Fri, 15 Sep 2017 17:28:12 -0400
Message-ID: <CADzB+2mxyXcROYx72tac8cUxBMxi=ZxUNQYxpUR1CZ43e-j9gA@mail.gmail.com>
Subject: Re: [PATCH] Fix merge parent checking with svn.pushmergeinfo.
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Aldy Hernandez <aldyh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2017 at 1:52 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Jason Merrill wrote:
>
>> Subject: Fix merge parent checking with svn.pushmergeinfo.
>>
>> Without this fix, svn dcommit of a merge with svn.pushmergeinfo set would
>> get error messages like "merge parent <X> for <Y> is on branch
>> svn+ssh://gcc.gnu.org/svn/gcc/trunk, which is not under the git-svn root
>> svn+ssh://jason@gcc.gnu.org/svn/gcc!"
>>
>> * git-svn.perl: Remove username from rooturl before comparing to branchurl.
>>
>> Signed-off-by: Jason Merrill <jason@redhat.com>
>
> Interesting.  Thanks for writing it.

Thanks for the review.

> Could there be a test for this to make sure this doesn't regress in
> the future?  See t/t9151-svn-mergeinfo.sh for some examples.

Hmm, I'm afraid figuring out how to write such a test would take
longer than I can really spare for this issue.  There don't seem to be
any svn+ssh tests currently.

> Nit: git doesn't use GNU-style changelogs, preferring to let the code
> speak for itself.  Maybe it would work better as the subject line?
> E.g. something like
>
>         git-svn: remove username from root before comparing to branch URL
>
>         Without this fix, ...
>
>         Signed-off-by: ...

How about this?

    git-svn: Fix svn.pushmergeinfo handling of svn+ssh usernames.

    Previously, svn dcommit of a merge with svn.pushmergeinfo set would
    get error messages like "merge parent <X> for <Y> is on branch
    svn+ssh://gcc.gnu.org/svn/gcc/trunk, which is not under the git-svn root
    svn+ssh://jason@gcc.gnu.org/svn/gcc!"

    So, let's call remove_username (as we do for svn info) before comparing
    rooturl to branchurl.

>> ---
>>  git-svn.perl | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/git-svn.perl b/git-svn.perl
>> index fa42364785..1663612b1c 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -931,6 +931,7 @@ sub cmd_dcommit {
>>               # information from different SVN repos, and paths
>>               # which are not underneath this repository root.
>>               my $rooturl = $gs->repos_root;
>> +             Git::SVN::remove_username ($rooturl);
>
> style nit: Git doesn't include a space between function names and
> their argument list.

Fixed.

> I wonder if it would make sense to rename the $rooturl variable
> since now it is not the unmodified root. E.g. how about
>
>                 my $expect_url = $gs->repos_root;
>                 Git::SVN::remove_username($expect_url);
>                 ...
>
>>               foreach my $d (@$linear_refs) {
>>                       my %parentshash;
>>                       read_commit_parents(\%parentshash, $d);

It isn't the unmodified root, but it is the effective root that is
printed by svn info and used in branch URLs in git-svn-id, so it seems
to me that the name $rooturl is still appropriate.

> The rest looks good.
>
> Thanks and hope that helps,
> Jonathan
