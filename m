From: Yann Simon <yann.simon.fr@gmail.com>
Subject: Re: Locally manage user/branch setting files without pushing them 
	remotely
Date: Wed, 11 Nov 2009 13:14:21 +0100
Message-ID: <551f769b0911110414j759bd4ayfedfa779307e1a63@mail.gmail.com>
References: <9accb4400911110401g5c44d011u50cafcfe736a2ec6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 13:14:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8C5l-00055Y-0f
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 13:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757383AbZKKMOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 07:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753560AbZKKMOS
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 07:14:18 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:34760 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756802AbZKKMOR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 07:14:17 -0500
Received: by fxm21 with SMTP id 21so927570fxm.21
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 04:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=GW1mMIrr+ShMFA8YspxbXTeWf6UPKESa5MFCaRbXAt4=;
        b=qY+D9m81NSCOSN1yNjShNOqWdyE69ZLXRALW4/ppf/OvYECfEnoJ1hgsk2cvvrngQg
         7x/JyT0UOqm8pW+jfas3k9taVLLC24piAiEaA8QJiM+4a/AG6d8roEibfiQWx5X/5sPj
         Jk/kwOY91fKBoV4XCMsKWBsaYRju7Txtig3Rk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mU45mwnAW0kl7J4a2gKFyc0lxXoP6zEyPFHq9VyrGOLeqaTJnwKeu9uRI9J6h0ILi6
         /vmzUM3NgYAY/it3KY55Y8O8T8Dv1+B843p+xFujuOQgAC/qFs343kzIsW3ogKAV+aqy
         X+S0ycLPz6SH7eZbS4mU8yKJV601Ai3ySVpL4=
Received: by 10.216.86.213 with SMTP id w63mr423581wee.71.1257941661922; Wed, 
	11 Nov 2009 04:14:21 -0800 (PST)
In-Reply-To: <9accb4400911110401g5c44d011u50cafcfe736a2ec6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132646>

2009/11/11 Daniele Segato <daniele.bilug@gmail.com>:
> I had a situation I don't know how to manage with Git.
>
> The project has a lot of setting that are really binded to the user
> and should not go pushed in a remote repository (example: database
> connections parameters / filesystem paths)
> We have a .template file for those settings but the actual settings
> are really binded to the user environment.
> I added those files to the .gitignore but now I can't keep an history
> of them and I can't use different version of them in different
> branches.
>
> I tell you what's the real situation but I will simplify things a
> little, suppose I only have two branches: master and experiments.
>
> I've a java application and some ANT script to automatizations like
> compiling, packaging and deploying stuffs.
>
> On my system I had two application servers and two databases one for
> "master" and the other for "experiment".
> There is a property files with the path of the two application servers
> and the parameters to connect at the DB.
>
> The ant script automatically deploy on the right application server
> and automatically set the properties to connect at the right database.
>
> This allow me to clean my experimantal database everytimes I need to
> and start over by a clean situation and keep the "master" one
> populated with all the data so I can do stress test/update procedures
> test and so on...
>
> At the moment I manually modify that property files when I checkout
> one of the two branches and I need to deploy it to test or whatever.
>
>
>
> Is there a way with Git to automatically switch that file when i
> switch through branches?
> It would be really perfect if I could also keep version of that file
> so that when I checkout an old commit I had the options I was using
> when I was testing that commit.
>
> Ideally that means that should be some files that are kept within each
> commit but they are not pushed to a remote repository.
> (Even if i'm talking about pushing I'm using git-svn because my
> company still use SVN as versioning system so I don't push but i do
> git svn dcommit when committing on a remote repository)
>
> How do you manage situation like this?

I am in the same situation.
What I did is not to add these files to .gitignore.
On my "work" branch, I commited these files in a separate commit
"local changes".
When I want to push to svn, I switch to the branch "master", and
cherry-pick the commit I want to push.
$ git checkout master
$ git svn rebase
$ git cherry-pick work
$ git svn dcommit
$ git checkout work
$ git rebase master

This workflow could maybe be better. Suggestions welcome.

Yann
