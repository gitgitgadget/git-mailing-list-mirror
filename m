From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: Idea, Transparent commits, easier "code style" commits
Date: Fri, 04 Jul 2014 17:26:36 +0200
Message-ID: <53B6C7AC.7000701@gmail.com>
References: <CAAwotL2a=2syXMCjPsNB9Tzaw1Rrr4UqDyLX9+JYDE-izpJnLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Andrius Bentkus <andrius.bentkus@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 04 17:26:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X35Nu-0000rI-Ca
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jul 2014 17:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbaGDP0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2014 11:26:42 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:40930 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbaGDP0m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2014 11:26:42 -0400
Received: by mail-we0-f177.google.com with SMTP id u56so1798624wes.8
        for <git@vger.kernel.org>; Fri, 04 Jul 2014 08:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=nps/FKp62hULRySAR15MDqh41LmQpK/nFewO/TN2Xbo=;
        b=wHW0IH6NbQc9HNVUiMXEJsJ7+KsYteOeaC5PofgVwMbtekN5Fz8CMX2rkiSzQ5tHTu
         vROQ4HMFd05lQEyfVa/pMTVcx+8N99biTbJT4cMilvwY+qqDcarkhBIub8ZDa8iLRNw2
         Cxn2GMHn6lMke1mcEENQcu3iyKYkRn7FRIrMJmWwC0zvIKY2qF0aL4ry50ki5BBrWHYm
         2JcFDegBBjepAg4mmNRf2DscCarcrnxZAq6H6uDxt0Wxf0drx8ryqSduDQ8LDCLxl6NA
         dWIYz6+zMgriG4uBoxFj/ReNMy65CaNfVR5PKjVOoS58Q9IcJrRiYN6QUf9ipvQisL0l
         areQ==
X-Received: by 10.180.76.134 with SMTP id k6mr29293636wiw.49.1404487599527;
        Fri, 04 Jul 2014 08:26:39 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id l8sm69662551wje.15.2014.07.04.08.26.38
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 04 Jul 2014 08:26:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CAAwotL2a=2syXMCjPsNB9Tzaw1Rrr4UqDyLX9+JYDE-izpJnLg@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252897>

On 04.07.2014 15:12, Andrius Bentkus wrote:
> I have worked on projects which only after a while (a year or so)
> established a consistent code style.
> After the consensus was established there was still some code left
> which did not fit the newly established standard.
> Now the problem is, if I create a new patch to actually fix it, it
> will pollute the blame history.
> And most of the projects just reject these kind of patches because of this.
> 
> Imagine that you would have a type conversion "(int)value" and wanted
> it to change to "(int) value".
> The patch will have hundreds of occurrences of this one line changes
> and will make the git blame look like swiss cheese.
> It doesn't add much information to the line (you'd rather have
> technical explanations in the commit) and actually hides all the
> original comments of the line.
> 
> So you kinda want to have that style fix patch because inconsistent
> code style just triggers your OCD, but you can't do anything about it
> because it doesn't add any value to the program when it executes and
> actually makes it harder to browse the source code using git blame.
> 
> My proposal is to add "transparent" commits.
> If you write git blame these commits will not be shown, instead git
> blame will show a merged version of the code style commit and the
> actual commit while only showing the commit id of the original commit.
> 
> A little visualized example:
> 
> Imagine your first commit is:
> 
> 58461d5a float yolo(void *i) {
> 58461d5a   return (float)*i;
> 58461d5a }
> 
> And you want it to change to (float) *i, so you patch it and the blame
> history looks now like this:
> 
> 58461d5a float yolo(void *i) {
> 263da519   return (float) *i;
> 58461d5a }
> 
> But what you really want to have when you do a git blame is this:
> 
> 58461d5a float yolo(void *i) {
> 58461d5a   return (float)*i;
> 58461d5a }
> 
> I hope I expressed myself clearly enough.
> Maybe this was already proposed, but I couldn't find anything in the archives.

Check the -w option of blame
http://git-scm.com/docs/git-blame
to fix it while blaming.

Or you need to rewrite the history (a bad idea if the history is
published to collegues or on the internet) and squash your fixes into
the original commits.
(see git rebase for that)

But re-reading your mail, you would like to propose a 3rd way?
So when commiting the fixup, you want to add a flag, which tells git
it's just a fixup commit, which should not be shown, when blaming, but
rather their parent for the lines in question.
That's an interesting idea.

Stefan
