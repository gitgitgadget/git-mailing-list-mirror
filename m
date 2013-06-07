From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 6/6] completion: clarify ls-tree, archive, show completion
Date: Fri, 7 Jun 2013 20:45:27 +0200
Message-ID: <20130607184527.GB25731@goldbirke>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
 <1370181822-23450-7-git-send-email-artagnon@gmail.com>
 <20130603192555.GK2192@goldbirke>
 <CALkWK0mbVgJHRoNXNkc6n7==-H+caNqvzrzUwspS_Eq2sMfJbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 20:45:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul1fZ-00023g-AT
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 20:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756953Ab3FGSpp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 14:45:45 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:50390 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756741Ab3FGSpo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 14:45:44 -0400
Received: from localhost6.localdomain6 (g228010151.adsl.alicedsl.de [92.228.10.151])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MErMM-1UZRtN2wxO-00FWXC; Fri, 07 Jun 2013 20:45:27 +0200
Content-Disposition: inline
In-Reply-To: <CALkWK0mbVgJHRoNXNkc6n7==-H+caNqvzrzUwspS_Eq2sMfJbg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:hfXsKuv2naTc3VIPeHJV58t4Rr+yUa12Hn6Qcxc+guq
 P76Dxo17Pqk+YgF1XwQ3f43wSeKn+M7TcFY9y1mQYsEf4jlbIT
 2pK6O1yy0LUEgGtI6+Afq6dcR9dJMTsPiMEacQntmkbN02yvXH
 oGcxrJe7D7Ffd6ImXe+Wkoy/MG10j8PJWjgW/3NGirJqcl4PbP
 MJsuONAwMRmUaE6P+vucFA5dGq82ZBE5pHeVkKHkhHP8wiyR3F
 7maVrGfso6WiWJiEEC4y+7iada4gOqebnltJ6B4dEb98s68SYD
 ztPSDSfExWRvjRMq0mxxwl1jbdcBB3R1GcLwKQCEYv4uujRRH1
 XDUaTljH5purQqjRMK6eMIhlgWWl//wQeGmb4jnc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226666>

On Fri, Jun 07, 2013 at 10:51:53PM +0530, Ramkumar Ramachandra wrote:
> SZEDER G=E1bor wrote:
> > Well, people out there might have completion scriplets for their
> > aliases or custom git commands which use __git_complete_file().
> > Removing this function would break those scripts.
>=20
> What is the advantage of using __git_complete_file() over
> __git_complete_revlist_file()?

That it doesn't imply that the command takes refs in the form of
ref1..ref2.

> Isn't it just a misleading alias?

No.  It's an implementation detail that __git_complete_file() became
an alias to __git_complete_revlist_file() to avoid unnecessary code
duplication.

And it was a concious decision to keep __git_complete_file() (and
__git_complete_revlist()) around in order not to break completion
scriplets for users' alieses and custom git commands which might call
it.

> > Arguably the name of __git_complete_file() could describe better wh=
at
> > the function does, or what it did, i.e. it used to provide completi=
on
> > for the master:Doc<TAB> notation.  But that's only the name.  Since
> > both git ls-tree and git archive understand this notation, calling =
the
> > helper for master:Doc<TAB> in their completion functions is not
> > misleading at all.
>=20
> But __git_complete_revlist_file() provides all this and more, no?

Indeed, and this "more" is exactly why it is misleading to call
__git_complete_revlist_file() directly for git ls-tree and git
archive.

> > Now, __git_complete_revlist_file() provides completion both for thi=
s
> > master:Doc<TAB> notation and for revision ranges, i.e. for
> > master..n<TAB> and master...n<TAB>.  However, since neither git
> > ls-tree nor git archive accept revision ranges, calling
> > __git_complete_revlist_file() in their completion function would be
> > misleading.
>=20
> Yeah, they accept tree-ish'es.  Isn't __git_complete_file() still a
> horrible name?

We can't go back in time to correct it, unfortunately.

> If anything, we
> should write a new __git_complete_treeish() function that does what
> __git_complete_revlist_file() does, except that it doesn't complete
> revision ranges, right?  Frankly, I don't know if it's worth the
> additional trouble

I agree that it isn't worth it, and that is exactly why
__git_complete_revlist() and __git_complete_file() were unified in
__git_complete_revlist_file().

>   $ git log HEAD:Doc<TAB>
>=20
> Note how log doesn't even error out.

But note how git log master..HEAD:Documentation/ errors out.

> > git show is special, as it understands both the master:Doc<TAB>
> > notation and revision ranges, and even the combination of the two, =
so
> > calling __git_complete_revlist_file() there would indeed be better.
>=20
> It just accepts any revspec with pathspec filtering, like many many
> other commands.

Which many many other commands do accept ref1..ref2:file?


G=E1bor
