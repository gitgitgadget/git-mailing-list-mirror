From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 09/10] fmt-merge-msg: Add contents of merged tag in the
 merge message
Date: Sat, 05 Nov 2011 09:43:57 +0100
Message-ID: <4EB4F74D.7090004@kdbg.org>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com> <1320472900-6601-10-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 05 09:44:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMbrU-0005K4-SO
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 09:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932Ab1KEIoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 04:44:20 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:60843 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750920Ab1KEIoT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 04:44:19 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.105])
	by lbmfmo03.bon.at (Postfix) with ESMTP id D7AFECE5A6
	for <git@vger.kernel.org>; Sat,  5 Nov 2011 09:44:29 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7FCAC2C400E;
	Sat,  5 Nov 2011 09:44:09 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B0E6719F440;
	Sat,  5 Nov 2011 09:43:57 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.23) Gecko/20110920 SUSE/3.1.15 Thunderbird/3.1.15
In-Reply-To: <1320472900-6601-10-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184836>

Am 05.11.2011 07:01, schrieb Junio C Hamano:
> When a contributor asks the integrator to merge her history, a signed tag
> can be a good vehicle to communicate the authenticity of the request while
> conveying other information such as the purpose of the topic.
> 
> E.g. a signed tag "for-linus" can be created, and the integrator can run:
> 
>    $ git pull git://example.com/work.git/ for-linus
> 
> This would allow the integrator to run "git verify-tag FETCH_HEAD" to
> validate the signed tag.
> 
> While we do not necessarily want to clutter the global tag namespace of
> the project, we would want to leave enough information in the repository
> to allow third party to later validate the resulting history.
> 
> Update fmt-merge-msg that prepares the merge message template, and store
> the contents of the signed tag object and the message that comes from GPG
> signature validation at the end of it. The integrator can choose to leave
> the contents of the tag in the resulting merge commit, or can choose to
> remove it. The GPG validation message is inserted as a comment only to
> help the integrator to review the validation result but otherwise will not
> be recorded in the resulting merge commit, because later validation by
> third parties does not need it.

Since the tag signature depends on the tag message, including all spelin
errors, the integrator must not change the text so that third parties
can repeat the verification. (Correct?) I assume this is the reason that
you put 'tag:' in front of the tag message, to discourage any changes.

What if the tag is not signed? Does this code path trigger at all? In
this case, I would prefer that the discouraging 'tag:' prefix were not
present. The resulting text would fit more naturally in a commit message
as a description of the commit/merge/topic. What do you think?

-- Hannes
