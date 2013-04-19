From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 1/8] Add new git-cc-cmd helper to contrib
Date: Fri, 19 Apr 2013 14:35:57 -0500
Message-ID: <CAMP44s2gA0JbfxA1UQW_pnizGBpmbQem3Qg0FpWP_Wi6eYwVjw@mail.gmail.com>
References: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
	<1366348458-7706-2-git-send-email-felipe.contreras@gmail.com>
	<7vfvym30t8.fsf@alter.siamese.dyndns.org>
	<CAMP44s3YAq66MrOR5a4ydujKR5+ZNMVV4i=JzPCxLXC244b52g@mail.gmail.com>
	<7v8v4e1fyz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 21:36:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTH6J-0007yW-R4
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 21:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543Ab3DSTf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 15:35:59 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:63618 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430Ab3DSTf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 15:35:59 -0400
Received: by mail-lb0-f177.google.com with SMTP id r10so3998995lbi.8
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 12:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=/wsJixPWSVCZ/6W+I9V/W+lZQhx7RILKujwk/Z/PrPg=;
        b=YXs0yyaKalHO8c9F0NOo/3Sqji8iCewUI9IjYJi5qVoWVTveG8B0yukuPDvzoJ+Xkr
         ee9caIdJPyem085eRLvFvbjCxh+qwksEFXr1G3Yl6bgr7eN3MtGJcOj9MItdyiA7/WYk
         qgKRylKgMBs9sPgvzTVEMAs7/n/iiLl5Wxq/BKhekJF3fwG+m6A9/cWw1NE/p5ln1Jrk
         IFOyF4q+SO6tbZEoGc/DZdteAKLW2RBCbs3w7HfygKGox/PyQAn3Os2NIVc3T0FrupyU
         NG+/E20blG3PDsQcM9pJrcXYY8muapsUjdQkGVZr4//v6IOAgwq/5pSybJNgNaDYN8VT
         whGg==
X-Received: by 10.112.163.6 with SMTP id ye6mr8607746lbb.59.1366400157510;
 Fri, 19 Apr 2013 12:35:57 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Fri, 19 Apr 2013 12:35:57 -0700 (PDT)
In-Reply-To: <7v8v4e1fyz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221808>

On Fri, Apr 19, 2013 at 2:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Fri, Apr 19, 2013 at 12:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>> The code finds the changes of a commit, runs 'git blame' for each chunk
>>>> to see which other commits are relevant, and then reports the author and
>>>> signers.
>>>
>>> In general, I am not all that interested in adding anything new to
>>> contrib/ as git.git has matured enough, but even if this will stay
>>> outside my tree, there are a few interesting things to note to help
>>> its eventual users.
>>
>> Why not add it to mainline git then? This tool, or a similar one,
>> would certainly be useful in the git arsenal.
>
> As to this particular "feature" (the goal it tries to achieve, not
> necessarily the implementation), that actually was the first thing
> that came to my mind.  It helps the "develop, review locally,
> format-patch, decide whom to ask reviews and then send it out"
> workflow in general to have a tool that tells you who are the people
> involved in the code you are touching.
>
> If this were _only_ to be used within send-email (i.e. replacing the
> "then send it out" above with "then use send-email" to limit the
> usecase), "git cc-cmd" would be a reasonable name.  But if that is
> the intended use case, it would even be more reasonable to make this
> logic part of send-email and trigger it with --auto-cc-reviewers
> option or something.

Yeap, but I wouldn't want to be the one that implements that in perl.

> But I think it can be useful outside the context of send-email as
> well, and having one independent tool that does one single job well
> is a better design.  Perhaps it is better to name it less specific
> to send-email's cc-cmd option.  "git people"?  "git whom"?  "git
> reviewers"?  I dunno, but along those lines.

'git relevant'? 'git related'? It's not only people, also commits.

> It is OK for a design demonstration prototype to be written in any
> language others (who can comment on the design) can read, but the
> version to be a first-class citizen needs to be written in one of
> the languages such as C, POSIX shell, or Perl to avoid adding extra
> dependencies to the users.

That is going to be though.

Cheers.

-- 
Felipe Contreras
