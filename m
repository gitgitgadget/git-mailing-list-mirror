From: Andreas Ericsson <ae@op5.se>
Subject: Re: rebasing merges
Date: Tue, 23 Sep 2008 10:06:09 +0200
Message-ID: <48D8A371.4030909@op5.se>
References: <20080922155749.c8070681.stephen@exigencecorp.com>	<20080922231927.ef18f420.stephen@exigencecorp.com>	<48D88813.9060400@viscovery.net> <2008-09-23-09-30-47+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Haberman <stephen@exigencecorp.com>,
	git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Tue Sep 23 10:07:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki2vj-0006z2-Lm
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 10:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbYIWIGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 04:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbYIWIGV
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 04:06:21 -0400
Received: from mail.op5.se ([193.201.96.20]:54303 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbYIWIGU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 04:06:20 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 117CA1B80051;
	Tue, 23 Sep 2008 09:56:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.241
X-Spam-Level: 
X-Spam-Status: No, score=-4.241 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.158, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KlNm+O6J7YOS; Tue, 23 Sep 2008 09:56:40 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id BB9C31B8004D;
	Tue, 23 Sep 2008 09:56:40 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <2008-09-23-09-30-47+trackit+sam@rfc1149.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96536>

Samuel Tardieu wrote:
> 
> Btw, would it be a good idea to unconditionally enable "rerere"
> conflict resolution *recording*, and add an option to "rebase" and
> "merge" to use "rerere" even when it is not enabled in the
> configuration file? I can't think of any drawback.
> 

I'm all for that. I actually thought (4 months ago) that that was
how it worked.

It would be a backwards incompatible change though, as we currently
fall back to "does rr-cache exist?" to determine if rerere is enabled
in case it isn't explicitly so in the configuration. Perhaps print
a warning if !rerere.enabled but $GIT_DIR/rr-cache exists. OTOH,
that will create a lot of warnings since we'd have to create that
rr-cache directory to record the resolutions.

To maintain backwards compatibility, we could ofcourse do like this;
* move rr-cache to rere ("recorded resolutions"; bikeshed color goes here)
* if rr-cache exists, implicitly enable rerere
* if rr-cache holds resolutions when setting up rerere, move them
  to rere
OR
* look for resolutions in both rr-cache and rere indefinitely.

It's not exactly performance critical, so swapping the pattern from
O(n) (or whatever it is now) to O(2n) for replaying resolutions
probably won't make that much of a difference.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
