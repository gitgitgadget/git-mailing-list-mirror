From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: [RFC] Interactive-rebase doesn't pick all children of "upstream"
Date: Sat, 21 May 2011 03:34:21 -0400
Message-ID: <4DD76AFD.8040504@sohovfx.com>
References: <20110517161234.GA21388@sigill.intra.peff.net> <1305957078-19111-1-git-send-email-andrew.kw.w@gmail.com> <1305957078-19111-2-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 21 09:34:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNghp-0001GC-2v
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 09:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360Ab1EUHeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 03:34:25 -0400
Received: from smtp04.beanfield.com ([76.9.193.173]:57126 "EHLO
	smtp03.beanfield.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752186Ab1EUHeY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 03:34:24 -0400
X-Spam-Status: No
X-beanfield-mta04-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta04-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta04-MailScanner: Found to be clean
X-beanfield-mta04-MailScanner-ID: 1QNgha-0003wx-4r
Received: from [24.246.58.202] (helo=ZanarkandMac.local)
	by mta01.beanfield.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1QNgha-0003wx-4r; Sat, 21 May 2011 03:34:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <1305957078-19111-2-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174112>

On 11-05-21 1:51 AM, Andrew Wong wrote:
>   			preserve=t
>   			for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
>   			do
> -				if test -f "$rewritten"/$p -a \( $p != $onto -o $sha1 = $first_after_upstream \)
> +				if test -f "$rewritten"/$p&&  (
> +					test $p != $onto ||
> +					expr "$commits_after_upstream" ":" ".*$sha1.*"
> +					)
>   				then
>   					preserve=f
>   				fi

Actually, I think this change might be effectively the same as removing 
both of the OR-conditions, which leaves only the "test -f" condition. 
That means commits are never skipped.

I guess this goes back to my first response to this issue. What kind of 
commits are skipped by the changes introduced in commit 
d80d6bc146232d81f1bb4bc58e5d89263fd228d4 ?
