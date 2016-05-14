From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] t9801 and t9803 broken on next
Date: Sat, 14 May 2016 11:15:42 -0700
Message-ID: <xmqq37pk8q0h.fsf@gitster.mtv.corp.google.com>
References: <3A110437-F778-42E2-A987-86B4EAB3D963@gmail.com>
	<20160513103621.GA12329@dcvr.yhbt.net>
	<xmqqpospap8g.fsf@gitster.mtv.corp.google.com>
	<4830D469-3885-4010-9A04-D809F0C6159D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <e@80x24.org>, Git Users <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 14 20:15:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1e6V-000625-KY
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 20:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbcENSPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 14:15:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51437 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752140AbcENSPq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 14:15:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E274818588;
	Sat, 14 May 2016 14:15:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WtaQHgYdsPJrG1XB6itqJibT/FI=; b=DQZyDM
	u7IGj3PVbN6dSomyIc2a5sHITBwpiL69WEJ4lnfJTnsL8qPbMaTsTePG0Ka+/pvA
	QpNGEdKjVpYHHX52K2a1hqwE25jOJ2Rqh99n1pMIAN2yngPl9Rt0E1tMFmCKiv12
	3ssKofYARQkcZMyRl3t0UQmlqd82lldTivAPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RhMY9iEZh9IF+04xVkLHcuXRPX/0MZpm
	huXk2A1riDuPycxNUwnjkNN9gRWd2uMvKIVvp9k3KKUPr1mGyAQYwOo04dutaNVd
	e6yG7zGEuR37lrwsM+kEvaWsNeyFARMvX5nrPmcbCnU9yJuxHJH3Fh7dGzGcyBy6
	xUtWVMk/rNw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DACCD18587;
	Sat, 14 May 2016 14:15:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 64CDA18586;
	Sat, 14 May 2016 14:15:44 -0400 (EDT)
In-Reply-To: <4830D469-3885-4010-9A04-D809F0C6159D@gmail.com> (Lars
	Schneider's message of "Sat, 14 May 2016 10:04:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DFD8C508-19FF-11E6-88BC-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294619>

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 13 May 2016, at 18:37, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> Are you saying that "git p4" itself breaks unless fast-import always
>> writes a new (tiny) packfile?  That sounds quite broken, and setting
>> unpacklimit to 0 does not sound like a sensible "fix".  Of course,
>> if the test script is somehow looking at the number of packs or
>> loose objects and declaring a failure, even when the resulting
>> history in p4 and git are correct, then that is a different issue,
>> and forcing to explode a tiny pack is a reasonable workaround.  I
>> couldn't quite tell which the case is.
>> 
>> Puzzled.  Please help.
>
> t9801 "import depot, branch detection" is the first test that fails
> with a fast import error:
> https://github.com/git/git/blob/78b384c29366e199741393e56030a8384110760d/t/t9801-git-p4-branch.sh#L110
>
> fast-import crash report:
>     fast-import process: 77079
>     parent process     : 77077
>     at 2016-05-14 07:48:40 +0000
>
> fatal: offset beyond end of packfile (truncated pack?)

Hmm, does that suggest Eric's "explode them into loose instead of
keeping a small pack" insufficient?  It sounds like that somebody
wanted to read some data back from its packfile without knowing that
the updated code may make it available in a loose object form, which
would mean that somebody needs to be told about what is going on,
namely, these objects are not in a half-written pack but are found
as loose objects.

> The problem seems to be related to the git-p4 branch import.
> I don't have time this weekend to look further into it, but
> I will try next week.

Thanks.
