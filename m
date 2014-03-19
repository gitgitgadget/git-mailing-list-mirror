From: Dragos Foianu <dragos.foianu@gmail.com>
Subject: Re: [PATCHv2] branch.c: simplify chain of if statements
Date: Wed, 19 Mar 2014 23:12:14 +0000 (UTC)
Message-ID: <loom.20140320T001131-702@post.gmane.org>
References: <1395071493-31435-1-git-send-email-dragos.foianu@gmail.com> <CAPig+cS9QApn1T3-R8n+W+1ee9FbNftsmhrr90SJKs+gqzvC5A@mail.gmail.com> <CAPig+cQKHQFNBob18g9UmZuE_mOpF3UMCBPfSKJYEYQpk1Z_tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 00:13:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQPfb-0004Ae-Jk
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 00:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882AbaCSXMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 19:12:47 -0400
Received: from plane.gmane.org ([80.91.229.3]:38966 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbaCSXMq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 19:12:46 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WQPfA-0003Ss-IB
	for git@vger.kernel.org; Thu, 20 Mar 2014 00:12:44 +0100
Received: from 109.100.93.176 ([109.100.93.176])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 00:12:44 +0100
Received: from dragos.foianu by 109.100.93.176 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 00:12:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.100.93.176 (Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Firefox/24.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244507>

Eric Sunshine <sunshine <at> sunshineco.com> writes:

> 
> Other submissions have computed this value mathematically without need
> for conditionals. For instance, we've seen:
> 
>     index = (!!origin << 0) + (!!remote_is_branch << 1) + (!!rebasing << 2)
> 
> as, well as the equivalent:
> 
>     index = !!origin + !!remote_is_branch * 2 + !!rebasing * 4
> 
> Although this works, it does place greater cognitive demands on the
> reader by requiring more effort to figure out what is going on and how
> it relates to table position. The original (ungainly) chain of 'if'
> statements in the original code does not suffer this problem. It
> likewise is harder to understand than merely indexing into a
> multi-dimension table where each variable is a key.

I have seen other submissions using this logic, but I didn't think it
accomplished the goal of the patch - simplifying the code. Not that my
approach does either, but I found it a little easier to understand.

Indexing into a table like this is always going to have this problem so this
is probably not the right approach to accomplishing the microproject's goals.

> It's possible to simplify this logic and have only a single
> printf_ln() invocation. Hint: It's safe to pass in more arguments than
> there are %s directives in the format string.

Indeed. It's a habit of mine to pass the exact number of arguments to printf
functions and I can't seem to get away from it.

> You can use ARRAY_SIZE() in place of sizeof(...)/sizeof(...).
> 
> Since an out-of-bound index would be a programmer bug, it would
> probably be more appropriate to use an assert(), just after 'index' is
> computed, rather than if+die(). The original code used die() because
> it couldn't detect the error until the end of the if-chain.

Thank you for this hint. Using already defined helpers in the project is
better and will prevent the need to patch the constructs later on.

> On Tue, Mar 18, 2014 at 6:31 PM, Eric Sunshine <sunshine <at>
sunshineco.com> wrote:
> 
> One other observation: You have a one-off error in your out-of-bounds
> check. It should be 'index >= sizeof...'

Well this is embarrasing.

Thank you again for the feedback. It's incredibily helpful and I learned a
lot from submitting these patches. Making the code simple is harder than it
appears at first sight.

I'm not sure it's worth pursuing the table approach further, especially
since a solution has already been accepted and merged into the codebase.

In this case, is it okay to try another microproject? I was thinking about
trying #17 (finding bugs/inefficiencies in builtin/apply.c), but I've
already had my one microproject.

All the best,
Dragos
