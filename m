From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 2/3] p7300: add performance tests for clean
Date: Sun, 12 Apr 2015 18:52:57 +0200
Message-ID: <20150412165257.GA5793@hank>
References: <1428770587-9674-1-git-send-email-erik.elfstrom@gmail.com>
 <1428770587-9674-4-git-send-email-erik.elfstrom@gmail.com>
 <20150411175941.GA32735@hank>
 <CAMpP7NZyHBMZ5omT+fPGfkRR56HQPNP3n6cXD7S8voVvqrG6eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: erik@vger.kernel.org,
	=?iso-8859-1?Q?elfstr=F6m_=3Cerik=2Eelfstrom=40gmail=2Ecom=3E?=@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 12 18:53:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhL8E-00053w-Sb
	for gcvg-git-2@plane.gmane.org; Sun, 12 Apr 2015 18:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbbDLQxE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Apr 2015 12:53:04 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35852 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbbDLQxB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2015 12:53:01 -0400
Received: by wizk4 with SMTP id k4so46788913wiz.1
        for <git@vger.kernel.org>; Sun, 12 Apr 2015 09:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0sY/aamhZNnJ7iU9W2Km3Ae/wBOnr+dqIqYSRCPZTaU=;
        b=JxN1w/r4TlzF20seuM+ufwxWlZjMzt/Fw7+RO/o+EGcBCtVGVg/ne8IQiOCS10plor
         9UovC7uqDtHzM5WK19QS7r6GtSlqkUMP8PJk3KAsO/i2nyxquf31Nr1lLiFoh7mvlB1H
         mXs+rfb/zUeAN1dNnyxW8HEWEMDXcf23F1WRwBwGK6axZVvdaBFVh5ItC9HHIAg4+Lz4
         bzYtakmvgjKpgRAoigjUlyOqy2SJxGBP/Ch2c4LBi7akljK89ARJA40K8fiB879OtB9U
         h5/br5kkXMMdffL9jopZfXj2+lxIUr/SN2dQE5NQSrMtEi6LLW8jIkLqKWvoUY7TrdOO
         Bv8w==
X-Received: by 10.194.23.39 with SMTP id j7mr20701098wjf.9.1428857579627;
        Sun, 12 Apr 2015 09:52:59 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id dg8sm7694905wjc.9.2015.04.12.09.52.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2015 09:52:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMpP7NZyHBMZ5omT+fPGfkRR56HQPNP3n6cXD7S8voVvqrG6eg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267052>

