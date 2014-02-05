From: Yuri <yuri@rawbw.com>
Subject: Re: 'git log' escape symbols shown as ESC[33 and ESC[m
Date: Tue, 04 Feb 2014 17:24:55 -0800
Message-ID: <52F192E7.1000301@rawbw.com>
References: <52D87A79.6060600@rawbw.com> <20140117014758.GF7249@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 05 02:25:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WArEl-0003iw-18
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 02:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbaBEBZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 20:25:04 -0500
Received: from shell0.rawbw.com ([198.144.192.45]:50608 "EHLO shell0.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638AbaBEBZD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 20:25:03 -0500
Received: from eagle.yuri.org (stunnel@localhost [127.0.0.1])
	(authenticated bits=0)
	by shell0.rawbw.com (8.14.4/8.14.4) with ESMTP id s151OtnH047276;
	Tue, 4 Feb 2014 17:24:56 -0800 (PST)
	(envelope-from yuri@rawbw.com)
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140117014758.GF7249@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241590>

On 01/16/2014 17:47, Jeff King wrote:
> Are you using "less" as your pager (it is the default in git unless you
> have set your PAGER environment variable)? If so, do you have the "R"
> option set to pass through ANSI codes? Git will set this automatically
> in your "LESS" variable if you do not already have such a variable (but
> it will not touch it if you already have it set, and are missing "R").


I think the 'experimental' approach is simpler and better.
When the git command requiring pager is first run, git would run the 
pager with some simple one line escape sequence, and see if sequence is 
preserved. If it was preserved, git should just run with escape 
sequences. If the pager destroyed the sequence, git should issue a 
warning to the user:
git: your default pager PAGER=more doesn't pass escape sequences, and 
they will be disabled them. You can revert this  decision by changing 
the file ~/.git/pager.conf

This way:
* damaged sequences will not show up by default
* colors will be displayed by default when possible
* user would be informed, and will have a clear choice
* this is easy to implement, and no elaborate and obscure reasoning 
should be employed in the implementation

For me, if git would have told me that my pager doesn't support escape 
sequences, I could have taken it from there.

Yuri
