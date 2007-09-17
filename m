From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 4/9] Introduce entry point for launching
	add--interactive.
Date: Mon, 17 Sep 2007 19:13:12 -0400
Message-ID: <1190070792.10112.15.camel@hinata.boston.redhat.com>
References: <11890382183913-git-send-email-krh@redhat.com>
	 <11890382242333-git-send-email-krh@redhat.com>
	 <11890382243290-git-send-email-krh@redhat.com>
	 <11890382253220-git-send-email-krh@redhat.com>
	 <Pine.LNX.4.64.0709061729270.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 01:13:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXPmS-00063o-GT
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 01:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbXIQXNX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 19:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752799AbXIQXNX
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 19:13:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45526 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611AbXIQXNX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 19:13:23 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8HNDIbF022539
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Sep 2007 19:13:18 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8HNDInh008247;
	Mon, 17 Sep 2007 19:13:18 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8HNDHCe011684;
	Mon, 17 Sep 2007 19:13:17 -0400
In-Reply-To: <Pine.LNX.4.64.0709061729270.28586@racer.site>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58495>

On Thu, 2007-09-06 at 17:31 +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Wed, 5 Sep 2007, Kristian H=C3=B8gsberg wrote:
>=20
> > diff --git a/builtin-add.c b/builtin-add.c
> > index 3dd4ded..e79e8f7 100644
> > --- a/builtin-add.c
> > +++ b/builtin-add.c
> > @@ -153,6 +154,13 @@ static int git_add_config(const char *var, con=
st char *value)
> >  	return git_default_config(var, value);
> >  }
> > =20
> > +int interactive_add(void)
> > +{
> > +	const char *argv[2] =3D { "add--interactive", NULL };
> > +
> > +	return run_command_v_opt(argv, RUN_GIT_CMD);
> > +}
>=20
> I'd rather have this in builtin-commit.c, since it is quite funny if=20
> builtin-add.c has code to fork() and exec() itself (eventually, that=20
> is) ;-)

Huh... it ends up in the same binary, and interactive_add() sounds like
it should live in builtin-add.c rather than builtin-commit.c.  Either
way, I don't care too much, but can we fix it up later?

> > diff --git a/commit.h b/commit.h
> > index 467872e..64e1d4b 100644
> > --- a/commit.h
> > +++ b/commit.h
> > @@ -122,4 +122,13 @@ extern struct commit_list *get_shallow_commits=
(struct object_array *heads,
> >  		int depth, int shallow_flag, int not_shallow_flag);
> > =20
> >  int in_merge_bases(struct commit *, struct commit **, int);
> > +
> > +extern const unsigned char *
> > +create_commit(const unsigned char *tree_sha1,
> > +	      unsigned char parent_sha1[][20], int parents,
> > +	      const char *author_info, const char *committer_info,
> > +	      const char *message, int length);
> > +
> > +extern int interactive_add(void);
> > +
>=20
> Just a guess: you did not want create_commit() to creep in here, righ=
t?

Yeah, that was another oversight, fixed in the next series.

Kristian
