From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] git-show-ref: fix escaping in asciidoc source
Date: Wed, 16 Nov 2011 12:54:07 +0100
Message-ID: <4EC3A45F.9080005@alum.mit.edu>
References: <1319050336-24717-1-git-send-email-mhagger@alum.mit.edu> <4EC27328.3070309@alum.mit.edu> <7vk471urfy.fsf@alter.siamese.dyndns.org> <4EC34FA5.2020809@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 12:55:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQe5T-0002NF-JE
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 12:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756416Ab1KPLzW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Nov 2011 06:55:22 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50287 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756181Ab1KPLzV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 06:55:21 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pAGBs8Ed031994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 16 Nov 2011 12:54:08 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <4EC34FA5.2020809@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185538>

On 11/16/2011 06:52 AM, Michael Haggerty wrote:
> On 11/15/2011 08:16 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>> Did this one fall through the cracks?  I don't see it in your tree.
>>
>> Yeah, I was wondering if we can have a concise description in what c=
ontext
>> any "^" must be spelled as {caret} and what other context "^" can be
>> spelled literally, and possibly which versions of AsciiDoc toolchain=
 have
>> this issue [*1*]. Without a clear guideline, people may unknowingly =
use
>> literal "^" to new paragraphs, or perhaps worse yet, spell {caret} t=
hat
>> end up being shown literally.
>>
>> Since I didn't find a clear pattern other than that "^" can and shou=
ld be
>> literally given in a literal paragraph (i.e. an indented paragraph o=
r
>> inside a listing/literal block that shows program examples), I was m=
eaning
>> to ask you if you knew the rules better than I did, and I stopped th=
ere,
>> forgetting to follow through.
>=20
> I didn't know anything about asciidoc, and just tried to fix it using=
 a
> bit of cargo-cult programming. [...]
>=20
> I can't believe I spent my whole morning on this :-(

There are a couple of FAQ entries on the asciidoc site that are relevan=
t
(excerpted; click on the links in the footnotes for the full text):

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

35 [1]. How can I place a backslash character in front of an attribute
reference without escaping the reference?

Use the predefined {backslash} attribute reference instead of an actual
backslash [...]

36 [2]. How can I escape AsciiDoc markup?

Most AsciiDoc inline elements can be suppressed by preceding them with =
a
backslash character.  These elements include: [...] But there are
exceptions=E2=80=89=E2=80=94=E2=80=89see the next question.

37 [3]. Some elements can=E2=80=99t be escaped with a single backslash

There are a number of exceptions to the usual single backslash rule=E2=80=
=89=E2=80=94=E2=80=89
mostly relating to URL macros that have two syntaxes or quoting
ambiguity.  Here are some non-standard escape examples: [...]  A
work-around for difficult cases is to side-step the problem using the
pass:[] passthrough inline macro.
Note Escaping is unnecessary inside inline literal passthroughs
(backtick quoted text).

51 [4]. How can I selectively disable a quoted text substitution?

Omitting the tag name will disable quoting. For example, if you don=E2=80=
=99t
want superscripts or subscripts then put the following in a custom
configuration file or edit the global asciidoc.conf configuration file:

[quotes]
^=3D
~=3D

Alternatively you can set the configuration entries from within your
document, the above examples are equivalent to:

:quotes.^:
:quotes.~:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Given that the git documentation uses lots of "^" and "~" but probably
no subscripting or superscripting, it seems like the suggestion in FAQ
entry 51 would be helpful.  But unfortunately it chokes version 8.5.2 o=
f
asciidoc, which is what I have installed.  So it is probably too new to
be appropriate for git use.

I also did a check to see whether other sub/superscripts are present in
the git documentation:

    make all doc
    find Documentation -type f -name '*.html' -print0 |
        xargs -0 grep -nE -e '<su[bp]>'

The only hit was the one under discussion, in git-show-ref.html.  (This
is no check that "^" and "~" are always quoted, but only that they don'=
t
appear unquoted in pairs.)

Michael

[1]
http://www.methods.co.nz/asciidoc/faq.html#_how_can_i_place_a_backslash=
_character_in_front_of_an_attribute_reference_without_escaping_the_refe=
rence
[2]
http://www.methods.co.nz/asciidoc/faq.html#_how_can_i_escape_asciidoc_m=
arkup
[3]
http://www.methods.co.nz/asciidoc/faq.html#_some_elements_can_8217_t_be=
_escaped_with_a_single_backslash
[4]
http://www.methods.co.nz/asciidoc/faq.html#_how_can_i_selectively_disab=
le_a_quoted_text_substitution

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
