From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFH] An early draft of v1.5.0 release notes
Date: Wed, 27 Dec 2006 13:12:15 +0100
Message-ID: <200612271312.15877.jnareb@gmail.com>
References: <7vvejx948y.fsf@assigned-by-dhcp.cox.net> <emtgps$f1q$1@sea.gmane.org> <7v1wml8wmw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 13:09:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzXb8-0000fK-Vy
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 13:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932780AbWL0MJ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 27 Dec 2006 07:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbWL0MJ2
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 07:09:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:48818 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932780AbWL0MJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 07:09:27 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3857891uga
        for <git@vger.kernel.org>; Wed, 27 Dec 2006 04:09:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=h3UBGozj6NqBgFP6OMWJ0uIMOfBO8Ug5HLjSxHCBGPT4os9Dov5sxYIRcAqaKKvdfuF509qDoA0oMe0HvTyPRYnAL3PH6RPiyl8w/kM9ZUnc7UVbt34TVzf1gyRypVUW3yCOSog6RxjUb4Mo8W8NLgGHxey6mHmTjfvSJFpE2Fg=
Received: by 10.66.216.20 with SMTP id o20mr18505677ugg.1167221365778;
        Wed, 27 Dec 2006 04:09:25 -0800 (PST)
Received: from host-81-190-19-121.torun.mm.pl ( [81.190.19.121])
        by mx.google.com with ESMTP id i39sm23018849ugd.2006.12.27.04.09.25;
        Wed, 27 Dec 2006 04:09:25 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7v1wml8wmw.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35465>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Junio C Hamano wrote:
>>>
>>> =A0- The commits referred to by reflog entries are now protected
>>> =A0 =A0against pruning. =A0The new command "git reflog expire" can =
be
>>> =A0 =A0used to truncate older reflog entries and entries that refer
>>> =A0 =A0to commits that have been pruned away previously.
>>>
>>> =A0 =A0Existing repositories that have been using reflog may get
>>> =A0 =A0complaints from fsck-objects; please run "git reflog expire
>>> =A0 =A0--all" first to remove reflog entries that refer to commits
>>> =A0 =A0that are no longer in the repository before attempting to
>>> =A0 =A0repack it.
>>
>> That's a bit bad, as it forces to lose some info... but that
>> info was not that useful anyway.
>=20
> I am tired of listening to this useless FUD of yours.  You lost
> the information when you pruned away the underlying objects; you
> are not losing information when you expire the reflog entries
> that became useless long time ago.

Sorry, this is a bit of my inner packrat ;-) showing thru.

I'd rather use "git reflog expire --pruned" to remove reflog entries
which refer to commits which are no longer in the repository; I don't
know, perhaps "git reflog expire --all" does that: but there is no
Documentation/git-reflog.txt (and I'm not running 'next' nor 'master'
but 1.4.4.3). So most probably it is just the case of adding an alias
to reflog expire option.

>>>  - A commit object recorded in non UTF-8 encoding records the
>>>    encoding i18n.commitencoding specified in the originating
>>>    repository in a new "encoding" header.  This information is
>>>    used by git-log and friends to reencode the message to UTF-8
>>>    when displaying.
>>
>> I don't quite like it. Why if someone uses different encoding
>> that utf-8 because his terminal is not set to utf-8? Having suddenly
>> what looks like garbage on output, while input was in local encoding
>> (and specified in i18n.commitencoding) is a bit suprising...
>=20
> If Luben wants UTF-8 in his project, but somebody he pulled from
> was mistakenly used latin-1, then the commit pulled record
> latin-1 while Luben has i18n.commitencoding in his repository
> set to UTF-8.  Output will be done in UTF-8 for Luben.  For the
> originator of that latin-1 commit, i18n.commitencoding says
> latin-1 (and that was the only reason he managed to create such
> a commit) and git show of that commit would not involve
> recoding.
>=20
> At least that is the idea.  Have you spotted a bug, perhaps?

Perhaps that is the idea, but that idea is not described in above
new feature announcement. "... to reencode the message to UTF-8=20
when displaying, if needed." would cover it, but perhaps better
would be to cover this in more detail: "reencode message to UTF-8
if i18n.commitencoding is not set to something other than UTF-8",
or "reencode ... to i18n.commitencoding ... if needed".

BTW. what happens for NO_ICONV? Just curious...

--=20
Jakub Narebski
Poland
