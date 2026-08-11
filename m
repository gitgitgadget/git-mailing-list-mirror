Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3500E2FD1CA
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 05:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786426548; cv=none; b=hqMXvc8oOIvQCFJe3fI2y8yqzuP3djMihXc2+yRN7UK+SkY8pt2q0OSi8CRfqjrq4poGbZeidaRffujSkwaYHmRRj1GYYQ9dIMaSu55sZ245GmE7KQfmPkS9LUjFTJgGUzGdJdGcC6rWfCXr09bxCkAjpE2OGV5uqE1n3ThBbDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786426548; c=relaxed/simple;
	bh=TDdI6frVgBnH+IPd96nS8cFQUVHHvsXT/G7gZO9Pvdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHs01GkAxwCLo2rIQySDKi9PFuOi7sBHIYDSuEtgwI4i+3HIYltc094JZplC8d7snFrTvGjfdXO4B8J4fCmtHVzuqEpq76VmjSaKHdOq5l2uHwwLU7H6sxglgyeT+QPdnxROAGwPlJnqdlijmcRIikLbyWU6F37aI0fbIT+jdK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ICAQVrzc; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ICAQVrzc"
Received: from macsyma.thunk.org (pool-173-48-113-153.bstnma.fios.verizon.net [173.48.113.153])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 67B5ZZ1T016822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 01:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1786426536; bh=X1iwKe3Dhf04rxlyWmdCIJjCTrtvS4/mUCjJ1S7Zw74=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ICAQVrzct4vvlkq819hb50n6cTfpG2w8WClhHjegakM1yQUWm/6+xEbxmY6sOZaOD
	 lroo6DSN1C3Bq573RBeGvbvGhbUIsk4N6oQCJbszigtVJEPdoXkK+pGDgopkXG5AeX
	 Sh/qt+ScBm72JvlVvaM87m1TDZEq7LKdun3dwa7AFL8q2HNQOozfohbZKMZasRm65y
	 zez50OJuWTIrpD1Fqvcp3gcTaqLBl2PfVhH6uI6Y7k7K5BC6oHEOGtkpDNAy0oOOqA
	 tg5dypgyG31mj45BYyTx/AQTaClDkg0C5chD2zgL72GMRnVzoyvDBd9W8QStH3O3w+
	 xkJG0k/8hbveQ==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id D4684E75F01; Tue, 11 Aug 2026 01:34:34 -0400 (EDT)
Date: Tue, 11 Aug 2026 01:34:34 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Skybuck Flying <skybuck2000@hotmail.com>
Cc: Git <git@vger.kernel.org>
Subject: Re: AI Textconv filter misconfiguration on Windows leads to silent
 corruption of diff output (ongoing investigation)
Message-ID: <anqu8TjyuvCkI948@mit.edu>
References: <AM0PR02MB445096594555DAD1D9EE1505B3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
 <AM0PR02MB445083767BAE669D4656CA6CB3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR02MB445083767BAE669D4656CA6CB3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>

On Tue, Aug 11, 2026 at 02:13:25AM -0500, Skybuck Flying wrote:
> 
> So sed removes literal 'r' instead of carriage returns. It appears that on
> Windows, the backslash in `\r` is not preserved through MSYS argument parsing,
> effectively turning the expression into `s/r//`.

The reason for this confusion is historical in nature and has to do
with a fundamental difference between Windows and Unix.  First,
understand that Unix predates Windows, with Unix being first developed
by AT&T Bell Labs in 1969, where as Windows dates from 1985, with DOS
dating from 1981.  Unix uses the forward slash ('/') as a path
separator.  However Windows and DOS uses the backwards slash ('\') as
a path separator, since DOS 1.0 used forward slashes for command-line
switches --- e.g., DIR/W.

Since Windows and DOS uses backwards slash as a path separator, it
can't be used as a quoting character, which is how Unix and Linux
interprets the backlash character.  Since MSYS (which is not developed
by the Windows Git team; they just use it), attempts to be compatible
with Unix / Linux, it uses backslash as quoting character.  CMD.EXE
and Powershell are Windows programs, which doesn't attempt to be Unix
compatible.

This is the nature of your confusion.  It's unfortunate that you find
this to be so irritating, but it's fundamentally because DOS/Windows
chose, back in the early 1980's, to be incompatible with Unix.  I
personally find Windows conventions to be irritating, and my way of
dealing with the problem is to avoid using Windows whenever possible.
Instead, I use MacOS and Linux, which doesn't have these Windows
compatibility problems.  Feel free to not use git, and to avoid
anything else which attempts to be compatible with Unix or Linux if
that brings you peace.  I certainly was much happier once I no longer
had to deal with Windows as part of my day job.  :-)

Cheers,

						- Ted
