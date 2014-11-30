From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] compat: convert modes to use portable file type values
Date: Sun, 30 Nov 2014 21:16:39 +0100
Message-ID: <547B7B27.90204@web.de>
References: <87vblxl8ah.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Michael <fedora.dm0@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 21:16:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvAvQ-0004Em-7Z
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 21:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbaK3UQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2014 15:16:42 -0500
Received: from mout.web.de ([212.227.17.11]:64351 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbaK3UQl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 15:16:41 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MTy9d-1XUOj02Dwn-00Qlgt; Sun, 30 Nov 2014 21:16:39
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <87vblxl8ah.fsf@gmail.com>
X-Provags-ID: V03:K0:oUPrP0nlbe2A4FI/7/RkBjgGjC6o7TVvi4IUxSOHt2DCGRwEVWI
 EmUjjdiCTdmdBTImBURwjOWTY+mJVRyrpI4EL/fBd3hGgVW64HVwEgTQfEmUNNnAkei/2Pz
 RL72XRSxhkO61ENSmkenVpcAv3z3pvpHn8DyGhQWsYspY2+bD1hDqZeTqjnlrGHc1WScnpT
 rWKsHXPKrSUrSmVNl8aoQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260455>

On 2014-11-30 03.41, David Michael wrote:
Some minor comments:
> +static inline mode_t mode_native_to_git(mode_t native_mode)
> +{
> +	if (S_ISREG(native_mode))
> +		return 0100000 | (native_mode & 07777);
> +	else if (S_ISDIR(native_mode))
> +		return 0040000 | (native_mode & 07777);
> +	else if (S_ISLNK(native_mode))
> +		return 0120000 | (native_mode & 07777);
> +	else if (S_ISBLK(native_mode))
> +		return 0060000 | (native_mode & 07777);
> +	else if (S_ISCHR(native_mode))
> +		return 0020000 | (native_mode & 07777);
> +	else if (S_ISFIFO(native_mode))
> +		return 0010000 | (native_mode & 07777);
> +	else /* Non-standard type bits were given. */
> +		return native_mode & 07777;
> +}
Could the code be more human-readable ?
static inline mode_t mode_native_to_git(mode_t native_mode)
{
	int perm_bits = native_mode & 07777;
	if (S_ISREG(native_mode))
		return 0100000 | perm_bits;
	if (S_ISDIR(native_mode))
		return 0040000 | perm_bits;
	if (S_ISLNK(native_mode))
		return 0120000 | perm_bits;
	if (S_ISBLK(native_mode))
		return 0060000 | perm_bits;
	if (S_ISCHR(native_mode))
		return 0020000 | perm_bits;
	if (S_ISFIFO(native_mode))
		return 0010000 | perm_bits;
	/* Non-standard type bits were given. */
	/* Shouldn't we die() here ?? */
		return perm_bits;
}
