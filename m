From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 1/2] Add 'git subtree' command for tracking history of 
	subtrees separately.
Date: Thu, 30 Apr 2009 10:32:48 -0400
Message-ID: <32541b130904300732i691800f5kecc2f845584071c1@mail.gmail.com>
References: <1240784983-1477-1-git-send-email-apenwarr@gmail.com>
	 <32541b130904291927m33908bacg2dbafcf64877b88f@mail.gmail.com>
	 <20090430085853.GA21880@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Thu Apr 30 16:33:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzXKW-0007zs-MW
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 16:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763003AbZD3OdO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Apr 2009 10:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763339AbZD3OdN
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 10:33:13 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:53051 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762969AbZD3OdM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2009 10:33:12 -0400
Received: by gxk10 with SMTP id 10so3798525gxk.13
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 07:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tbAlmn48b62Xw2KkJ7jGDLEyMwoXgf4ued1FN1kTFH0=;
        b=k+x2RpSiWTY70H4ijWbgSgEsiWMcwVK2FNnRSj1JouCFyRBpj1emI3okBEnpcdMIFO
         +cByIHWfi6Ieh+z/FeF50ujbmUdD6qb6UVYBlcpt9kF3XIoSsKhKW5vgdA3JyPqnb46d
         Frq+Z+cM9x4VoxcNiBBNX4QHfLyQvBRtgqDzM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FAhHv8zMwiFjACxpncpYHdw+g2QLAcCqMn5rLpkfP2iGb/UVkLsM2JDRPz4K1b+FCC
         1oKAGHDIlSiMfiR6bT6PFeXeN1501EWdQfityvzDBWDXB/mygue//wdxqlqbL5EyQh9j
         glKkTjVb3bmmzTYpPOlRMkcxOlGCxEYDm6iPE=
Received: by 10.151.122.3 with SMTP id z3mr3616741ybm.231.1241101968495; Thu, 
	30 Apr 2009 07:32:48 -0700 (PDT)
In-Reply-To: <20090430085853.GA21880@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118019>

On Thu, Apr 30, 2009 at 4:58 AM, Finn Arne Gangstad <finnag@pvv.org> wr=
ote:
> On Wed, Apr 29, 2009 at 10:27:44PM -0400, Avery Pennarun wrote:
>> 'git subtree' provides an alternative mechanism, based around the
>> 'git merge -s subtree' merge strategy. =A0Instead of tracking a subm=
odule
>> separately, you merge its history into your main project, and occasi=
onally
>> extract a new "virtual history" from your mainline that can be easil=
y merged
>> back into the upstream project. =A0The virtual history can be increm=
entally
>> expanded as you make more changes to the superproject.
>
> We have the exact same situation. I wanted to attack this from the
> other end though, make submodules useable also in this scenario. The
> subtree solution seems to be much easier to do in git, so maybe this
> is a better approach!

Sounds like your thought process is similar to mine :)  I spent a lot
of time trying to figure out how to convince submodules to work the
way I wanted, until I eventually realized that subtrees were already a
lot closer.

> Let's say you have three different projects that all use some shared
> modules, The following operations should all be easy and fully
> supported:
>
> a) Modify project + some shared modules (in your project) with single=
 commit
> b) Push project + shared modules (for your project)
> c) Push modifications to shared modules
> d) Merge upstream version of shared modules into your project.
>
> My quick analysis:
> Your subtrees: a & b are easy, c & d are painful

My *attempt* with git-subtree was to make all four operations easy.
It's up to you to decide whether I succeeded :)

a) Modify-and-commit: just git commit

b) Push project+shared: just git push

c) Push shared changes only:
      # Should we try to make a simpler single command for this?
      # The problem is: I suspect people will normally want to review t=
he
      # git subtree split output before pushing it anywhere, so combini=
ng
      # the split/push operations may not be wise.
      git push shared-remote $(git subtree split --prefix=3Dshared-dir)=
:master

d) Merge upstream changes of shared module:
      git subtree pull --prefix=3Dshared-dir shared-remote master
    or
      git fetch shared-remote master
      git subtree merge --prefix=3Dshared-dir FETCH_HEAD

Have fun,

Avery
