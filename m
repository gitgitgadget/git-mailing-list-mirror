From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Libgit2 on the Summer of Code
Date: Thu, 27 May 2010 20:46:36 +0300
Message-ID: <20100527174636.GB9909@LK-Perkele-V2.elisa-laajakaista.fi>
References: <AANLkTil-M3kQGbRZIacItlwr37Lf3lso7FspftLr43_F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, srabbelier@gmail.com
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 27 19:48:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHhBs-0006CP-QP
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 19:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759387Ab0E0RsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 13:48:14 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:57494 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756760Ab0E0RsN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 13:48:13 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id D18CD13B6E9;
	Thu, 27 May 2010 20:48:11 +0300 (EEST)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A05D719FA81; Thu, 27 May 2010 20:48:11 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id A778527D82;
	Thu, 27 May 2010 20:48:08 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <AANLkTil-M3kQGbRZIacItlwr37Lf3lso7FspftLr43_F@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147889>

On Thu, May 27, 2010 at 06:25:32PM +0200, Vicent Marti wrote:
> 
> All the milestones for the first coding period are mostly finished
> (yay for that) and you can find the code and follow my progress on my
> public github repo [2]. There is some documentation in place, and
> there are some tests in place. In the following days I'll aim for
> about 90% code coverage on the tests, to finish the documentation, and
> then prepare the patch series for review on this list.
> 
> Meanwhile, you are very much welcome to start flaming away before the
> patch series are ready. We have roughly one month and a half to fix up
> my code to the project's standards; hopefully it won't be *that* bad
> and I will be able to implement some extra features before the
> evaluation.

I start the flaming... :->

* I noticed that you seem to format if/while/for like this:

if (foo)
{
    something1;
    something2;
}
else
{
    something3;
    something4;
}

While the existing percedent seems to be:

if (foo) {
	something1;
	something2;
} else {
	something3;
	something4;
}

* Also, you appear to be using 4 spaces for indent, whereas the existing
percedent appears to be indent by tab. Some functions appear to use mixed
indents (sometimes even in one block construct).

* There seems to be some trailing whitespace. I don't know the policies of
libgit2 on that, but I suppose it is not supposed to be there.

* git_commit_list_push_back() fails silently if memory allocation fails. Is
it supposed to? Same for git_commit_list_push_front().

* Where algorithm in git_revpool_table__hash() is from? Since it appears to
hash binary object IDs, wouldn't just simple sum/xor over words be sufficient
(all SHA-1 output bits are very nearly independent). Or do you need to be
compatible with some other implementation (doesn't appear so, because hash
is computed differently depending on endianess)?

* gitrp_push() just returns if git_commit_parse_existing() fails. But causes
of that failing seemingly can include ODB read errors, which are fairly
serious...

* Is gitrp__enroot() supposed to just ignore failures of
git_commit_parse_existing()? is 'commit->parents.head' valid even in this
case?

* There are numerious cases where function that suspiciously lacks error
code is called (if error code is added, it presumably needs to be bubbled
back to caller).

-Ilari
