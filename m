From: Charles Bailey <charles@hashpling.org>
Subject: Re: git mergetool from next not working in subdirectory
Date: Fri, 30 Jan 2009 14:06:15 +0000
Message-ID: <20090130140615.GA26321@hashpling.org>
References: <glutv9$4b1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonas =?iso-8859-1?Q?Flod=E9n?= <jonas.floden@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 15:07:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSu25-0006E2-Qd
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 15:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159AbZA3OGT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jan 2009 09:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753048AbZA3OGT
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 09:06:19 -0500
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:30830 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752530AbZA3OGS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2009 09:06:18 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEACSYgknUnw6U/2dsb2JhbADLGYQQBg
Received: from fhw-relay07.plus.net ([212.159.14.148])
  by relay.ptn-ipout02.plus.net with ESMTP; 30 Jan 2009 14:06:16 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by fhw-relay07.plus.net with esmtp (Exim) id 1LSu0e-0001NA-Bn; Fri, 30 Jan 2009 14:06:16 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n0UE6F1x028488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 Jan 2009 14:06:15 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n0UE6FA6028487;
	Fri, 30 Jan 2009 14:06:15 GMT
Content-Disposition: inline
In-Reply-To: <glutv9$4b1$1@ger.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: d5d9623354eb86a6a43ffc905e1bd7d8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107821>

On Fri, Jan 30, 2009 at 02:05:45PM +0100, Jonas Flod=E9n wrote:
> ~/src/rep/subdir $ git mergetool
> Merging the files: a/b/file.c
>=20
> git checkout-index: subdir/subdir/a/b/file.c is not in the cache
> git checkout-index: subdir/subdir/a/b/file.c is not in the cache
> git checkout-index: subdir/subdir/a/b/file.c is not in the cache
> Normal merge conflict for 'a/b/file.c':
>   {local}: modified
>=20
>   {remote}: modified


Oh bother. I know exactly what this is. ls-files -u shows paths
relative to the work tree root, whereas checkout-index responds to
relative paths. Essentially the "$prefix" needs to come out of the
calls to the new checkout_staged_file shell function.

This is the bad commit 0ec7b6c26dad51f690cd985d4a5357634123c4b7

I can patch this (and more importantly add a test for this) tonight if
nobody beats me to it.

--=20
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
