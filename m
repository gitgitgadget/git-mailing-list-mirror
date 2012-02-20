From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Manually decoding a git object
Date: Mon, 20 Feb 2012 09:29:46 +0100
Message-ID: <87mx8dj4at.fsf@thomas.inf.ethz.ch>
References: <1329312140-24089-1-git-send-email-pclouds@gmail.com>
	<1329624946-32173-1-git-send-email-pclouds@gmail.com>
	<A716A27D407F401DAAC373027D5CFF2A@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Feb 20 09:30:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzOdC-0000Vd-J3
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 09:29:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679Ab2BTI3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 03:29:50 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:18051 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184Ab2BTI3t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 03:29:49 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 20 Feb
 2012 09:29:46 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 20 Feb
 2012 09:29:46 +0100
In-Reply-To: <A716A27D407F401DAAC373027D5CFF2A@PhilipOakley> (Philip Oakley's
	message of "Sun, 19 Feb 2012 18:07:51 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191052>

"Philip Oakley" <philipoakley@iee.org> writes:

> If I have a renamed file which is a git object, such a "Git_Object", was
> 8c-something-or-other, what is the easiest way of examining / decoding /
> recreating the original file (either as its sha1, or a cat-file).
>
> I don't appear to be able to unzip the file in its raw format...  I'm using
> Msysgit on windows XP.

The SHA1 is over the decompressed object contents.  The file simply
holds a zlib-compressed stream of those contents.  (It's pretty much
like gzip without the file header.)

You can use any bindings to zlib and something that does sha1, e.g. in
python:

  $ cd g/.git/objects/aa/  # my git.git
  $ ls
  592bda986a8380b64acd8cbb3d5bdfcbc0834d  6322a757bee31919f54edcc127608a3d724c99
  $ python
  Python 2.7.2 (default, Aug 19 2011, 20:41:43) [GCC] on linux2
  Type "help", "copyright", "credits" or "license" for more information.
  >>> import hashlib
  >>> hashlib.sha1(open('592bda986a8380b64acd8cbb3d5bdfcbc0834d').read().decode('zlib')).digest().encode('hex')
  'aa592bda986a8380b64acd8cbb3d5bdfcbc0834d'

Notice that the first byte of the hash goes into the directory name.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
