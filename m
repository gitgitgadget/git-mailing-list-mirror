From: Charlie Smurthwaite <charlie@atechmedia.com>
Subject: Re: Segfault with merge-tree on multiple Git versions
Date: Wed, 27 Mar 2013 21:10:59 +0000
Message-ID: <51536063.50405@atechmedia.com>
References: <51531059.8000407@atechmedia.com> <7vsj3gn55b.fsf@alter.siamese.dyndns.org> <515331F2.3060703@atechmedia.com> <874nfw4t0r.fsf@59A2.org> <51533E8D.5050206@atechmedia.com> <87zjxo3b7b.fsf@59A2.org> <20130327194521.GQ2286@serenity.lan> <20130327200113.GC26380@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: John Keeping <john@keeping.me.uk>, Jed Brown <jed@59A2.org>,
	Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 27 22:11:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKxdD-0001VS-F8
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 22:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060Ab3C0VLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 17:11:10 -0400
Received: from smtp.atechmedia.net ([109.104.109.18]:36017 "EHLO
	smtp.atechmedia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023Ab3C0VLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 17:11:09 -0400
Received: by smtp.atechmedia.net (Postfix, from userid 2002)
	id DC2CFC11F1; Wed, 27 Mar 2013 21:09:25 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on smtp.atechmedia.net
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,HELO_NO_DOMAIN
	autolearn=no version=3.3.1
Received: from exchange.atechmedia.net (exchange.atechmedia.net [109.104.109.9])
	by smtp.atechmedia.net (Postfix) with ESMTP id 22CD8C0218;
	Wed, 27 Mar 2013 21:09:24 +0000 (GMT)
Received: from [IPv6:2001:9d8:2005:12::3] (2001:9d8:2005:12::3) by
 exchange.atechmedia.net (2001:9d8:2005:1::9) with Microsoft SMTP Server (TLS)
 id 14.1.438.0; Wed, 27 Mar 2013 21:11:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <20130327200113.GC26380@sigill.intra.peff.net>
X-Originating-IP: [2001:9d8:2005:12::3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219332>

On 27/03/13 20:01, Jeff King wrote:
> On Wed, Mar 27, 2013 at 07:45:21PM +0000, John Keeping wrote:
>
>> On Wed, Mar 27, 2013 at 02:16:24PM -0500, Jed Brown wrote:
>>> Charlie Smurthwaite <charlie@atechmedia.com> writes:
>>>
>>>> Yes, I would need to be able to do this on a bare repo for my use case.
>>> And if it's on the server, you don't want this to be observable, so
>>> you don't want HEAD to move around. I don't know a better way than:
>>>
>>>    $ git clone --shared -b upstream-branch bare-repo.git /tmp/merge-repo
>>>    $ cd /tmp/merge-repo
>>>    $ git pull URL incoming-branch
>>>
>>> Cloning with --shared just writes a path into .git/objects/info/alternatives
>>> and it doesn't need to be on the same file system (unlike --local).
>>>
>>> Since 'git merge-tree' just works with trees, it has less information
>>> than 'git merge'.
>> You could use a temporary index and do something like:
>>
>> 	rm -f TMP_INDEX
>> 	GIT_INDEX_FILE=TMP_INDEX
>> 	export GIT_INDEX_FILE
>> 	git read-tree -m $base $ours $theirs &&
>> 	git merge-index git-merge-one-file -a
>>
>> then inspect that with "git diff-index --cached $ours".
> That is precisely how we do it at GitHub. You probably want to add in
> "--aggressive" to your read-tree to cover a few more simple cases. If
> there are conflicts, we just bail and say "this can't be merged", and
> expect the user to do it themselves using git.
>
> -Peff

This may be ideal. I will compare it with merge-tree to see which will 
suit best. Thank you everyone for your help here.

Charlie
