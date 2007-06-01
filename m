From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: handle non UTF-8 text
Date: Fri, 1 Jun 2007 23:05:40 +0200
Message-ID: <200706012305.41183.jnareb@gmail.com>
References: <1180385254576-git-send-email-mkoegler@auto.tuwien.ac.at> <200705291121.12119.jnareb@gmail.com> <20070529215536.GA13250@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Martin Langhoff <martin@catalyst.net.nz>,
	Martyn Smith <martyn@catalyst.net.nz>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Sat Jun 02 00:26:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuFZb-00024O-RM
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 00:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757083AbXFAW0P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 1 Jun 2007 18:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757389AbXFAW0P
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 18:26:15 -0400
Received: from hu-out-0506.google.com ([72.14.214.239]:22818 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755577AbXFAW0L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 18:26:11 -0400
Received: by hu-out-0506.google.com with SMTP id 19so145793hue
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 15:26:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Cayo+ky7Ke0QF+EC/PFqtshVC71zpGyUVKaQCviwlV/5pgPe+tmACCWE4wOGm4WTZUN7kmDD4vztbSYZ3Bj/J0H/RfHxmnUK3vniMbdNcCzLeoJy1jK6EuO9IlUK441unh4NcnEajbz+EuTjOH4p5GyvQLpVMRXIyYlQ8n+k+z8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AJWKbhiFZiercILe78fsbMqv+OfsNubRNdA0aPnS/y+Mwppt0+MrNsklsfJIRfvxXOoAgWTpoOWvtCpQQlDVIvdkAFoyvJWngXUGQ6G5a30asZaAARnyqH6IpPMR+9JA6fcFSdv/E0mq7103gpV5dAzZR01LG8Y+iWRny/6tLMg=
Received: by 10.67.116.15 with SMTP id t15mr1062736ugm.1180736768193;
        Fri, 01 Jun 2007 15:26:08 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id g1sm1047910muf.2007.06.01.15.26.04;
        Fri, 01 Jun 2007 15:26:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070529215536.GA13250@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48895>

On Tue, 29 May 2007, Martin Koegler wrote:
> On Tue, May 29, 2007 at 11:21:11AM +0200, Jakub Narebski wrote:
>> On Tue, 29 May 2007, Petr Baudis wrote:
>>> On Mon, May 28, 2007 at 10:47:34PM CEST, Martin Koegler wrote:
>>=20
>>>> gitweb assumes, that everything is in UTF-8. If a text contains in=
valid
>>>> UTF-8 character sequences, the text must be in a different encodin=
g.
>>=20
>> But it doesn't tell us _what_ is the encoding. For commit messages,
>> with reasonable new git, we have 'encoding' header if git known that
>> commit message was not in utf-8.
>>=20
>> By the way, I winder why we don't have such header for tag objects
>> (i18n.tagEncoding ;-)...
>=20
> Why do I need to set i18n.commitEncoding on a normal Linux systems?  =
We
> have a locale, which contains this information. With this, its more
> likely, that the commits can be read correctly later, if somebody
> forget to set "i18n.commitEncoding" in a repository.

Because repository is (or at least can be) _shared_. People working on
the same repository can have set different locale. Web server running
gitweb can have different locale.

>>>> This patch interprets such a text as latin1.
>>=20
>> Meaning that it tries to recode text from latin1 (iso-8859-1) to utf=
-8
>> (not changing gitweb output encoding, which is utf-8).

And this (i.e. what does "interprets" mean) is what should be in the
commit message too.

>> It would be much better, and much easier at least for commit message
>> to add --encoding=3Dutf-8 to git-rev-list / git-log invocation.
>=20
> It does not help for old commits, where the encoding was not specifie=
d
> correctly. If my research is correct, the encoding handling was
> introduced at the end of 2006 and released this february.

True. But it _can_ help.

>>>> If commit/blob/... is not in UTF-8, it displays the text
>>>> with a very high probability correct.=20
>>
>> And I doubt very much about this "very high probability to be
>> correct".
>=20
> For normal text, this should be true:
>=20
> We can divide ISO-8859-1 into some groups:
> a) 0x00-0x7f: shared with UTF-8
> b) 0x80-0xBF: continuation characters in UTF-8 (0x80-0x9F are control=
 characters/unused)
