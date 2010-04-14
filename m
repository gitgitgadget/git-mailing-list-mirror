From: Steven Michalske <smichalske@gmail.com>
Subject: Re: Update on SoC proposal: git-remote-svn
Date: Tue, 13 Apr 2010 23:33:23 -0700
Message-ID: <F0CD5B83-2D28-47E1-A336-5C88E2803CBE@gmail.com>
References: <1271136573-sup-5613@kytes>
Mime-Version: 1.0 (Apple Message framework v1068)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam@vilain.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 08:33:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1wAZ-000209-Bu
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 08:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062Ab0DNGdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 02:33:43 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:46051 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948Ab0DNGdg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 02:33:36 -0400
Received: by gxk9 with SMTP id 9so4664223gxk.8
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 23:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:in-reply-to
         :mime-version:content-type:message-id:content-transfer-encoding:cc
         :from:subject:date:to:x-mailer;
        bh=lhkFOdcqXdyztdTk7R4Cg6eO65ro+ttMcvatnCrJeMs=;
        b=wZuDEY5BOGkk1P3y6veBrXONR/y1OuIOyUEor5pcLYKBNlBOm5116shAMxEo8vFsvi
         Nf+dUM13BZ7c8XNpmK4p9r6N5hsl+n7ez1QSmQh5qx6INJ8jV6AB00ocU4ftqiliTzvC
         ILKuafDbsjFxiG+68/08BPAeAXAZ/GeKq//0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-type:message-id
         :content-transfer-encoding:cc:from:subject:date:to:x-mailer;
        b=ZhO/ADe5kXTnRIgTqII2vCQsQDKITy4D4o458N+e7+232zBldO7MyiZM9pQUMKXaeN
         hgIgCaG7eAo8KMhFAiplJEq16Giy1kLBZGBXErgeZtELpsIkWUHCIw2506yG0XtsgU3F
         +6jNHU2qmRcpHuhIPUvl3TglKsppS+yfBvyME=
Received: by 10.100.238.12 with SMTP id l12mr12524285anh.239.1271226807044;
        Tue, 13 Apr 2010 23:33:27 -0700 (PDT)
Received: from [192.168.1.105] (c-98-234-104-87.hsd1.ca.comcast.net [98.234.104.87])
        by mx.google.com with ESMTPS id 5sm925ywd.44.2010.04.13.23.33.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Apr 2010 23:33:26 -0700 (PDT)
In-Reply-To: <1271136573-sup-5613@kytes>
X-Mailer: Apple Mail (2.1068)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144853>

Ramkumar,

In reading this I wondered how a svn dump of one of the repositories  
monitor would size.  If I were to check out the svn root of that  
repository, I would use well over 3TB of disk space to have that  
checked out, I filled my 750GB drive with about a third of it checked  
out.  About 256MB of code with thousands of tags and hundreds of  
branches.

It looks like svnadmin dump defaults to dumping all data.  Fortunately  
it has a delta option, which looks like it would be needed to dump  
this repository I am speaking of without filling up many hard drives.

This might also be helped if the dumps are chunked into ranges for  
many thousands of commits as well, this would keep the files more  
manageable

Just food for thought.

Steve

On Apr 12, 2010, at 10:29 PM, Ramkumar Ramachandra wrote:

