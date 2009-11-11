From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: Locally manage user/branch setting files without pushing them 
	remotely
Date: Wed, 11 Nov 2009 14:00:55 +0100
Message-ID: <9accb4400911110500y37437dc5h16388b07a734dc6d@mail.gmail.com>
References: <9accb4400911110401g5c44d011u50cafcfe736a2ec6@mail.gmail.com>
	 <551f769b0911110414j759bd4ayfedfa779307e1a63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 14:01:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Coq-0005dn-53
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 14:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbZKKNAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 08:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbZKKNAw
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 08:00:52 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:62931 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbZKKNAv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 08:00:51 -0500
Received: by fxm21 with SMTP id 21so976477fxm.21
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 05:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=PbowsvhRbO7veujAMVJaYqBfouhjBae7unuEx1o/ii0=;
        b=wqrB+uWAODrJQ9eUjtZv7iAxk15Z3gyZTu7FCGCXa5Q2mvyECI92d3qYhoOJge1POY
         o0DmSiOIzVbC5hsmltQgH0ML6W1Im6Jt0njJq+3oe2c3I4tz5KWyhIIKKsd708LgglwL
         jkY5ruQH7ZnWinfifQpb6zGwV0Un1rrBW5+UQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=eeWzGkbvPobbED8su9ut2gyXoA00Dz7t+kdCIY29fhCSmUnSDBCFhf+trBpUJbDOyA
         9s5gkkhDEefM2VkBN9bxfex7ThGrRYqGuMSUwMg+uF6WtiCRYZ16R5+h93DyxaxcWOXQ
         Qatj2JX9bH2N97Y8Fe2Qcer3ad7vl4xSyO3DA=
Received: by 10.204.5.138 with SMTP id 10mr1428687bkv.110.1257944455849; Wed, 
	11 Nov 2009 05:00:55 -0800 (PST)
In-Reply-To: <551f769b0911110414j759bd4ayfedfa779307e1a63@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132648>

On Wed, Nov 11, 2009 at 1:14 PM, Yann Simon <yann.simon.fr@gmail.com> wrote:
> I am in the same situation.
> What I did is not to add these files to .gitignore.
> On my "work" branch, I commited these files in a separate commit
> "local changes".
> When I want to push to svn, I switch to the branch "master", and
> cherry-pick the commit I want to push.
> $ git checkout master
> $ git svn rebase
> $ git cherry-pick work
> $ git svn dcommit
> $ git checkout work
> $ git rebase master
>
> This workflow could maybe be better. Suggestions welcome.

hum
but I don't want to push those files


the idea of placing those files in a separate commit could be handy...
If I create a branch for each version of the file: example
experiments-local, master-local then I could keep version of the file
there and cherry pick them when needed

like this:

$ git checkout experiment
$ # do work
$ git commit -a -m "my recent work"
$ git cherry-pick experiment-local
$ # test / compile / whatever
$ git reset --hard HEAD~ # undo the cherry-pick because i don't want to push it
$ git svn dcommit / git chechout another-branch

but I could forgot to reset --hard HEAD~ and I had to be very careful...

instead I would place those files in separate stash called
"experiments", "master" and apply the right stash when I need and then
discard it before switching branch..
this is something I hadn't thinked about

$ git checkout experiment
$ # do work
$ git stash apply experiment-stash # don't know if i could use name to
reference stashes
# test / compile / whatever
$ rm mypropfile.properties
$ git add <files...>
$ git commit
$ git svn dcommit / git checkout another-branch

this way I still had to remove the file manually but since I never use
git commit -a I probably wouldn't add it to a commit by mistake.

This could be more handy then the way I act now...
still I hope there is a better way to handle situations like this

regards,
Daniele
