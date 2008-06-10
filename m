From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH - stgit] Patch to allow import of compressed files
Date: Tue, 10 Jun 2008 08:33:28 +0200
Message-ID: <20080610063328.GB26965@diana.vm.bytemark.co.uk>
References: <484D78BF.6030504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Clark Williams <clark.williams@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 08:34:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5xR9-00038w-VM
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 08:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbYFJGdh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2008 02:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbYFJGdh
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 02:33:37 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1515 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbYFJGdh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 02:33:37 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K5xQ9-00079K-00; Tue, 10 Jun 2008 07:33:29 +0100
Content-Disposition: inline
In-Reply-To: <484D78BF.6030504@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84475>

On 2008-06-09 13:38:55 -0500, Clark Williams wrote:

> This patch allows StGit to directly import compressed (.gz and .bz2)
> files with reasonable patch names.
>
> I do a lot of work on modified kernel trees and usually the first
> two things imported are a stable update patch followed immediately
> by an -rt patch, both of which are compressed. With this patch I can
> just copy the files down directly from kernel.org and import them,
> rather than having to keep uncompressed copies around.
>
> Hey, I'm lazy... :)

Lazy is good. Thanks for the patch!

> +        if filename.endswith(".gz"):
> +            import gzip
> +            f =3D gzip.open(filename)
> +            pname =3D filename.replace(".gz", "")
> +        elif filename.endswith(".bz2"):
> +            import bz2
> +            f =3D bz2.BZ2File(filename, 'r')
> +            pname =3D filename.replace(".bz2", "")

Some comments here:

  * By my reading of the docs, the second argument to BZ2File defaults
    to 'r' anyway, so you could omit it.

  * We try to use single quotes wherever possible (except when triple
    quoting). You're using a mix ...

  * .replace() will happily replace anywhere in the string. Please
    consider using stgit.util.strip_suffix() instead.

And last but not least, it'd be terrific if you'd let me bully you
into adding .gz and .bz2 test cases for t1800-import. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
