From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Why is the name of a blob SHA1("$type $size\0$data") and not
	SHA1("$data")?
Date: Fri, 1 May 2009 00:57:33 +0200
Message-ID: <20090430225733.GC18940@atjola.homenet>
References: <49FA0214.70009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Srbecky <dsrbecky@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 01 00:57:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzfCL-00065U-Ox
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 00:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbZD3W5g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Apr 2009 18:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbZD3W5g
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 18:57:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:38675 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750727AbZD3W5g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 18:57:36 -0400
Received: (qmail invoked by alias); 30 Apr 2009 22:57:34 -0000
Received: from i59F54956.versanet.de (EHLO atjola.local) [89.245.73.86]
  by mail.gmx.net (mp010) with SMTP; 01 May 2009 00:57:34 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18+yksu1eg+ljICDKM5Pgy9JAECeeiL8mFNDQ5Wkt
	j1Gje1NW11mqdh
Content-Disposition: inline
In-Reply-To: <49FA0214.70009@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118049>

On 2009.04.30 20:55:00 +0100, David Srbecky wrote:
> Hi,
>
>
> First of all, congratulations on makeing such a great version control=
 =20
> system.  I love the storage model - in comparison with other systems,=
 it =20
> is just birantly simple and ingenious.
>
>
> I started digging into the details and there is one thing that is rea=
lly =20
> bugging me - why is the name of a blob SHA1("$type $size\0$data") and=
 =20
> not SHA1("$data")?  I mean, wouldn't it be beautiful if the name of t=
he =20
> blob would really just be the SHA1 of the uncompressed file content? =
:-)
>
>
> Furthermore, is the header really necessary?  Wouldn't it be =20
> eqvivalently effective to put the blobs into own subdirectory? For =20
> example:  .git\objects\blob\22\22a3d28c5b2fca0eae83be1a2ed619e357f6a1=
e6
> So the blob would contatin just be the compressed content and nothing=
 =20
> else - beautiful :-)

Yes, at least the type is pretty important. Consider just "git show
$some_object_name". If the object name was just the hash of the
contents, you could have a blob and a commit with the same name. Which
is which? And which do you mean in that command? The command line
interface would need to accept a type in addition to the object name in
a lot of place.

And in packs, you want the objects ordered so that you get could access
patterns, and don't read from all over the pack file. That means that
you would need the type header there, regardless of whether it is in th=
e
loose object file.

Bj=F6rn
