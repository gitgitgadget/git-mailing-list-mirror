From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Wed, 17 Apr 2013 17:56:58 +0200
Message-ID: <87wqs1xi9h.fsf@hexa.v.cablecom.net>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<87txn5xzdn.fsf@linux-k42r.v.cablecom.net>
	<7vd2ttgoyr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 17:57:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USUjM-0004Xk-7v
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 17:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966897Ab3DQP5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 11:57:03 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:59076 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966548Ab3DQP5B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 11:57:01 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 17 Apr
 2013 17:56:55 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 17 Apr
 2013 17:56:58 +0200
In-Reply-To: <7vd2ttgoyr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 17 Apr 2013 08:24:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221550>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> The warning triggers in some cases where it shouldn't, relating to
>> submodules:
>>
>>   $ git submodule add gitosis@git.csa.inf.ethz.ch:domjudge.git domjudge
>>   Adding existing repo at 'domjudge' to the index
>>   warning: In Git 2.0, 'git add <pathspec>...' will also update
>>   the index for paths removed from the working tree that match
>>   the given pathspec. If you want to 'add' only changed
>>   or newly created paths, say 'git add --no-all <pathspec>...' instead.
>
> Good one.  So "add" used internally there needs to say --no-add?

I think the logic in git-add needs to learn about submodules.  The same
warning later trigger when you later say 'git add submoduledir', even
though that obviously doesn't walk inside the submodule.

>> It also seems to hint that the problem is with giving a 'pathspec', but
>> in fact in the case of a "proper" pathspec (that isn't an existing path)
>> it does *not* trigger, even though it probably should:
>
> We have seen users who explicitly say:
>
> 	git add dir
>
> after removing dir/del and adding dir/ins got surprised that we do
> not notice removal of dir/del without "add -A".  And it is fairly
> straight-forward to check and warn for such a case.

I can see that problem, but along the same lines, why shouldn't I have
an expectation that when I say 'git add "*.py"' it removes stuff that I
have removed?  That's what I tried to show with the f?o example.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
