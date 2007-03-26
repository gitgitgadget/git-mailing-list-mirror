From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH] gitweb: Support comparing blobs (files) with different names
Date: Mon, 26 Mar 2007 22:41:16 +0200
Message-ID: <20070326204116.GB1128@auto.tuwien.ac.at>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at> <11748548621186-git-send-email-mkoegler@auto.tuwien.ac.at> <200703261912.09445.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 22:41:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVw0I-0001JM-W8
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 22:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbXCZUlU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 26 Mar 2007 16:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752546AbXCZUlU
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 16:41:20 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:39324 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbXCZUlT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 16:41:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id BCE1272C8FB4;
	Mon, 26 Mar 2007 22:41:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H-bT0eig1bbn; Mon, 26 Mar 2007 22:41:16 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 719F673839AD; Mon, 26 Mar 2007 22:41:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200703261912.09445.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43183>

On Mon, Mar 26, 2007 at 06:12:09PM +0100, Jakub Narebski wrote:
> It is done by adding $file_parent ('fp') to the path limiter, meaning
> that diff command becomes:
>=20
> 	git diff-tree [options] hpb hb -- fp f
>=20
> instead of finding hash of a blob using git_get_hash_by_path subrouti=
ne
> or using extended SHA-1 syntax:
>=20
> 	git diff [options] hpb:fp hp:f
>=20

As far as I tested, this only works for renames, not
for comparing different objects, eg:

git-diff -r -p 08727ea8bba8c81678e5cf15124ada23ad097bc3:grep.h bb95e19c=
5f1e470d2efe1c0e4e04c291019e4b25:refs.h
shows differences

git-diff-tree -r 08727ea8bba8c81678e5cf15124ada23ad097bc3 bb95e19c5f1e4=
70d2efe1c0e4e04c291019e4b25 -- grep.h refs.h
shows no difference

As I want gitweb to be able to even do such compares (not just renames)=
,
I'll still need a solution for this.

My idea is, that if I got hb:f and hpb:fp, the user exactly specified
the blobs to be compared. Then I don't want any guessing logic.

mfg Martin K=F6gler
