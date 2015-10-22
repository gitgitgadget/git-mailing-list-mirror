From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v2 2/2] blame: allow blame --reverse --first-parent when
 it makes sense
Date: Thu, 22 Oct 2015 17:56:06 +0300
Message-ID: <20151022145606.GD5722@wheezy.local>
References: <1445485872-21453-1-git-send-email-max@max630.net>
 <1445485872-21453-3-git-send-email-max@max630.net>
 <xmqqfv13ttq6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Kirillov <max@max630.net>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 16:56:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpHHr-0003qY-FN
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 16:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbbJVO4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 10:56:11 -0400
Received: from p3plsmtpa06-01.prod.phx3.secureserver.net ([173.201.192.102]:40292
	"EHLO p3plsmtpa06-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750877AbbJVO4K (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Oct 2015 10:56:10 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa06-01.prod.phx3.secureserver.net with 
	id YEw51r0075B68XE01Ew7nj; Thu, 22 Oct 2015 07:56:09 -0700
Content-Disposition: inline
In-Reply-To: <xmqqfv13ttq6.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280057>

On Wed, Oct 21, 2015 at 09:25:37PM -0700, Junio C Hamano wrote:
> Max Kirillov <max@max630.net> writes:
> 
>> Do not die immediately when the two flags are specified. Instead
>> check that the specified range is along first-parent chain. Exploit
>> how prepare_revision_walk() handles first_parent_only flag: the commits
>> outside of first-parent chain are either unknown (and do not have any
>> children recorded) or appear as non-first parent of a commit along the
>> first-parent chain.
>>
>> Since the check seems fragile, add test which verifies that blame dies
>> in both cases.
> 
> It is not quite clear in what way the "check seems fragile".
> 
> It is either "correct" or "appears to have worked by chance and
> nobody has any confidence that it would tell if 'it makes sense'
> reliably", and the latter cannot be papered over with any number of
> tests.
> 
> The logic you implemented feels solid to me, at least at a first
> glance.  What kind of gotchas are you worried about?

The fact than arbitrary commit's children are unknown does
not seem reliable to me. It more fits the "works by chance"
description.

Actually, I realized that this can produce false positive if
the final commit is no-ff merged into first-parent chain,
because it woul be both first and non-first parent of the
first-parent chain.
But afaik such merge is not possible to create by frontent git
commands, so I'm not sure I should consider such case.

-- 
Max
