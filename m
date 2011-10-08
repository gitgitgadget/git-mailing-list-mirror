From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How pretty is pretty? git cat-file -p inconsistency
Date: Sat, 08 Oct 2011 16:47:46 +0200
Message-ID: <4E906292.1020909@drmicha.warpmail.net>
References: <4E8EBC00.90909@drmicha.warpmail.net> <7v62k0wudg.fsf@alter.siamese.dyndns.org> <4E8F6088.8060300@drmicha.warpmail.net> <m3r52o1hxr.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-4
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 08 16:47:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCYBx-0006CJ-9N
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 16:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542Ab1JHOru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 10:47:50 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:54761 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751433Ab1JHOrt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Oct 2011 10:47:49 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2D759209EF;
	Sat,  8 Oct 2011 10:47:49 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Sat, 08 Oct 2011 10:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=KkJCd3UkBczrj9wJt2Mkxv
	/ftw4=; b=oU34uO58Ec6SEZsKsMRc+pg32KOW/Qt19ekYvdTpEzIz3EgiiRKrul
	dKpvjUYsP7x5eMNgmg8uyYgC7+/Va0Mf6GHt/pTmiGgacxXElHQ6PB6+omdbhEwk
	SEk9J9R0e0xSIyOfJOv9Ib2q+AhOWr5YJ6zXMYB6AIwLqLypKe8Lg=
X-Sasl-enc: e2Y0eKK9HLct1CvAdQbdxuzJ8jMa8PZgvJbEfCU6wbNo 1318085268
Received: from localhost.localdomain (p54859710.dip0.t-ipconnect.de [84.133.151.16])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 237BDD00294;
	Sat,  8 Oct 2011 10:47:48 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <m3r52o1hxr.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183143>

Jakub Narebski venit, vidit, dixit 08.10.2011 01:50:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> [cut]
>> I never knew how ugly the output of "git tag-file tree sha1" is. I guess
>> it's the type of object whose format I don't know... We don't have an
>> object format description in Doc/technical, do we? tree.c doesn't tell
>> me much.
> 
> I had to handle this in my attempt to write "git blame <directory>" in Perl,
> which was using `git cat-file --batch`, and that gives raw data and not
> pretty-printed.
> 
> Tree object consist of zero or more entries.  Each item consist of mode,
> filename, and sha1:
> 
>   <mode> SPC <filename> NUL <sha1>
> 
> where
> 
> 1. <mode> is variable-length (!) text (!) containing mode of an
>    entry. It encodes type of entry: if it is blob (including special
>    case: symbolic link), tree i.e. directory, or a commit
>    i.e. submodule.  Does not include leading zeros.
> 
> 2. <filename> is variable-length null-terminated ("\0") name of a file
>    or directory, or name of directory where submodule is attached
> 
> 3. <sha1> is 40-bytes _binary_ identifier.
> 
> HTH

It does help, thanks.

Though I'm beginning to think we have a crazy object format. Not only do
we have a lot of indirections (like ascii representation of decimal
representation of length), but we store sha1 as ascii in commit and tag
objects and as binary in tree objects. Which makes tree objects the only
unpleasant ones to look at (and parse) in raw form. (I was hoping we can
dispose of/deprecate cat-file -p in favor of show). Oh well.

Michael