On 04/12, erik elfstr=F6m wrote:
> On Sat, Apr 11, 2015 at 7:59 PM, Thomas Gummerer <t.gummerer@gmail.co=
m> wrote:
> > On 04/11, Erik Elfstr=F6m wrote:
> >> Signed-off-by: Erik Elfstr=F6m <erik.elfstrom@gmail.com>
> >> ---
> >>  t/perf/p7300-clean.sh | 37 +++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 37 insertions(+)
> >>  create mode 100755 t/perf/p7300-clean.sh
> >>
> >> diff --git a/t/perf/p7300-clean.sh b/t/perf/p7300-clean.sh
> >> new file mode 100755
> >> index 0000000..af50d5d
> >> --- /dev/null
> >> +++ b/t/perf/p7300-clean.sh
> >> @@ -0,0 +1,37 @@
> >> +#!/bin/sh
> >> +
> >> +test_description=3D"Test git-clean performance"
> >> +
> >> +. ./perf-lib.sh
> >> +
> >> +test_perf_large_repo
> >> +test_checkout_worktree
> >> +
> >> +test_expect_success 'setup untracked directory with many sub dirs=
' '
> >> +     rm -rf 500_sub_dirs 50000_sub_dirs clean_test_dir &&
> >> +     mkdir 500_sub_dirs 50000_sub_dirs clean_test_dir &&
> >> +     for i in $(test_seq 1 500)
> >> +     do
> >> +             mkdir 500_sub_dirs/dir$i || return $?
> >> +     done &&
> >> +     for i in $(test_seq 1 100)
> >> +     do
> >> +             cp -r 500_sub_dirs 50000_sub_dirs/dir$i || return $?
> >> +     done
> >> +'
> >> +
> >> +test_perf 'clean many untracked sub dirs, check for nested git' '
> >> +     rm -rf clean_test_dir/50000_sub_dirs_cpy &&
> >> +     cp -r 50000_sub_dirs clean_test_dir/50000_sub_dirs_cpy &&
> >
> > Maybe this would be a good place to use test_perf_cleanup, which I
> > introduced a while ago and you can find in the
> > tg/perf-lib-test-perf-cleanup branch?  It probably won't influence =
the
> > performance a lot, but still better separate the code that actually
> > needs to be tested from the cleanup/preparation code.  Ditto in the
> > other test.
> >
>
> Yes, that would be a clear improvement. I was looking for something l=
ike
> this, the copy takes more time than the clean currently.
>
> The cleanup hook is maybe not exactly the right fit here though. I wo=
uld
> need to do one initial copy in the setup test and then a copy in the
> cleanup, something like this:
>
> test_expect_success 'setup untracked directory with many sub dirs' '
>     ...
>     cp -r 50000_sub_dirs clean_test_dir/50000_sub_dirs_cpy
> '
>
> test_perf_cleanup 'clean many untracked sub dirs, check for nested gi=
t' '
>     git clean -q -f -d  clean_test_dir/
> ' '
>     test_dir_is_empty clean_test_dir &&
>     rm -rf clean_test_dir/50000_sub_dirs_cpy &&
>     cp -r 50000_sub_dirs clean_test_dir/50000_sub_dirs_cpy
> '
>
> This works better than my original code but maybe we can do even bett=
er
> with something like:
>
> test_setup_perf_cleanup 'clean many untracked sub dirs, check for nes=
ted git' '
>     rm -rf clean_test_dir/50000_sub_dirs_cpy &&
>     cp -r 50000_sub_dirs clean_test_dir/50000_sub_dirs_cpy
> ' '
>     git clean -q -f -d  clean_test_dir/
> ' '
>     test_dir_is_empty clean_test_dir
> '
>
> Having a setup phase avoids the initial copy in the setup test making
> things a little easier to follow. I'm not sure its worth the extra co=
mplexity
> in perf-lib though (and I'm not sure I would be able to implement it =
either).

Yeah, you're right, that would look even better.  In order to avoid
the extra complexity we might actually go the other route that was
proposed by Junio in the discussion back then
(http://thread.gmane.org/gmane.comp.version-control.git/234874/focus=3D=
235241).

Using that and adding a setup option we could have something like:

test_perf --setup '
	rm -rf clean_test_dir/50000_sub_dirs_cpy &&
	cp -r 50000_sub_dirs clean_test_dir/50000_sub_dirs_cpy
' --cleanup '
	test_dir_is_empty clean_test_dir
' 'clean many untracked sub dirs, check for nested git' '
	git clean -q -f -d clean_test_dir
'

> Also, what would the implications be if I were to use your new cleanu=
p
> function that is not yet on master? Should I rebase on top of your to=
pic
> or make a follow up patch to switch over?

If the consensus is to go that route, I think you could just rebase
the topic onto my topic.  If we introduce the "modern" test style as
described before it might be worth merging this series first and then
switch over to the new style.  You should probably wait for other
opinions before changing it though.

> >> +     git clean -q -f -d  clean_test_dir/ &&
> >> +     test_dir_is_empty clean_test_dir
> >> +'
> >> +
> >> +test_perf 'clean many untracked sub dirs, ignore nested git' '
> >> +     rm -rf clean_test_dir/50000_sub_dirs_cpy &&
> >> +     cp -r 50000_sub_dirs clean_test_dir/50000_sub_dirs_cpy &&
> >> +     git clean -q -f -f -d  clean_test_dir/ &&
> >> +     test_dir_is_empty clean_test_dir
> >> +'
> >> +
> >> +test_done
> >> --
> >> 2.4.0.rc0.37.ga3b75b3
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe git" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
Thomas Gummerer
