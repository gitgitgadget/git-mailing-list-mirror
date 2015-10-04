From: Ray Donnelly <mingw.android@gmail.com>
Subject: Re: [PATCH 1/2] test-path-utils.c: remove incorrect assumption
Date: Mon, 5 Oct 2015 00:36:16 +0100
Message-ID: <CAOYw7duDLWYpu+NK2t2+hV3rtU=dK3eQ6R11mfwLKbQQowbWuQ@mail.gmail.com>
References: <CAOYw7dubGJ=m5+EnjGy7jTQxR+b0uBmyG138KEQ5rzX2K7WcgA@mail.gmail.com>
	<xmqqlhbj3mfo.fsf@gitster.mtv.corp.google.com>
	<CAOYw7dv4iPQ4cq4Ab1ZeThrp=u51T5v387a1Y8QPO-yj=fyMcg@mail.gmail.com>
	<xmqqwpv21rej.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 01:36:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZispK-0004vK-Fr
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 01:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbbJDXgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 19:36:17 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34514 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbbJDXgR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 19:36:17 -0400
Received: by obbda8 with SMTP id da8so116937645obb.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 16:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yZbUGBKA5oRnXJxArxxLggEN9/J42eJfkrILEszLzqU=;
        b=LdLS8f/AUiZ++No4f5sTC/TJjYy59EzUKKnaku0EYxAt7J+MnV/VzZ/cmcv4njDCnf
         Apa2Zk2+HLr7EFXxXp6tT4xcUasl5dSe3RKViSDpsdH5/m25xnAmL3d+L3FbLJnkfXfg
         JbwMtO8SzO5L8b7L2IFq7qmH/N7lE4MEX5GllBHhwTEDX/V6CA78BFIwZYLRTYQCY6Et
         TmXj0MKgTK+MYLEE2YHmFhJ94v8AorJj8DaakN/gUZm4n6OvCLTqp3kxhD7QOfkHm4ph
         g+spqN3ymd9G8/owHA6PVoCIh7BS2rYKgbotyL15hn4wPKq5OpwEafOMSQU0dMYYlM9/
         bW1g==
X-Received: by 10.60.79.226 with SMTP id m2mr16156467oex.20.1444001776512;
 Sun, 04 Oct 2015 16:36:16 -0700 (PDT)
Received: by 10.202.15.21 with HTTP; Sun, 4 Oct 2015 16:36:16 -0700 (PDT)
In-Reply-To: <xmqqwpv21rej.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279026>

On Sun, Oct 4, 2015 at 6:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ray Donnelly <mingw.android@gmail.com> writes:
>
>>> Some callers of this function in real code (i.e. not the one you are
>>> removing the check) do seem to depend on that condition, e.g. the
>>> codepath in clone that leads to add_to_alternates_file() wants to
>>> make sure it does not add an duplicate, so it may end up not noticing
>>> /foo/bar and /foo/bar/ are the same thing, no?  There may be others.
>>
>> Enforcing that normalize_path_copy() removes any trailing '/' (apart
>> from the root directory) breaks other things that assume it doesn't
>> mess with trailing '/'s, for example filtering in ls-tree. Any
>> suggestions for what to do about this? Would a flag be appropriate as
>> to whether to do this part or not? Though I'll admit I don't like the
>> idea of adding flags to modify the behavior of something that's meant
>> to "normalize" something. Alternatively, I could go through all the
>> breakages and try to fix them up?
>
> I agree with you that "normalize" should "normalize".  Making sure
> that all the callers expect the same kind of normalization would be
> a lot of work but I do think that is the best approach in the long
> run.  Thanks for the ls-tree example, by the way, did you find it by
> code inspection?  I do not think it is reasonable to expect the test
> coverage for this to be 100%, so the "try to fix them up" would have
> to involve a lot of manual work both in fixing and reviewing,
> unfortunately.

For the ls-tree failure, I ran "make test" to see how much fell out.
I'm not familiar with the code-base yet, so I figured that at least
investigating the changes needed to make the test-suite pass would be
a good entry point to reading the code; I will study it at the same
time to try and get my bearings.

>
> The first step of the "best approach" would be to make a note on
> normalize_path_copy() by adding a NEEDSWORK: comment to describe the
> situation.
>
> Thanks.
