From: Alex Vandiver <alex@chmrr.net>
Subject: Re: Race condition in git push --mirror can cause silent ref rewinding
Date: Wed, 02 Jul 2014 19:10:43 -0400
Message-ID: <53B49173.4020001@chmrr.net>
References: <53B47535.3020101@chmrr.net> <xmqqfvijflnr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 01:11:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2TgS-0007gb-BF
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 01:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbaGBXLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 19:11:20 -0400
Received: from chmrr.net ([209.67.253.66]:44308 "EHLO utwig.chmrr.net"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751403AbaGBXLT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 19:11:19 -0400
Received: from 75-147-59-54-newengland.hfc.comcastbusiness.net ([75.147.59.54] helo=[10.1.10.102])
	by utwig.chmrr.net with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.76)
	(envelope-from <alex@chmrr.net>)
	id 1X2Tfl-0004Eq-58; Wed, 02 Jul 2014 19:11:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqfvijflnr.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Exim-Version: 4.76 (build at 25-May-2011 17:04:25)
X-Date: 2014-07-02 19:11:10
X-Connected-IP: 75.147.59.54:56792
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252851>

On 07/02/2014 06:20 PM, Junio C Hamano wrote:
> Alex Vandiver <alex@chmrr.net> writes:
> 
>>     [remote "github"]
>>         url = git@github.com:bestpractical/rt.git
>>         fetch = +refs/*:refs/*
>>         mirror = yes
> 
> "git push github master^:master" must stay a usable way to update
> the published repository to an arbitrary commit, so "if set to
> mirror, do not pretend that a fetch in reverse has happened during
> 'git push'" will not be a solution to this issue.

Hm?  I'm confused, as mirror isn't compatible with refspecs:

$ git push github master^:master
error: --mirror can't be combined with refspecs

> Perhaps removing remote.github.fetch would be one sane way forward.

Ahh -- I see.  The repository predates a9f5a355, which split `git remote
add --mirror` into `--mirror=push` and `--mirror=fetch`, because of more
or less this exact problem.  Of course, there is nothing much that can
be done for existing repositories in this situation as it's a legitimate
combination.
 - Alex
