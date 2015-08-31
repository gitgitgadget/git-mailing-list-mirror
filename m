From: Christian Couder <christian.couder@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2015, #05; Fri, 28)
Date: Mon, 31 Aug 2015 22:12:09 +0200
Message-ID: <CAP8UFD3j8k4Wippd9_RUOYnu+5E_hsCjzbjZDpSpLVj-EUpwbw@mail.gmail.com>
References: <xmqq4mjj15lm.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD3-Y4T=dQmBVfRR1DEuuRZLSrUvQid8m1YttOnJc5Fj8w@mail.gmail.com>
	<xmqqzj17y16t.fsf@gitster.mtv.corp.google.com>
	<1441045835.25570.7.camel@twopensource.com>
	<xmqqegijusrm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 22:12:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWVRB-00011C-3k
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 22:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbbHaUMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 16:12:12 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37861 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbbHaUMK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 16:12:10 -0400
Received: by igui7 with SMTP id i7so61939581igu.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 13:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=eRtJSI1FAeTef5y2Zo82ckTORewLtNHWvLmTLLqaAxk=;
        b=b4VvunHukB2v/Zi/aoKtm55+n/QISqbBRoz5GDvADggRTKp8ikeNNKT3Cdg1sK/cjF
         kbV0V/OYSH7fRVdnKfsXRAvQ7StgOLytfMW3K6oO0TO9/TfJ9vBGhyEirMUmOndek1oq
         WWoPMxoyx+tBmmylupGUBJBCPofmBb8+9SFoHEKhv96wBzPBTHXrxvGmooEWnDk1NajI
         WqEt221LZxnvtFJA90HZCBzvy6gArsaCbJJUQuBQwm3/qS1uBFN576zTo4my45b1Jo9Q
         +zIO5OMApFfFZf6VUEoyd6qAX1kLn5lkQa9Jymes5GZq2gdAs74XmOFqIPrhtInXD0IJ
         qEGA==
X-Received: by 10.50.73.170 with SMTP id m10mr318949igv.71.1441051929590; Mon,
 31 Aug 2015 13:12:09 -0700 (PDT)
Received: by 10.79.93.131 with HTTP; Mon, 31 Aug 2015 13:12:09 -0700 (PDT)
In-Reply-To: <xmqqegijusrm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276932>

On Mon, Aug 31, 2015 at 10:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Turner <dturner@twopensource.com> writes:
>
>>> Christian, thanks for raising this one.
>>>
>>> I do recall the thread and I might be the somebody like Michael you
>>> remember, e.g. $gmane/275105---which did mention that "git bisect"
>>> would not need changing if we kept refs/bisect/.
>>>
>>> What was the reason why we chose to move to refs/worktree/ again?  I
>>> do not think there was an issue that we cannot keep refs/* in
>>> general shared while having one (or more) subhierarchy of it per
>>> worktree (otherwise we would not be using refs/worktree/*, but using
>>> something outside refs/, like $GIT_DIR/worktree-refs/).  Was there an
>>> objection to refs/bisect being private from aesthetics point of view
>>> (i.e. forcing everything per-worktree in refs/worktree/ would prevent
>>> proliferation of refs/this and refs/that that need to be private
>>> case by case), ignoring the practical issue of compatibility issues
>>> around existing tools?
>>
>> That is correct.  IIRC, on one of these patch sets, I proposed accepting
>> both new and old refs, but you said that would be unnecessary (it might
>> have been the notes/merge one instead of this one).
>
> I suspect it was notes-merge thing, but anyway, if you asked me
> right now, I certainly would say it is not OK to drop the old
> location but I may still say it is not worth having old and new with
> funny directory symlink like thing, because refs backend thing
> cannot say "I'll follow the symbolic link refs/bisect that points
> at refs/worktrees/bisect".
>
> But the reason why I say it is not worth is not because I do not
> think we need refs/bisect, but because I do not think we need
> refs/worktree/ at this point.  In other words, throwing new
> hierarchies that are private to worktree into refs/worktree/ is fine
> if we discover the need for some new hierarchies in the future, but
> being able to access the bisection points as refs/worktree/bisect is
> not necessary.  If people and tools are familiar with it being in
> refs/bisect, that location is fine.
>
>>> I think one example of script, "gitk --bisect", does want to show
>>> the DAG limited by bisect refs, but it does so using plumbing
>>> without having to say refs/bisect/bad itself.  Perhaps the thinking
>>> (or lack of enough of it) went that no other uses by scripts need to
>>> peek directly into refs/bisect/ hierarchy?
>>
>> I did a quick search on github, and did not see any scripts that said
>> "refs/bisect".
>
> That's one data point, but not a very confidence-building one.
>
> Christian, did you see your private script break with this change,
> or as one of the larger stakeholder of "bisect" subsystem you wanted
> to proceed with caution (the latter I myself would share, actually)?

Yeah, it's the latter.
