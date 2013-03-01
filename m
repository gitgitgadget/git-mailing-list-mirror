From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Make !pattern in .gitattributes non-fatal
Date: Fri, 1 Mar 2013 21:42:09 +0100
Message-ID: <87mwumx36m.fsf@pctrast.inf.ethz.ch>
References: <a1679159dbe67c34675bbe016e131260310db189.1362168366.git.trast@student.ethz.ch>
	<7vfw0eg90e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 01 21:42:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBWms-000186-Jy
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 21:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478Ab3CAUmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 15:42:13 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:57007 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245Ab3CAUmM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 15:42:12 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 1 Mar
 2013 21:42:00 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 1 Mar
 2013 21:42:09 +0100
In-Reply-To: <7vfw0eg90e.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 01 Mar 2013 12:28:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217292>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> Before 82dce99 (attr: more matching optimizations from .gitignore,
>> 2012-10-15), .gitattributes did not have any special treatment of a
>> leading '!'.  The docs, however, always said
>>
>>   The rules how the pattern matches paths are the same as in
>>   `.gitignore` files; see linkgit:gitignore[5].
>>
>> By those rules, leading '!' means pattern negation.  So 82dce99
>> correctly determined that this kind of line makes no sense and should
>> be disallowed.
>>
>> However, users who actually had a rule for files starting with a '!'
>> are in a bad position: before 82dce99 '!' matched that literal
>> character, so it is conceivable that users have .gitattributes with
>> such lines in them.  After 82dce99 the unescaped version was
>> disallowed in such a way that git outright refuses to run(!) most
>> commands in the presence of such a .gitattributes.  It therefore
>> becomes very hard to fix, let alone work with, such repositories.
>
> Fixing the working tree is easy, but when we read from a history
> that already records such an entry in an attribute file, it would
> become somewhat cumbersome.  I wouldn't use "very hard to fix" to
> describe such a case.

Well, I'm sorry if I hurt any feelings there, but...

  ~/tmp/badattr(master)$ git show bad:.gitattributes
  !bad text
  ~/tmp/badattr(master)$ ~/g/git-checkout bad  # a git without my patch
  fatal: Negative patterns are forbidden in git attributes
  Use '\!' for literal leading exclamation.
  ~/tmp/badattr(master)$ git status
  # On branch master
  nothing to commit (use -u to show untracked files)

Notice how it remains on master.  I suppose with enough knowledge of the
internals I could manage, but after seeing how hard it was to *build*
such broken history with a git that dies, I don't really want to try.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
