From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: Newbie Query
Date: Tue, 20 Jan 2009 20:17:11 +0000
Message-ID: <3f4fd2640901201217x22262655w115cc2a25e32865e@mail.gmail.com>
References: <20090120191952.GA25322@uts.thewillards.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Chris Willard <chris@thewillards.co.uk>
X-From: git-owner@vger.kernel.org Tue Jan 20 21:18:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPN3W-0002Wz-QB
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 21:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756937AbZATURO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 15:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756147AbZATURN
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 15:17:13 -0500
Received: from wf-out-1314.google.com ([209.85.200.170]:61666 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464AbZATURN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 15:17:13 -0500
Received: by wf-out-1314.google.com with SMTP id 27so3954246wfd.4
        for <git@vger.kernel.org>; Tue, 20 Jan 2009 12:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sRuD0yuk6SSd1bpXVPzz8dpN5KkgK+s+EzYhCIj9mOw=;
        b=p5A8MQtItFFWFfkyZ5Nut3RITUaOUzqG/q9N4wmlPUptdmZwkz2AyBMf1tI4Fr23AK
         43EJy/9I52+1YzMBrfFWG7i+W8OP5BACexhihfQLs6CwolmbWISqlUdXmrKMHP3SO4+7
         CVtJeo12lBvBTvLS4o/WLda2E1sWBRn4ocKIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aOsyQDNj2NVgcHZZp7pXwmWtdwCOhUR0DOhuU7kL1UEmQnCZviI3any5z43w4IQE54
         lxnNdDNN0s4TwmobqInf6LxceDlM5b6dz5Hqjs6uuwkiFigeNRk6+NCvpLnTAr0zpULn
         o7iDfXptGMMlqMz82+xbpfb+faX750P5vekDU=
Received: by 10.142.170.6 with SMTP id s6mr3003355wfe.58.1232482631991; Tue, 
	20 Jan 2009 12:17:11 -0800 (PST)
In-Reply-To: <20090120191952.GA25322@uts.thewillards.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106518>

2009/1/20 Chris Willard <chris@thewillards.co.uk>:
> Hello All,
>
> I then modified the files, added them, commited the changes and then
> used git push to put them on the PC - still no problems.
>
> Both systems show the commits but the PC does not have the latest
> version of the files. Git status on the PC shows the file as changed
> but commiting give an error when pushing from the laptop.
>
> I assume that I need to run a command on the PC to get both systems
> the same. Is it a reset or something else?

So IIUC running 'git log' on the machine you pushed the changes to,
you can see the checkin you made on the machine you made the change
on? You need to run 'git checkout' on the machine you pushed to, to
tell git that you want these files. This is a safety feature, since
someone may be working on the files on that machine locally, and so
doesn't want them being overwritten by your push.

You may find the documentation (http://git-scm.com/documentation)
useful, especially
http://www.kernel.org/pub/software/scm/git/docs/everyday.html which
has your scenario under "Push into another repository. ".

If you want someone to take some changes you made, it is recommended
to let them know so that they can run 'git pull' or 'git fetch' to get
your changes (performing a merge or rebase as desired). This means
that they control when they get the updates and what they want to do
with them.

If you are committing the files to a shared public repository (e.g. a
central repository, or build server repository), a pussible approach
is to create that as a "bare" repository (one with just the contents
of the .git folder - i.e. it does not have any files checked out). You
can do this by running:
    git clone --bare source/git/path/project project.git
you can then clone from this:
    git clone my/shared/project.git
and push any changes to it as normal.

The build server can then do a 'git pull' to get the new changes from
that repository.

You can keep it setup like you currently have (assuming that where you
are pushing to is a shared repository), and do:
    git checkout HEAD
before you run a build (assuming this is the repository that you are
using for your builds). The advantage of a bare repository is that it
will take up less space, and using a different (cloned) repository for
performing builds keeps the main repository clean.

One of the great things about git is that you can customise it to fit
different workflows.

HTH,
- Reece
