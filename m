From: Galder Zamarreno <galder.zamarreno@redhat.com>
Subject: Re: [egit-jgit] excluded patterns are decorated as being untracked
Date: Wed, 18 Jun 2008 17:40:56 +0200
Message-ID: <48592C88.3080302@redhat.com>
References: <4857E9A0.7070408@redhat.com> <200806172316.46416.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Florian Koeberle <florianskarten@web.de>,
	Marek Zawirski <marek.zawirski@gmail.com>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 17:42:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8znY-0002jl-Rd
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 17:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbYFRPlL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jun 2008 11:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752753AbYFRPlL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 11:41:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46481 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752417AbYFRPlK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 11:41:10 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5IFf3XO015605;
	Wed, 18 Jun 2008 11:41:03 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5IFf30x004868;
	Wed, 18 Jun 2008 11:41:03 -0400
Received: from dhcp-144-245.gva.redhat.com (dhcp-144-245.gva.redhat.com [10.33.144.245])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5IFf0i6023558;
	Wed, 18 Jun 2008 11:41:02 -0400
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <200806172316.46416.robin.rosenberg.lists@dewire.com>
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85387>

Hi,

=46irstly, thanks to all for the quick response.

Robin Rosenberg wrote:
> tisdagen den 17 juni 2008 18.43.12 skrev Galder Zamarreno:
>> Hi,
>>
>> I've been using egit for a few weeks and firstly, I'd like to thank =
the=20
>> people involved in the project for the work done so far.
>>
>> There's one thing that has been bugging me about egit though which i=
s=20
>> related to the decoration of untracked files. Egit/JGit does not see=
m to=20
>> pay attention to .git/info/exclude that I have configured so that=20
>> anything under output folder is excluded.
> This is a correct observation. It is a missing feature so far.
>=20
>> Egit/JGit does seem to have decorations working fine for patterns=20
>> specified in "Team/Ignored Resources" but it only applies it to file=
s=20
>> not folders, hence, adding "output" as pattern does not work and=20
> I haven't noticed, but looking at the code its seems some we should
> use Team.isIgnoredHint instead of what we do now (which only
> take a file as an argument). Patch below. The reason I haven't notice=
d
> is that I have only depended on Eclipse marking of resources as "deri=
ved"
> which worked. (You can mark resources as derived youself in the prope=
rties
> of that resource, and Egit will ignore it).

Hmmmm, is marking a resource as "derived" recursive? i.e. if I mark=20
"output" folder as derived, would anything under it be considered=20
derived? It'd be a pain to go a mark as derived each and every class.

I suppose you still need the patch to use Team.isIgnoredHint to get=20
derived resources to be ignored, correct?

>=20
>> instead, I have to specify any pattern that would match a file withi=
n=20
>> the output folder which is not practical. Folders are taken into acc=
ount=20
>> as ignored resources in subeclipse (subversion eclipse plugin)
>>
>> I can see two ways of implementing this that I'm happy to have a loo=
k=20
>> into but I wanted to get some advice from the experts of egit/jgit t=
o=20
>> indicate which would be the preferred solution going forward.
>>
>> 1.- Implement .git/info/exclude functionality in egit/jgit
> We need that. Florian came up with a set of patches that should be
> usable for this. I haven't applied them to the tree yet.

That'd probably be the proper solution to the decoration issue at hand.

>=20
>> 2.- Improve the decoration handling in jgit/egit so that it can chec=
k=20
>> whether the file is under a pattern that should be excluded. I tried=
 to=20
>> implement this but requires using API that eclipse considers interna=
l.
>>
>> What do people think? Should I bother with 2 or is it better to=20
>> implement decorations for patterns in .git/info/exclude correctly?
>=20
> The decoration should not ignore anything except what the resource fi=
lters
> (affecting visibility) dictates. If a resource is tracked it should b=
e shown unless
> visibility is prevented by a resource filter or other view specific m=
echanism.
> When we track (add) resources recursively we should honor the git ign=
ore
> patterns, but only for add. Everywhere else we do not just ignore res=
ources
> that match an ignore pattern.
>=20
> Btw, Here is an attempt to match folders by Team ignore patterns too.

Hmmmm, so the proper way is either marking resources as derived and use=
=20
your patch or implementing .git/info/exclude, correct?

>=20
> (OT: I did not format the code. (please try, and you'll see why). We'=
ll have
> to come up with something better than an 80-column format, it's so se=
venties)
>=20
> -- robin
>=20
> From 42eadb50b9b87e5324f941ce2d2371e07577f55a Mon Sep 17 00:00:00 200=
1
> From: Robin Rosenberg <robin.rosenberg@dewire.com>
> Date: Tue, 17 Jun 2008 22:48:52 +0200
> Subject: [PATCH] Apply Team/Ignore settings to folders too when track=
ing new resources
>=20
> We used to only care for file resources. Now folders, and their conte=
nt,
> are ignored if the folder name matches a pattern marked as ignored
> in the Team settings.
>=20
>=20
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  .../org/spearce/egit/core/op/TrackOperation.java   |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
>=20
> diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/Track=
Operation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/Tra=
ckOperation.java
> index 6521f1c..af16cdb 100644
> --- a/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperati=
on.java
> +++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperati=
on.java
> @@ -90,13 +90,20 @@ public class TrackOperation implements IWorkspace=
Runnable {
>  							public boolean visit(IResource resource) throws CoreException=
 {
>  								try {
>  									String repoPath =3D rm.getRepoRelativePath(resource);
> +									// We use add to reset the assume valid bit, so we check th=
e bit
> +									// first. If a resource within a ignored folder is marked
> +									// we ignore it here, i.e. there is no way to unmark it exp=
ect
> +									// by explicitly selecting and invoking track on it.
>  									if (resource.getType() =3D=3D IResource.FILE) {
>  										Entry entry =3D index.getEntry(repoPath);
> -										if (!Team.isIgnored((IFile)resource) || entry !=3D null &&=
 entry.isAssumedValid()) {
> +										if (!Team.isIgnoredHint(resource) || entry !=3D null && en=
try.isAssumedValid()) {
>  											entry =3D index.add(rm.getWorkDir(), new File(rm.getWorkD=
ir(), repoPath));
>  											entry.setAssumeValid(false);
>  										}
>  									}
> +									if (Team.isIgnoredHint(resource))
> +										return false;
> +
>  								} catch (IOException e) {
>  									e.printStackTrace();
>  									throw Activator.error(CoreText.AddOperation_failed, e);

--=20
Galder Zamarre=F1o
Sr. Software Maintenance Engineer
JBoss, a division of Red Hat
