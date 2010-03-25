From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Subversion integration with git
Date: Thu, 25 Mar 2010 15:31:57 +0100
Message-ID: <40aa078e1003250731y2c900605k9c681475621a1ff2@mail.gmail.com>
References: <3311ED3F-77BC-4F66-80D5-AA9E21ACF0E2@cordelta.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, artagnon@gmail.com,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Michael Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 15:32:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nuo6S-000766-0w
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 15:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741Ab0CYOcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 10:32:00 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:2778 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588Ab0CYOb7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Mar 2010 10:31:59 -0400
Received: by ey-out-2122.google.com with SMTP id d26so893399eyd.19
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 07:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=O+WSthsZR27px/sjzCNFgmvupBzMVApfXGdDDVL7DWI=;
        b=S/f7X7TF2zmjbt4UquIiRsFkNgVr/udAX/sAzPTPoqUz3ssdaMUKxwj7/q5d9FFbf0
         JMLAiFbVcSSdg2BKibB7ipo2cZQV1BwjZNVq4FqnC3hxuk+xyBee9/DgEa7SQp4C7xGE
         wnbteKwCiMxqhH1fx/PSO7CqECCjkwxrbIvfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=tTE2r5Bz0Uckg5SQZ1nNGlOVK6W+B71fbHfpJzZnbQiZFFvTiX3kx0B+iPcfhP579m
         7R10Cp8x0yWhnD5VQqWAFGWxvFtbp1jtaQKUuk+N/4vDk6qE3jKi2hHAIfh32LMMmX8p
         lbGM4Z0fbLbt/AANKROZECNJy/DjDLqf6hjUI=
Received: by 10.216.157.1 with SMTP id n1mr2335550wek.141.1269527517580; Thu, 
	25 Mar 2010 07:31:57 -0700 (PDT)
In-Reply-To: <3311ED3F-77BC-4F66-80D5-AA9E21ACF0E2@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143181>

On Thu, Mar 25, 2010 at 3:17 PM, David Michael Barr
<david.barr@cordelta.com> wrote:
> Hi folks,
>
> As my first posting to the list, I'd like to start by giving a big thank you to all the git developers and maintainers for such a great tool.
>
> Unfortunately, I still have to interact with lesser tools such as Subversion and that is what leads me to post.
>
> I'm employed on proprietary project which is supported by a large number of open source tools. The 'canonical' source repository is hosted on a Subversion server on the other side of a rather unreliable WAN link. To date I've been using a combination of git-svn, cron, and a handful of bash scripts to handle marshalling commits between our git repositories and the Subversion instance. However, whilst this solution works well for incremental commits, every time a branch is created on the remote repository it's a hassle to synchronise.
> So I thought I'd use git-svn and standard layout - this resulted in blasting my link with so many HTTP requests that I got a stern warning from our sysadmin and I'm sure the firm on the other side of the link weren't impressed.
> After exploring a few solutions I used SVK to create a local mirror of the repository.
>
> When I pointed git-svn at the local mirror, it took 4 days, a whole lot of RAM and fell over at 90% completion with a checksum error.
>
> When I pointed svn-all-fast-export at the repository it had to skip three commits or would indefinitely spew garbage.
>
> When I pointed svn2git.py at a dump of the repository it successfully imported 50% of commits and then ran at snail's pace, ETA next century.
>
> I decided that I liked the idea of subversion dump in - git fast-import out but it had to scale well.
>
> So I grabbed the git-fast-import documentation and the Subversion dump format documentation and tried to design a data structure that would map well between them and scale linearly with my repository.
>
> I started a new project to implement my design and am curious as to how many git users actually care about this kind of problem. While conversion is once off for most projects - there are an awful number of projects currently using Subversion. As the community and tool-chain builds around git, that will mean many desiring to make the transition. I hope to make it far less painful than it has been for me.
>
> My project is still in the preview phase but has enough to import commit-tree structure bar symlinks and executable flags. It imports my 22000+ commit 2.8GB dump in 4 minutes. It is currently 840 non-comment lines of C. I aim to produce output that git-svn can take over from.
>

Wow, your figures sounds very impressive. I'd love to have a look at
it! I've tried to convert simiar-sized SVN repos before, but given up
due to the poor performance. So at work I'm currently using git-svn
with only parts of the history imported, and falling back to SVN when
having to dig far in the history (which is not much fun).

> Is it worthwhile to start a new project - or would it be better to grok the internals of existing projects and try to make them scale?
>

I think it falls very close to the native-git-svn Google SoC
project[1], and if you are able to share what you have I'm sure
Ramkumar (I hope you don't mind me CC'ing you, and that I spelled your
name right) would appreciate having a look.

[1]: https://git.wiki.kernel.org/index.php/SoC2010Ideas#A_remote_helper_for_svn

-- 
Erik "kusma" Faye-Lund
