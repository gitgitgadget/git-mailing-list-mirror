From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] builtin-commit: Refresh cache after adding files.
Date: Fri, 09 Nov 2007 12:38:13 -0500
Message-ID: <1194629893.30909.12.camel@hinata.boston.redhat.com>
References: <1194626427-2419-1-git-send-email-krh@redhat.com>
	 <Pine.LNX.4.64.0711091702190.4362@racer.site>
	 <1194628412.30909.7.camel@hinata.boston.redhat.com>
	 <Pine.LNX.4.64.0711091722520.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 09 18:45:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqXvA-0005oW-Gh
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 18:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578AbXKIRpQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Nov 2007 12:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754388AbXKIRpQ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 12:45:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34050 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754193AbXKIRpP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 12:45:15 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA9HcJLx016593;
	Fri, 9 Nov 2007 12:38:19 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA9HcJ24008229;
	Fri, 9 Nov 2007 12:38:19 -0500
Received: from [192.168.1.105] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA9HcIKH017009;
	Fri, 9 Nov 2007 12:38:18 -0500
In-Reply-To: <Pine.LNX.4.64.0711091722520.4362@racer.site>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64230>

On Fri, 2007-11-09 at 17:24 +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Fri, 9 Nov 2007, Kristian H?gsberg wrote:
>=20
> > On Fri, 2007-11-09 at 17:05 +0000, Johannes Schindelin wrote:
> >=20
> > > On Fri, 9 Nov 2007, Kristian H=C3=B8gsberg wrote:
> > >=20
> > > > This fixes the race in the last test int t3700.
> > >=20
> > > Well, it is not a race.  My fault.  I thought it was.
> > >=20
> > > What you basically did was to make sure that the index is up-to-d=
ate=20
> > > after adding the files.  You might even want to say that in the c=
ommit=20
> > > message, and only then say that it fixes t3700, too.
> >=20
> > OK, I guess what I was wondering was why write_cache() doesn't writ=
e out
> > an up-to-date index.
>=20
> write_cache() only writes the index, it does not update it.
>=20
> > Do we need a call to refresh_cache() when we update the user cache =
but=20
> > commit an index created from read_tree+add_files?  I.e. after the=20
> > add_files_to_index() call on line 97?  The shell script doesn't do =
this,=20
> > it only runs update-index --refresh for the index that gets committ=
ed.
>=20
> I think it would be sane to do so.
>=20
> IIUC this basically means that "git add <file> && git commit" should =
do=20
> the same to the cache as "git commit <file>".

No, that's equivalent to "git commit -i <file>".  If you just say "git
commit <file>", that will create a temporary index initialized to HEAD,
add file to that index and the regular (user) index, and then commit th=
e
temporary index file.  The shell script doesn't refresh the regular
index in this case.  I think it makes sense to add that, but it will be
a subtle difference in behaviour.

cheers,
Kristian
