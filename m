From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule: no [--merge|--rebase] when newly cloned
Date: Wed, 16 Feb 2011 21:10:27 +0100
Message-ID: <4D5C2F33.8020309@web.de>
References: <1297860417-21895-1-git-send-email-olsonse@umich.edu> <7v62sjkbbi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Spencer E. Olson" <olsonse@umich.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 21:10:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppnht-0003u6-7D
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 21:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221Ab1BPUKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 15:10:32 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:38693 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753757Ab1BPUKa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 15:10:30 -0500
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id B3C7B19814472;
	Wed, 16 Feb 2011 21:10:27 +0100 (CET)
Received: from [93.246.53.236] (helo=[192.168.178.43])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Ppnhj-0000ay-00; Wed, 16 Feb 2011 21:10:27 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7v62sjkbbi.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18Rkd/TJjHVfCU/KxiUedpnLujnI54PaC8YOXUJ
	fGrONlKd7Texo46cUVJ8WYi8ZegVDhTSzmAF7COPaQZJLwnUMy
	zR/uyIqiA4caMim2ep7w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166998>

Am 16.02.2011 20:51, schrieb Junio C Hamano:
> "Spencer E. Olson" <olsonse@umich.edu> writes:
> 
>> Previously, when a submodule was cloned in the same command execution, --rebase
>> or --merge would attempt to run (instead of and) before a checkout, resulting in
>> an empty working directory.  This patch ignores --rebase or --merge for a
>> particular submodule when that submodule is newly cloned and instead simply
>> checks out the appropriate revision.
> 
> Sorry, but I cannot parse the problem description, "(instead of and)" part.

I think what he wanted to say was that after a new submodule is cloned
by running "git submodule update" it will attempt to do a rebase or
merge without having checked out the submodule at all, which obviously
can't work. A plain checkout looks like the right thing to do, as there
aren't any local commits to rebase or merge yet.

> Why is it a better thing to do to ignore these options, instead of
> detecting the situation and error it out, saying "you are initially
> cloning, don't say --rebase"?

It should be fine to use these options when new submodules appear.
(And even without explicitly specifing these command line options
this bug can also be triggered by having the "submodule.<name>.update"
option set in .gitmodules to either "rebase" or "merge", which is easy
to miss)

So this looks like a worthwhile fix. The commit message and POSIX issue
need to be addressed, tests would be a good thing to add too, but apart
from that it looks sane.
