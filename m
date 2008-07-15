From: =?ISO-8859-1?Q?=22Peter_Valdemar_M=F8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>
Subject: Standard "git svn init ; git svn fetch" behavior
Date: Tue, 15 Jul 2008 13:24:00 +0200
Message-ID: <487C88D0.30609@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 15 13:55:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIj82-0003fD-Ba
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 13:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755298AbYGOLye convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jul 2008 07:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755253AbYGOLye
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 07:54:34 -0400
Received: from morch.com ([193.58.255.207]:56030 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755238AbYGOLyd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 07:54:33 -0400
X-Greylist: delayed 1828 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jul 2008 07:54:32 EDT
Received: from [192.168.1.214] (ANice-157-1-23-113.w90-28.abo.wanadoo.fr [90.28.46.113])
	by morch.com (Postfix) with ESMTP id BB0AC2837
	for <git@vger.kernel.org>; Tue, 15 Jul 2008 13:25:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88551>

Hi,

I've now converted my svn repos to git with

$ git-svn init -T trunk -t tags -b branches file://some/path
$ git svn fetch

Wonderful!

I have two questions about the result:

1) It seems the svn tags were converted into git branches such as=20
"tags/mytag". Is that normal?

2) Why does master end up being off of tags/mytag instead of off of tru=
nk?

###################################
Re: 1) It seems the svn tags were converted into git branches such as=20
"tags/mytag". Is that normal?
###################################

$ git tag -l
returns nothing and
$ git branch -a
returns all my svn tags as "tags/<tag>" git branches and all my svn=20
branches as expected in "the root".

Is that by design? Are there any downsides of creating a script that

foreach $tag ( m|tags/(.*)| ) {
   git tag $tag $tag
   git branch -r -D $tag
}

I'm cool with doing that, I just wanted to know if this is the expected=
=20
behaviour, and/or whether I'll run into trouble later because of a=20
wierdly converted subversion repository.


###################################
Re: 2) Why does master end up being off of tags/mytag instead of off of=
=20
trunk?
###################################

I would have expected, that "master" ended up tracking "trunk", and not=
=20
tags/mytag. Why track an obscure tag instead of trunk?

The tail of the fetch:

Successfully followed parent
W: +empty_dir: tags/mytag/probe/userHomedir/foo/cache/zlcache
W: +empty_dir: tags/mytag/probe/userHomedir/foo/pna_menu_items
r7375 =3D 5d3012afabccd348a5a5b81c5cf28532d324ea1b (tags/mytag)
Checking out files: 100% (2184/2184), done.
Checked out HEAD:
   file:///home/pvm/cm/repos/tags/mytag r7375

("mytag" and "foo" replaced internal identifiers present in real output=
=2E..)

$ git log --pretty=3Doneline --decorate -n 1

5d3012afabccd348a5a5b81c5cf28532d324ea1b (refs/remotes/tags/mytag,=20
refs/heads/master) Tag mytag

I rectified it with simply

$ git branch -m master old
$ git checkout -b master trunk
$ git branch -d old

Just wondering: Why is this behaviour the default? Is it a bug?

Is there a smarter way to find out what branchpoint was used to create=20
"master"? (I'm new to git, and find it difficult to see what my branche=
s=20
were "made from")

Peter

--=20
Peter Valdemar M=F8rch
http://www.morch.com
