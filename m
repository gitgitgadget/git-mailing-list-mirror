From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 0/2] test_when_finished and returning early
Date: Mon, 8 Aug 2011 03:13:41 +0200
Message-ID: <20110808011341.GA19551@elie.gateway.2wire.net>
References: <20110321105628.GC16334@sigill.intra.peff.net>
 <cover.1300872923.git.git@drmicha.warpmail.net>
 <20110324082108.GA30196@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 03:14:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqEPo-0003Nj-5X
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 03:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664Ab1HHBNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 21:13:55 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42165 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab1HHBNy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 21:13:54 -0400
Received: by gya6 with SMTP id 6so991475gya.19
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 18:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EXGOSxZ6qqnGLFqwgmNzGTd6v0lkNNsnV0dxlRcJ7LI=;
        b=oYIArfbycuZPMvheABLiG9G3YNNLhAQ+lS+Qgf4nUqy/eFeGMwDCwtiBfnSIFV8u3P
         clAmCt9ZwdxM0sGynr7fbaFI3/aoNPA956gq5EyeizlcG13f93fexbmI1kRkYckKXeHv
         jrVcWA7CmQSko5L9hSOG/Mdd1oRIFRl6GMGiQ=
Received: by 10.42.132.72 with SMTP id c8mr4944804ict.505.1312766033622;
        Sun, 07 Aug 2011 18:13:53 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-49-224.dsl.chcgil.sbcglobal.net [69.209.49.224])
        by mx.google.com with ESMTPS id q4sm3821577ibb.32.2011.08.07.18.13.51
        (version=SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 18:13:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110324082108.GA30196@elie>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178931>

Jonathan Nieder wrote:

> The use of "return" was surprising.  It seems this style has been
> intended to work ever since v0.99.5~24^2~4 (Trapping exit in tests,
> using return for errors, 2005-08-10).
>
> It interacts poorly with test_when_finished but since these tests do
> not use that function, they should be safe.  test_when_finished could
> use some fixes to avoid future surprises but that's another story.

The above was about some code that looks like this:

|	for i in 1 2 3 4 5 6 7 8 9 10 11
| 	do
|		git checkout -b root$i five || return

The fixes alluded to might go something like this.  Thoughts?

Jonathan Nieder (2):
  test: simplify return value of test_run_
  test: cope better with use of return for errors

 t/test-lib.sh |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)
