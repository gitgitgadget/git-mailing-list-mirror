From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 3/7] test patch hunk editing with "commit -p -m"
Date: Mon, 10 Mar 2014 20:30:39 -0000
Organization: OPDS
Message-ID: <E509041DA7394C9893F4F3EBE99B6E43@PhilipOakley>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com> <1394477377-10994-4-git-send-email-benoit.pierre@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Benoit Pierre" <benoit.pierre@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 21:30:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN6qW-0008FY-4P
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 21:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008AbaCJUan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 16:30:43 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:15852 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752758AbaCJUam (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 16:30:42 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Au4XACEgHlNZ8Y3F/2dsb2JhbABagwY7iRu4fAECAYEhF3RpAQGBHwEBFAEEAQEBAQMIAQEuHgEBLAIDBQIBAxUMJRQBBAgSBgcXBgESCAIBAgMBhTgHAYIHDQMVCbQ5lEsNhlmMRIVCgRQEiRmGIIcfjlKFSIMtPQ
X-IPAS-Result: Au4XACEgHlNZ8Y3F/2dsb2JhbABagwY7iRu4fAECAYEhF3RpAQGBHwEBFAEEAQEBAQMIAQEuHgEBLAIDBQIBAxUMJRQBBAgSBgcXBgESCAIBAgMBhTgHAYIHDQMVCbQ5lEsNhlmMRIVCgRQEiRmGIIcfjlKFSIMtPQ
X-IronPort-AV: E=Sophos;i="4.97,625,1389744000"; 
   d="scan'208";a="100581361"
Received: from host-89-241-141-197.as13285.net (HELO PhilipOakley) ([89.241.141.197])
  by out1.ip07ir2.opaltelecom.net with SMTP; 10 Mar 2014 20:30:41 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243811>

mincro nit.
From: "Benoit Pierre" <benoit.pierre@gmail.com>
> Add (failing) test: with commit changing the environment to let hooks
> now that no editor will be used (by setting GIT_EDITOR to ":"), the
s/now/know/

> "edit hunk" functionality does not work (no editor is launched and the
> whole hunk is committed).
>
> Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
> ---
> t/t7513-commit_-p_-m_hunk_edit.sh | 34 
> ++++++++++++++++++++++++++++++++++
> 1 file changed, 34 insertions(+)
> create mode 100755 t/t7513-commit_-p_-m_hunk_edit.sh
>
> diff --git a/t/t7513-commit_-p_-m_hunk_edit.sh 
> b/t/t7513-commit_-p_-m_hunk_edit.sh
> new file mode 100755
> index 0000000..994939a
> --- /dev/null
> +++ b/t/t7513-commit_-p_-m_hunk_edit.sh
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +
> +test_description='hunk edit with "commit -p -m"'
> +. ./test-lib.sh
> +
> +if ! test_have_prereq PERL
> +then
> + skip_all="skipping '$test_description' tests, perl not available"
> + test_done
> +fi
> +
> +test_expect_success 'setup (initial)' '
> + echo line1 >file &&
> + git add file &&
> + git commit -m commit1 &&
> + echo line3 >>file &&
> + cat >expect <<-\EOF
> + diff --git a/file b/file
> + index a29bdeb..c0d0fb4 100644
> + --- a/file
> + +++ b/file
> + @@ -1 +1,2 @@
> + line1
> + +line2
> + EOF
> +'
> +
> +test_expect_failure 'edit hunk "commit -p -m message"' '
> + echo e | env GIT_EDITOR="sed s/+line3\$/+line2/ -i" git commit -p -m 
> commit2 file &&
> + git diff HEAD^ HEAD >actual &&
> + test_cmp expect actual
> +'
> +
> +test_done
> -- 
> 1.9.0
>
> --
> 
