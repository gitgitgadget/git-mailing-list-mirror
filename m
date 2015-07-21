From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v8 6/7] update-ref and tag: add --create-reflog arg
Date: Tue, 21 Jul 2015 06:46:04 -0700
Message-ID: <55AE4D1C.1010308@alum.mit.edu>
References: <1436482260-28088-1-git-send-email-dturner@twopensource.com> <1436482260-28088-7-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	j6t@kdbg.org
X-From: git-owner@vger.kernel.org Tue Jul 21 15:46:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHXsO-0004xl-7I
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 15:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbbGUNqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 09:46:22 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:46058 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932607AbbGUNqU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2015 09:46:20 -0400
X-AuditID: 1207440e-f79516d0000012b3-a2-55ae4d2aa2f7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 88.32.04787.A2D4EA55; Tue, 21 Jul 2015 09:46:18 -0400 (EDT)
Received: from [172.20.208.234] ([66.251.117.141])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6LDkF9H007246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 21 Jul 2015 09:46:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1436482260-28088-7-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1NXyXRdqsP+3pMX8TScYLbqudDNZ
	PJl7l9mB2ePhqy52jwXP77N7fN4kF8AcxW2TlFhSFpyZnqdvl8Cdsff3B/aCGwIV2y/NYWlg
	bOLtYuTkkBAwkXiy+gkzhC0mceHeerYuRi4OIYHLjBLrPr9nhHA2MUl83rabEaSKV0Bb4v2x
	92A2i4CqxJR/e9hAbDYBXYlFPc1MXYwcHKICQRKvX+ZClAtKnJz5hAXEFhHwk9jWNQesVVjA
	XWLm2fksEPNbGSW6l/4HS3AKeEpMXNbBBGIzC+hJ7Lj+ixXClpfY/nYO8wRG/llI5s5CUjYL
	SdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbrGermZJXqpKaWbGCFhyreDsX29zCFGAQ5G
	JR7eC21rQ4VYE8uKK3MPMUpyMCmJ8uobrQsV4kvKT6nMSCzOiC8qzUktPsQowcGsJML7xR4o
	x5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4DX0AWoULEpNT61Iy8wp
	QUgzcXCCDOeSEilOzUtJLUosLcmIB8VkfDEwKkFSPEB7wdp5iwsSc4GiEK2nGBWlxHm1QBIC
	IImM0jy4sbDk84pRHOhLYd4GkCoeYOKC634FNJgJaPCtWWtABpckIqSkGhg3PQ2V9ssJDFAQ
	/Hbhwp+NPrqMAV3ZTsWPzli166x+Kfx1UXCCtmSmzi+Fsmsy31bnSrI0Fxc1u7JbLsxdlv0u
	79Xbq8liWTNZXGy0/wTbKVW1nM1UZb3Is/KQ6Ae2bc473mVK/J2+xVPV/dn0+7d2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274378>

On 07/09/2015 03:50 PM, David Turner wrote:
> Allow the creation of a ref (e.g. stash) with a reflog already in
> place. For most refs (e.g. those under refs/heads), this happens
> automatically, but for others, we need this option.
> 
> Currently, git does this by pre-creating the reflog, but alternate ref
> backends might store reflogs somewhere other than .git/logs.  Code
> that now directly manipulates .git/logs should instead use git
> plumbing commands.
> 
> I also added --create-reflog to git tag, just for completeness.
> 
> In a moment, we will use this argument to make git stash work with
> alternate ref backends.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  Documentation/git-tag.txt        |  5 ++++-
>  Documentation/git-update-ref.txt |  5 ++++-
>  builtin/tag.c                    |  5 ++++-
>  builtin/update-ref.c             | 14 +++++++++++---
>  t/t1400-update-ref.sh            | 38 ++++++++++++++++++++++++++++++++++++++
>  t/t7004-tag.sh                   | 14 +++++++++++++-
>  6 files changed, 74 insertions(+), 7 deletions(-)
> 
> [...]
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index d1ff5c9..75423ab 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -51,7 +51,19 @@ test_expect_success 'creating a tag using default HEAD should succeed' '
>  	echo foo >foo &&
>  	git add foo &&
>  	git commit -m Foo &&
> -	git tag mytag
> +	git tag mytag &&
> +	test_must_fail git reflog exists refs/tags/mytag
> +'
> +
> +test_expect_success 'creating a tag with --create-reflog should create reflog' '
> +	test_when_finished "git tag -d tag_with_reflog" &&
> +	git tag --create-reflog tag_with_reflog &&
> +	git reflog exists refs/tags/tag_with_reflog
> +'
> +
> +test_expect_success '--create-reflog does not creates reflog on failure' '

s/creates/create/

> +	test_must_fail git tag --create-reflog mytag &&
> +	test_must_fail git reflog exists refs/tags/tag_with_reflog

Shouldn't this be

	test_must_fail git reflog exists refs/tags/mytag

?

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
