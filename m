From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Probably a bug with "~" symbol in filenames on Windows 7 x64 in git 1.9.5
Date: Thu, 08 Jan 2015 11:08:47 -0800
Message-ID: <xmqqegr5f5ts.fsf@gitster.dls.corp.google.com>
References: <CADb7K9rELHWgy_NYJWrSr9gZn7pcMvETv93d0j+u2fXinj5iTg@mail.gmail.com>
	<CAPc5daVddkaMkx=43nCeQKbbkrV6nExOqvEBJNyugzDQB2n6kQ@mail.gmail.com>
	<alpine.DEB.1.00.1501081100570.21312@s15462909.onlinehome-server.info>
	<20150108102815.GA4806@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Dmitry Bykov <pvrt74@gmail.com>, msysgit@googlegroups.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 08 20:09:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9IS4-00074D-W8
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 20:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756315AbbAHTI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 14:08:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51432 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755580AbbAHTIz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 14:08:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CF17A2DFA7;
	Thu,  8 Jan 2015 14:08:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2SpmU6Y7urQmSswYGHrR+Egeq9g=; b=io5nUZ
	iE+l+uaYL+4bxrIiWs+IYFb8LBGYKk4+KdTQkhJyMj+H/tUG+qFHo3bWn48OeDTN
	ILGvBUVleJDOKA5Gje7L9X8rdGNPNXwPxxRBEQP8INBCYC2JJ0NGbyVBk3KhCFvi
	KBw1msvnV8PFcgE5oxopcKL6URIafiP7+7BqE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kAeYRsCgivzJt+U5eT/29SZsdgesx/Yp
	Q74WqQrzxbBNKe2/hAi6cbmaz9MVMAfDSMc+XZw31ZIV/PlxrSlzpUl2dptks34U
	b2Cf4E4u0Ez3cQZoIruiD2UWakDJi/pEjvwvYtCH8dIkQmAmB//ya+AuRsTsuYvw
	bo7qidLBeXs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C59802DFA6;
	Thu,  8 Jan 2015 14:08:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 48E012DFA3;
	Thu,  8 Jan 2015 14:08:49 -0500 (EST)
In-Reply-To: <20150108102815.GA4806@peff.net> (Jeff King's message of "Thu, 8
	Jan 2015 05:28:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C6FC8B92-9769-11E4-9D31-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262207>

Jeff King <peff@peff.net> writes:

> On Thu, Jan 08, 2015 at 11:06:18AM +0100, Johannes Schindelin wrote:
>
>> ICON~714.PNG is a valid short name for a long name (such as
>> 'icon.background.png') because it fits the shortening scheme (8.3 format,
>> the base name ends in ~<n>). As this can clash with a validly shortened
>> long name, Git for Windows refuses to check out such paths by default.
>> 
>> If you want the old -- unsafe -- behavior back, just set your
>> core.protectNTFS to false (this means that you agree that the incurred
>> problems are your own responsibility and cannot be blamed on anybody else
>> ;-))
>
> I wonder if it is worth having a "git-only" mode for core.protectNTFS.
> Turning it off entirely would make him susceptible to GIT~1 attacks.

Yes, I think having distinctions would make sense, but I am not sure
if "git-only" vs "every questionable included" should be the
classification.

To classify various funniness of paths by the extent of damage they
may cause for Windows:

 - ".Git" and "GIT~1" would be the worst level; 

 - "CON.c" and the like would be the next bad level; and

 - "ICON~714.PNG" would be in "to be avoided in an ideal world but
   as long as the project is comfortable with having it in, Git is
   in no position to complain" level.

that is just my knee-jerk reaction.

And if we were to go with just two level, I'd throw "CON.c" into the
same level as ".Git"; they both are to break the host that checks
out such paths.  The former may break Git on the host, and the
latter may break something that is not Git on the host, but they are
not that different in that the end user on that host is harmed.

"8.3 ambiguity" does not directly harm individual hosts, but the
reason to flag is primarily because such a path may make the
project's contents unreliable (e.g. "icon1234234.png" may alias
"ICON~714.PNG" on somebody's machine, causing confusion).  The same
reason should make us flag a tree object as suspect if it contains
two paths that are the same case-insensitively (e.g. a tree that
represents the "net/netfilter" part of the Linux kernel source would
be flagged because it contains both "xt_tcpmss.c" and "xt_TCPMSS.c").

Let's call the former Harmful and the latter Questionable.  "CON.c"
is Harmful on Windows, while "net/netfilter" is Questionable on
Windows.  Orthogonal to this, we earlier discussed what to do in
fsck and receive.fsckObjects.  I think we want to be express
different shades of grays between the two extremes:

 - A repository of a mono-culture project would want to flag
   Harmfuls and Questionables that apply to the project's intended
   platform as errors.  By definition, a mono-culture project would
   not care about paths that may only be Harmful on others'
   platforms.

 - A repository for a cross-platform project would want to flag
   paths that may be Harmful or Questionable on some platform, and
   does not care if these paths are Harmful or Questionable on the
   platform that happens to host the repository.  By definition, a
   cross-platform project wants to make sure everybody involved will
   not get hurt.
