From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Additional remote on a local clone. Where do the objects go?
Date: Wed, 1 Sep 2010 18:32:39 +0800
Message-ID: <AANLkTi=_uP_zFOV_k=cM8TXH16kTPAoPGpNkz+QUSzb-@mail.gmail.com>
References: <i5kudr$dp7$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 12:32:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqkcZ-0006Kn-OQ
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 12:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754298Ab0IAKcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 06:32:42 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60948 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab0IAKcl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 06:32:41 -0400
Received: by ewy23 with SMTP id 23so4186362ewy.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 03:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=fojiSbTEXE7GujkDyHxaO7OkBxBe4ltFspe4chhTgCs=;
        b=xwBMsZnb1ePlo1SrT5ky0ZjDDgTMZujWEHhDVC/7kzMOJa3PHymu8b9BmZthx7A9jl
         wMaW1MBSjp7ki1ZxfdHIfBncTj9UI9FPPHnlyv0eVsEqhSaJSmJ9xwVeEdlIqZ6v0FOW
         5+BE29agi8yjo/Xchl8BsTr+1jzWeamaEl2eg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=c5QrIsiTbt3tk4ARnOQXeF8SUTr5aRd6R21/crDZiAl4npM720yZcoGhXD5OPalCwT
         FR7q+EfZDofBZGtwM6gIoeoaWk6EXGVECkEGESeFs3ly58xJ1TJF3xpOf7FEw0cXj2gW
         qzySW53fzc2eeUVa3Z3bkCbTtPenj3m7PWqO0=
Received: by 10.213.59.76 with SMTP id k12mr131621ebh.13.1283337160008; Wed,
 01 Sep 2010 03:32:40 -0700 (PDT)
Received: by 10.213.105.73 with HTTP; Wed, 1 Sep 2010 03:32:39 -0700 (PDT)
In-Reply-To: <i5kudr$dp7$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155035>

Hi,

On Wed, Sep 1, 2010 at 3:12 PM, Stephen Kelly <steveire@gmail.com> wrote:
> git clone git://gitorious.org/qt/qt.git qtrepo
> cd qtrepo
> git checkout -b 4.7 origin/4.7
> git checkout -b 4.6 origin/4.6
> git clone qtrepo qt46
> cd qt46 && git checkout -b 4.6 origin/4.6
> cd ..
> git clone qtrepo qt47
> cd qt46 && git checkout -b 4.7 origin/4.7
> cd ..

Two improvements: shared objects, and configuring git-pull:

  git clone git://gitorious.org/qt/qt.git qtrepo
  git init qt46
  PARENT_GIT=$(pwd)/qtrepo/.git
  cd qt46

  # use of shared objects - tell git where to find the "missing" objects
  cat $PARENT_GIT/objects > .git/objects/info/alternates

  # setup of git pull
  cat <<EOF >> .git/config
[remote "parent"]
  url = $PARENT_GIT
[branch "master"]
  remote = parent
  merge = refs/remotes/origin/4.6
EOF

  # done!
  git pull

Repeat for 4.7.

If you want to go one step further and track these repos, you could
look at git-submodule or git-subtree.

-- 
Cheers,
Ray Chuan
