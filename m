From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 1/2] tests: make test_must_fail more verbose
Date: Wed, 1 Sep 2010 13:37:31 +1000
Message-ID: <AANLkTi=aGdLj4vRKs8dR64JO=c8eC3SHj0_hkh6Wutaw@mail.gmail.com>
References: <20100831155457.GB11014@sigill.intra.peff.net>
	<20100831155636.GA11530@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 01 05:37:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqe8p-0003bq-HO
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 05:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851Ab0IADhd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 23:37:33 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57769 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab0IADhc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 23:37:32 -0400
Received: by qwh6 with SMTP id 6so5900234qwh.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 20:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e4EY9l3udxX4/L23dAqIGgwVNaSREAiRWu+pJikw/sQ=;
        b=pAz0rMJVCMthxpFse8ttG8R24gPkE1LGWUbGTv4pFlZi6g87AX0zqzSuYR7JRxX5b5
         b8Af2QUwGWH3WgkP4EKyLbC1s+ygF3Dr/yD3oe6rxAC5r8blWuj5ybbMerWBk5L2SCDP
         QXfZLmF4TMaayCT5Xozc+H3rX+ufpgxK7lV4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ejgKyaeqAX3GWyr8025HUas6FLDK2pzNVGoe5aITnVOu6IotQ7qyal8YxXBMbtGiEU
         0NXH+OHqs782iGgNigjK8yUjM8PQxPXkQ5DXvkGyfM66kyWpnsvowzK+mDBJzDWGF7hV
         Z4E/S1C83tey0dtdv1BoQfEOAB57OKi8iOSPc=
Received: by 10.224.57.213 with SMTP id d21mr4702890qah.136.1283312251544;
 Tue, 31 Aug 2010 20:37:31 -0700 (PDT)
Received: by 10.229.96.7 with HTTP; Tue, 31 Aug 2010 20:37:31 -0700 (PDT)
In-Reply-To: <20100831155636.GA11530@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155011>

On Wed, Sep 1, 2010 at 1:56 AM, Jeff King <peff@peff.net> wrote:
> Because test_must_fail fails when a command succeeds, the
> command frequently does not produce any output (since, after
> all, it thought it was succeeding). So let's have
> test_must_fail itself report that a problem occurred.
>
> Signed-off-by: Jeff King <peff@peff.net>

Jeff,

Nice fix - thank you!

It is nice to see that my initial sloppiness inspired a thoughtful
remediation. I'll try not to rely of gitters being always so helpful
:-)

jon.

> ---
> =C2=A0t/test-lib.sh | =C2=A0 10 +++++++++-
> =C2=A01 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 3a3d4c4..285bfd8 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -591,7 +591,15 @@ test_path_is_missing () {
>
> =C2=A0test_must_fail () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"$@"
> - =C2=A0 =C2=A0 =C2=A0 test $? -gt 0 -a $? -le 129 -o $? -gt 192
> + =C2=A0 =C2=A0 =C2=A0 exit_code=3D$?
> + =C2=A0 =C2=A0 =C2=A0 if test $exit_code =3D 0; then
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo >&2 "test_mus=
t_fail: command succeeded: $*"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1
> + =C2=A0 =C2=A0 =C2=A0 elif test $exit_code -gt 129 -a $exit_code -le=
 192; then
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo >&2 "test_mus=
t_fail: died by signal: $*"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1
> + =C2=A0 =C2=A0 =C2=A0 fi
> + =C2=A0 =C2=A0 =C2=A0 return 0
> =C2=A0}
>
> =C2=A0# Similar to test_must_fail, but tolerates success, too. =C2=A0=
This is
> --
> 1.7.2.2.119.gf9c33
>
>
