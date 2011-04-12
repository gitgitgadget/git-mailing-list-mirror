From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: rebase on remote branch
Date: Tue, 12 Apr 2011 20:08:04 +0200
Message-ID: <4DA49504.3030208@dirk.my1.cc>
References: <6b4c9a4d-075c-4805-8fad-bacecb24e9de@w7g2000pre.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: allstars <allstars.chh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 20:08:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9i0f-00073o-59
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 20:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758255Ab1DLSIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 14:08:12 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:42751 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731Ab1DLSIL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 14:08:11 -0400
Received: from [84.176.52.24] (helo=[192.168.2.100])
	by smtprelay03.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1Q9i0T-0002Yo-Tm; Tue, 12 Apr 2011 20:08:06 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <6b4c9a4d-075c-4805-8fad-bacecb24e9de@w7g2000pre.googlegroups.com>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171407>

Am 12.04.2011 19:17 schrieb allstars:
> hi
> first I know rebase on remote branch is bad idea
> so I am here asking for suggestions if you can kindly provide some
>
> in my server I got two branches , master and release ,
> and release is branched from master
>
> 0---0---0---0-- master
>          \
>             0---0-- release
>
> our work mainly focus on master, so we will keep committing code to
> master
> for some reasons, release branch is for others, and it has some
> commits that master doesn't have
>
> and now in every week, we have some stable code in master branch
> so we also want the release branch also has these new code
>
> 0---0---0---0---*---*---* master
>          \
>             0---0-- release
>
> how should we do now??
>
> currently our way is doing rebase in our local pc
>
> 0---0---0---0---*---*---* master
>                                      \
>                                        0'---0'-- release
> in release branch
> $>git rebase master
>
> but in that way when we want to push the release branch back
> it will fail because it's non-fast-forward updates
> so we doing git push -f origin release to force it to 'rebase' on our
> remote server
>
>
> or if we use cherry-pick model
>
> 0---0---0---0---*---*---* master
>          \
>             0---0---*---*---* release
>
> but in this case , how do we do it in script?
> I mean, how do we know we need to start cherry-pick from the 1st '*'
> to the 3rd '*' in master
>
> more precisely , if A to E represents the commit SHA1
>
> 0---0---0---0---A---B---C---D---E master
>          \
>             0---0---A'---B'---C' release
>
> the 3 cherry-picks A' B' C' on release branch won't have the same SHA1
> for A B C in master
> how can we know effectively we need to start cherry-pick from C to E
> on master
>
>
> thanks
>

Hi,

if you have:

0---0---0---X---A---B---C---D---E master
          \
             0---0 release

then you could do

$ git rebase --onto release X master

to get this:

0---0---0---X---A---B---C---D---E master
          \
             0---0---A'---B'---C'---D'---E' release

IOW, it rebases everything between X (w/o X itself) and master (which is 
E, including E) onto release.

Or, with

$ git rebase --onto release X C

you would get:

0---0---0---X---A---B---C---D---E master
          \
             0---0---A'---B'---C' release

HTH.

     Dirk
