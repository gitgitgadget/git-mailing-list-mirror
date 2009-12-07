From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCHv2 0/2] Add a "fixup" command to "rebase --interactive"
Date: Mon,  7 Dec 2009 05:22:57 +0100
Message-ID: <cover.1260099005.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@drmicha.warpmail.net,
	Johannes.Schindelin@gmx.de, bgustavsson@gmail.com,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 07 05:23:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHV8Q-0005as-BF
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 05:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933310AbZLGEXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 23:23:21 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933303AbZLGEXU
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 23:23:20 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:59263 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933298AbZLGEXT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 23:23:19 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (p4FC1D1BC.dip.t-dialin.net [79.193.209.188])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id nB74NHR3019782;
	Mon, 7 Dec 2009 05:23:17 +0100
X-Mailer: git-send-email 1.6.6.rc1.34.gd7b83
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134708>

Thanks, everybody, for all of the feedback.  This is the redone patch
series, which I think addresses all of your suggestions.

I would still like to implement "don't open the editor if there are
only fixups", but if it's OK I'll work on that in a separate patch
series when I have time.

Michael J Gruber wrote:
> My first reaction to the subject was "Huh? What repository?". So I
> suggest something like
>=20
> t3404: Better document the original repository layout
>=20
> as a more descriptive subject.

Good idea.  Done.

Johannes Schindelin wrote:
> Alternatively, one could use the test_commit function, I guess. [...]

Yes, that's much easier.  Changed.  This makes the old first and
second patches reduce to a single one.

Johannes Schindelin wrote:
> On Fri, 4 Dec 2009, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.s=
h
>>> index 0bd3bf7..539413d 100755
>>> --- a/git-rebase--interactive.sh
>>> +++ b/git-rebase--interactive.sh
>>> @@ -302,7 +302,7 @@ nth_string () {
>>> =20
>>>  make_squash_message () {
>>>  	if test -f "$SQUASH_MSG"; then
>>> -		COUNT=3D$(($(sed -n "s/^# This is [^0-9]*\([1-9][0-9]*\).*/\1/p"=
 \
>>> +		COUNT=3D$(($(sed -n "s/^# Th[^0-9]*\([1-9][0-9]*\)\(th\|st\|nd\|=
rd\) commit message.*:/\1/p" \
>>>  			< "$SQUASH_MSG" | sed -ne '$p')+1))
>> This sed replacement worries me.  I don't have a time to check mysel=
f
>> today but do we use \(this\|or\|that\) alternates with our sed scrip=
t
>> already elsewhere in the codebase (test scripts do not count)?
>>
>> Otherwise this may suddenly be breaking a platform that has an
>> implementation of sed that may be substandard but so far has been
>> sufficient to work with git.
>=20
> IIRC "|" was not correctly handled by BSD sed (used e.g. in MacOSX).
>=20
> So maybe it would be best to just look for "commit message"?  I agree=
 with
> Michael that the regex should not be too loose.

Thanks for pointing this out.  I replaced the problematic part of the
regexp with "[snrt][tdh]", which isn't quite so selective but should
be portable.  (This is the same fix that Junio suggested.)

Bj=C3=B6rn Gustavsson wrote:
> On Fri, Dec 4, 2009 at 3:36 PM, Michael Haggerty <mhagger@alum.mit.ed=
u> wrote:
> Nitpick: the recommended style is to leave out the full stop
> at the end of the first line of the commit message.

Nit picked.

Junio C Hamano wrote:
> IIRC, the end result of the bikeshedding for the name of the command =
was
> won by Dscho's "fixup":
>=20
>   http://thread.gmane.org/gmane.comp.version-control.git/127923/focus=
=3D121820

That's fine with me (the abbreviation is even the same :-) ).
Changed.

Michael

Michael Haggerty (2):
  t3404: Use test_commit to set up test repository
  Add a command "fixup" to rebase --interactive

 Documentation/git-rebase.txt  |   13 +++--
 git-rebase--interactive.sh    |   51 +++++++++++++++++----
 t/lib-rebase.sh               |    7 ++-
 t/t3404-rebase-interactive.sh |   96 +++++++++++++++++++++------------=
-------
 4 files changed, 103 insertions(+), 64 deletions(-)
