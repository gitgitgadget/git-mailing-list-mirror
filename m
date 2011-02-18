From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH 2/2] git-p4: Improve branch support
Date: Fri, 18 Feb 2011 00:51:00 +0000
Message-ID: <AANLkTinXHOUNhi163WFGYLgQx4QhO=duOGExhtYr-chK@mail.gmail.com>
References: <1297813789-3831-1-git-send-email-vitor.hda@gmail.com>
 <1297813789-3831-3-git-send-email-vitor.hda@gmail.com> <20110217184234.GB20627@honk.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 01:51:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqEZM-0004FE-Ml
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 01:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504Ab1BRAvc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Feb 2011 19:51:32 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36938 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab1BRAva convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 19:51:30 -0500
Received: by mail-vw0-f46.google.com with SMTP id 16so1561921vws.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 16:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=d602+S6WTSHZMwIEJWe3U70eXi5VZ6YddwhGRMh9jjY=;
        b=W2ZrH85u7HmEmxXqfWZ+L/N0j3CBVct1OIpR242jT6mQTlLEzOi4rrtrgLhRd+LXYQ
         DZTRJIzDu8MZcrQLMor/w/iIK/fuwLWux6lrC29zM+cZHBBX9r0mSmZFK6dYF9qE99+2
         RMvHBgBzgubD/OtAo8IeG0/81/ram65NSTXC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HSrIAmDpxlyfPrTcUG7FJcz6j0omO06Hk8J2Cf5DwLETdYmOMWWpNbKDbIp3HGO8Lo
         g6SOCYBcLzD15JajhZlbTaXvVlfX99GW8JQrGtD0gUKXgMTC7yJRMGvEjOnQKaixbqam
         TYuyfYDY3x+g97a55WxN+MoxzaouBPAr/u8us=
Received: by 10.52.158.233 with SMTP id wx9mr162448vdb.119.1297990290223; Thu,
 17 Feb 2011 16:51:30 -0800 (PST)
Received: by 10.220.184.75 with HTTP; Thu, 17 Feb 2011 16:51:00 -0800 (PST)
In-Reply-To: <20110217184234.GB20627@honk.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167146>

Hi Pete,

=46irst thing I just noticed is that I wanted to send the "Improve
rename detection" patch and not this one.
And now, after I sent it I understood that I still don't know how to
use the format-patch correctly because I sent it as a 1/3 set of
patches... :/
Sorry to all the mailing list about this.

On Thu, Feb 17, 2011 at 6:42 PM, Pete Wyckoff <pw@padd.com> wrote:
> vitor.hda@gmail.com wrote on Tue, 15 Feb 2011 23:49 +0000:
>> Add new config option branchUser to allow filtering P4 branch list b=
y user.
>> Allow defining the branch list through branchList config option.
>> Correct base branch directory detection to use '/' as the split char=
acter.
>
> I've only been avoiding reading this one because I don't use
> branches, and am having a hard time following what the point
> of the change is. =A0Maybe someone else will notice that this is
> a good change straightaway, and save you the bother of explaining
> it to me.
>
> The whole detectBranches option seems a bit spotty, given its
> lack of documentation and numerous shady "## HACK" and "## FIXME"
> comments. =A0So it certainly does appreciate your attention.

I also noticed those comments in the code, but until now I did not
find any wrong behavior on how the script works with branches. But
then again, in our depot we don't do many complex operations.
I still want to add an improvement on how it detects the branch's
origin commit. If while doing that I see something else I can improve
I will do so :)

> As far as I can tell, a branch is just a mapping between two
> areas of the repo, and all you can do with one is to feed it
> to "p4 integrate" instead of giving a single explicit src/dest.

In P4 branches work like in Subversion - they are simple links to the
origin data, which are created with the integrate command. But we can
also define a branch specification. That way we can simply refer to
that branch for the integrate to know where to update the data
from/to. git-p4 was using the branch specs to search for branches.

