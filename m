From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: What's the difference between =?utf-8?b?YGdpdA==?= show branch:file =?utf-8?b?fA==?= diff -u - =?utf-8?b?ZmlsZWA=?= vs =?utf-8?b?YGdpdA==?= diff branch =?utf-8?b?ZmlsZWA/?=
Date: Fri, 26 Aug 2011 09:43:31 +0000 (UTC)
Message-ID: <loom.20110826T113153-510@post.gmane.org>
References: <loom.20110823T091132-107@post.gmane.org> <4E537AF0.9070604@drmicha.warpmail.net> <1314096731.15017.2.camel@n900.home.ru> <4E53C89A.9000604@drmicha.warpmail.net> <7vk4a4rqvb.fsf@alter.siamese.dyndns.org> <4E54088F.7050700@drmicha.warpmail.net> <7vy5yhi4eq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 11:43:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwsxA-0007z7-Oq
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 11:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650Ab1HZJnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 05:43:51 -0400
Received: from lo.gmane.org ([80.91.229.12]:56130 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753948Ab1HZJnu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 05:43:50 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Qwsx1-0007sh-0X
	for git@vger.kernel.org; Fri, 26 Aug 2011 11:43:49 +0200
Received: from 195.218.191.171 ([195.218.191.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Aug 2011 11:43:47 +0200
Received: from marat by 195.218.191.171 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Aug 2011 11:43:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 195.218.191.171 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.112 Safari/534.30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180159>

Junio C Hamano <gitster <at> pobox.com> writes:
> An interesting comparison may be to run this once:
> 
>    $ git show branch:file >fileI
> 
> and then compare between these two:
> 
>     $ diff -u fileI file
>     $ git diff --no-index fileI file

In all times below, "file" is the same file i used in original report.

$ time diff -u fileI file > /dev/null 

real    0m0.002s
user    0m0.000s
sys     0m0.000s

$ time git diff --no-index fileI file > /dev/null 

real    0m0.331s
user    0m0.270s
sys     0m0.060s

Same with "pu" branch (has 27af01d):
$ time ~/git/git-diff --no-index fileI file > /dev/null 

real    0m0.307s
user    0m0.220s
sys     0m0.080s

> 
> If the latter is slower than the former in the same way as the original
> experiment, that would mean that the tree traversal time does not have
> anything to do with it (iow, your "The way 'git diff' is now, it does
> that" is not just incorrect---we don't read the full tree to begin
> with---but irrelevant).
I still suspect tree traversal. Original report with "pu" branch is still 30s.
