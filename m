From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/9] Define a structure for object IDs.
Date: Mon, 05 May 2014 11:50:11 +0200
Message-ID: <87d2fstuzw.fsf@fencepost.gnu.org>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
	<1399147942-165308-2-git-send-email-sandals@crustytoothpaste.net>
	<5365D91E.70207@alum.mit.edu> <536606AB.1020803@kdbg.org>
	<m2mwexke34.fsf@linux-m68k.org> <5366A09E.6030802@kdbg.org>
	<87ppjt6xjv.fsf@igel.home> <87lhugu7iw.fsf@fencepost.gnu.org>
	<87vbtk60lh.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue May 06 19:26:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whhwe-0005Yp-I5
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933AbaEEJul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 05:50:41 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:57346 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755689AbaEEJuk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 05:50:40 -0400
Received: from localhost ([127.0.0.1]:56384 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WhFXi-0006pv-4H; Mon, 05 May 2014 05:50:38 -0400
Received: by lola (Postfix, from userid 1000)
	id D9298E048F; Mon,  5 May 2014 11:50:11 +0200 (CEST)
In-Reply-To: <87vbtk60lh.fsf@igel.home> (Andreas Schwab's message of "Mon, 05
	May 2014 11:23:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248183>

Andreas Schwab <schwab@linux-m68k.org> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> It does not as far as I can see guarantee that a pointer to something
>> of the same type of its first member can be converted to a pointer to
>> a struct even if the struct only contains a member of such type.
>
> This sentence doesn't make any sense.

I disagree.

> If you have an object of struct type

Your premise is _not_ assumed in my statement.  My premise was "a
pointer to something of the same type of [the struct's] first member".
That does quite explicitly _not_ state that an object of struct type is
in existence.

> then any pointer to the first member of the object can only be a
> pointer to the one and same object.

The case we are talking about is basically passing a pointer to some
actual bonafide toplevel unsigned char [20] object to a routine that
expects a pointer to a struct _only_ containing one such
unsigned char [20] element.

This is the situation we have to deal with if a caller has not been
converted to using such a struct, but the called function does.

More seriously, this is the situation we have to deal with when our SHA1
is actually embedded in some header or whatever else that is actually
available only inside of a larger byte buffer.

In that case, the standard does not permit us converting the address
where that SHA1 is into a pointer to struct.  It may well be that this
will fall under the "let's ignore the standard and write for "sensible"
compilers/architectures" dictum, but if it doesn't, it might be
necessary to first copy the data to a struct before passing it to
routines expecting a pointer to struct.

-- 
David Kastrup
