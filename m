From: Jonathan Gossage <jgossage@gmail.com>
Subject: Re: [EGIT] [PATCH RFC v1 0/5] Add (static) ignore functionality to
 EGit
Date: Sun, 29 Mar 2009 18:40:59 -0600
Message-ID: <49D0151B.6070408@magma.ca>
References: <cover.1238102327.git.ferry.huberts@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ferry Huberts <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Mon Mar 30 02:43:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo5bC-0008H0-SK
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 02:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917AbZC3Al2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 20:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754912AbZC3Al1
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 20:41:27 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:56717 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749AbZC3Al1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 20:41:27 -0400
Received: by qyk16 with SMTP id 16so3198265qyk.33
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 17:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=cCjvpNSVyFBDvFIidAg+0pxsR4riQHbRc98tgBnFgYY=;
        b=UXhGmHHlcY/Jgtrr2cOgx/6EuChbpPEwdWZjwy81S9NJeaWVjtM9nyJdf8PRPd5iwD
         uLcUZY+MOezI9LqY1ZDIG7VLl8zdI3UUx3AHkxJF9XfTTsA9NZpUauKIbb89N4t0L8wq
         wGgJlvH764aY832Nhw6rrowJITlH4xiPRD3b8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=JrPQHaQKGewl3vRNWoCIpbwM3tCcwcciLlzrKhokqs+AtgVhBA3XmvQyP/BJFfBLul
         p7n6fYC0lawEOJffm76wbABoJkvYr/DyF0tHTuP0CBta1O0rK53Y/TV84OumTWxiBx/D
         os3xJTT0/o3V9ZypvD7qB1kkcrVwiTH+LHnCs=
Received: by 10.224.19.141 with SMTP id a13mr5459498qab.60.1238373684435;
        Sun, 29 Mar 2009 17:41:24 -0700 (PDT)
Received: from ?192.168.1.65? ([189.163.1.77])
        by mx.google.com with ESMTPS id 6sm3342506ywi.13.2009.03.29.17.41.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Mar 2009 17:41:24 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
In-Reply-To: <cover.1238102327.git.ferry.huberts@pelagic.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115050>

Ferry Huberts wrote:
> This is the first - early - code that adds ignore functionality to EGit.
> Currently it reads in all ignore patterns upon workspace startup into an
> ignore cache. From this cache the ignore state of a resource is evaluated
> in the same fashion as git does.
>
> The code does not yet react to changes in ignore files but I'm planning to add
> that soon and I can share a lot of code for that.
>
> I send this code to receive feedback and to give you insight into what I'm
> doing with it. I'm new both to EGit programming and Eclipse programming so
> there might be things that could be done more elegantly :-)
>
> A few notes:
> - The patches are rebased on the current master (e3440623)
> - The order of the patches must be re-arranged, but that is rather easy. The
>   correct order - once finished - would be:
>     Build up the ignore patterns cache upon workspace startup.
>     Use the ignore patterns cache to determine ignores
>     Enable the ignore handling of the plugin
>     Optimise ignore evaluation
>     Do not set .git as a Team ignore pattern
> - The core.excludesfile code is currently untested, the other code seems to be
>   in a good state.
> - There are a few FIXMEs in the code with questions and tasks. It's a work in
>   progress and these will disappear.
>
> Ferry Huberts (5):
>   Build up the ignore patterns cache upon workspace startup.
>   Enable the ignore handling of the plugin
>   Optimise ignore evaluation
>   Do not set .git as a Team ignore pattern
>   Use the ignore patterns cache to determine ignores
>
>  org.spearce.egit.core/META-INF/MANIFEST.MF         |    1 +
>  org.spearce.egit.core/plugin.xml                   |    6 -
>  .../src/org/spearce/egit/core/ignores/DType.java   |   44 ++
>  .../src/org/spearce/egit/core/ignores/Exclude.java |  243 +++++++++
>  .../spearce/egit/core/ignores/GitIgnoreData.java   |  180 +++++++
>  .../org/spearce/egit/core/ignores/IgnoreFile.java  |   82 +++
>  .../egit/core/ignores/IgnoreFileOutside.java       |  543 ++++++++++++++++++++
>  .../egit/core/ignores/IgnoreProjectCache.java      |  245 +++++++++
>  .../egit/core/ignores/IgnoreRepositoryCache.java   |  358 +++++++++++++
>  .../org/spearce/egit/core/op/TrackOperation.java   |    7 +-
>  .../spearce/egit/core/project/GitProjectData.java  |    8 +
>  .../decorators/DecoratableResourceAdapter.java     |   11 +-
>  org.spearce.jgit/META-INF/MANIFEST.MF              |    1 +
>  13 files changed, 1712 insertions(+), 17 deletions(-)
>  create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ignores/DType.java
>  create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ignores/Exclude.java
>  create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ignores/GitIgnoreData.java
>  create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreFile.java
>  create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreFileOutside.java
>  create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreProjectCache.java
>  create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ignores/IgnoreRepositoryCache.java
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
>   

Eclipse supplies a repository-independent ignore file list as part of the repository-type independent Team support. A first step, which would provide useful functionality would be to populate your cache with this list and enable it's use in the Egit plugin. This would accomplish the goal of enabling EGit to use ignore lists in an immediately useful way with minimal effort. As a second stage you can add support for picking up Git specific files and updating them from Eclipse.

I think you will run into problems if you try to create a workspace wide
cache. It is quite possible that one workspace could have projects that
target different Git repositories. This means that your cache would need
to look at all projects in the workspace and potentially take into
account Eclipse working sets and other such complications. You also will
need to deal with projects being added and deleted from the Eclipse
workspace.

I think a better approach might be to go for lazy cache construction
where the cache is built only when actually needed by a user operation.
The cache would then be built only for a specific Git repository. JGit
should be responsible for assembling a merged list from the various Git
files. It should also be responsible for the actual updating of the
various Git ignore files. Since I believe that the Eclipse
repository-independent ignore file list should be the lowest priority in
the merged list, it will be necessary to pass the Eclipse list to JGit
as a parameter whenever a merged list is required.

In general, you should look to do Git specific things in JGit and do
Eclipse things in Eclipse. That way JGit continues to acquire the
functionality to support any IDE and EGit is kept as simple as possible.

HTH

Jonathan Gossage
