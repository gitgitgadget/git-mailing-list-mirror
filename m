From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2015, #05; Fri, 28)
Date: Mon, 31 Aug 2015 13:06:53 -0700
Message-ID: <xmqqegijusrm.fsf@gitster.mtv.corp.google.com>
References: <xmqq4mjj15lm.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD3-Y4T=dQmBVfRR1DEuuRZLSrUvQid8m1YttOnJc5Fj8w@mail.gmail.com>
	<xmqqzj17y16t.fsf@gitster.mtv.corp.google.com>
	<1441045835.25570.7.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 22:07:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWVM5-0004Hj-2V
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 22:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbbHaUG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 16:06:56 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34902 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbbHaUGz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 16:06:55 -0400
Received: by pacdd16 with SMTP id dd16so149436587pac.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 13:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=m9qWUG8XQ5Ha9HWHupRDqZm65G2AUnbZNzjQsd5SizE=;
        b=IvVyoLfZU4yaONIaWJFD+mMz7kso6J5Z03Tn4ncY8TuY5w7ddTD1fhaJlcVJXfwnfI
         tGjEZ4Xj097z2QK7H/Yg3obr0Co3qMhK6Jdvqfe/uwE/+ULI1VHalY1kiCzdUV95P6nW
         kSOOeXt1QcWkUM7n8ssX+FCYd3MYbHPb5hN/gRi0qv+yDSWH/QEEb+CGNKiAFBPc7QFS
         vun0GVZtDClBdz5zje0HEjLIowIejQRgUhNOmm4oAzgB3fh7hyqNJzMv/ugJcC8NtNMX
         SPyTs/6VeFvnsyC8ly232PwSHhuQkzANC8KUCiaQhyiPr8MwbXz4IEFGs7KwXcdX37Jc
         jS6g==
X-Received: by 10.66.227.98 with SMTP id rz2mr41077526pac.16.1441051614752;
        Mon, 31 Aug 2015 13:06:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id d8sm15610510pat.0.2015.08.31.13.06.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 13:06:53 -0700 (PDT)
In-Reply-To: <1441045835.25570.7.camel@twopensource.com> (David Turner's
	message of "Mon, 31 Aug 2015 14:30:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276930>

David Turner <dturner@twopensource.com> writes:

>> Christian, thanks for raising this one.
>> 
>> I do recall the thread and I might be the somebody like Michael you
>> remember, e.g. $gmane/275105---which did mention that "git bisect"
>> would not need changing if we kept refs/bisect/.
>> 
>> What was the reason why we chose to move to refs/worktree/ again?  I
>> do not think there was an issue that we cannot keep refs/* in
>> general shared while having one (or more) subhierarchy of it per
>> worktree (otherwise we would not be using refs/worktree/*, but using
>> something outside refs/, like $GIT_DIR/worktree-refs/).  Was there an
>> objection to refs/bisect being private from aesthetics point of view
>> (i.e. forcing everything per-worktree in refs/worktree/ would prevent
>> proliferation of refs/this and refs/that that need to be private
>> case by case), ignoring the practical issue of compatibility issues
>> around existing tools?
>
> That is correct.  IIRC, on one of these patch sets, I proposed accepting
> both new and old refs, but you said that would be unnecessary (it might
> have been the notes/merge one instead of this one).

I suspect it was notes-merge thing, but anyway, if you asked me
right now, I certainly would say it is not OK to drop the old
location but I may still say it is not worth having old and new with
funny directory symlink like thing, because refs backend thing
cannot say "I'll follow the symbolic link refs/bisect that points
at refs/worktrees/bisect".

But the reason why I say it is not worth is not because I do not
think we need refs/bisect, but because I do not think we need
refs/worktree/ at this point.  In other words, throwing new
hierarchies that are private to worktree into refs/worktree/ is fine
if we discover the need for some new hierarchies in the future, but
being able to access the bisection points as refs/worktree/bisect is
not necessary.  If people and tools are familiar with it being in
refs/bisect, that location is fine.

>> I think one example of script, "gitk --bisect", does want to show
>> the DAG limited by bisect refs, but it does so using plumbing
>> without having to say refs/bisect/bad itself.  Perhaps the thinking
>> (or lack of enough of it) went that no other uses by scripts need to
>> peek directly into refs/bisect/ hierarchy?
>
> I did a quick search on github, and did not see any scripts that said
> "refs/bisect".

That's one data point, but not a very confidence-building one.

Christian, did you see your private script break with this change,
or as one of the larger stakeholder of "bisect" subsystem you wanted
to proceed with caution (the latter I myself would share, actually)?
