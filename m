From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/3] git-sh-setup: introduce say() for quiet options
Date: Sun, 14 Jun 2009 21:23:08 -0700
Message-ID: <7vab4ap1lf.fsf@alter.siamese.dyndns.org>
References: <1244924500-27391-1-git-send-email-bebarino@gmail.com>
	<1245021374-8430-1-git-send-email-bebarino@gmail.com>
	<1245021374-8430-2-git-send-email-bebarino@gmail.com>
	<18071eea0906141621t676a965aqc3056b481b8e8796@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 06:23:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MG3jI-0003Oh-Lq
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 06:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbZFOEXJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2009 00:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbZFOEXH
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 00:23:07 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:51932 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbZFOEXH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 00:23:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090615042309.SFCO18948.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Mon, 15 Jun 2009 00:23:09 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 44P91c0014aMwMQ044P9i1; Mon, 15 Jun 2009 00:23:09 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=qTOai3nRsLwA:10 a=QBPUJJ0DKCAA:10
 a=pGLkceISAAAA:8 a=aYBj5RdVJ6CbEd7amkYA:9 a=rICUMnrW_Tsz0V4ArEAA:7
 a=1c3JU7XnYlIMWDZJ8S3vFUTM30gA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <18071eea0906141621t676a965aqc3056b481b8e8796@mail.gmail.com> (Thomas Adam's message of "Mon\, 15 Jun 2009 00\:21\:53 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121580>

Thomas Adam <thomas.adam22@gmail.com> writes:

> 2009/6/15 Stephen Boyd <bebarino@gmail.com>:
>> Scripts should use say() when they want to echo to stdout. Setting
>> GIT_QUIET will mute say(), allowing scripts to easily implement a qu=
iet
>> option.
>>
>> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
>> ---
>> =C2=A0git-sh-setup.sh | =C2=A0 =C2=A07 +++++++
>> =C2=A01 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
>> index 80acb7d..f88184e 100755
>> --- a/git-sh-setup.sh
>> +++ b/git-sh-setup.sh
>> @@ -44,6 +44,13 @@ die() {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1
>> =C2=A0}
>>
>> +say () {
>> + =C2=A0 =C2=A0 =C2=A0 if test -z "$GIT_QUIET"
>> + =C2=A0 =C2=A0 =C2=A0 then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "$@"
>
> Except that where you've then replaced various calls with say() they
> were originally using printf.

The only difference I found in these three patch series is this hunk  o=
n
git-am.sh in [PATCHv2 3/3]:

    @@ -498,7 +505,7 @@ do
                    stop_here $this
            fi

    -       printf 'Applying: %s\n' "$FIRSTLINE"
    +       say "Applying: $FIRSTLINE"

            case "$resolved" in
            '')

This was made from echo to printf with 4b7cc26 (git-am: use printf inst=
ead
of echo on user-supplied strings, 2007-05-25), with reason:

    Under some implementations of echo (such as that provided by
    dash), backslash escapes are recognized without any other
    options. This means that echo-ing user-supplied strings may
    cause any backslash sequences in them to be converted. Using
    printf resolves the ambiguity.
   =20
    This bug can be seen when using git-am to apply a patch
    whose subject contains the character sequence "\n"; the
    characters are converted to a literal newline. Noticed by
    Szekeres Istvan.

To make the conversion of the above hunk correct, say() must use

	printf "%s" "$*"

Needless to say, all the conversions from "echo" to "say" in the patch
series need to be verified.
