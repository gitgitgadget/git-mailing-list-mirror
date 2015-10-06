From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [BUG?] parallel make interdepencies
Date: Tue, 6 Oct 2015 20:39:15 +0100
Organization: OPDS
Message-ID: <316BD1414B4A4B45BD9214872096A236@PhilipOakley>
References: <56138273.6010204@drmicha.warpmail.net> <e76ba2a01053392526a499ec9bff0d37@dscho.org> <20151006133341.GS17201@serenity.lan>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "John Keeping" <john@keeping.me.uk>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 06 21:39:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjY55-0002AL-OE
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 21:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbbJFTjT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Oct 2015 15:39:19 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:53016 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752616AbbJFTjS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Oct 2015 15:39:18 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CHIAC5IhRWPPm3YwJeGQMBAYMJVG6HR7hHIYUvRAQCgT5NAQEBAQEBBwEBAQFBJBtBAQMBg1kFAQEBAQMIAQEZDwEFHgEBIQsCAwUCAQMVAwICBSECAhQBBBoGBwMUBgESCAIBAgMBiCEJrBOGWI1cAQEIAgEbBIEihVGEfoRLQoJwMYEUBZYEAYEdg3qjbYRmPTOCaoFWgSyBC4FHAQEB
X-IPAS-Result: A2CHIAC5IhRWPPm3YwJeGQMBAYMJVG6HR7hHIYUvRAQCgT5NAQEBAQEBBwEBAQFBJBtBAQMBg1kFAQEBAQMIAQEZDwEFHgEBIQsCAwUCAQMVAwICBSECAhQBBBoGBwMUBgESCAIBAgMBiCEJrBOGWI1cAQEIAgEbBIEihVGEfoRLQoJwMYEUBZYEAYEdg3qjbYRmPTOCaoFWgSyBC4FHAQEB
X-IronPort-AV: E=Sophos;i="5.17,645,1437433200"; 
   d="scan'208";a="690156853"
Received: from host-2-99-183-249.as13285.net (HELO PhilipOakley) ([2.99.183.249])
  by out1.ip06ir2.opaltelecom.net with SMTP; 06 Oct 2015 20:39:15 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279162>

=46rom: "John Keeping" <john@keeping.me.uk>
> On Tue, Oct 06, 2015 at 03:13:05PM +0200, Johannes Schindelin wrote:
>> Hi Michael,
>>
>> On 2015-10-06 10:12, Michael J Gruber wrote:
>> > "make -j3" just errored out on me, a follow-up "make" succeeded". =
This
>> > looks like an interdependency issue, but I don't know how to track=
 it:
>> >
>> >     GEN git-web--browse
>> >     GEN git-add--interactive
>> >     GEN git-difftool
>> > mv: der Aufruf von stat f=C3=BCr =E2=80=9Eperl.mak=E2=80=9C ist ni=
cht m=C3=B6glich: Datei oder
>> > Verzeichnis nicht gefunden
>> >
>> > (cannot stat "perl.mak")
>>
>> This one sounds awfully familiar. Although I only encountered this i=
f
>> I specified `make -j15 clean all`, i.e. *both* "clean" and "all"...
>
> I've seen something like this after upgrading perl (I can't remember =
the
> exact error, so it may not be the same problem but I'm pretty sure it
> involves perl.mak).  The problem was a result of the perl library pat=
h
> changing, but I never got around to creating a patch.
>
> I thought I remembered someone else posting a patch to address this, =
but
> I can't find it so perhaps I'm remembering commit 07981dc (Makefile:
> rebuild perl scripts when perl paths change, 2013-11-18).

This bug hit me when updating the MSVC-build script in contrib.

In a fully cleaned installation there is no PM.stamp file and the perl.=
mak=20
file fails with a message that can easily be misunderstood. In my case =
I was=20
doing a `make` dry run, so the rebuilding of the perlscrip list (commit=
=20
07981dc) never happened.

The wider patch series somehow never made it onto vger (don't know why)=
 but=20
the original is at=20
https://groups.google.com/d/msg/msysgit/aj4v9ZpMIJo/2BA68P0saT0J

My fix was (expect whitesapace damage)
---
perl/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/perl/Makefile b/perl/Makefile
index 15d96fc..5b86aac 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -22,7 +22,9 @@ clean:
  $(RM) $(makfile).old
  $(RM) PM.stamp

+ifneq (,$(wildcard PM.stamp))
 $(makfile): PM.stamp
+endif

 ifdef NO_PERL_MAKEMAKER
 instdir_SQ =3D $(subst ','\'',$(prefix)/lib)
--=20
2.4.2.windows.1.5.gd32afb6

--
Philip
