From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 10/19] fast-import: introduce 'done' command
Date: Wed, 8 Jun 2011 22:07:07 +0200
Message-ID: <BANLkTik71j9qw_eaFmAMXjMmZq9wCTpGMg@mail.gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-11-git-send-email-srabbelier@gmail.com> <20110608200345.GJ27715@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 22:07:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUP2g-0003ou-01
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 22:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab1FHUHt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 16:07:49 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:40075 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab1FHUHs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 16:07:48 -0400
Received: by qyk7 with SMTP id 7so2126947qyk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 13:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=sEo/x4yLOddD7d8S5aOdUKYK/XBOY2GcwT4aW54k6no=;
        b=qAg2tNwlQNg+NDc48iyL9PxdIW0yiPgPkfW+jmTph/sJIhuxyK2DlkfVrzX63yQ0Ft
         9Hwk5E6qHkEBoz+Sklx12sr6rZFljddUHh462D0JfnTvjkTZmPud9akflr96DQ7gfdU0
         c+InEGnSluuNdsbSwj5Sh+hKV9uoTIEz23IXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pNzxFAfb6n5DmveEMOsSLryG++faiHIpMACntGVaIvZEK0wrIN47+mg8ncCpbEPGfX
         heX2KdNHo2YGeWpUJaI+fS30oGbnPmSVvNaQKYgLOO9VC/hq9fOqIpok91jTFMQKp+Np
         sxSEr2NorMkZDsuBmAvcgUIYfo85hX51Ym848=
Received: by 10.229.135.12 with SMTP id l12mr5911348qct.53.1307563667175; Wed,
 08 Jun 2011 13:07:47 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Wed, 8 Jun 2011 13:07:07 -0700 (PDT)
In-Reply-To: <20110608200345.GJ27715@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175455>

Heya,

On Wed, Jun 8, 2011 at 22:03, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C2=A0C) make sure the upstream of the pipe does not write anything a=
fter
> =C2=A0 =C2=A0"done\n" until the "done\n" command has been read. =C2=A0=
In other
> =C2=A0 =C2=A0words:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0transport-helper> =C2=A0 =C2=A0 =C2=A0 don=
e
> =C2=A0 =C2=A0 =C2=A0 =C2=A0remote-helper> =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0yep, I'm done
> =C2=A0 =C2=A0 =C2=A0 =C2=A0transport-helper> =C2=A0 =C2=A0 =C2=A0 ah,=
 now that you mention that, here are
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a few more things you could d=
o...
>
> As long as there is nothing after the "done\n" in the pipe buffer whe=
n
> fast-import reads "done\n", it won't read too far.

This I think makes the most sense. Although I'm not sure it's
currently possible in remote-testgit, as in, I'm not sure the relevant
pipes are connected to the right programs to make feasible. Also, I'm
not really interested in implementing that, or at least, not right
now, I just shamelessly stole your commit message ;).

--=20
Cheers,

Sverre Rabbelier
