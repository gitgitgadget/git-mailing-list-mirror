From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] git-merge: add support for branch.<name>.mergeoptions
Date: Sun, 23 Sep 2007 12:20:49 -0700
Message-ID: <7vr6kpchny.fsf@gitster.siamese.dyndns.org>
References: <1190421186-21784-1-git-send-email-hjemli@gmail.com>
	<1190421186-21784-2-git-send-email-hjemli@gmail.com>
	<1190421186-21784-3-git-send-email-hjemli@gmail.com>
	<1190421186-21784-4-git-send-email-hjemli@gmail.com>
	<7vps0adx0x.fsf@gitster.siamese.dyndns.org>
	<8c5c35580709230331h459bd07ay8b17146b5feec212@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 21:20:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZX0g-0003JZ-1m
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 21:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbXIWTUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 15:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbXIWTUu
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 15:20:50 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:57699 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbXIWTUu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 15:20:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070923192050.YHZV24061.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 23 Sep 2007 15:20:50 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo02.cox.net with bizsmtp
	id rvLp1X00P1gtr5g0000000; Sun, 23 Sep 2007 15:20:49 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58979>

"Lars Hjemli" <hjemli@gmail.com> writes:

> On 9/23/07, Junio C Hamano <gitster@pobox.com> wrote:
>> Lars Hjemli <hjemli@gmail.com> writes:
>> > +branch=$(git-symbolic-ref HEAD | sed -e 's|^refs/heads/||')
>> > +mergeopts=$(git config "branch.$branch.mergeoptions")
>> > +parse_config $mergeopts
>>
>> What should happen when your head is detached?
>>
>
> My plan was 'nothing', but I should have tested it (it does work, but
> also prints an ugly "fatal: ref HEAD is not a symbolic ref").

That, and also running "git config branch..mergeoptions" and
expect it does not change behaviour to issue more strict
warning, are both not so good.  Perhaps the code needs to be
more defensive like:

    if branch=$(git symbolic-ref -q HEAD)
    then
        mergeopts=$(git config "branch.${branch#refs/heads/}.mergeoptions")
	if test -n "$mergeopts"
        then
	    parse_config $mergeopts
	fi
    fi


 
