From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/3] archive: specfile support (--pretty=format: in archive
 files)
Date: Wed, 05 Sep 2007 01:13:50 +0200
Message-ID: <46DDE6AE.10107@lsrfire.ath.cx>
References: <46DC4D45.4030208@lsrfire.ath.cx>	<Pine.LNX.4.64.0709031935540.28586@racer.site> <85ps0zmrhs.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 01:14:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IShau-0003GJ-0t
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 01:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbXIDXNz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 4 Sep 2007 19:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754041AbXIDXNz
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 19:13:55 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:37428
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752403AbXIDXNy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2007 19:13:54 -0400
Received: from [10.0.1.201] (p508EDAF7.dip.t-dialin.net [80.142.218.247])
	by neapel230.server4you.de (Postfix) with ESMTP id B0D6C873B6;
	Wed,  5 Sep 2007 01:13:53 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <85ps0zmrhs.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57656>

David Kastrup schrieb:
> I think a bit more layering would be helpful: when using git-svn, one
> would want to have things like $Id$ and $Date$ expanded, so maybe
> attribute specs like
>=20
> somefile: expandmarkers=3D"$Date: %aD$ $Id: ....$"
>=20
> would be nice having.  In the case of git-svn, I would expect them to
> be generated from git-svn from the respective svn properties, so that
> the user is not bothered with figuring out the awful $Id$ and whateve=
r
> strings.

Eek!  I'd rather shove this into a new layer below specfile/template
expansion, which would do something like that:

   s/\$Date:.*\$/$Format:$$Date: %aD$/

This way A) the complexity and ugliness affects only the users of these
fields, while $Format:...$ users are not adversely affected, and B) we
can first implement $Format:...$ handling and add the rest later.

In order to expand $Id$, git-archive would need to run some kind of
callback, right? :-/  Let's first see if such a thing is really needed.

Ren=E9
