From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 0/5] git bisect old/new
Date: Tue, 23 Jun 2015 12:04:50 -0700
Message-ID: <xmqq381idz59.fsf@gitster.dls.corp.google.com>
References: <1435006836-18182-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 23 21:05:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7TVC-0008J3-Am
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 21:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933182AbbFWTEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 15:04:54 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34841 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932323AbbFWTEx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 15:04:53 -0400
Received: by iebrt9 with SMTP id rt9so18377176ieb.2
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 12:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fLsSYk5FRXSt/FW5Y/Y0Kj9m/x9kFPAGPbINtuV2rZU=;
        b=Y9Fhr/QX+w0XFSmMfvteGexG/c9GqQIxYF/ls2zJixFSZK/a0Nt1gVelKh29qh13fm
         UOX46pfS4xscrtq1jfWYGL+xc6ZLQ6WLv98VFp5b2C+L7FH4KMZGwMyAX03Wryyr0KBv
         JjDCSLWQutI3u1iY6g3MgompdEQy2HJR+C0HYLra1Gh34gquFgibGFwxW3h28c2QZrwv
         Ro8hA91rhpY/M51kG6MvvLoPg+dFr85HA9Iad2/DxOxWQgP1shGOjNlquNomIQ6MH+JV
         YBCTtFpWH4BoFdrps6fiRZElzSmoCahnVHIziGtoLqenrs6fQTVYmSD/PRHsTRywlGG9
         XpgA==
X-Received: by 10.50.79.169 with SMTP id k9mr4177848igx.44.1435086292750;
        Tue, 23 Jun 2015 12:04:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3c90:65f7:f86b:dfda])
        by mx.google.com with ESMTPSA id p193sm15659188ioe.34.2015.06.23.12.04.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jun 2015 12:04:51 -0700 (PDT)
In-Reply-To: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr> (Matthieu
	Moy's message of "Tue, 23 Jun 2015 14:54:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272481>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> I fixed a few minor issues in v6. Patch between my version and v6 is
> below. I also pushed my branch here:
>
>   https://github.com/moy/git/tree/bisect-terms

It is somewhat confusing to see v3 yesterday and then this v7 next
day.  How did I miss v4 thru v6?

> Not visible in the patch below: I squashed PATCH 5 into PATCH 3 to
> avoid the pattern "break stuff and then repair it".

Good.

> The first two patches seem ready.

Yeah, the first one is obviously fine ;-), and I agree the second
one looks more or less OK.

Regarding the second and third one, the messages they give when the
user marked one tip of a side branch as old and the other new gave
me a hiccup while reading them, though.

	if (!strcmp(name_bad, "bad")) {
		fprintf(stderr, "The merge base %s is bad.\n"
			"This means the bug has been fixed "
			"between %s and [%s].\n",
			bad_hex, bad_hex, good_hex);
	} else {
		fprintf(stderr, "The merge base %s is %s.\n"
			"This means the first commit marked %s is "
			"between %s and [%s].\n",
			bad_hex, name_bad, name_bad, bad_hex, good_hex);

The "bad" side is inherited from the original and not your fault,
but it was already very hard to understand. The other side is not
just unreadable, but I think is incorrect and confusing to say
"first commit marked %(name_bad)s"; you know there are history
segments whose oldest ends (i.e. merge base that is bad) are marked
as 'bad', and the other ends are marked as 'good', and you haven't
marked any of the commits in between yet.  So there is no "first
commit marked" either as bad or good there between these endpoints
(yet).

Also I was somewhat puzzled and disappointed to still see
name_{bad,good} not name_{new,old} used as variable names even in
the endgame patch, though.  Is that intended?

> PATCH 4 (add old/new) is still buggy. When starting a bisection with
>
>   git bisect start $old $new
>
> the command "git bisect visualize" does not work (it shows no commit).
>
> I consider PATCH 5 as WIP, I think it would need a lot of polishing
> and testing to be mergeable. I think a reasonable objective for now it
> to get old/new working in the user-interface, and drop PATCH 5 from
> the series when it gets merged. The existance of PATCH 5 is a very
> good thing even if it doesn't get merged:
>
> * The fact that it's possible to do it on top of the series shows that
>   we make the code more generic. I think it's important that
>   regardless of features, the code moves in the right direction.
>
> * The patch can be taken over later by someone else.

Yeah, if I may rephrase to make sure we are on the same page, in
order for 5/5 to be done sanely, 1-4/5 must be giving a good
foundation to build on.  I agree with that, I agree that including a
polished 5/5 would be a good thing, and then I further agree that
1-4/5 could be delivered before 5/5 is ready.

Thanks.
