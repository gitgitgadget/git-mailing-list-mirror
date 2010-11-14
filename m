From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH/RFC/WIP/POC] git-gui: grep prototype
Date: Sun, 14 Nov 2010 23:15:12 +0100
Message-ID: <AANLkTi=JR3vVnZ4Yz8o9MpZKiQ2_ASYxahbPNv8QACir@mail.gmail.com>
References: <1289770869-11665-1-git-send-email-bert.wesarg@googlemail.com>
	<20101114215442.GC16413@burratino>
	<AANLkTiktg4aZ7VfdXUT9XF4RK7MuCvzevB5jSRaNiE1L@mail.gmail.com>
	<20101114220932.GE16413@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	"Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 23:15:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHkr4-0000Zp-BQ
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 23:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325Ab0KNWPP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 17:15:15 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43717 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756497Ab0KNWPN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Nov 2010 17:15:13 -0500
Received: by iwn10 with SMTP id 10so5948357iwn.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 14:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=G/LdHnY0KKvcSRGAZvBoNrmuhkQSGWwJwn1S5nFdrao=;
        b=ExHO6II9JRLWYs4Mtfqpy1JNRZBsLCuE8fMHfCqkV5Vg+2IuHB2ZIE/9K2bPXrn+F7
         oMk3N0rcTZE+xzHdPCjiRdPbUyrjzPNMyJX+DkS7ZxJfjxwc2HiuFP7Py/Tb02aRRPnU
         de5ZZPOWppcesFJMFV20x31XIFuKoYZbdsT7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SYFNgSltiPMT1Roq62UfVFoB5L0BdfDonhdkFtQVJ50aEzklGgJ/s4jz+dd4u+L/5x
         bpjNSkWbZH4ZNC9YXgQFUplFhBB+6otUHAhHABmypPJGJVgB0hzsOue4BJYctYhFf8/u
         YraVj4/mW1muNoSzo37MrNFJtPfTdAYzOml+g=
Received: by 10.42.172.193 with SMTP id o1mr3940637icz.106.1289772912484; Sun,
 14 Nov 2010 14:15:12 -0800 (PST)
Received: by 10.42.167.1 with HTTP; Sun, 14 Nov 2010 14:15:12 -0800 (PST)
In-Reply-To: <20101114220932.GE16413@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161457>

On Sun, Nov 14, 2010 at 23:09, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Bert Wesarg wrote:
>> On Sun, Nov 14, 2010 at 22:54, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>
>>> This sounds like an excellent sort of thing to add to git grep -O, =
too
>>> (which currently has very limited support for editors' line number
>>> features). =C2=A0But what will it do with typical non-git-specific =
setups
>>> like
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0VISUAL=3Dvim
>>>
>>> or
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0EDITOR=3D"gvim --nofork"
>>>
>>> ?
>>>
>>> Do existing editors support LINENUMBER in the environment?
>>
>> I don't expect this, I have a wrapper script around my editor to sca=
n
>> the environment for these variables and pass the block/non-block
>> option to the editor.
>
> In that case, perhaps something like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0GIT_EDITOR=3D$(git var GIT_EDITOR)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0set -- --open-file-named-in-the-environmen=
t
> =C2=A0 =C2=A0 =C2=A0 =C2=A0eval "$GIT_EDITOR" '"$@"'
>
> would be appropriate? =C2=A0This way, existing editors like vi, ed, a=
nd
> emacs fail:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ ed --fjdkaslfjdas
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ed: unrecognized option `--fjdkaslfjdas'
>
> rather than opening a new, empty file.
>

Now I got your point. Maybe I should call GIT_EDITOR with $FILENAME as
argument but with a new variable to indicate open'n'forget. So
existing setups would always open the file (even without honoring the
line number) and new/smart wrappers can honor the open'n'forget and
line number flag.

Bert
