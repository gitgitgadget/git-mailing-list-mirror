From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 12/14] Extract some useful pathspec handling code from
 builtin/add.c into a library
Date: Fri, 21 Sep 2012 09:54:15 +0200
Message-ID: <505C1D27.7080100@alum.mit.edu>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org> <1348170383-15751-1-git-send-email-git@adamspiers.org> <1348170383-15751-13-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 09:54:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEy4b-0000iJ-Qz
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 09:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586Ab2IUHyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 03:54:19 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:52195 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754491Ab2IUHyS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Sep 2012 03:54:18 -0400
X-AuditID: 1207440d-b7f236d000000943-f7-505c1d29f700
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id FC.A2.02371.92D1C505; Fri, 21 Sep 2012 03:54:17 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8L7sFAd020302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 21 Sep 2012 03:54:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <1348170383-15751-13-git-send-email-git@adamspiers.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqKspGxNg8PWAkcXPaRMZLbqudDNZ
	NPReYbbonvKW0eJHSw+zA6vH8iWLWDx2zrrL7vGsdw+jx8VLyh6fN8kFsEZx2yQllpQFZ6bn
	6dslcGcc23qeteAwf8W8x5PYGhhv8HQxcnJICJhI3Lr3jx3CFpO4cG89WxcjF4eQwGVGibnH
	brFCOMeZJP4vm8AMUsUroC2xuqeZpYuRg4NFQFXiZqcWSJhNQFdiUU8zE4gtKhAiMePyZKhy
	QYmTM5+wgNgiAioS9z4vAZvJLLCTUeLKrpmMIAlhgRyJA3umQi1bwigxbd8fsA5OAReJVQc3
	s4MsYxZQl1g/TwgkzCwgL7H97RzmCYwCs5DsmIVQNQtJ1QJG5lWMcok5pbm6uYmZOcWpybrF
	yYl5ealFukZ6uZkleqkppZsYISHOu4Px/zqZQ4wCHIxKPLyXLKIDhFgTy4orcw8xSnIwKYny
	iojHBAjxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4X0UA1TOm5JYWZValA+TkuZgURLnVVui7ick
	kJ5YkpqdmlqQWgSTleHgUJLg7ZQBGipYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEP
	itT4YmCsgqR4gPZqgLTzFhck5gJFIVpPMepyrL274AGjEEtefl6qlDhvHUiRAEhRRmke3ApY
	QnvFKA70sTBvAUgVDzAZwk16BbSECWjJm+tRIEtKEhFSUg2MPtdXWnzaJvrN8F6E9Z26kEvn
	XW5cDEz5fnttipXeX719l4QXnHcIDD0rxLJo2b76qQHb9e9rXnj0+/+7F6tjov9r 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206113>

On 09/20/2012 09:46 PM, Adam Spiers wrote:
> This is in preparation for reuse by a new git check-ignore command.
> 
> Signed-off-by: Adam Spiers <git@adamspiers.org>
> ---
>  Makefile      |  2 ++
>  builtin/add.c | 95 ++-------------------------------------------------------
>  pathspec.c    | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  pathspec.h    |  6 ++++
>  4 files changed, 108 insertions(+), 92 deletions(-)
>  create mode 100644 pathspec.c
>  create mode 100644 pathspec.h
> 
> [...]
> diff --git a/pathspec.h b/pathspec.h
> new file mode 100644
> index 0000000..4ed40a5
> --- /dev/null
> +++ b/pathspec.h
> @@ -0,0 +1,6 @@
> +extern void validate_path(const char *prefix, const char *path);
> +extern const char **validate_pathspec(const char *prefix, const char **files);
> +extern char *find_used_pathspec(const char **pathspec);
> +extern void fill_pathspec_matches(const char **pathspec, char *seen, int specs);
> +extern const char *treat_gitlink(const char **path);
> +extern void treat_gitlinks(const char **pathspec);

It was unfortunate that these functions were not already documented.
But now that you are elevating them from static to global functions, it
would be great if you would add some comments for them.

(By the way, thanks for the docstrings that you added in an earlier patch.)

This patch is not only moving code around, but also:

* extracting a new function, validate_path()

* changing the signature of validate_pathspec()

* maybe other things?  How is a reviewer to know without examining every
line of the patch?

Each self-contained change should be done in a separate patch.  For
example, one patch should move the code while making only the minimal
changes logically connected to the move (e.g., removing "static"
qualifiers).  The other changes should be made separate commits.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
