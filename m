From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] status: report ignored yet tracked directories
Date: Sat, 05 Jan 2013 22:27:35 +0100
Message-ID: <50E89AC7.9070600@web.de>
References: <20130105112432.GA14666@sigill.intra.peff.net> <1357418563-6626-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: tboegi@web.de, peff@peff.net, git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 22:28:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrbHl-0000x3-Sd
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 22:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945Ab3AEV1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 16:27:51 -0500
Received: from mout.web.de ([212.227.17.12]:60452 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755917Ab3AEV1q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 16:27:46 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0Lb1wz-1T7ZE62GpV-00l9e5; Sat, 05 Jan 2013 22:27:36
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <1357418563-6626-1-git-send-email-apelisse@gmail.com>
X-Provags-ID: V02:K0:h99kHJgZwfmpJLI5IP1HoOrIB9tyMeWGgLl+5wMv24b
 Z72BLpCGRcNG3UlLpHkuCBb12Bk39HUQmUVm3w2NDPFFADCpsY
 LHaZj5R/paO1OcIXq/qPOwxebQ1doyemRYSo+qMIj1Lrxq7oXf
 4p1NAxYuQldXzXQQh85dfYww35p+Cd+xvf6VivvHH3qRhOZl7F
 0/T5HhaVAjbKB5dSUe8ow==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212727>

On 05.01.13 21:42, Antoine Pelisse wrote:
> Tracked directories (i.e. directories containing tracked files) that
> are ignored must be reported as ignored if they contain untracked files.
>
> Currently, tracked files or directories can't be reported untracked or ignored.
> Remove that constraint when searching ignored files.
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---
> Torsten, Jeff,
>
> Can you please test this patch and tell me if this is better ? (t7061 is now
> successful with core.ignorecase=true)
>
> This patch applies on top of ap/status-ignored-in-ignored-directory (but
>  should also apply cleanly on top of next for testing purpose).
>
> Thanks,
>
>  dir.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/dir.c b/dir.c
> index 9b80348..eefa8ab 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -672,7 +672,8 @@ static struct dir_entry *dir_entry_new(const char *pathname, int len)
>
>  static struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
>  {
> -	if (cache_name_exists(pathname, len, ignore_case))
> +	if (!(dir->flags & DIR_SHOW_IGNORED) &&
> +	    cache_name_exists(pathname, len, ignore_case))
>  		return NULL;
>
>  	ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);
> --
> 1.7.12.4.2.geb8c5b8.dirty
>
(BTW: thanks for contributing to git)
Antoine, the test is OK:
# passed all 10 test(s)
================
I'm not sure if I am happy with the commit message, so I try to have an improved
version below, which may be a starting point for a discussion:

git status: report ignored directories correctly

A directory containing tracked files where the directory
is ignored must be reported as ignored even if it contains untracked files.

/Torsten
