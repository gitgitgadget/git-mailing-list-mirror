From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: how to force a commit date matching info from a mbox ?
Date: Fri, 23 Jan 2009 18:52:09 +0900
Message-ID: <20090123185209.6117@nanako3.lavabit.com>
References: <7vtz7qxsxc.fsf@gitster.siamese.dyndns.org>
 <7vwscm1nic.fsf@gitster.siamese.dyndns.org>
 <7vljt26fp9.fsf@gitster.siamese.dyndns.org>
 <46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com>
 <20090123094529.6117@nanako3.lavabit.com>
 <20090123172646.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git list <git@vger.kernel.org>,
	Christian MICHON <christian.michon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 10:54:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQIjg-00044q-WC
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 10:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759049AbZAWJwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 04:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758968AbZAWJwd
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 04:52:33 -0500
Received: from karen.lavabit.com ([72.249.41.33]:53829 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758945AbZAWJwc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 04:52:32 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 6C3C1C7B31;
	Fri, 23 Jan 2009 03:52:31 -0600 (CST)
Received: from 9469.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id K3JUSX3SM68O; Fri, 23 Jan 2009 03:52:31 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=WwfglQ6g4q9LFF1RSDsrcBmnZKUSZ8bPPkjcWu6Ixp4J352jMfJhaoJ0v4ltcPykvGLN5xDSrABCgQtz6RCa7e5p1TgCfGOX9RmPTkO1uVRZwpTB72y+6bxr0hdCVbaADRQRgj6kajtQCl+2xgG9xdyRBJEy/AKWLxrBc4/ir+I=;
  h=From:To:Cc:Subject:Date:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106870>

Quoting Junio C Hamano <gitster@pobox.com>:

>> --->8---
>> Subject: [PATCH] git-am: Add --ignore-date option
>
> Good.
>
> Leaving "Subject: " in saves me typing, because I do not have to insert it
> manually when editing the submitted patch in my MUA to chop off everything
> before the scissors.

I am sorry to ask you a stupid question, but do you mean you want to have
"Subject: " there, or do you mean you want me to leave that word out?

> I think it would work equally well if you somehow manage to pass this
> through "git-rebase", but this won't work with "git-rebase --interactive".

I can try to change git-rebase if you want, but I do not think I can
modify git-rebase --interactive.  The script looked very scary last time I
looked at it (^_^;;;).

>> +test_expect_success 'am --ignore-date' '
>> +	git checkout first &&
>> +	test_tick &&
>> +	git am --ignore-date patch1 &&
>> +	git cat-file commit HEAD | sed -e "/^$/q" >head1 &&
>> +	at=$(sed -ne "/^author /s/.*> //p" head1) &&
>> +	echo "$at" | grep "+0000"
>> +'
>
> This is a convoluted logic.
>
> The committer and author dates are set to -0700 timezone by test_tick,
> while TZ is set to UTC (+0000) by test-lib.sh, and you are taking
> advantage of them to see which one is being used.
>
> But I do not think of a better way to do this offhand, so I'll let it
> pass.
>
> Regarding the "date -R" thing, I think we can take advantage of the fact
> that an empty GIT_AUTHOR_DATE (and GIT_COMMITTER_DATE) means "do not use
> this environment variable, but use the current date instead".  Something
> like this patch on top of yours, whose first hunk reverts your change to
> use "date -R", and sets GIT_AUTHOR_DATE to empty when --ignore-date is
> asked for.
>
> No, I didn't test it.

I did, and it works.

Thank you very much.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
