From: Junio C Hamano <gitster@pobox.com>
Subject: Re: proper remote ref namespaces
Date: Wed, 12 Aug 2015 12:35:47 -0700
Message-ID: <xmqq1tf8l2p8.fsf@gitster.dls.corp.google.com>
References: <CA+P7+xpj+8DZ=K0pna299Mu3nsQ4+JV_JUK=WFzzAFnJN+Bkbg@mail.gmail.com>
	<55CB63C5.8090708@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 21:35:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPboZ-00075f-60
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 21:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbbHLTfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 15:35:50 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36540 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbbHLTfu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 15:35:50 -0400
Received: by pacrr5 with SMTP id rr5so20708750pac.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 12:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=w8YsIfL68beOz67v3emTu6R0DgjVMQv2Ns/Q5bhOUBM=;
        b=jFX/agTI6thKHTIdaslDhMv353x3ghW9NGkjgPggz4RWJOdCLX6W82JB2EbM58HBn7
         x9hxzgsHLyP7xMP4K8DjyRkbBCjo8zSySdnqrgQkprf3687DTVEvurujnBxLf6mxVt31
         /D3jVfVNLXHImNbVHXNi+jgEQL5uHTQp1Lacqv3NuPRRYc9FVkE4/abTheSqOPsuWnR5
         o8hjkNAgaDTLw+vZNoSsHsevvP6mIYECxO/JmW+EIgxeme6OiOYb9ciT+18A+hf5yLU/
         lFSl0swwZX9v2TgGW3FgtN2C2TDAxkxmWxKixorTQ1AOoT1MkM2GCizVJTjzBoU+CWP2
         WHmw==
X-Received: by 10.66.102.71 with SMTP id fm7mr69686985pab.5.1439408149610;
        Wed, 12 Aug 2015 12:35:49 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:755f:3d29:a826:eda6])
        by smtp.gmail.com with ESMTPSA id u10sm7382345pbs.16.2015.08.12.12.35.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 12:35:49 -0700 (PDT)
In-Reply-To: <55CB63C5.8090708@xiplink.com> (Marc Branchaud's message of "Wed,
	12 Aug 2015 11:18:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275804>

Marc Branchaud <marcnarc@xiplink.com> writes:

> Not a lot.  Existing DWIMery already handles ambiguous branches, by
> preferring a local branch name over any remote ones.  The only teaching
> that's really needed is ...

You need to remember that there are five useful things you can do to
mutable things.

 - Creation can be covered by teaching "clone" to put a new-style
   refspec but the same change needs to also go to "remote add".

 - Reading is done by the DWIMery in ref_rev_parse_rules[] (your
   point above).

 - Updating is automatic, as "fetch" does not have any funny
   built-in intuit and blindly follows configured fetch refspec.

 - Deletion by "branch -d -r" and "remote remove" needs to be
   careful about designing how the case where both old and new
   hierarchies exist should be handled (my gut feeling is "delete
   both", but there may be funny corner cases).

 - Enumeration by "branch -l -r" probably shares the same issue as
   deletion.
