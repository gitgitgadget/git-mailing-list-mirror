From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Manually decoding a git object
Date: Mon, 20 Feb 2012 18:27:47 -0000
Organization: OPDS
Message-ID: <EF3174E8E5D5433CBC44E912309946A8@PhilipOakley>
References: <1329312140-24089-1-git-send-email-pclouds@gmail.com><1329624946-32173-1-git-send-email-pclouds@gmail.com><A716A27D407F401DAAC373027D5CFF2A@PhilipOakley><87mx8dj4at.fsf@thomas.inf.ethz.ch><5D290031F60941368FB1A36464201DCF@PhilipOakley> <871uppbwnu.fsf@thomas.inf.ethz.ch>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	=?UTF-8?B?5b6Q6L+q?= <xudifsd@gmail.com>
To: "Thomas Rast" <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 20 19:27:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzXxi-0006Do-SC
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 19:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603Ab2BTS1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 13:27:42 -0500
Received: from smtp2go.com ([207.58.142.213]:41458 "EHLO smtp2go.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535Ab2BTS1m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 13:27:42 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191082>

From: "Thomas Rast" <trast@inf.ethz.ch> Sent: Monday, February 20, 2012
10:56 AM
> Philip Oakley <philipoakley@iee.org> writes:
>
>> From: "Thomas Rast" <trast@inf.ethz.ch> Sent: Monday, February 20,
>> 2012 8:29 AM
>>>
>>> The SHA1 is over the decompressed object contents.  The file simply
>>> holds a zlib-compressed stream of those contents.  (It's pretty much
>>> like gzip without the file header.)
>>>
>>> You can use any bindings to zlib and something that does sha1, e.g. in
>>> python:
>>>
>>>  $ cd g/.git/objects/aa/  # my git.git
>>>  $ ls
>>>  592bda986a8380b64acd8cbb3d5bdfcbc0834d
>>> 6322a757bee31919f54edcc127608a3d724c99
>>>  $ python
>>>  Python 2.7.2 (default, Aug 19 2011, 20:41:43) [GCC] on linux2
>>>  Type "help", "copyright", "credits" or "license" for more information.
>>>  >>> import hashlib
>>>  >>>
>>> hashlib.sha1(open('592bda986a8380b64acd8cbb3d5bdfcbc0834d').read().decode('zlib')).digest().encode('hex')
>>>  'aa592bda986a8380b64acd8cbb3d5bdfcbc0834d'
>>>
>>> Notice that the first byte of the hash goes into the directory name.
>>>
>>
>> At the moment I'm in a Catch 22 situation where I can't make the first
>> step of examining the deflated contents, so I can't do all those next
>> steps to get the sha1 etc.. Have I misunderstood your suggestions?
>
> Huh?  The method I showed does not rely on knowing the SHA1.  The fact
> that I used it on a properly filed away (by its SHA1) object file is
> immaterial, if perhaps confusing.
>
> I can untangle that python expression for you:
>
> hashlib.sha1(foo).digest()      gives the SHA1 digest of the string foo,
> as a (binary) string
> foo.encode('hex')               turns foo from (binary) string into its
> hex representation
> open('filename').read()         opens the file called filename, and
> returns its whole contents
> foo.decode('zlib')              applies the zlib decompressor to foo, and
> returns the resulting data
>
> So that trick works for any file[*], and you can then use its results to
> file it back where it needs to go.
>
>
> [*] that is sufficiently small for Python to hold it in memory, but git
> shares the same problems in that department.
>

I see what you mean now. I'll need to work out how to get Python in
msysgit - the 'minimal' part of msys keeps on biting... That is, I didn't
see it (Python) in the 1.7.8 full install bash - I didn't see it anyway.

I was hopeful that unzip/gunzip would have an option to simply deflate a
(file)stream, rather than it expecting the normal file archive.
