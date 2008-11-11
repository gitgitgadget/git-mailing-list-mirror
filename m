From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: git commit -v does not removes the patch
Date: Tue, 11 Nov 2008 12:20:52 +0100
Message-ID: <adf1fd3d0811110320w53f9745bs68a6bd1b2e437f42@mail.gmail.com>
References: <adf1fd3d0811100720n52ac1d47id9b7f402412aa0d3@mail.gmail.com>
	 <20081110181023.GA22753@coredump.intra.peff.net>
	 <adf1fd3d0811101434j658b2e8aj83d8cbe2293f5021@mail.gmail.com>
	 <7vej1j40x5.fsf@gitster.siamese.dyndns.org>
	 <20081111000706.GA26223@coredump.intra.peff.net>
	 <adf1fd3d0811102356u6e671dcfj6491f81cf462ec2e@mail.gmail.com>
	 <20081111102914.GA30330@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 12:22:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzrK0-0006We-J2
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 12:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438AbYKKLUz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Nov 2008 06:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755432AbYKKLUz
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 06:20:55 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:12484 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404AbYKKLUy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Nov 2008 06:20:54 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1341938nfc.21
        for <git@vger.kernel.org>; Tue, 11 Nov 2008 03:20:52 -0800 (PST)
Received: by 10.103.52.7 with SMTP id e7mr4431152muk.52.1226402452632;
        Tue, 11 Nov 2008 03:20:52 -0800 (PST)
Received: by 10.103.165.1 with HTTP; Tue, 11 Nov 2008 03:20:52 -0800 (PST)
In-Reply-To: <20081111102914.GA30330@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100640>

On Tue, Nov 11, 2008 at 11:29 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 11, 2008 at 08:56:34AM +0100, Santi B=E9jar wrote:
>
>> Almost! I have diff.mnemonicprefix=3Dtrue, if I unset it everything =
works.
>
> Ah, indeed. The obvious fix is just loosening our match a little bit:
>
> diff --git a/builtin-commit.c b/builtin-commit.c
> index 93ca496..a721990 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -1015,7 +1015,7 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
>        }
>
>        /* Truncate the message just before the diff, if any. */
> -       p =3D strstr(sb.buf, "\ndiff --git a/");
> +       p =3D strstr(sb.buf, "\ndiff --git ");
>        if (p !=3D NULL)
>                strbuf_setlen(&sb, p - sb.buf + 1);
>

It fixes it, thanks.

>
> But I have to wonder if there is some more robust solution. It seems
> like this can have false positives if you include diff output in your
> commit message, and a potential false negative if you delete the newl=
ine
> (e.g., delete everything up to "diff --git", making it the first line=
).
>
> But I guess we haven't seen a lot of complaints, so maybe those
> conditions aren't worth worrying about.

The false positive/negative were already possible, it was just a
little more narrow. So not worth worrying about.
Also, if you really want a diff in the commit message you can use the
--cleanup option.

A more robust solution could be to have a:

# Everything after this line will be removed from the commit message

But, again, not worth.

Santi


>
> -Peff
>
