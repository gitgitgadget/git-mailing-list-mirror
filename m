From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] Add test case for dealing with a tracked file in an ignored directory
Date: Thu, 19 Aug 2010 10:50:13 +0200
Message-ID: <vpqr5hv56m2.fsf@bauges.imag.fr>
References: <AANLkTiky+azVAnXEBFWR1q9_8NH8TX2TfuonXCpA_-ms@mail.gmail.com>
	<1282123788-24055-1-git-send-email-gdb@mit.edu>
	<vpq8w44mer6.fsf@bauges.imag.fr>
	<AANLkTi=u2jA5MOKwyYO_pwcZaK=A1D2g+gueFGF2L+5U@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
	Jens.Lehmann@web.de, jrnieder@gmail.com
To: Greg Brockman <gdb@mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 19 10:50:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om0pb-0006dl-SO
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 10:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480Ab0HSIu3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 04:50:29 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48374 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854Ab0HSIu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 04:50:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o7J8cwPE028749
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 19 Aug 2010 10:38:58 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Om0pB-0006Mg-N2; Thu, 19 Aug 2010 10:50:13 +0200
In-Reply-To: <AANLkTi=u2jA5MOKwyYO_pwcZaK=A1D2g+gueFGF2L+5U@mail.gmail.com> (Greg Brockman's message of "Thu\, 19 Aug 2010 02\:52\:28 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 19 Aug 2010 10:38:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7J8cwPE028749
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1282811940.25763@fRHtA8O2iAJqUhsNteZwqg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153911>

Greg Brockman <gdb@mit.edu> writes:

>> I don't think you want to complain with "did not match any files"
>> here.
> Well, I copied the behavior of 'git add "*"' here, where every file i=
n
> . is ignored.  E.g.
> """
> $ echo >ignore-file
> $ echo .gitignore >>.gitignore
> $ echo ignore-file >>.gitignore
> $ git add '*'
> fatal: pathspec '*' did not match any files
> """

OK, that makes sense (you can add comments to your tests or commit
message to justify this is case someone wonders later).

> realized today that git globbing seems to act differently depending o=
n
> where the wildcard appears.  E.g.:

> Is this a bug?

There are many known inconsistancies with Git globing, yes. See for
example:

http://thread.gmane.org/gmane.comp.version-control.git/128672/focus=3D1=
28759

>> You're not testing the case
>>
>> =A0git add ignored-dir/
>>
>> which gives another case where Git tries to add files not explicitel=
y
>> given on the command-line. But the correct behavior of this case may
>> be more controversial, so maybe it's indeed better to focus on the
>> other cases.
> A fair point.  I would have thought the behavior here should be
> unchanged, namely that 'git add ignored-dir/' should spit out a "The
> following paths are ignored by one of your .gitignore files: ..."
> error, regardless of the directory's contents.  Does anyone believe
> this should be different/would it be useful for me to draw up a test
> case for it now?  In any case, I'll certainly put a test case for thi=
s
> into the final patch.

It makes sense to make "git add dir/" equivalent to "git add dir/*",
but I don't really care either way.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
