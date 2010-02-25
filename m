From: Mark Lodato <lodatom@gmail.com>
Subject: Re: git-svn fails with non-alphanumeric SVN authors
Date: Wed, 24 Feb 2010 21:52:30 -0500
Message-ID: <ca433831002241852x41af821dm5549dd602d5b89e7@mail.gmail.com>
References: <e260aad41002241247r180d5477kd18f5cbee8109634@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Craig de Stigter <craig.destigter@koordinates.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 03:53:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkTqU-0003I9-3G
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 03:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758848Ab0BYCww convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 21:52:52 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:39443 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758822Ab0BYCwv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2010 21:52:51 -0500
Received: by ywh35 with SMTP id 35so2965651ywh.4
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 18:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=oNuBRMZ8fjaYZ6WhteeOgiX/C3+gddyoa2YW0DFvWdY=;
        b=S3DeGuc2SQIWq5+214PAQuJpzPEEQGK1lGVUUSas1mniQgrRWyfO1NCnqFgl7SmBco
         DSgwkRngmvqMukgOMp/crxkiWx617FstKkk+vd3CWvQowOlGPi0us1Amisl/wau5kxiQ
         vqy3HC360CWKFHebJ/HlOtG9HRJM9UUukvLWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Fg1WI/Ize/Qd/4NM8+HCzft0xZ0sU0uelEgE5m2WLsyFaxUQiNTnXsHShsmfnwlPzx
         BYWB4F5XUjLiBrUcmoBclOQDzXSNvtyTTmH2ocUnn8/6Ap7V/6Bz3UT83fQ2sTwU6ViG
         LXIHr1bKBifxIx6ZaMGXYIB5pnWw6aF0SbNc0=
Received: by 10.90.183.7 with SMTP id g7mr917388agf.42.1267066370176; Wed, 24 
	Feb 2010 18:52:50 -0800 (PST)
In-Reply-To: <e260aad41002241247r180d5477kd18f5cbee8109634@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141021>

On Wed, Feb 24, 2010 at 3:47 PM, Craig de Stigter
<craig.destigter@koordinates.com> wrote:
> I'm trying to use git-svn to move our subversion to git. Some of the
> authors in our SVN repository are x.509 identifiers, so my authors
> file has some entries like this:
> =C2=A0 /C=3DNZ/ST=3DNew Zealand/L=3DAuckland/O=3DKoordinates
> Ltd/OU=3DIS/CN=3Dcdestigter =3D Craig de Stigter
> <craig.destigter@koordinates.com>
>
> git-svn doesn't like that - it fails saying:
> =C2=A0 Author: /C=3DNZ/ST=3DNew Zealand/L=3DAuckland/O=3DKoordinates
> Ltd/OU=3DIS/CN=3Dcdestigter not defined in ./authors.txt file
>
> I presume it is choking on either the spaces or the '=3D' characters =
in
> the SVN username?

Yes.  The --authors-file option reads the name up to the first equals
sign, which causes a problem for the X.509 identifiers.  I had this
exact problem, which is why I implemented --authors-prog. [1]  In my
case, I could compute the username and email address from the X.509
id, so I didn't have to list them all out.  Perhaps you can use this
to solve your problem?  Even if you can't compute the name directly
from the X.509 ID, you could implement your own lookup in a script.

[1] http://www.spinics.net/lists/git/msg103524.html
