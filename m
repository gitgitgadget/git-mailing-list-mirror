From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Notes on supporting Git operations in/on partial Working Directories
Date: Thu, 14 Sep 2006 13:08:10 -0700
Message-ID: <4509B6AA.9040902@gmail.com>
References: <4509A7EC.9090805@gmail.com> <20060914192119.GC10556@spearce.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 22:08:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNxVe-0006iD-Gx
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 22:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWINUIP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 16:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWINUIP
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 16:08:15 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:60444 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751119AbWINUIN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 16:08:13 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1251503nzf
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 13:08:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=EOkf7vUxyPoU/eFyx7bdGC71zi3FEWelws3bluJbbEwf9PQGgg8v47dq3qvYwKhOymmXMgu1KuWQggF2Vq3FRUjK4f54UW0ebmnGKll5mv7w0OkAVSqwT18VrzdUGiRq7PmoOAPPNM9yys77Ne5D7HeIrwy94D/72O6/diZM7TA=
Received: by 10.35.18.3 with SMTP id v3mr15715412pyi;
        Thu, 14 Sep 2006 13:08:12 -0700 (PDT)
Received: from ?10.0.0.6? ( [24.55.157.69])
        by mx.gmail.com with ESMTP id n62sm7895606pyf.2006.09.14.13.08.11;
        Thu, 14 Sep 2006 13:08:12 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060914192119.GC10556@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27036>

Shawn Pearce wrote:
> A Large Angry SCM <gitzilla@gmail.com> wrote:
>> The contents of the index file still reflect the full tree but flag each
>> object (file or symlink) separately as part of the checkout or not. The
>> WD_Prefix string is so that a partial checkout consisting of only
>> objects somewhere in the a/b/c/d/ tree can be found in the working
>> directory without the a/b/c/d/ prefix to the path of the object.
> 
> Why not just load a partial index?
> 
> If we only want "a/b/c/d" subtree then only load that into the index.
> At git-write-tree time return the new root tree by loading the tree
> of the current `HEAD` commit and walking down to a/b/c/d, updating
> that with the tree from the index, then walking back updating each
> node you recursed down through.  Finally output the new root tree.
> 
> The advantage is that if you have a subtree checked out you aren't
> working with the entire massive index.

I was looking for minimal changes to the index and associated code. 
Either way works.

> But how does this let the user checkout and work on the 10 top
> level directories at once and perform an atomic commit to all
> of them, but not checkout the other 100+ top level directories?
> As I recall this was desired in the Mozilla project for example.

That's a partial working working directory by my definition so it would 
work. How it's specified on the command line is TBD.

It's desired by a lot of very modular projects.

>> [*3*] Possibly split the index up by directory and store the parts in
>> the working directory. An index "distributed" in this way would have
>> a "natural" cache-tree built in and (finally) be able support empty
>> directories.
> 
> Please, no.  On a project with a large number of directories
> operations like git-write-tree would take a longer time to scan the
> index and generate the new trees.  I unfortunately work on such
> projects as its common for Java applications to be very deeply
> nested and large projects have a *lot* of directories.

Directory trees without any changes might actually be less expensive to 
work with using the split index since you could ignore all of the 
unchanged entries easily.
