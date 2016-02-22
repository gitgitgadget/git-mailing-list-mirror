From: Moritz Neeb <lists@moritzneeb.de>
Subject: Re: [PATCH 1/5] bisect: read bisect paths with strbuf_getline()
Date: Mon, 22 Feb 2016 01:07:34 +0100
Message-ID: <56CA5146.7050008@moritzneeb.de>
References: <56ACF82B.2030005@moritzneeb.de> <56ACFB03.3020000@moritzneeb.de>
 <xmqqlh74unja.fsf@gitster.mtv.corp.google.com> <56C0EB3F.90202@moritzneeb.de>
 <xmqqtwlar2bd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 02:24:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXfES-0006LV-Vl
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 02:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbcBVBXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 20:23:49 -0500
Received: from moritzneeb.de ([78.47.1.106]:55729 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557AbcBVBXs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 20:23:48 -0500
Received: from [192.168.1.3] (x55b377aa.dyn.telefonica.de [85.179.119.170])
	by moritzneeb.de (Postfix) with ESMTPSA id E796D1C0F5;
	Mon, 22 Feb 2016 02:23:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456104225;
	bh=fnmd1qYvXxKJGoyIpjvkmEwR1Mg85rI3v5ldhDs+5K8=;
	h=From:Subject:To:References:Cc:Date:In-Reply-To:From;
	b=ey/CUTsleOOpWUUYcbFEZSCUYJH8LbszULcu1fneZ5dpfbIYvDRl3y6imWU3ZxT/d
	 fNwb9WsKMgRgbpsqEMjUboMjZ5BtaopAwS19usCzKd//lY/ZUd53ioOcP/mFS/+UyZ
	 EJZW1r3N1LEkUrvVT9i7STSwKcNDZxQNH0ypLVPw=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <xmqqtwlar2bd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286864>

On 02/15/2016 06:05 AM, Junio C Hamano wrote:
> As to bisect pathspec, while I do not think it is sensible to change
> it in the middle of bisection, I do not think it would cause the
> bisect command to produce an incorrect result if you did so.  You
> would be changing the definition of what is the "middle point" of
> the history on the fly by changing the pathspec, hence you may end
> up making the bisection suboptimal, but it shouldn't affect the
> correctness of the bisection.

Yep I also think it would not affect the correctness. To reformulate
your explanation: changing the pathspec does not change the good and bad
"frontiers". And those should be still correct under the assumption
you're still looking for the same bug/regression.

As to the question if it is sensible, I also don't really think it could
be helpful. The only way I would expect it to be useful, it so "refine"
the search by adding specific files to the filepath. But then it's
possible to end up in a dead-end if the commits left are not touching
the specified files with:

	No testable commit found.
	Maybe you started with bad path parameters?

I have also seen other messed up messages, like "-1 commits left" while
playing around.

> So I tend to agree with you that it is a good idea to be prepared to
> parse what the end user may have futzed with the editor, as long as
> the user did not break the syntax of the quoted string.

Now I am not convinced anymore, because I think if it potentially leads
to troubles, it should not be made easier to get oneself into them.

> 	Side note: of course, you can instead say "while it is
> 	technically possible, we have never advertised this file to
> 	be editable by user, or encouraged them to do so" and
> 	tighten the parsing to assume only what we write out,
> 	erroring out when we see any attempt to edit it.

I will include something like that in the patch v2 that is to follow soon.
