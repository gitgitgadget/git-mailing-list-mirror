From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 2/2] read-tree: migrate to parse-options
Date: Wed, 24 Jun 2009 18:36:31 -0700
Message-ID: <4A42D49F.8010805@gmail.com>
References: <1245817672-25483-1-git-send-email-bebarino@gmail.com>	<1245817672-25483-2-git-send-email-bebarino@gmail.com> <7vws721ao9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 03:37:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJdu8-000228-1W
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 03:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbZFYBhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 21:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753173AbZFYBhW
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 21:37:22 -0400
Received: from mail-pz0-f189.google.com ([209.85.222.189]:40891 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbZFYBhV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 21:37:21 -0400
Received: by pzk27 with SMTP id 27so986292pzk.33
        for <git@vger.kernel.org>; Wed, 24 Jun 2009 18:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=WVJB6eEjkVdhzoASMfq1ny5BfhxDkeBgqKf6j183b3c=;
        b=nOQhMNXw1UXFAQv8KCKdZZYxrVah1s4t3OCkoNgW/LSmjX5II8VfttpLHC/wvphk93
         lc6GG6+PSdecfBMtheVrBjPlodEOyeD9P8IIcbecMSwn6qPPAKZ9SxzcO3kH902Ri2rL
         q3sRqqfAV4DAYeFBb2WH9t2s1YSZOYdXZczPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=dAYP7uty1ls/pvdIFrNoGDUcUlmh9WbQnyjUBFruZRJ31yHKFQCFA95uqD0ZBvIuuA
         vmww8cbr7gCXNkJm00Ssg0EVagsjC3Ew05oEMtiDqTLCRoD7CL5aFS+dagSrfwbp2ffW
         e4nLIopCfQ69Wu6wi6TJXhIalVB2ULk8roo1w=
Received: by 10.114.211.1 with SMTP id j1mr2994112wag.176.1245893839441;
        Wed, 24 Jun 2009 18:37:19 -0700 (PDT)
Received: from ?10.10.0.2? (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id j15sm3027996waf.51.2009.06.24.18.37.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Jun 2009 18:37:18 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <7vws721ao9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122176>

Junio C Hamano wrote:
> Sorry, but I have to ask: Why?

I think there are advantages to parse-optification, for plumbing and
porcelains. Two reasons I see are:

1. Providing a unified way of handling options
2. Providing a consistent usage message format

Obviously, 1 reduces the bugs associated with parsing options (strcmp
vs. prefixcmp, incorrect argv+offset). For number 2, I think it helps
users when they see the same style of usage messages with each command.
It's also nice to get a quick help message without opening the man pages
or using git help <command>.

Admittedly this patch ends up adding 20 or so lines. Do the above points
justify this? I think so. I think the added lines can be attributed to
the rougher edges of parse-opts exposed by this patch. You can't take
the address of bit fields, so 6 lines are dealing with this problem.
Where are the other 15 lines coming from?

Looking over it again, I think I may be able to cut the overhead down by
refactoring three of the callbacks into boolean options. There's a lot
of duplication there, which can be simplified. I was trying to make this
a straight port which is probably not so good for convincing you that
it's worthwhile.

For now, I don't mind this patch being dropped (there's an ambiguity in
the callbacks returning non-zero I'd like to fix too). I'll try and get
a new patch (or maybe this patch with the oneline fix and a refactoring
patch) out later tonight that actually reduces the amount of lines,
instead of grossly adding to them.
