From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/5] diff: introduce diff.submoduleFormat configuration variable
Date: Mon, 29 Oct 2012 16:00:23 +0530
Message-ID: <CALkWK0nPJ-8UvyYN800-Tj+mLQtv-vF3SJScb1O8EEiY238Z6w@mail.gmail.com>
References: <1349196670-2844-1-git-send-email-artagnon@gmail.com>
 <1349196670-2844-5-git-send-email-artagnon@gmail.com> <506B4418.2050700@web.de>
 <506C4161.3040201@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 29 11:30:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSmcT-0005Vw-2s
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 11:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758568Ab2J2Kar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 06:30:47 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:48759 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758562Ab2J2Kap (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 06:30:45 -0400
Received: by mail-qc0-f174.google.com with SMTP id o22so2520195qcr.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 03:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6pSem3dm29JrAD4M29EGZPxm1DWIjoS2hNj3mGvxalc=;
        b=ndU6otPasmRJtlpKB1wgq9Pd5lxTlpPxPGTgVSSYUMmd5BJVQxrdkugx3RLuzcjb9q
         soB3lWnT+neHrgij9imHdOL9KVfS3ZXkOo5IdKLmJJiesf+LERJo54Gu0W/IysZPUxBI
         hZ5iXfsaWd6VDBug6mmX7i1TepzG+w5jhRPx5QaB+x5H4t0iqkisP/49DBmCpHF7iIad
         XlQ439FFkrMUs6a54DJfW45FIvZ2Zvq6waI51sRLIVpVoYeaE4ncRmBNx47rjOjJHVQm
         2/uE1lWqlW19WSSBMMNIYNF8eYzQprlgzyCpnpIgc309j8pHSd6nAgRx4H1dCaztHja5
         SvwQ==
Received: by 10.224.31.20 with SMTP id w20mr14272825qac.3.1351506643999; Mon,
 29 Oct 2012 03:30:43 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Mon, 29 Oct 2012 03:30:23 -0700 (PDT)
In-Reply-To: <506C4161.3040201@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208612>

Jens Lehmann wrote:
> Am 02.10.2012 21:44, schrieb Jens Lehmann:
>> Am 02.10.2012 18:51, schrieb Ramkumar Ramachandra:
>>> Introduce a diff.submoduleFormat configuration variable corresponding
>>> to the '--submodule' command-line option of 'git diff'.
>>
>> Nice. Maybe a better name would be "diff.submodule", as this sets the
>> default for the "--submodule" option of diff?
>>
>> And I think you should also test in t4041 that "--submodule=short"
>> overrides the config setting.
>
> We also need tests which show that setting that config to "log" does
> not break one of the many users of "git diff" ("stash", "rebase" and
> "format-patch" come to mind, most probably I missed some others). I
> suspect we'll have to add "--submodule=short" options to some call
> sites to keep them working with submodule changes.

Um, why would "stash", "rebase" or "format-patch" be affected by this
setting?  They don't operate on submodules at all.  To be sure, I ran
all the tests with the following diff and nothing broke.

Confused,

Ram

-- 8< --
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 514282c..904a81c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -608,6 +608,8 @@ fi
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$test" || exit 1

+git config test.submodule log
+
 this_test=${0##*/}
 this_test=${this_test%%-*}
 for skp in $GIT_SKIP_TESTS
