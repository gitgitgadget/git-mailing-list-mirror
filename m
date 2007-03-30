From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Support comparing blobs (files) with different names
Date: Sat, 31 Mar 2007 01:55:14 +0200
Message-ID: <200703310155.14452.jnareb@gmail.com>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at> <200703280158.54929.jnareb@gmail.com> <20070328210301.GA57@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Sat Mar 31 01:52:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXQtP-0005nv-Bu
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 01:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933099AbXC3XwF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 30 Mar 2007 19:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933133AbXC3XwF
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 19:52:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:41031 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933099AbXC3XwC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 19:52:02 -0400
Received: by ug-out-1314.google.com with SMTP id 44so969851uga
        for <git@vger.kernel.org>; Fri, 30 Mar 2007 16:52:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IBBKux+xbTHcqogDCXK8LxbQUwLhivWsk54iXej/mWXEgiXqBCYiaGu3EMNv+wL1+6+BfUMGi0pyeyL6YVHP/Z+ReQE/FFLItROHYyLHdugLKvn0OAkuYcaac8UyJunLdUboGZ1ogcQqhHD+yZ8iN0/J/5LQg8Qz7wmy+ulR6vA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gAwo04PbfmCEDqGTUAY3WqpxH2sZ0gW268eySsOZyMxE6P0c2O+rD9LN+u/mHdSmoNynXgUhxmg7ftUP6nTL3yvqI5L6/Jue8QEtRhj5bi+wu5swTFs+/SqzCtTur2+sBNt/zBWBZOMk2msizX6weLoMhcQqB7SugrD+ZeBumM0=
Received: by 10.67.28.9 with SMTP id f9mr2329922ugj.1175298721248;
        Fri, 30 Mar 2007 16:52:01 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id g8sm9984402muf.2007.03.30.16.51.59;
        Fri, 30 Mar 2007 16:52:00 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070328210301.GA57@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43510>

On Wed, Mar 28, 2007, Martin Koegler wrote:

> I created a blob with a "strange" filename: &()=3D!"=A7$%[<>]*#+_;.
> In the result of the blob view, the " is not escaped in the filename =
in the header
> and a strage content type is returned:
>=20
> $ telnet localhost 80
> Trying 127.0.0.1...
> Connected to localhost.
> Escape character is '^]'.
> GET /gitweb/gitweb.cgi?p=3Dt/.git;a=3Dblob;f=3D%26()%3D%21%22%A7%24%2=
5%5B%3C%3E%5D%2A%23%2B_%3B.;hb=3D7bfed2588bee66b33db544830606fa6606478f=
d9 HTTP/1.0
>=20
> HTTP/1.1 200 OK
> Date: Wed, 28 Mar 2007 19:55:36 GMT
> Server: Apache
> Content-disposition: inline; filename=3D"&()=3D!"=C2=A7$%[<>]*#+_;."
> Expires: Thu, 29 Mar 2007 19:55:39 GMT
> Connection: close
> Content-Type: application/vnd.mif
>=20
> xx

There are two separate things.=20

=46irst is not escaped filename in HTTP header. There was some discussi=
on
about this, and even patch by Luben Tuikov which added to_qtext=20
subroutine to deal with escaping in HTTP (which has diferent rules than
escaping in HTML, or in HTML attributes)
 * gitweb: using quotemeta
   http://thread.gmane.org/gmane.comp.version-control.git/28050/
 * [PATCH] gitweb: Convert Content-Disposition filenames into qtext
   http://thread.gmane.org/gmane.comp.version-control.git/28437
But the patch was newer accepted; either lost in the noise, or in lack
of summary to the discussion.

Second is detecting file as binary (for text files we always return
HTML), and content type set. Gitweb checks mimetype of a file (based
on extension, mainly) by default using /etc/mime.magic, and if it is
neither text/* nor HTML images (png, jpg, gif) it uses "blobdiff_plain"
view. Perhaps instead of just calling git_blob_plain($mimetype) we
should do a redirect (but then how to pass detected mimetype?). It look=
s
like there is an error with mimetype detection: could you tell me the
line with "application/vnd.mif" in your /etc/mime.types?

--=20
Jakub Narebski
Poland
