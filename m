From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] test-string-list.c: Fix some sparse warnings
Date: Wed, 19 Sep 2012 20:07:01 +0100
Message-ID: <505A17D5.2000406@ramsay1.demon.co.uk>
References: <5054AA62.2040603@ramsay1.demon.co.uk> <5056DC28.60809@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Christopher Li <sparse@chrisli.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 19 21:10:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEPfU-0002ZV-0v
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 21:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756916Ab2ISTK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 15:10:28 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:33444 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755457Ab2ISTKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 15:10:25 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 0FED9400286;
	Wed, 19 Sep 2012 20:10:24 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])	by mdfmta010.tch.inty.net (Postfix) with ESMTP id ED2D740024D;	Wed, 19 Sep 2012 20:10:22 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta010.tch.inty.net (Postfix) with ESMTP;	Wed, 19 Sep 2012 20:10:21 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <5056DC28.60809@alum.mit.edu>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205981>

Michael Haggerty wrote:
> On 09/15/2012 06:18 PM, Ramsay Jones wrote:
>>
>> In particular, sparse complains as follows:
>>
>>         SP test-string-list.c
>>     test-string-list.c:10:6: warning: symbol 'parse_string_list' was not \
>>         declared. Should it be static?
>>     test-string-list.c:18:6: warning: symbol 'write_list' was not \
>>         declared. Should it be static?
>>     test-string-list.c:25:6: warning: symbol 'write_list_compact' was not \
>>         declared. Should it be static?
>>     test-string-list.c:38:5: warning: symbol 'prefix_cb' was not \
>>         declared. Should it be static?
>>
>> In order to suppress the warnings, since the above symbols do not
>> need more than file scope, we simply include the static modifier
>> in their declaration.
> 
> Thanks for fixing this.
> 
> Is there some documentation about how to run sparse on the git codebase?
>  I naively tried "make sparse" and ended up with zillions of errors like
> 
> /usr/include/unistd.h:288:54: error: attribute '__leaf__': unknown attribute
> /usr/include/unistd.h:294:6: error: attribute '__leaf__': unknown attribute
> /usr/include/unistd.h:298:6: error: attribute '__leaf__': unknown attribute
> /usr/include/unistd.h:306:6: error: attribute '__leaf__': unknown attribute
> /usr/include/unistd.h:338:18: error: attribute '__leaf__': unknown attribute
> /usr/include/unistd.h:347:6: error: attribute '__leaf__': unknown attribute
> /usr/include/unistd.h:418:36: error: attribute '__leaf__': unknown attribute
> /usr/include/unistd.h:423:50: error: attribute '__leaf__': unknown attribute

Yep, "make sparse" is the correct way to run sparse over git.

This looks like you are running sparse on a 64-bit system. I have heard that
it has (or *had*) problems running on 64-bit systems. Unfortunately, I am
currently confined to 32-bit. (I'm looking at getting a new laptop soon, before
Windows 8 causes boot-time problems, so I will then have the same problem!)

How did you obtain/build/install sparse? The current release (v0.4.4) was
released about Nov 2011 and I think you need a more up to date version.
i.e. you need to build the latest, directly from the sparse repo.

Note that the repo on kernel.org is currently dormant. Christopher moved the
active development to github: http://github.com/sparsecli/sparse

In particular, I *think* that the following commits (among others) may improve
your experience of running sparse on git:

    b0b4886 sparse: Add 'leaf' to ignored attributes.
    7aa79f8 Adding default for m64/m32 handle
    2313167 sparse: Add '__vector_size__' to ignored attributes
    0a04210 sparse: Add 'error' to ignored attributes

(These are all post v0.4.4)

Note that I "make sparse" on Linux, cygwin and MinGW. (All 32-bit, of course)
Only cygwin is "sparse clean". :-D

Linux has a handfull of warnings, mainly due to the system header files
using features not supported by sparse; e.g. transparent unions. (It's on
my TODO list!). I have a few patches which I keep forgetting to push back
upstream ...

I "ported" sparse to MinGW about three years ago. I have yet to "tidy up"
the patches and push them upstream. (*ahem*) I have a shed-load of patches
to fix sparse warnings on git. However, since (as far as I know) nobody can
confirm they actually fix anything ... ;-)

HTH

ATB,
Ramsay Jones
