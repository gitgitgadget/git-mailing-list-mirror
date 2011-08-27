From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Idea: "git format-patch" should get more information out of git
Date: Sat, 27 Aug 2011 22:35:45 +0200
Message-ID: <4E595521.7080208@drmicha.warpmail.net>
References: <4E587CC0.4090508@alum.mit.edu> <7vippiaduw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 27 22:41:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxPgj-00025z-QA
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 22:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484Ab1H0Ufu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 16:35:50 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48980 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751400Ab1H0Uft (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Aug 2011 16:35:49 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 83DB620A9A;
	Sat, 27 Aug 2011 16:35:48 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sat, 27 Aug 2011 16:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=sAoqdvDXiPt210dHzT8KUN
	aojvU=; b=QCkn53ZI+YHsXrFsCCMV+q6/nrgY3j59GRiCuysDFeqF5GFhfbOroV
	JkIIq49wGdmByCM92AhDYTG57l1aFqMat2YjcJy2FMeYIW0FmxWxvU2vxc/Pf5vX
	w7JDzYiruw0SxQhmp45/njDbl7rTt80H90ht8iCH1U7889trYJKSw=
X-Sasl-enc: Jpob83oZ5bwrEgnt9ampL3x9C8phOsLSYJyJfGDLp3yp 1314477348
Received: from localhost.localdomain (p548580F9.dip0.t-ipconnect.de [84.133.128.249])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4BC0D9C03E7;
	Sat, 27 Aug 2011 16:35:47 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <7vippiaduw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180246>

Junio C Hamano venit, vidit, dixit 27.08.2011 20:46:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> 1. The extra information typed into the email series is not archived in
>> the git repository, and therefore the emails have to be kept around.
> 
> The convention is to have information that is not meant to be kept around
> after '---', so...
> 
>> 2. If it is discovered between "git format-patch" and "git send-email"
>> that one of the patches needs a tweak, then the email series has to be
>> generated anew and all of the hand-edits need to be redone.
> 
> I actually often work this backwards. Tweak the patch files, apply them to
> commit that they are meant to be applied, retest and then finally send.
> There is no "generating anew" involved.
> 
>> 4. There is no place to store the "additional information" (the part
>> that comes in patch emails between the "---" and the diffstat) while
>> working on the patch series;...
> 
> I thought there was a RFC floating around to do this using notes and also
> teach it to "commit -e" a few months ago? I vaguelly recall that Peff and
> one of the J's were involved, so I am CC'ing them.

Don't forget the MJ ;)

My current setup is:

A. I put the additional per commit info in notes. "git format-patch
--notes" takes it from there and adds it where it belongs.

B. I put series title and cover letter text into a ref note. "git branch
--notes" displays them as a branch note, and "git format-patch --cover
--notes" fills in the cover letter for me.

A patch for A has been on the list, but Junio didn't like the additional
"---" which I had for technical reasons, and I haven't had time to
revisit that patch yet. (The code would have to store a flag about notes
having been inserted or not.) Nobody has complained about the patches
I've created with that form, though ;)

The stuff for B is part of my "ref notes" stuff which I haven't
submitted so far. I've been using it for quite a while now, but am still
unsure about some design aspects.

A is simply my branch "format-patch-notes".

B uses these:
vob/virtual-objects
vob/refrev-hash
vob/branch-notes
vob/format-patch-branch-note
(Merge in this order. Last one is the most immature.)

Note that I rebase frequently these days because of overlapping work in
these areas.

I think Jeff had an interesting patch allowing to edit the note along
side (OK: at the bottom of) the commit message.

Cheers,
Michael

Oh, repo, yes... Any of these:

git://github.com/gitigit/git.git
git://gitorious.org/~mjg/git/mjg.git
git://repo.or.cz/git/mjg.git
