From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7063: fix breakage with split index
Date: Sat, 06 Jun 2015 23:20:35 -0700
Message-ID: <xmqq1thodop8.fsf@gitster.dls.corp.google.com>
References: <1433547093-6616-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 08:20:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1Two-0003t9-Vy
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 08:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbbFGGUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 02:20:38 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35857 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbbFGGUh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 02:20:37 -0400
Received: by igbpi8 with SMTP id pi8so41604640igb.1
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 23:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=kO3hITIyN7XAgqg2YQAKyH17Z7f2VMAIlYNvWbs+WXY=;
        b=a+ios+wUEpnza+At+TWmBHjQ7iDNgiyNXRMFjHauODQXbsHNx3BDWh4AQ/tTZNtWbk
         OJgvbdAIlN/3Xdc6FZeuXkt2LRYTDA9lqiKBpZnrQcnOWag2+ISjxujfPbBdxf0BpNLf
         Aze/1IO9xaxBucnjpv1djwziVMmdpH2AS8v5WRkVRsWLUUZZFqrHv/bspIEVKCi17eg2
         3XGWE0AZKCTwRNSW2VjdB9ggMoIpakWAkmsmZrTCqsfpEbOevKC3K6OEx0v6Z7joPMsN
         EdCp0+hL9WTnlAtg+yuB7FSqNRhjSoMDk8DqDtA6Lh96wUEb8mTqbySHic8fv+HjsNzY
         cNaw==
X-Received: by 10.50.112.73 with SMTP id io9mr6772503igb.18.1433658036925;
        Sat, 06 Jun 2015 23:20:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a868:1333:6cc9:5851])
        by mx.google.com with ESMTPSA id d4sm2505928igl.1.2015.06.06.23.20.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 06 Jun 2015 23:20:36 -0700 (PDT)
In-Reply-To: <1433547093-6616-1-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Sat, 6 Jun 2015 01:31:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270957>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> When running the test suite with GIT_TEST_SPLIT_INDEX set, tests 17-18
> in t7063 fail.  Unset GIT_TEST_SPLIT_INDEX at the beginning of the test,
> in order to fix it.

That is not fixing but sweeping the problem under the rug, is it?

Duy, untracked-cache is a fairly new toy and I wouldn't be surprised
if it has un-thought-out interaction with split-index which is also
a fairly new exotic toy.  As both are from you, can you take a look
at it?

We may want to make it easier to run tests with TEST-SPLIT-INDEX, if
we envision that the feature will bring us sufficient benefit and we
would eventually want to encourage its use to more people.  As it
stands now, only people who are curious enough opt into trying it
out by exporting the environment, which would be done by a tiny
minority of developers and users.

Thanks.

>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>
> Hi,
>
> This breakage is both in the current master and next.  I'm not entirely
> sure this is the best way to solve the issue, but unfortunately I don't
> have any more time to look into this.
>
>  t/t7063-status-untracked-cache.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
> index bd4806c..2f958c7 100755
> --- a/t/t7063-status-untracked-cache.sh
> +++ b/t/t7063-status-untracked-cache.sh
> @@ -8,6 +8,8 @@ avoid_racy() {
>  	sleep 1
>  }
>  
> +unset GIT_TEST_SPLIT_INDEX
> +
>  # It's fine if git update-index returns an error code other than one,
>  # it'll be caught in the first test.
>  test_lazy_prereq UNTRACKED_CACHE '