>> @@ -1272,7 +1277,13 @@ class P4Sync(Command):
>> =A0 =A0 =A0def getBranchMapping(self):
>> =A0 =A0 =A0 =A0 =A0lostAndFoundBranches =3D set()
>>
>> - =A0 =A0 =A0 =A0for info in p4CmdList("branches"):
>> + =A0 =A0 =A0 =A0user =3D gitConfig("git-p4.branchUser")
>> + =A0 =A0 =A0 =A0if len(user) > 0:
>> + =A0 =A0 =A0 =A0 =A0 =A0command =3D "branches -u %s" % user
>> + =A0 =A0 =A0 =A0else:
>> + =A0 =A0 =A0 =A0 =A0 =A0command =3D "branches"
>> +
>> + =A0 =A0 =A0 =A0for info in p4CmdList(command):
>
> This part is for branches -u, to limit the auto-detected braches
> to just those created by a given user.

Yes, as simple as that!
When you have a worldwide server an ocean away with thousands of
branch specifications, you really don't want to go through all of
them... ;)

>> @@ -1305,6 +1316,12 @@ class P4Sync(Command):
>> =A0 =A0 =A0 =A0 =A0for branch in lostAndFoundBranches:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0self.knownBranches[branch] =3D branch
>>
>> + =A0 =A0 =A0 =A0configBranches =3D gitConfigList("git-p4.branchList=
")
>> + =A0 =A0 =A0 =A0for branch in configBranches:
>> + =A0 =A0 =A0 =A0 =A0 =A0if branch:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(source, destination) =3D branch.sp=
lit(":")
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.knownBranches[destination] =3D=
 source
>> +
>
> This bit adds more branches, if you have put them in .git/config
> separated by a :. =A0Presumably things that are directories in the
> depot but do _not_ have a branch? =A0I don't get it. =A0What does
> your depot look like and what do you stick in branchList?

Assume

//depot/project

as the main branch. And

//depot/project_featureA
//depot/project_featureB

as feature development branches. So, you could have a list like:
project:project_featureA
project:project_featureB

Of course, if project_featureB originated from the first dev branch,
you would need to define it like:

project_featureA:project_featureB

This was to avoid using P4 branch specifications. In my team we don't
use them that much and since I was only creating branch specs to use
git-p4, I kinda of thought it would be better do keep that
configuration within git.

>> =A0 =A0 =A0 =A0 =A0branches =3D p4BranchesInGit(self.importIntoRemot=
es)
>> =A0 =A0 =A0 =A0 =A0for branch in branches.keys():
>> @@ -1626,12 +1643,14 @@ class P4Sync(Command):
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0paths =3D []
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (prev, cur) i=
n zip(self.previousDepotPaths, depotPaths):
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for i in ra=
nge(0, min(len(cur), len(prev))):
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if =
cur[i] <> prev[i]:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prev_list =3D=
 prev.split("/")
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cur_list =3D=
 cur.split("/")
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for i in ra=
nge(0, min(len(cur_list), len(prev_list))):
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if =
cur_list[i] <> prev_list[i]:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0i =3D i - 1
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0break
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0paths.appen=
d (cur[:i + 1])
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0paths.appen=
d ("/".join(cur_list[:i + 1]))
>
> This was a bug? =A0I guess somehow this is adapting the existing
> depot paths to include new ones that you discovered with "p4
> branches". =A0And now you are comparing the path elements instead
> of going a character at a time. =A0Maybe to catch //depot/ab vs
> //depot/ac ?

Exactly. The example I used above was created to also show that.

> In other words, add some comments or add something to the commit
> text. =A0It is encouraged to split up a patch into the smallest
> logical chenk if the changes are all independent. =A0Maybe these
> three are related through the theme of auto-branch detection.

Understood. I think this patch can easily be split into 3 different
logical chunks.
I'll add some comments and probably see if I can include some
descriptions/examples in git-p4.txt. I just have to find some free
time first :)

Thank you very much for your feedback and help.

--=20
Vitor Antunes
