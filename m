From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: [PATCH 2/4] git-gui: add smart case search mode in searchbar
Date: Mon, 17 Oct 2011 09:32:00 +1100
Message-ID: <CAH5451=jUS5PpMddwML36F-mH=pxxh8FsP2ZiRH2_NFBBy+Q5g@mail.gmail.com>
References: <94b050c4cf7ae8df8d79112e13613244ebff4037.1318579823.git.bert.wesarg@googlemail.com>
 <9350c86dc58e6345b237de5af186718d97fdd19b.1318579823.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 00:32:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFZGE-0005mN-W2
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 00:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269Ab1JPWcd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Oct 2011 18:32:33 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45210 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab1JPWcW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Oct 2011 18:32:22 -0400
Received: by bkbzt19 with SMTP id zt19so2832025bkb.19
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 15:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=q1nKBb/e9LAfRTntwMX9w4lnGqiemSz/YuBJeB6qiPw=;
        b=XPc5Twn4jcDuL1hyyzCQQJIqNB1nyLdQRoGeYTH1YikOwpzEf/iI4WZS0oaHUBs4Ei
         RjigK1X6jKasmE2HrBJe8z/9H81wruvOr1eedmqSvx7PxB0/EugzD420wNBIwOTDCWwa
         K3eMxPQm5fXmeRpNu/RM8dnGvAW23Ht7IT8Os=
Received: by 10.223.5.3 with SMTP id 3mr20017128fat.4.1318804340596; Sun, 16
 Oct 2011 15:32:20 -0700 (PDT)
Received: by 10.152.13.100 with HTTP; Sun, 16 Oct 2011 15:32:00 -0700 (PDT)
In-Reply-To: <9350c86dc58e6345b237de5af186718d97fdd19b.1318579823.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183740>

On 14 October 2011 19:14, Bert Wesarg <bert.wesarg@googlemail.com> wrot=
e:
> Setting config gui.search.smartcase to true, the search mode in the
> searchbar (from the blame view) is by default case-insensitive. But
> entering an upper case letter into the search field activates the cas=
e-
> sensitive search mode.
>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
> =C2=A0lib/search.tcl | =C2=A0 13 ++++++++++++-
> =C2=A01 files changed, 12 insertions(+), 1 deletions(-)
>
> diff --git a/lib/search.tcl b/lib/search.tcl
> index ef3486f..461c66d 100644
> --- a/lib/search.tcl
> +++ b/lib/search.tcl
> @@ -7,7 +7,8 @@ field w
> =C2=A0field ctext
>
> =C2=A0field searchstring =C2=A0 {}
> -field casesensitive =C2=A01
> +field casesensitive
> +field default_casesensitive
> =C2=A0field searchdirn =C2=A0 =C2=A0 -forwards
>
> =C2=A0field smarktop
> @@ -18,6 +19,12 @@ constructor new {i_w i_text args} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0set w =C2=A0 =C2=A0 =C2=A0$i_w
> =C2=A0 =C2=A0 =C2=A0 =C2=A0set ctext =C2=A0$i_text
>
> + =C2=A0 =C2=A0 =C2=A0 if {[is_config_true gui.search.smartcase]} {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set default_casese=
nsitive 0
> + =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set default_casese=
nsitive 1
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0${NS}::frame =C2=A0$w
> =C2=A0 =C2=A0 =C2=A0 =C2=A0${NS}::label =C2=A0$w.l =C2=A0 =C2=A0 =C2=A0=
 -text [mc Find:]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0entry =C2=A0$w.ent -textvariable ${__this}=
::searchstring -background lightgreen
> @@ -45,6 +52,7 @@ constructor new {i_w i_text args} {
> =C2=A0method show {} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if {![visible $this]} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0grid $w
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set casesensitive =
$default_casesensitive
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0focus -force $w.ent
> =C2=A0}
> @@ -125,6 +133,9 @@ method _incrsearch {} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if {[catch {$ctext index anchor}]} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$ctext mark se=
t anchor [_get_new_anchor $this]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 if {[regexp {[[:upper:]]} $searchstring]} {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set casesensitive =
1
> + =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if {$searchstring ne {}} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set here [_do_=
search $this anchor mlen]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if {$here ne {=
}} {
> --
> 1.7.6.789.gb4599
>

I don't really know tcl so I'm not certain, but it looks like you
never reset the case sensitive flag once it has been set by entering
an upper case letter. If I accidentally enter an upper case letter and
have set smartcase true, I would expect that deleting that character
would turn case sensitivity off again.

Regards,

Andrew Ardill
