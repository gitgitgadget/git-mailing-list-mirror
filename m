From: Chris Kees <cekees@gmail.com>
Subject: Re: CAC enabled authentication with git transfer protocols
Date: Mon, 12 Mar 2012 21:20:39 -0500
Message-ID: <CAOVFbFhbuWDFYcOqW3vcN==eC8495xuGRONLOrcWO6uZwJ2ETA@mail.gmail.com>
References: <B1ECBDB2E23847488F70D870CBE563F70198D579@nawespscez06v.nadsuswe.nads.navy.mil>
	<CAJo=hJsshrJc0Onjph3LcQxEkXDSzEPp8TQetGoy9Rwz6OXRuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jones, Brian P CTR SPAWARSYSCEN-PACIFIC, 63600" 
	<brian.p.jones4.ctr@navy.mil>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 13 03:29:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7HUA-00035c-D7
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 03:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758419Ab2CMC2k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Mar 2012 22:28:40 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:48800 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756113Ab2CMC2j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Mar 2012 22:28:39 -0400
Received: by wejx9 with SMTP id x9so43919wej.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 19:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=K5YIJ/MFcCJohtCkuguefOQRX9VihYIU/X46So1uKjY=;
        b=B3qJvLRWpAzP+32Eku6/CIHIS+yozpOF0qQK976COYSN7UT10/IG3u7MLrEtAUkJKO
         fOH6/zqNtJefa0iG4el/vvyg87vIUe8AWjfqNMioAVJmwRdPNk1rB/aScLj/w1IKlB4N
         Sk59JjBC+YbYFxnhVcvzR6PyqLiipgvxiPUDYp+0zLVdvIpP0UI6dBYIx3pu4+iphuPB
         2HjvE+hMvMkB7Lj9RseH/+7ACnXMy3hyIreBPCDi+9v/hkaBz2lbg0QM8yxIdn9IvXOB
         A+jYiPAU76DqZEIOzA0ieWFi/RD8h25Lw2K99goawvl8iS5/T8mS/hgoPIbFDm6jemHd
         fx8A==
Received: by 10.180.102.102 with SMTP id fn6mr2997919wib.10.1331605240004;
 Mon, 12 Mar 2012 19:20:40 -0700 (PDT)
Received: by 10.216.178.8 with HTTP; Mon, 12 Mar 2012 19:20:39 -0700 (PDT)
In-Reply-To: <CAJo=hJsshrJc0Onjph3LcQxEkXDSzEPp8TQetGoy9Rwz6OXRuw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192970>

On Mon, Mar 12, 2012 at 8:53 PM, Shawn Pearce <spearce@spearce.org> wro=
te:
> On Mon, Mar 12, 2012 at 17:54, Jones, Brian P CTR
> SPAWARSYSCEN-PACIFIC, 63600 <brian.p.jones4.ctr@navy.mil> wrote:
>> Does anyone know if git is being used in a military CAC enabled envi=
ronment? This means that the DoD CAC card is required to authenticate w=
hen hitting the git transfer protocol. This is a requirement before I c=
an propose using git. I understand that git is able to use https as wel=
l as ssh or over port 9418. Is there any documentation on setting up CA=
C enabled git protocols?
>
> The git:// protocol on port 9418 has no authentication. It won't meet
> your requirements.
>
>
> For Git over ssh://, Git just relies on the SSH client and server
> binaries installed on the system. You would have to find out if these
> binaries meet your requirements. If they do, you may just be able to
> use SSH.
>

It seems like ssh might be the best shot. Kerberised ssh servers and
clients can already be set up so that they use a CaC for
authentication.

>
> Git 1.7.9 and later on https:// can use a credential helper binary to
> obtain the user's "password" string. A credential helper is an
> external program Git calls to help it authenticate over HTTP using
> either HTTP basic or HTTP digest authentication. It may be possible t=
o
> write a git-credential-dodcac binary that does the magic required.
> Install this binary in the user's $PATH, have them enable it with a
> `git config --global credential.helper dodcac` configuration setting,
> and away they go.
>
> If a DoD CAC is like a one time password scheme, it may be possible t=
o
> have the user's "password" over HTTP actually be $password:$onetimepa=
d
> or some such format, and then use a custom authentication system on
> the server to decode this string and verify it.
>
> Internally at $DAYJOB we use a custom git-credential-$DAYJOB binary t=
o
> acquire a unique token that identifies the caller and pass this to th=
e
> server over HTTPS. The HTTP server in turn verifies this string with
> the authentication system. Its not really their password, its just a
> mutually agreed upon blob that was passed around between the client
> workstation and the server.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
