From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] test-path-utils.c: remove incorrect assumption
Date: Sun, 04 Oct 2015 10:21:08 -0700
Message-ID: <xmqqwpv21rej.fsf@gitster.mtv.corp.google.com>
References: <CAOYw7dubGJ=m5+EnjGy7jTQxR+b0uBmyG138KEQ5rzX2K7WcgA@mail.gmail.com>
	<xmqqlhbj3mfo.fsf@gitster.mtv.corp.google.com>
	<CAOYw7dv4iPQ4cq4Ab1ZeThrp=u51T5v387a1Y8QPO-yj=fyMcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Ray Donnelly <mingw.android@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 04 19:21:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZimyM-0001fF-6s
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 19:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbbJDRVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 13:21:13 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33261 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbbJDRVK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 13:21:10 -0400
Received: by pacex6 with SMTP id ex6so152938966pac.0
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 10:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=e65hMFlcmA0nqJtm8lhazTODIODEtvnwvbGzn56oi8A=;
        b=yIkjSmwu3vIi8nbGTAsFefrvserka2Nff8YtuC0URFlkuyL+GCDahdk86M3DmwczHB
         sMWlUnK+UPUk7GiIuEvaofbp8ixhjQlyPgnKaTVYP0Ax5fXtoWR3bf0WacVg37Jl612z
         +wQbqbVwtgBIMUI6c2BIzqI7Z6SuXdZpMaNFD7M41PMfTnMpV0K9DQKzto3U9IKtk76h
         +sfECTVh95kpCCI58nbqq7VMrg8TB9nv9nzpNZHVdYE/NbJdNxLiymUkUNMP9FiABzCz
         Frvs/OCAuZr8xbcmxCov2CQXlAX2l7As8LSR+3i4IQvnkD89+MVsEoedPclcXhWaJ8it
         cO9w==
X-Received: by 10.66.124.229 with SMTP id ml5mr34033022pab.77.1443979270095;
        Sun, 04 Oct 2015 10:21:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:cd5:dd7c:35c8:15e])
        by smtp.gmail.com with ESMTPSA id ux7sm23099955pac.10.2015.10.04.10.21.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 04 Oct 2015 10:21:09 -0700 (PDT)
In-Reply-To: <CAOYw7dv4iPQ4cq4Ab1ZeThrp=u51T5v387a1Y8QPO-yj=fyMcg@mail.gmail.com>
	(Ray Donnelly's message of "Sun, 4 Oct 2015 15:51:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279004>

Ray Donnelly <mingw.android@gmail.com> writes:

>> Some callers of this function in real code (i.e. not the one you are
>> removing the check) do seem to depend on that condition, e.g. the
>> codepath in clone that leads to add_to_alternates_file() wants to
>> make sure it does not add an duplicate, so it may end up not noticing
>> /foo/bar and /foo/bar/ are the same thing, no?  There may be others.
>
> Enforcing that normalize_path_copy() removes any trailing '/' (apart
> from the root directory) breaks other things that assume it doesn't
> mess with trailing '/'s, for example filtering in ls-tree. Any
> suggestions for what to do about this? Would a flag be appropriate as
> to whether to do this part or not? Though I'll admit I don't like the
> idea of adding flags to modify the behavior of something that's meant
> to "normalize" something. Alternatively, I could go through all the
> breakages and try to fix them up?

I agree with you that "normalize" should "normalize".  Making sure
that all the callers expect the same kind of normalization would be
a lot of work but I do think that is the best approach in the long
run.  Thanks for the ls-tree example, by the way, did you find it by
code inspection?  I do not think it is reasonable to expect the test
coverage for this to be 100%, so the "try to fix them up" would have
to involve a lot of manual work both in fixing and reviewing,
unfortunately.

The first step of the "best approach" would be to make a note on
normalize_path_copy() by adding a NEEDSWORK: comment to describe the
situation.

Thanks.
