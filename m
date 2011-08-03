From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1bis/2] Diff patterns for POSIX shells
Date: Wed, 3 Aug 2011 12:12:41 +0200
Message-ID: <CAOxFTcxEL38HW0mX++Wa7b0TEPo56xDZPZaqJ5wrpMcQGSfQoQ@mail.gmail.com>
References: <7vzkjrem6b.fsf@alter.siamese.dyndns.org> <1312349176-20984-1-git-send-email-giuseppe.bilotta@gmail.com>
 <20110803093252.GA16351@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 03 12:13:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoYRo-0004dH-DB
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 12:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482Ab1HCKNE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 06:13:04 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55291 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab1HCKNC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2011 06:13:02 -0400
Received: by iyb12 with SMTP id 12so820491iyb.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 03:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=3HX3yTnCcnXH1SW6hks/88qtuI0JtUGyTZ7Agz2UQa0=;
        b=TKIqEcdqG8ToTzhw86r56OosO1Q/cytIdsZEJi8bsfDLwB6tdnTMo/6XsbNewHYshR
         egwo/trr8ywHmf6AhOFFn+UIUlgET7EeMTQ9mmsNB8keZ0REdacsYD37ppDcrPml9/Uj
         55XYKIMvFd/Uz68IUPIar7U1SGSsa0cXIj5ds=
Received: by 10.231.193.137 with SMTP id du9mr4807982ibb.136.1312366381245;
 Wed, 03 Aug 2011 03:13:01 -0700 (PDT)
Received: by 10.231.30.129 with HTTP; Wed, 3 Aug 2011 03:12:41 -0700 (PDT)
In-Reply-To: <20110803093252.GA16351@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178556>

On Wed, Aug 3, 2011 at 11:32 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Aug 03, 2011 at 07:26:16AM +0200, Giuseppe Bilotta wrote:
>
>> All diffs following a function definition will have that function na=
me
>> as chunck header, but this is the best we can do with the current
>> userdiff capabilities.
>
> Curious as to how this would look in git.git, I tried "git log -p"
> before and after your patches, and diffed the result. I noticed two
> things:
>
> =A01. Given a block of shell code like this:
>
> =A0 =A0 =A0 =A0foo() {
> =A0 =A0 =A0 =A0 =A0... do something ...
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0test_expect_success 'test foo' '
> =A0 =A0 =A0 =A0 =A0... the actual test ...
> =A0 =A0 =A0 =A0'
>
> =A0 =A0 if we add new code after the test, the old regex would print:
>
> =A0 =A0 =A0 =A0@@ -1,2 +3,4 @@ test_expect_success 'test foo' '
>
> =A0 =A0 and now we say:
>
> =A0 =A0 =A0 =A0@@ -1,2 +3,4 @@ foo
>
> =A0 =A0 which seems more misleading. I know the function-matching cod=
e has
> =A0 =A0 no way to say "look for ^}, which signals end of function", s=
o we
> =A0 =A0 can't be entirely accurate. But I wonder if the new heuristic
> =A0 =A0 (which seems to look for a name followed by parentheses) is
> =A0 =A0 actually any better than the old.

I'm not too satisfied with the solution either. I've been thinking
about adding some important keywords such as for, while, if, until,
case etc, but decided it would be too much overkill. And, it still
woudln't work 'correctly' in a case such as this one you presented
above.

> =A02. What would have printed before:
>
> =A0 =A0 =A0 @@ -1,2 +3,4 @@ foo() {
>
> =A0 =A0 now prints
>
> =A0 =A0 =A0 @@ -1,2 +3,4 @@ foo
>
> =A0 =A0 without the parentheses or brace. It looks like the similar C=
 one
> =A0 =A0 keeps the parentheses, at least. I find that a bit more reada=
ble,
> =A0 =A0 as it is more clear that the line indicates a function, and n=
ot
> =A0 =A0 simply some top-level command.

Indeed. I'll change the regexp to include the parenthesis.

--=20
Giuseppe "Oblomov" Bilotta
