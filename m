From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: [PATCHv3 5/5] branch: allow pattern arguments
Date: Tue, 06 Sep 2011 15:10:54 +0200
Message-ID: <4E661BDE.1080204@elegosoft.com>
References: <cover.1314367414.git.git@drmicha.warpmail.net> <0c487086643fbf0334140365f20fef62242b7dac.1314543252.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 06 15:11:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0vRE-0008A8-I5
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 15:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319Ab1IFNLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 09:11:32 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:59085 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753073Ab1IFNLb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 09:11:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 1CA88DE757;
	Tue,  6 Sep 2011 15:11:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X+603pmae7LB; Tue,  6 Sep 2011 15:11:21 +0200 (CEST)
Received: from [10.10.10.197] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 9E9DFDE73C;
	Tue,  6 Sep 2011 15:11:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.1) Gecko/20110831 Thunderbird/6.0.1
In-Reply-To: <0c487086643fbf0334140365f20fef62242b7dac.1314543252.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180799>

On 08/28/2011 04:54 PM, Michael J Gruber wrote:
> +static int match_patterns(const char **pattern, const char *refname)
> +{
> +	if (!*pattern)
> +		return 1; /* no pattern always matches */
> +	while (*pattern) {
> +		if (!fnmatch(*pattern, refname, 0))
> +			return 1;
> +		pattern++;
> +	}
> +	return 0;
> +}

Nitpick: maybe builtin/branch.c and builtin/tag.c could share match_pattern().?

A second thought: the printed "remotes/" prefix could be confusing for users,
since it seems to be part of the refname. For example:

$ git branch -a
* master
  maint
  man
  remotes/origin/master
  remotes/origin/maint
  remotes/origin/man

$ git branch -a --list remotes/origin*
[no output]

but

$ git branch -a --list origin*
  remotes/origin/master
  remotes/origin/maint
  remotes/origin/man

(Sorry in case I missed that) What's the reason you decided --list to show local
branches only? Maybe --list could show all refnames without any extra prefix.?

Thanks.
