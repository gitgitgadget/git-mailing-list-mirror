From: Marc Bowes <marcbowes@gmail.com>
Subject: git-svn against a monolithic repository
Date: Wed, 14 Apr 2010 11:44:21 +0200
Message-ID: <j2tcfa4e841004140244o1dfa51fdk9b435ff7c04c2a3b@mail.gmail.com>
References: <h2jcfa4e841004140232y2137d43eg4be9bebdc2d29290@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 14 11:44:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1z95-0000Ng-Va
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 11:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826Ab0DNJoZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Apr 2010 05:44:25 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33477 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564Ab0DNJoY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Apr 2010 05:44:24 -0400
Received: by gyg13 with SMTP id 13so4021444gyg.19
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 02:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=l63Pld0F6gpMYXll9RYELUyBwZ8MdYY+N7r+/XdKK8E=;
        b=Z9/mhTn4hpi3GTxqaB2cKt5nvx8kVbfBTDZlfkjrdOoXAnSkzOZ3ktW4VDKll3gdbF
         4vXcRKn+0pueVdN24PWs44DRHTKWTjHfr2IueoWvnNkBuWfbbj60s3wnbygna5qx0l9M
         VDr60d/XWIKiRXFEdfREK2IE8vgsu04jSQ0qo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=AT2Iv78wkISGt2+LxSEhVm20MAOeCYYSWp/fjzSwpHJfswR0g3Czh6qAZbM5IORgmV
         w1fQbFdEqCk7MQiHhRPSEXOJcKYB7S2xFAOsKErDhtxFS0zie18q0HM+HGiA2KaiyedW
         BN1cOJ7cMD/HqfmPUPShyrWryLdPt43TBbnJA=
Received: by 10.90.50.3 with HTTP; Wed, 14 Apr 2010 02:44:21 -0700 (PDT)
In-Reply-To: <h2jcfa4e841004140232y2137d43eg4be9bebdc2d29290@mail.gmail.com>
Received: by 10.90.141.20 with SMTP id o20mr3276038agd.97.1271238261102; Wed, 
	14 Apr 2010 02:44:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144862>

Hiya,

The subversion repository I need to work with is quite odd (by my
standards, anyways).

The structure looks something like:

|-- patches
|=A0=A0 `-- foobar
|=A0=A0=A0=A0=A0=A0 `-- project-name
`-- trunk-team-name
=A0=A0=A0 `-- project-name

That is, a single monolithic repository. Each team has their own trunk
(as a folder). The patches folder is essentially a production branch
for a specific region. Each developer tends to have a branch somewhere
else which they use to hack on. When they are ready, the code goes
through a review process and then is copied (svn copy) into trunk. It
then goes through a build process and is finally merged (in this case,
using meld) into the patches where other stuff happens to it.

I would like to use a single git repository for each project. That is,
my master branch should relate to the project folder in trunk and my
production-foobar branch should relate to the project folder in
patches. I could then use git to hack on a local branch and merge to
master (and then dcommit back to trunk). When ready, I could then
merge master into the production branch (and then dcommit back to
patches).

I guess what I'm looking for is something like:

git svn clone https://svn/url -T trunk-team-name/project-name -b
patches/foobar/project-name

However, I'm pretty sure that is wrong. Not only does it take forever
(I landed up canceling it), but I don't think the git-svn branches
will understand the weirdo layout.

I tried manually adding svn-remotes, running git-svn fetch against
then and then branching off. However, I started seeing weird things
happening when merging (sometimes git-svn became attached to the wrong
remote, sometimes it wouldn't update properly, lots of obscure merge
conflicts..).

In the worst case, I could clone each project (that is, trunk and
patches) separately and manually merge. But if I can get git to do
this for me, it'd make a lot of sense.

If anybody has any ideas, I'd be extremely grateful.
