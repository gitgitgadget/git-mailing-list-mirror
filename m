From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: Rebase regression in v1.7.9?
Date: Wed, 01 Feb 2012 12:27:58 -0500
Message-ID: <4F29761E.1030605@sohovfx.com>
References: <CAMP44s1EAwHjQ7S2ArLvhNg5qkR05DRJ70tQmP8sXYdOP=i_zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 18:28:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsdye-00053u-7o
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 18:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164Ab2BAR2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 12:28:06 -0500
Received: from smtp04.beanfield.com ([76.9.193.173]:57742 "EHLO
	smtp04.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552Ab2BAR2F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 12:28:05 -0500
X-Spam-Status: No
X-beanfield-mta04-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta04-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta04-MailScanner: Found to be clean
X-beanfield-mta04-MailScanner-ID: 1RsdyR-0005ic-9p
Received: from [66.207.196.114] (helo=[192.168.1.112])
	by mta04.beanfield.com with esmtpa (Exim 4.76)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1RsdyR-0005ic-9p; Wed, 01 Feb 2012 12:27:59 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101026 SUSE/3.0.10 Thunderbird/3.0.10
In-Reply-To: <CAMP44s1EAwHjQ7S2ArLvhNg5qkR05DRJ70tQmP8sXYdOP=i_zQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189526>

On 01/31/2012 05:56 PM, Felipe Contreras wrote:
> The rebase will finish, but there will be a .git/CHERRY_PICK_HEAD file.
>   
Ah, good catch. I can reproduce the issue. This is only happening in
"rebase -i" because interactive rebase relies on cherry-pick, but not
regular rebase. And now cherry-pick creates a state when there's a
conflict (since 1.7.5?), which "rebase -i" didn't expect before. We
probably just need to do a manual clean up before "rebase -i" continues.

I'll try to come up with a patch for this. In the mean time, doing a
"git reset" will remove that dangling file. Of course, you could always
manually remove it. Does the dangling file cause a subsequent git
command to fail?
