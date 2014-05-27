From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v3 2/5] commit test: Change $PWD to $(pwd)
Date: Tue, 27 May 2014 09:35:30 +0200
Message-ID: <87sinv3c8t.fsf@fencepost.gnu.org>
References: <20140525062427.GA94219@sirius.att.net>
	<1401130586-93105-1-git-send-email-caleb@calebthompson.io>
	<1401130586-93105-3-git-send-email-caleb@calebthompson.io>
	<538426D3.8090107@viscovery.net>
	<20140527061448.GA25927@hudson.localdomain>
	<53843206.3040902@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Caleb Thompson <cjaysson@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue May 27 09:35:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpBv7-0000Ya-Is
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 09:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbaE0Hfe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 May 2014 03:35:34 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:40784 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbaE0Hfd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 May 2014 03:35:33 -0400
Received: from localhost ([127.0.0.1]:39824 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WpBv1-0007Xg-5k; Tue, 27 May 2014 03:35:31 -0400
Received: by lola (Postfix, from userid 1000)
	id 9D75CE0765; Tue, 27 May 2014 09:35:30 +0200 (CEST)
In-Reply-To: <53843206.3040902@viscovery.net> (Johannes Sixt's message of
	"Tue, 27 May 2014 08:34:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250145>

Johannes Sixt <j.sixt@viscovery.net> writes:

> That said, it is not wrong to use $(pwd) with test_set_editor, it's j=
ust
> unnecessarily slow.

Any shell that knows $(...) is pretty sure to have pwd as a built-in.
I=A0don't think Git will run on those kind of ancient shells reverting =
to
/bin/pwd here.

The autoconf manual (info "(autoconf) Limitations of Builtins") states

'pwd'
     With modern shells, plain 'pwd' outputs a "logical" directory name=
,
     some of whose components may be symbolic links.  These directory
     names are in contrast to "physical" directory names, whose
     components are all directories.

     Posix 1003.1-2001 requires that 'pwd' must support the '-L'
     ("logical") and '-P' ("physical") options, with '-L' being the
     default.  However, traditional shells do not support these options=
,
     and their 'pwd' command has the '-P' behavior.

     Portable scripts should assume neither option is supported, and
     should assume neither behavior is the default.  Also, on many host=
s
     '/bin/pwd' is equivalent to 'pwd -P', but Posix does not require
     this behavior and portable scripts should not rely on it.

     Typically it's best to use plain 'pwd'.  On modern hosts this
     outputs logical directory names, which have the following
     advantages:

        * Logical names are what the user specified.
        * Physical names may not be portable from one installation host
          to another due to network file system gymnastics.
        * On modern hosts 'pwd -P' may fail due to lack of permissions
          to some parent directory, but plain 'pwd' cannot fail for thi=
s
          reason.

     Also please see the discussion of the 'cd' command.

So $PWD is pretty much guaranteed to be the same as $(pwd) and pretty
much guaranteed to _not_ be "unnecessarily slow" when not run in an
inner loop.

However, looking at (info "(autoconf) Special Shell Variables") I see

'PWD'
     Posix 1003.1-2001 requires that 'cd' and 'pwd' must update the
     'PWD' environment variable to point to the logical name of the
     current directory, but traditional shells do not support this.
     This can cause confusion if one shell instance maintains 'PWD' but
     a subsidiary and different shell does not know about 'PWD' and
     executes 'cd'; in this case 'PWD' points to the wrong directory.
     Use '`pwd`' rather than '$PWD'.

Ok, probably Git relies on Posix 1003.1-2001 in other respects so it's
likely not much of an actual issue.

--=20
David Kastrup