> c) 0xC0-0xDF: start of a two byte UTF-8 character
> d) 0xE0-0xEF: start of a tree byte UTF-8 character
> e) 0xF0-0xFF: start of other longer UTF-8 sequences
>=20
> To misinterpret a ISO-8859-1 text as UTF-8, each character of class
> c/d/e must be followed by the correct number of character of class b.
[cut]
> As gitweb is processing a line of text at once, one UTF-8 compatible
> combinations has no effect, if any other non UTF-8 combatible
> character sequence occurs.

Thanks for the explanation. In short: if characters not shared with UTF=
-8
(outside US-ASCII), "special characters" occur usually solo, there is
low probability that line in non-UTF-8 encoding will be valid UTF-8.
Which perhaps is valid for German and latin1 aka. iso-8859-1; not
necessarily so for example for Polish and iso-8859-2, see
  za=C5=BC=C3=B3=C5=82=C4=87 g=C4=99si=C4=85 ja=C5=BA=C5=84
which is perfectly good fragment containing all Polish special
characters, and as you can see those characters occur one after another=
=2E
Well, it still could be invalid UTF-8 sequence; what about koi8r and
eucjp (or other non-UTF-8 encoding for Asian languages)?

> But I agree, that there should be the possibilty to choose a the
> fallback encoding.

I think for the beginning it would be enough to have

  # assume this charset if line contains non-UTF-8 characters
  our $fallback_encoding =3D "latin1";

or something like that (perhaps different wording in the comment,
perhaps different name of the variable) in the gitweb.perl for your
idea to be accepted.

That, and using to_utf8 (as before e3ad95a8) and not my_decode_utf8
as subroutine name. If only it would be possible to avoid I think
quote costly "eval {....}" invocation...


[cut]

There are six sources of possibly non-UTF-8 input: commits, tags,
trees (file names), blobs, gitweb files and results of system calls.

Only first one, commits, comes with encoding specified... if commit
was made with new enough git, and if committer correctly specified
encoding. Commits are read using git-rev-list, which accept --encoding
parameter, so we can convert it easily to utf-8... if git was compiled
with iconv support. It is possible that due to repository, gitweb user
or global configuration (i18n.logOutputEncoding, i18n.commitEncoding)
this is done automatically. On the other hand I think it is easiest
to have accidental wrongly encoded sequence in commit message.

Second one, tags, really _should_ have encoding header like commits.
On the other hand usually the message is version + PGP signature, so
there is no place for any encoding. Tags are read using git-cat-file,
which does not do any encoding/decoding.

Third, filenames in tree objects, "suffers" from git design decision:
for performance and simplicity git stories filenames in tree 'as is',
and relies on the fact that filenames are the same in tree objects,
in the index (dircache), in the filesystem during saving, and as read
from filesystem. Moreover I think that names encoding on filesystem
might depend on filesystem in question and be different from locale
specified encoding (locale is user local, filesystem is global).
On the other hand side one ususually does not use special characters
in filenames because of the problems they cause.

=46ourth, blobs (file contents). They can use different encoding than
commit messages; moreover different files can use different encoding.
Encoding has to be specified externally; there is no place for encoding
header in the blob object structure.

=46ifth, gitweb files include files read and transformed such as=20
GIT_DIR/description file, or projects index file $projects_list,
and files containing fragments of HTML like README.html or header/foote=
r
files.

Sixth, we sometimes have to decode to utf8 results of system calls
like getpwuid to get owner of a file (of a project), or decode to utf8
path (fragment) to the repository.


There are two places to specify gitweb output charset. First is charset
used in HTML output, which is also default charset (binmode) of STDOUT
stream. Gitweb uses utf-8 here, and utf-8 is recommended for XML and fo=
r
XHTML by W3C, although we could theoretically add an option to use
different charset by default, and decode (or not) to this charset, inst=
ead
of recoding everything (see above) to utf-8.

Second place is default charset for text/plain blob_plain output:
  # default blob_plain mimetype and default charset for text/plain blob
  our $default_blob_plain_mimetype =3D 'text/plain';
  our $default_text_plain_charset  =3D undef;
and for other *_plain output written as text/plain; charset=3Dutf-8, an=
d
which is actually dumpled :raw to STDOUT.


So what should be the solution? Add global, per gitweb installation
configureation variables $input_encoding and $fallback_input_encoding?
What do you think? Do you have other ideas?

--=20
Jakub Narebski
Poland
