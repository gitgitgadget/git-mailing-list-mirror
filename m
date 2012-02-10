From: David Aguilar <davvid@gmail.com>
Subject: Re: A note on modern git plus ancient meld ("wrong number of arguments")
Date: Thu, 9 Feb 2012 18:42:51 -0800
Message-ID: <CAJDDKr58LV9EDJZP+3S0YfyTOXFgJWD6nm=AiA19MkyBF-wb_g@mail.gmail.com>
References: <20120209191742.GA20703@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Fri Feb 10 03:43:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvgS3-0001CD-4k
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 03:43:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331Ab2BJCmw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 21:42:52 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44420 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758134Ab2BJCmv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 21:42:51 -0500
Received: by yhoo21 with SMTP id o21so1274562yho.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 18:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=s0X8cvUaZqgv1hud7H7DF2xL7x4qcYNPYxpz1VUOM8E=;
        b=CxNP9eY4zhTtJ6xZFZqOGUghZ4jIV3fvMRxA88HiHNtfoVf4JKHDTI9Z7eL5XNeETM
         bco2++4cv5Uj9z9daPPHrnq5Td5gZaQpcqri1O8aVvbM6EahN6GkPe6xFyEcwtAhxzki
         KNq6KJBEh+JRkxjZQ8ukZvgZAqkc9gLZQF2bM=
Received: by 10.236.173.202 with SMTP id v50mr6269863yhl.102.1328841771241;
 Thu, 09 Feb 2012 18:42:51 -0800 (PST)
Received: by 10.146.249.16 with HTTP; Thu, 9 Feb 2012 18:42:51 -0800 (PST)
In-Reply-To: <20120209191742.GA20703@unpythonic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190373>

On Thu, Feb 9, 2012 at 11:17 AM, Jeff Epler <jepler@unpythonic.net> wro=
te:
> I note this just in case it helps someone else track down a similar
> problem, not because I think any change needs to be made to git, as a
> version of meld new enough to not be affected by this problem is 5 ye=
ars
> old.
>
> At $DAYJOB, I recently encountered a problem after upgrading from (do=
n't
> laugh) git 1.7.1 to 1.7.8.3: one developer stated that meld failed to
> run, instead displaying the error 'Wrong number of arguments (Got 5)'=
=2E
>
> We determined that this user was running a very old version of meld
> (1.1.1) from his home directory, as opposed to the also very old syst=
em
> version of meld (1.1.5). =C2=A0It turns out that the check added in
> =C2=A0 =C2=A0f61bd9c mergetools/meld: Use '--output' when available
> fails on meld 1.1.1, leading git to incorrectly believe the --output
> flag is supporrted:
> =C2=A0 =C2=A0$ meld-1.1.1 --output /dev/null --help >/dev/null 2>&1; =
echo $?
> =C2=A0 =C2=A00 =C2=A0 # i.e., detected as supported
> The test as written gives the correct ("not supported") result with m=
eld
> 1.1.5:
> =C2=A0 =C2=A0$ meld-1.1.5 --output /dev/null --help >/dev/null 2>&1; =
echo $?
> =C2=A0 =C2=A02 =C2=A0 # i.e., detected as supported
>
> so if you encounter the message 'Wrong number of arguments (Got 5)' f=
rom
> meld, then check whether you have an ancient version of meld. =C2=A0I=
f for
> some reason you can't upgrade to at least 1.1.5, maybe you'd find the
> following configuration flags useful:
> =C2=A0 =C2=A0[merge]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tool =3D ancientmeld
> =C2=A0 =C2=A0[mergetool "ancientmeld"]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd =3D meld-1.1.1 \"$LOCAL\" \"$MERGED\" =
\"$REMOTE\"

We originally used the --output test so that we wouldn't have to check
for a specific version.  Does your meld support `meld --version`, and
what does it output?

I'm thinking that maybe we should just try and parse the version
number since it seems like we cannot depend on ancient meld's return
code.

Thanks Jeff.  I'll see what we can do about it.
--=20
David
