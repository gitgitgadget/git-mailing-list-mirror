From: =?ISO-8859-1?Q?Florian_K=F6berle?= <florian@fkoeberle.de>
Subject: Re: [BUG REPORT] git-svn fails to create branches if ssh+svn gets
 used as protocol.
Date: Wed, 23 Dec 2009 20:26:27 +0100
Message-ID: <4B326EE3.5060409@fkoeberle.de>
References: <4B309730.5070509@fkoeberle.de> <20091223072500.GB4323@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Dec 23 20:26:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNWr0-0004gv-QV
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 20:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157AbZLWT0e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Dec 2009 14:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753261AbZLWT0d
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 14:26:33 -0500
Received: from wp165.webpack.hosteurope.de ([80.237.132.172]:55212 "EHLO
	wp165.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751889AbZLWT0d (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Dec 2009 14:26:33 -0500
Received: from p54965134.dip.t-dialin.net ([84.150.81.52] helo=[192.168.1.50]); authenticated
	by wp165.webpack.hosteurope.de running ExIM with esmtpsa (TLSv1:RC4-MD5:128)
	id 1NNWqt-0000iP-FP; Wed, 23 Dec 2009 20:26:31 +0100
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <20091223072500.GB4323@dcvr.yhbt.net>
X-Enigmail-Version: 0.96.0
X-bounce-key: webpack.hosteurope.de;florian@fkoeberle.de;1261596393;0475186d;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135630>

Hello Eric,

your patch works great. I created successfully a branch on a svn+ssh://
repository using the patched git-svn.

Thank you for the patch and the fast reply. I hope the patch find it's
way into the next release.

Best regards,
=46lorian



Eric Wong wrote:
> Florian K=F6berle <florian@fkoeberle.de> wrote:
>  =20
>> Hello
>>
>> I haven't seen a link to a bug tracker so I am sending this bug repo=
rt
>> to the mailing list, I hope it's okay.
>>    =20
>
> Hi Florian,
>
> The mailing list is the bug tracker here :)
>
>  =20
>> If you try to run
>> $ git svn branch foo
>> in a project using a svn+ssh url, you get the following error log:
>>
>> Copying svn+ssh://example.org/svn/project/trunk at r1000 to
>> svn+ssh://me@example.org/svn/project/branches/foo...
>> Trying to use an unsupported feature: Source and dest appear not to =
be
>> in the same repository (src: 'svn+ssh://example.org/svn/project/trun=
k';
>> dst: 'svn+ssh://me@example.org/svn/project/branches/foo') at
>> /home/florian/libexec/git-core/git-svn line 722
>>
>> It fails as the username is missing in the source url. If you modify=
 the
>> git-svn script and add the username it works. The bug can be reprodu=
ced
>> with git-svn version 1.6.5.7 (svn 1.5.1).
>>    =20
>
> Thanks for the info, the following patch should help.
>
> I rarely get around to testing against svn+ssh servers myself
> (and they don't appear too common compared to http/https).
>
> Let us know how it goes, thanks!
>
> From b2bc7e330209659c20d02ee0ba3785f9f59fd0b2 Mon Sep 17 00:00:00 200=
1
> From: Eric Wong <normalperson@yhbt.net>
> Date: Tue, 22 Dec 2009 22:40:18 -0800
> Subject: [PATCH] git svn: branch/tag commands detect username in URLs
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>  git-svn.perl |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index dba0d12..650c9e5 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -663,7 +663,8 @@ sub cmd_branch {
>  	}
>  	$head ||=3D 'HEAD';
> =20
> -	my ($src, $rev, undef, $gs) =3D working_head_info($head);
> +	my (undef, $rev, undef, $gs) =3D working_head_info($head);
> +	my $src =3D $gs->full_url;
> =20
>  	my $remote =3D Git::SVN::read_all_remotes()->{$gs->{repo_id}};
>  	my $allglobs =3D $remote->{ $_tag ? 'tags' : 'branches' };
>  =20
