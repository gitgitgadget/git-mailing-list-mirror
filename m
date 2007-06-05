From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] filter-branch: use sh -c instead of eval
Date: Tue, 05 Jun 2007 21:02:18 +0200
Message-ID: <f44bvq$klu$1@sea.gmane.org>
References: <20070605165734.GA21708@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 21:26:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hveg3-00035I-V6
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 21:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755761AbXFET0j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 15:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756434AbXFET0j
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 15:26:39 -0400
Received: from main.gmane.org ([80.91.229.2]:49802 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755761AbXFET0j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 15:26:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HveWj-0004TW-6r
	for git@vger.kernel.org; Tue, 05 Jun 2007 21:17:09 +0200
Received: from at00d01-adsl-194-118-045-019.nextranet.at ([194.118.45.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 21:17:09 +0200
Received: from johannes.sixt by at00d01-adsl-194-118-045-019.nextranet.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 21:17:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: at00d01-adsl-194-118-045-019.nextranet.at
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49219>

Matthias Lederhofer wrote:

> If filters use variables with the same name as variables
> used in the script the script breaks.  Executing the filters
> in a separate process prevents accidential modification of
> the variables in the main process.
> @@ -349,21 +349,21 @@ while read commit; do
>  
>  eval "$(set_ident AUTHOR <../commit)"
>  eval "$(set_ident COMMITTER <../commit)"
> -     eval "$filter_env" < /dev/null
> +     sh -c "$filter_env" < /dev/null

NACK.

The eval is on purpose here. $filter_env must be able export GIT_AUTHOR* and
GIT_COMMITTER* variables here.

Generally, it might be useful that one filter sets or exports variables that
are then available for subsequent filters or the next commit. Therefore, I
think it's actually a feature to have eval instead of sh -c even if there
is a chance that the filter overwrites internal variables. 

-- Hannes