>
> Hi,
>
> Sam Vilain commented on my SoC proposal using Google's SoC interface,
> and requested me to CC my response to the mailing list. His original
> comment is also quoted below.
>
> ----------------------->8----------------------<8-------------------
> Hi Sam,
>
>> Hi Ramkumar, I've looked at this proposal and seen that it differs a
>> bit from the version on the list, and I can't see the relevant
>> discussion, so I'll just throw my bit in here - though note this is a
>> technical comment and not a critique of your proposal.
>
> There's been a lot of discussion, some on the list, and some more off
> the list.
>
>> First, consider not using the SVN API at all while prototyping the
>> import part of the chain.  Instead, parse the 'svnadmin dump' stream
>> from a local mirror.  This will allow you to tackle the actual
>> problems involved and importing the data effectively, without
>> suffering from the brain-damage that is the SVN API.  After all, the
>> SVN API should be returning you all of the same information that the
>> dump stream does, so you can treat making it work using the remote
>> access API (eg svn_ra_replay, which is faster for mirroring AIUI)  
>> as a
>> separate task.  You will also more easily spot information which you
>> should be extracting from the API, but aren't - it's definitely all  
>> in
>> the dump format; it has to be.  I received similar advice to this
>> before building a perforce importer and let's just say it was
>> invaluable.
>
> Yes. I've studied the SVN API, and I agree with you- it's quite
> horrible. Instead of providing a API that's transparently
> backward-compatible, they've provided different methods for different
> versions. There are also several variations of certain methods, and
> this is quite confusing.
>
> `svnadmin dump` is exactly how I plan to start out- I've already
> discussed this with my to-be mentor, Sverre Rabbelier and David
> Michael-Barr, who's building a new SVN exporter in his own time.
>
>> Second, consider making the mirror phase emit directly to a tracking
>> branch via git-fast-export, that is not intended to be checked out.
>> Instead, it contains trees which correspond to revisions in the
>> mirrored SVN repository.  Directory and file properties can be saved
>> in the tree using specially named dotfiles, and revision properties
>> can be saved in the commit log.  Perhaps I misread your intentions
>> with the "stripped down svnsync" part, but syncing to a local SVN
>> repository seems to me like a waste of time; people can just do that
>> themselves if they choose anyway.  An SVN repository can easily be 10
>> times the size of the corresponding git store, and it just seems like
>> double-handling of the data and will make the whole process slower  
>> and
>> more cumbersome than it needs to be.
>
>> With all the blobs already in the git store, and the information
>> needed to perform the data mining operation which is the extraction  
>> of
>> git-style branch histories from the svn data, you will be working  
>> with
>> data which is all in git-land, and exporting referencing blobs which
>> are already in the store.  This will save you a LOT of time, as it
>> means in this stage you are not handling the actual file images; just
>> constructing branch histories in the git-fast-import stream.  Your
>> branch miner will potentially be able to process thousands of
>> revisions per second this way, even from python.
>
> Agreed. Sverre, David and I discussed exactly this- The final version
> of mirror-client will dump all the SVN information to a Git store
> first, so we can do the mapping painlessly in Git. There are some
> concerns about information loss though, which we'll have to deal with
> as we go on.
>
>> Also bear in mind
>> that people might use SVN in a way that violates the expectations of
>> this branch miner.  An example is putting a README file in the
>> top-level projects directory, a heuristic approach might consider  
>> that
>> the start of a new project and then mess up later stages.  Another
>> example is people accidentally deleting trunk and re-adding it; the
>> nice thing about this two-stage approach is that it allows advanced
>> users to muck with the "raw" data (ie, this whole repository tracking
>> branch) using git to do things like graft away the bad revisions, and
>> then the second stage will use the corrected data.  Of course
>> eventually, this detail will be hidden by the remote helper.
>
> Excellent suggestion! I'll attempt to build the plumbing for the
> mapping in a manner that exposes a sane interface.
>
>> As a general comment - you must be careful in trying to assume that
>> what you are attempting is even possible.  Sure, you want 'git clone
>> svn://example.com/myrepo' to work, but what does that mean?  A
>> repository in SVN is a filesystem, which can contain multiple
>> projects.  In git, a repo is a single project.  People might expect  
>> to
>> be able to clone the trunk URL for instance.  My advice there is to
>> not support that use case at all, it's a complete can of worms which
>> you will discover as you tackle the conversion algorithms.  Just  
>> focus
>> on making the case where the complete repository is mirrored work for
>> this project.  Mining a single branch out of SVN without all data
>> available is the domain of git-svn and really you don't want to go
>> there.
>
> Hm, this is something that I hadn't thought about earlier. Thanks for
> the suggestion- I will not attempt to go into complicated cases,
> atleast in my summer term.
>
>> Anyway like I say, please follow-up on the mailing list, and this
>> advice can receive wider scrutiny.
>
> Thank you for your valuable comment!
>
> -- Ram
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
