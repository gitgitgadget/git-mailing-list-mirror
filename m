X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 15 Dec 2006 18:43:59 +0100
Message-ID: <e7bda7770612150943j71a7362bmb509cea3b7756003@mail.gmail.com>
References: <20061130170625.GH18810@admingilde.org>
	 <e7bda7770612100347j78854d79x547084972ed14e99@mail.gmail.com>
	 <e7bda7770612141327r11368e4dtabe8077e96545040@mail.gmail.com>
	 <200612150007.44331.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 15 Dec 2006 17:44:14 +0000 (UTC)
Cc: "R. Steve McKown" <rsmckown@yahoo.com>,
	"Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=raI2l5puwvQ9RryF4DiQjscMv8cEdYfHB8YDevW2p5rcFL3BYAA8S+OkaYdKOOIAlywYTmKuIX723/XRegkRf2A9FsuZffUMLSt9tE0Q8T6586uSvIJ7wXQ5Obwbl+TaF6xd464rh7tC8vPpFOwJIdgB0rLmvsJmtc2BEU/B6xs=
In-Reply-To: <200612150007.44331.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34535>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvH6O-0005XO-QJ for gcvg-git@gmane.org; Fri, 15 Dec
 2006 18:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753053AbWLORoF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 12:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753059AbWLORoF
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 12:44:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:58786 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1753053AbWLORoC (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 12:44:02 -0500
Received: by ug-out-1314.google.com with SMTP id 44so868341uga for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 09:44:00 -0800 (PST)
Received: by 10.49.42.5 with SMTP id u5mr2930017nfj.1166204639944; Fri, 15
 Dec 2006 09:43:59 -0800 (PST)
Received: by 10.49.28.8 with HTTP; Fri, 15 Dec 2006 09:43:59 -0800 (PST)
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

On 12/15/06, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> If you want to track build results for some source,
> why would you ever want these builds go out of sync with the source?

I don't, bad wording by me. That was the problem I wanted to address.


> Your example has the folling submodule dependence
> ("X ==> Y" means Y being a submodule of X):
>
>   App     ==>   Lib
>    ^             ^
>    |             |
>  AppBuild ==> LibBuild

In my example "AppBuild" and "LibBuild" were the same project but this
scenario is relevant as well.


> If we force submodules to be subdirectories of supermodules,
> Lib needlessly will have to appear two times in a checkout of
> AppBuild.
>
> However, there is nothing wrong with it. Yet, you perhaps want
> the 2 Lib submodules not to go out of sync. This easily
> can be done with symlinking the Lib checkouts. As they are submodules,
> everything should work fine.

This is interesting. In my notation:

/path/to/link/name -> <commit>/path/to/subtree

means that there is a link named "name" in the tree object for
"path/to/link". The link points to a "link object" specifying a
subtree or blob of the tree that is pointed to in a submodule commit.
This is not currently implemented but has at least the following
advantages:

1. You can access files in a submodule without fetching the whole
submodule (which may be very large). (App1 is only interested in
lib1.h, the rest is toally irrelevant)
2. Superproject can access referenced (linked) files in it's own
folder-structure without being forced a structure by the subproject.

If you do a symlink instead, doesn't you loose versioning information?
What happens with the symlinks if someone clones the superproject?


>
> Perhaps an option you want to have is to force a checkout
> of AppBuild to make these symlinking itself when it detects
> identical submodules links.
>
> Hmmm... the only problem with a symlink is that it can go wrong
> when moved. Unfortunately, I do not have a good solution for
> this. We can not make UNIX symlinks smart in any way.
> Hardlinking directories would be a solution, but that is not
> possible.
>

Wouldn't specifying the submodule path in the link object fit in well
here? Then each "link object" can represent a checked out tree from
the subproject in the superproject directory-structure.


> Another thing:
> With normal "$buildroot != $srcroot" environments, the source
> can not be a subdirectory of the build directory.

This is true for symlinks and would also be corrected if we have a
(sparse) submodule checkout there in it's place.


> BTW, build project commits probably should not depend on any
> history of other build commits.

Why? Can you give an example here.


> > Link: /headers/lib1.h -> <lib1-commit3>/src/lib1.h
> > Link: /bin/lib1.so -> <build1-commit>/i386/lib1/lib1.so
> > Link: /bin/app1 -> <build1-commit>/i386/app1/app1
> >
> >
> > <lib1-commit1>, <lib1-commit2> and <lib1-commit3> should be the same,
> > dictated by the app1 project.
>
> I do not see any problem here. Symlinks are stored in the git repository.
> As the AppBuild commit depends on App and LibBuild submodule commits, the
> symlinks always should be correct.

The main reason for these "links" are for versioning purposes: the
uniqe SHA1 of the "link" representing a tree/blob in a version of the
submodule should be "included" in the supermodules commit. Symlinks
won't give that at all.


> > How do the super-projects in this case get access to the blobs pointed
> > by the links - transparent or explicit in the build-process?
>
> Submodules should automatically be checked out when checking out the
> supermodule. So the blobs should already be there.
> Or do I miss something?

Probably not as that was a piece of the puzzle that I was missing.


