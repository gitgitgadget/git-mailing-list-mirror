From: Simon Josefsson <simon@josefsson.org>
Subject: Re: ANNOUNCE: git2cl
Date: Fri, 02 Mar 2007 12:05:51 +0100
Message-ID: <87649jsy5s.fsf@latte.josefsson.org>
References: <87mz2wrp9u.fsf@latte.josefsson.org>
	<20070302101607.GA6811@alberich.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Andreas Herrmann" <andreas.herrmann3@amd.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 12:06:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN5ay-0008UD-Vj
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 12:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423019AbXCBLGL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 2 Mar 2007 06:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423020AbXCBLGK
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 06:06:10 -0500
Received: from 178.230.13.217.in-addr.dgcsystems.net ([217.13.230.178]:38993
	"EHLO yxa.extundo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933333AbXCBLGI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 06:06:08 -0500
Received: from extundo.com (yxa.extundo.com [217.13.230.178])
	(authenticated bits=0)
	by yxa.extundo.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l22B5qSF008125
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Mar 2007 12:05:52 +0100
OpenPGP: id=B565716F; url=http://josefsson.org/key.txt
X-Hashcash: 1:22:070302:git@vger.kernel.org::kvxZFTDTwGIyPWnB:0eb
X-Hashcash: 1:22:070302:andreas.herrmann3@amd.com::f7AdGql6JJ7DCiA+:J9HU
In-Reply-To: <20070302101607.GA6811@alberich.amd.com> (Andreas Herrmann's
	message of "Fri\, 2 Mar 2007 11\:16\:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.94 (gnu/linux)
X-Spam-Status: No, score=-0.6 required=4.0 tests=AWL,BAYES_50 autolearn=ham 
	version=3.1.1
X-Spam-Checker-Version: SpamAssassin 3.1.1 (2006-03-10) on yxa-iv
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on yxa.extundo.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41188>

"Andreas Herrmann" <andreas.herrmann3@amd.com> writes:

> On Fri, Mar 02, 2007 at 10:03:09AM +0100, Simon Josefsson wrote:
>> Hi!  I really need proper GNU ChangeLog functionality for my project=
s,
>> so I ended up writing my own script to do this in Perl.  Below is th=
e
>> README, but you can find more information at:
>>=20
>> http://josefsson.org/git2cl/
>>=20
>
>
> Hi,
>
> Just for your interest ...
> I downloaded git2cl version as of 02-Mar-2007 09:58, gave it a try an=
d
> received the following (while running the script for an current git
> tree):

Hi.  Thanks for testing!

>   #> git log --pretty --numstat --summary | ~/git2cl
>   2007-02-28  Junio C Hamano <junkio@cox.net>
>
>           * : Add recent changes to draft 1.5.1 release notes.
>
>
>
>   Usage: POSIX::strftime(fmt, sec, min, hour, mday, mon, year, wday =3D
>   -1, yday =3D -1, isdst =3D -1)
>      at git2cl line 257, <> line 20.
>
> So it seems that your script needs some improvement.

Yup!  The parser did not handle merges, and several other things that
I haven't learned about and didn't use in libtasn1 yet.

I have fixed the script so that it doesn't break on the git log.
However, the log style used in git doesn't work perfectly with the
ChangeLog format, some problems are:

* Sentences are sometimes finished with newline instead of '.'.  It is
  difficult for the parser to know when a sentence is finished or not.
  For example:

    * np/types:
      Cleanup check_valid in commit-tree.
      make sure enum object_type is signed
      get rid of lookup_object_type()
      convert object type handling from a string to a number
      formalize typename(), and add its reverse type_from_string()
      sha1_file.c: don't ignore an error condition in sha1_loose_object=
_info()
      sha1_file.c: cleanup "offset" usage
      sha1_file.c: cleanup hdr usage

* The Signed-off-by message also aren't terminated with '.'.  However,
  I think it would be useful to put these headers together with the
  author field, something like this:

2007-02-28  Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>
        Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-frei=
burg.de>
        Signed-off-by: Junio C Hamano <junkio@cox.net>

        * Documentation/Makefile: Include config.mak in doc/Makefile
        config.mak.autogen is already there.  Without this change it is=
 not
        possible to override mandir in config.mak.=20

   However, this is an extension of the changelog format, and should
   probably be discussed within the GNU community.

There are more issues, but making this work right is not my priority.

If you care, please run the script and compare the output with what
you believe should have happened and try to improve it.  Possibly the
current parser is too simplistic to handle more complex situations,
but there is a starting point for everything...

/Simon
