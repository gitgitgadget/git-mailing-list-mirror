From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Thu, 7 Apr 2016 08:21:13 +0200
Message-ID: <5705FC59.2050801@kdbg.org>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
 <1459980722-4836-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pclouds@gmail.com, aevarb@gmail.com,
	jeffhost@microsoft.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 08:21:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ao3Ji-0005PP-6G
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 08:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbcDGGVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 02:21:17 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:3854 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784AbcDGGVR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 02:21:17 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3qgXXp12JSz5tld;
	Thu,  7 Apr 2016 08:21:14 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id B52EB5239;
	Thu,  7 Apr 2016 08:21:13 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <1459980722-4836-4-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290908>

Am 07.04.2016 um 00:11 schrieb David Turner:
> +static void share_index(struct index_state *istate, struct shm *is)
> +{
> +	void *new_mmap;
> +	if (istate->mmap_size <= 20 ||
> +	    hashcmp(istate->sha1,
> +		    (unsigned char *)istate->mmap + istate->mmap_size - 20) ||
> +	    !hashcmp(istate->sha1, is->sha1) ||
> +	    git_shm_map(O_CREAT | O_EXCL | O_RDWR, 0700, istate->mmap_size,
> +			&new_mmap, PROT_READ | PROT_WRITE, MAP_SHARED,
> +			"git-index-%s", sha1_to_hex(istate->sha1)) < 0)

Builds which have NO_MMAP set require that MAP_PRIVATE is set. So I 
would guess that at this point you leave those builds behind. Unless we 
declare such systems as hopelessly outdated and remove NO_MMAP and 
compat/mmap.c or you support index-helper only when NO_MMAP is not set.

-- Hannes
