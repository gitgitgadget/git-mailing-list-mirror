From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 8/9] branch: use ref-filter printing APIs
Date: Wed, 7 Oct 2015 22:17:47 +0530
Message-ID: <CAOLa=ZS4xVfsQ+F+KGD8Gz9NHzvJtuVvW16RSLV08ZiEv8DhKw@mail.gmail.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
 <1443807546-5985-9-git-send-email-Karthik.188@gmail.com> <vpqvbao86pj.fsf@grenoble-inp.fr>
 <CAOLa=ZSk8-6nkfEd+Kz1srOJxPLj6+zLEU9DnLgW3rW1O6kZGg@mail.gmail.com>
 <vpq7fn1qhp2.fsf@grenoble-inp.fr> <CAOLa=ZS5x=ksfnBt1kLp5bJJHmqeBztR7Zn7U5VKZN-56T-_5A@mail.gmail.com>
 <vpqmvvvhl9m.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 07 18:48:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zjrt8-0005G4-Sz
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 18:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737AbbJGQsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 12:48:18 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:36801 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995AbbJGQsS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 12:48:18 -0400
Received: by vkfp126 with SMTP id p126so15174659vkf.3
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 09:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qWgSx9Z3mRmHkg7HYCkdnXL2LCtRiLUSRZVAokHWD7Y=;
        b=oxUW0BYZsTBkPWVk+Y4T4cA4MWEQyEkYtVVho+e7QzaEAPJ3f0J9x2n/4s1RYqNz/F
         mhQkDX6CxZsnOUP6EU4rVMHvQ/UmKLZ2RR25jgphVtWbLtFG18k0An5dSMd45kGDY0oY
         HVq7ce4u0r5dM5bZFWJtvXsTe9Nb259z3dG/WcOqst9FiC/M26EAz7N8HNGI+W2wFSjR
         K9+PZ5wOcjAbp8Sxk9c+gimCdvZvLwh+lwUOhhZX+adXwiA2WnsNc+x9bzlUWGM6prG5
         wyugZflVQhXMNIjW5UDkjdwG07oPyE9Zs6RFRqT17kD+8KVWQt5GGQwgjQht7rJnxTZZ
         fgYQ==
X-Received: by 10.31.15.69 with SMTP id 66mr1972181vkp.142.1444236496914; Wed,
 07 Oct 2015 09:48:16 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Wed, 7 Oct 2015 09:47:47 -0700 (PDT)
In-Reply-To: <vpqmvvvhl9m.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279185>

On Wed, Oct 7, 2015 at 12:33 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> If you look closely, thats only for the local branches, the remotes
>> have `align` atom when
>> printing in verbose.
>
> Yes, but that's already one thing factored out of the if, even if it's
> just for local.
>
> Actually, I think you can also factor some parts out of the
> %(if:notequals=remotes). In 'local', you have an %(if) to display either
> "* " or "  ", and in remote you always start with "  ". Why not always
> apply the %(if), and let it display "  " if not displaying the current
> branch? Similarly, the "verbose" part of remote branches seems like a
> particular case of the one for local ones (remotes don't have tracking
> branches, so the tracking info should expand to the empty string).

We could factor out the " " and the "* " printing. I'll do that

>
> To go a bit further, you can pre-build a string or strbuf aligned_short
> with value like "%%(align:20,left)%%(refname:short)%%(end)" and use it
> where needed (it's not a constant because you have to introduce maxwidth
> into the string, so it's not a candidate for #define).
>

Again, the remote has a remote prefix here, so we can't really factor
it out much.

>> I could cook up this:
>
> Your mailer broke the formatting, so it looks terrible, but from what I
> could parse, it's already much better than the previous one. It's not a
> matter of size of the function, I very much prefer reading 10 lines of
> nice code than 4 lines like
>

I get what you're saying I'll see if I can factor out more.

>> +                        local = xstrfmt("%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)%%(align:%d,left)%%(refname:short)%%(end)%s"
>> +                                        " %%(objectname:short,7) %%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s] %%(end)"
>> +                                        "%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)",
>> +                                        branch_get_color(BRANCH_COLOR_CURRENT), maxwidth, branch_get_color(BRANCH_COLOR_RESET),
>> +                                        branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
>
> ;-).
>
> One obvious issue with the initial version was this big hard-to-parse
> block, but another one is that the code did not make it easy to
> understand what was changing depending on which branch of the if, and
> depending on local/remote. It's getting much easier already.
>

Yea, we can say that :)

-- 
Regards,
Karthik Nayak
