From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Manually decoding a git object
Date: Mon, 20 Feb 2012 11:56:37 +0100
Message-ID: <871uppbwnu.fsf@thomas.inf.ethz.ch>
References: <1329312140-24089-1-git-send-email-pclouds@gmail.com>
	<1329624946-32173-1-git-send-email-pclouds@gmail.com>
	<A716A27D407F401DAAC373027D5CFF2A@PhilipOakley>
	<87mx8dj4at.fsf@thomas.inf.ethz.ch>
	<5D290031F60941368FB1A36464201DCF@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?5b6Q6L+q?= <xudifsd@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Feb 20 11:57:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzQvU-0006kl-Fg
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 11:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176Ab2BTK44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 05:56:56 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:30097 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301Ab2BTK4z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 05:56:55 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 20 Feb
 2012 11:56:52 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 20 Feb
 2012 11:56:52 +0100
In-Reply-To: <5D290031F60941368FB1A36464201DCF@PhilipOakley> (Philip Oakley's
	message of "Mon, 20 Feb 2012 10:19:49 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191061>

Philip Oakley <philipoakley@iee.org> writes:

> From: "Thomas Rast" <trast@inf.ethz.ch> Sent: Monday, February 20,
> 2012 8:29 AM
>>
>> The SHA1 is over the decompressed object contents.  The file simply
>> holds a zlib-compressed stream of those contents.  (It's pretty much
>> like gzip without the file header.)
>>
>> You can use any bindings to zlib and something that does sha1, e.g. in
>> python:
>>
>>  $ cd g/.git/objects/aa/  # my git.git
>>  $ ls
>>  592bda986a8380b64acd8cbb3d5bdfcbc0834d
>> 6322a757bee31919f54edcc127608a3d724c99
>>  $ python
>>  Python 2.7.2 (default, Aug 19 2011, 20:41:43) [GCC] on linux2
>>  Type "help", "copyright", "credits" or "license" for more information.
>>  >>> import hashlib
>>  >>>
>> hashlib.sha1(open('592bda986a8380b64acd8cbb3d5bdfcbc0834d').read().decode('zlib')).digest().encode('hex')
>>  'aa592bda986a8380b64acd8cbb3d5bdfcbc0834d'
>>
>> Notice that the first byte of the hash goes into the directory name.
>>
>
> At the moment I'm in a Catch 22 situation where I can't make the first
> step of examining the deflated contents, so I can't do all those next
> steps to get the sha1 etc.. Have I misunderstood your suggestions?

Huh?  The method I showed does not rely on knowing the SHA1.  The fact
that I used it on a properly filed away (by its SHA1) object file is
immaterial, if perhaps confusing.

I can untangle that python expression for you:

hashlib.sha1(foo).digest()      gives the SHA1 digest of the string foo, as a (binary) string
foo.encode('hex')               turns foo from (binary) string into its hex representation
open('filename').read()         opens the file called filename, and returns its whole contents
foo.decode('zlib')              applies the zlib decompressor to foo, and returns the resulting data

So that trick works for any file[*], and you can then use its results to
file it back where it needs to go.


[*] that is sufficiently small for Python to hold it in memory, but git
shares the same problems in that department.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
