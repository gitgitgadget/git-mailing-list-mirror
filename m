From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] completion: split __git_ps1 into a separate script
Date: Wed, 23 May 2012 17:40:46 +0200
Message-ID: <CAMP44s0aKi+8WHPXYLQ+iSMkj9iV88JGTabrpBRNBWb7upAMiQ@mail.gmail.com>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
	<1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
	<4FBC0019.6030702@in.waw.pl>
	<7v4nr72bim.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, Ted Pavlic <ted@tedpavlic.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Kerrick Staley <mail@kerrickstaley.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	=?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>,
	Dan McGee <dan@archlinux.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 23 17:40:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXDgE-0007eC-EQ
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 17:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597Ab2EWPkt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 11:40:49 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45770 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755457Ab2EWPks convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 May 2012 11:40:48 -0400
Received: by lbbgm6 with SMTP id gm6so5173304lbb.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 08:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ELrHzXWQP1GYo97ul1O2l3gRnyA7S8slF4Ee8GArrU4=;
        b=fw26pKPHmI0lZIjMApvE2XHu5jbh5GrZRqOw2fQAnA+k0F0UZv7+FG3TqXvwYYU6Uo
         aFcKGon6dUM3cEJDAOgJd1rnOqlXAdsJmOzQCN4teEcMrL1w+Fri0eKNREpjBFjrYq6A
         QDSBNVNsu6Hzdx7F/wekuow/72WJvri/dArHO8OorvF71sSc6/usUTclEMgX2PtlH1pn
         KbNl/J7TqD+99aZfxrI2LbPCdXk7ipO4m2BR+b9wC/drSJtHwyzSTcqyWv0JHmNfgq3x
         hR0hWgA4LSwfIq9Y6s3m/lP2dita9QTfg7a7RP9i778fTiqZerCxg9LIzAG5m19XMGFV
         gMwQ==
Received: by 10.112.23.200 with SMTP id o8mr12452422lbf.9.1337787646643; Wed,
 23 May 2012 08:40:46 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Wed, 23 May 2012 08:40:46 -0700 (PDT)
In-Reply-To: <7v4nr72bim.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198299>

Hi,

On Wed, May 23, 2012 at 4:54 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Zbigniew J=C4=99drzejewski-Szmek =C2=A0<zbyszek@in.waw.pl> writes:
>
>> On 05/22/2012 10:46 PM, Felipe Contreras wrote:
>>> =C2=A0contrib/completion/git-completion.bash | =C2=A0257 +---------=
------------------
>>> =C2=A0contrib/completion/git-prompt.sh =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
287 ++++++++++++++++++++++++++++++++
>>> =C2=A0t/t9903-bash-prompt.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
>>> =C2=A03 files changed, 290 insertions(+), 256 deletions(-)
>>> =C2=A0create mode 100644 contrib/completion/git-prompt.sh
>> Hi,
>> since git-prompt is not completion related anymore, should a differe=
nt
>> directory be used?
>
> I am not sure if that is worth it. =C2=A0These two share/duplicate so=
me shell
> functions and we may end up refactoring them (a way to do so may be t=
o
> dot-source git-prompt from git-completion and drop duplicated definit=
ions
> from the latter), for example.

And how do you propose to update the install documentation?

#    1) Copy this file to somewhere (e.g. ~/.git-completion.sh).
#    2) Add the following line to your .bashrc/.zshrc:
#        source ~/.git-completion.sh
#
#    3) Consider changing your PS1 to also show the current branch:

1) Copy the file (e.g. ~/.git-completion.sh)
2) Copy the other file (.e.g ~/.git-prompt.sh)
3) Edit the original file (~/.git-completion.sh), modify the 'source'
command to use the other file (~/.git-prompt.sh)

And if the user doesn't care about prompt this certainly looks like ove=
rkill.

What do we gain by this incredible user annoyance? Less maintenance
burden of __gitdir() which barely changes anyway?

What about 'git dir' or 'git info dir' (this could be used by other
scripts to get information about various git commands, for completion,
documentation, what not)?

Cheers.

--=20
=46elipe Contreras
