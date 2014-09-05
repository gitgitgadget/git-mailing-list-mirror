From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2014, #01; Tue, 2)
Date: Fri, 5 Sep 2014 08:18:34 +0700
Message-ID: <CACsJy8AyrGeLJ-B+81ZNQaKGvNV5YNnZ_RWUumvhKR-tvTrg9A@mail.gmail.com>
References: <xmqqzjehy8vx.fsf@gitster.dls.corp.google.com> <CACsJy8C_=aNX9LT2V_zhw++tC22C5SDfwbpTS=juONMxwcV9pA@mail.gmail.com>
 <xmqqtx4nuy5k.fsf@gitster.dls.corp.google.com> <xmqqmwafux3y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 03:19:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPiBE-00069e-L9
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 03:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755713AbaIEBTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 21:19:07 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:53659 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222AbaIEBTG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 21:19:06 -0400
Received: by mail-ie0-f178.google.com with SMTP id tp5so225482ieb.9
        for <git@vger.kernel.org>; Thu, 04 Sep 2014 18:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=m1oOqiJ4n8mwwcOV0K/IU68FBEkfkvO6J+4sd8QMl44=;
        b=cUzfEriFuFf3p/DRRBmFe9NsGU2SK/5Nj4HvQIjaAfD6ffkqbyjD1V2PXEbGiO9w52
         OHAnrKjZDSXISZNxw0dx1Itevxwa8u1DL5uwLal2HWzLxjbp5OaR2+8ayxHcj+PlXaVo
         Iy8Vebrh+j1MQ//lJoaRltkud31GpK7KYaKuYPgOTmmt4p8FgLLubbCSX5AXzktyTmZc
         WZfyOkD8pZeZgIJBVMHmfp/FnBbLrl6158GGM06XFxFEnY5mIq0XHQHiMmi7rsNt6ZAS
         uLQDSMMgonoc0Q5RtDlXa7JX9OZ8tNUJi0VkoEOw3RrNBO5/iSX4gUws+fTEJLYSArrc
         dGxQ==
X-Received: by 10.50.171.199 with SMTP id aw7mr12298761igc.27.1409879944978;
 Thu, 04 Sep 2014 18:19:04 -0700 (PDT)
Received: by 10.107.3.152 with HTTP; Thu, 4 Sep 2014 18:18:34 -0700 (PDT)
In-Reply-To: <xmqqmwafux3y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256494>

On Fri, Sep 5, 2014 at 12:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> On Wed, Sep 3, 2014 at 5:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> * nd/multiple-work-trees (2014-07-29) 39 commits
>>>>
>>>>  Reroll posted, but haven't picked up yet.  How would this interact
>>>>  with rr/transaction series which is pretty much all about the refs?
>>>
>>> Haven't checked out that topic yet. But ref changes in
>>> multiple-work-trees are to make sure ref path construction goess
>>> through git_path(), and some cleaning up after strbuf_git_path() is
>>> introduced. So basically textual conflicts only.
>>
>> Up to the point that is queued on 'pu', the other topic(s) still
>> keep the assumption that all refs are files in $GIT_DIR/refs/, and I
>> think I managed the textual conflicts correctly in 'pu' before.
>
> One point that caused unnecessary conflict resolution was that the
> transaction series lacked "let's use strbuf to hold paths".  This
> had two immediate side effects, i.e. "instead of returning upon
> errors, jump to the end with 'goto done/fail' for necessary
> clean-up" and "get rid of git_snpath and use strbuf_git_path", both
> of which are good general clean-ups, even if they weren't related to
> the multiple worktrees feature, that conflicted with the transaction
> series when getting merged.
>
> You can see the interactions by checking
>
>     $ git show 'pu^{/^Merge branch .nd/multi}' refs.c
>
> Perhaps these three changes, without the addition of the multiple
> worktree feature, should come first as a general clean-up on top of
> which both topics can be built?

If that makes your life easier, sure. Changes up until (and including)
c88c438 (setup.c: convert is_git_directory() to use strbuf -
2014-08-30) could be considered cleanups. After that commit, refs.c is
not touched. Will look at your conflict resultion later..
-- 
Duy
