From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: jn/config-ignore-inaccessible (Re: What's cooking in git.git (Apr 2013, #10; Mon, 29))
Date: Mon, 6 May 2013 11:54:23 +0200
Message-ID: <8738u0igc0.fsf@linux-k42r.v.cablecom.net>
References: <7vppxdgife.fsf@alter.siamese.dyndns.org>
	<87y5bvyw7j.fsf@hexa.v.cablecom.net>
	<20130504201414.GA2420@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 06 11:54:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZI7q-0005i0-VF
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 11:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569Ab3EFJy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 05:54:26 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:47626 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753490Ab3EFJy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 05:54:26 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 6 May
 2013 11:54:23 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 6 May 2013 11:54:23 +0200
In-Reply-To: <20130504201414.GA2420@elie.Belkin> (Jonathan Nieder's message of
	"Sat, 4 May 2013 13:14:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223435>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thomas Rast wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>
>>> * jn/config-ignore-inaccessible (2013-04-15) 1 commit
>>>  - config: allow inaccessible configuration under $HOME
>>>
>>>  When $HOME is misconfigured to point at an unreadable directory, we
>>>  used to complain and die. This loosens the check.
>>>
>>>  I do not think we agreed that this is a good idea, though.
>>
>> As a data point: yesterday on IRC, two users complained that they each
>> had this problem.
>>
>>   http://colabti.org/irclogger/irclogger_log/git?date=2013-05-03#l3022
>>   http://colabti.org/irclogger/irclogger_log/git?date=2013-05-03#l3111
>
> I think the approach taken in the patch above is a good one.  If
> /etc/gitconfig contains important configuration, it is still not
> ignored, errors other than permissions reading ~/.gitconfig are
> still fatal, and permissions errors accessing ~/.gitconfig are no
> longer fatal because they are expected as something very common
> in normal setups.
>
> I haven't been able to convince myself there is a different, better
> behavior to be found.  Special-casing inaccessible $HOME while still
> forbidding inaccessible $HOME/.config/git and $HOME/.gitconfig would
> seem strange.

What I found iffy about all of it is that the current failures happen
really late: they prevent the children spawned by the daemon for repo
handling from doing any useful work, while the daemon itself chugs along
nicely.

Wouldn't it be better to (attempt to) reload configs immediately after
switching to the new user/group, and then either warn or exit?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
