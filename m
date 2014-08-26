From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/3] log-tree: make add_name_decoration a public function
Date: Tue, 26 Aug 2014 12:48:24 +0100
Message-ID: <53FC7408.1030708@ramsay1.demon.co.uk>
References: <20140826102051.GA4885@peff.net> <20140826102335.GA25687@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 13:48:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMFEp-0003V6-BT
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 13:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757595AbaHZLsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 07:48:31 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:55558 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754812AbaHZLsa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 07:48:30 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 5D2076F8B94;
	Tue, 26 Aug 2014 12:48:01 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 16C036F8B83;
	Tue, 26 Aug 2014 12:48:01 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Tue, 26 Aug 2014 12:47:59 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140826102335.GA25687@peff.net>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255889>

On 26/08/14 11:23, Jeff King wrote:
> The log-tree code keeps a "struct decoration" hash to show
> text decorations for each commit during log traversals. It
> makes this available to other files by providing global
> access to the hash. This can result in other code adding
> entries that do not conform to what log-tree expects.
> 
> For example, the bisect code adds its own "dist"
> decorations to be shown. Originally the bisect code was
> correct, but when the name_decoration code grew a new field
> in eb3005e (commit.h: add 'type' to struct name_decoration,
> 2010-06-19), the bisect code was not updated. As a result,
> the log-tree code can access uninitialized memory and even
> segfault.
> 
> We can fix this by making name_decoration's adding function
> public. If all callers use it, then any changes to structi

s/structi/struct/

> initialization only need to happen in one place (and because
> the members come in as parameters, the compiler can notice a
> caller who does not supply enough information).
> 
> As a bonus, this also means that the decoration hashes
> created by the bisect code will use less memory (previously
> we over-allocated space for the distance integer, but not we

s/not/now/

> format it into a temporary buffer and copy it to the final
> flex-array).
> 
> Signed-off-by: Jeff King <peff@peff.net>

ATB,
Ramsay Jones
