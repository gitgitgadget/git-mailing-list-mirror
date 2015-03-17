From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/5] t5312: test object deletion code paths in a corrupted
 repository
Date: Tue, 17 Mar 2015 19:34:02 +0100
Message-ID: <5508739A.5030608@kdbg.org>
References: <20150317072750.GA22155@peff.net> <20150317072844.GA25191@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 19:34:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXwJl-0002Ia-RS
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 19:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbbCQSeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 14:34:08 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:22790 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752679AbbCQSeH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 14:34:07 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.106])
	by bsmtp4.bon.at (Postfix) with ESMTPS id 3l63716RQzz5v31
	for <git@vger.kernel.org>; Tue, 17 Mar 2015 19:34:05 +0100 (CET)
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3l636y4f4sz5tlH;
	Tue, 17 Mar 2015 19:34:02 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 2AAE151F7;
	Tue, 17 Mar 2015 19:34:02 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150317072844.GA25191@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265651>

Am 17.03.2015 um 08:28 schrieb Jeff King:
> +test_expect_success 'create history reachable only from a bogus-named ref' '
> +	test_tick && git commit --allow-empty -m master &&
> +	base=$(git rev-parse HEAD) &&
> +	test_tick && git commit --allow-empty -m bogus &&
> +	bogus=$(git rev-parse HEAD) &&
> +	git cat-file commit $bogus >saved &&
> +	echo $bogus >.git/refs/heads/bogus:name &&

This causes headaches on Windows: It creates an empty file, named 
"bogus", with all the data diverted to the alternate data stream named 
"name". Needless to say that this...

> +test_expect_success 'clean up bogus ref' '
> +	rm .git/refs/heads/bogus:name
> +'

does not remove the file "bogus", but only the alternate data stream (if 
at all---I forgot to check). How about .git/refs/heads/bogus..nam.e?

-- Hannes
