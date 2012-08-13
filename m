From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 2/4] revisions passed to cherry-pick should be in
 "default" order
Date: Mon, 13 Aug 2012 13:50:35 -0700
Message-ID: <CAOeW2eEbe9_m_QSbsJUbWPhf6G17X3vqbh__TCefrB0G2VKXdw@mail.gmail.com>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
	<50289e50.a19f320a.5d99.3fdfSMTPIN_ADDED@gmr-mx.google.com>
	<7vtxw6d0ct.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 22:50:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T11b1-0006eO-08
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 22:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919Ab2HMUuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 16:50:37 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46461 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab2HMUuf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 16:50:35 -0400
Received: by yenl14 with SMTP id l14so2447439yen.19
        for <git@vger.kernel.org>; Mon, 13 Aug 2012 13:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VrOqW709W9Y3jpL7+zljbbJVIRAgyjJRfs5dOPKgJLM=;
        b=pz03NWngjR6AJOSCRiiCkVE8gzjT8pXSRPy3uP5dDWvmMv2KLzkrsK2uZCEOaFXTfz
         oxoKTXmG/nB+/zWJAdpg8FnMkd6jbYLDuUP8pdMyKkgI3A306HB70uZKks0dWi0K0LBp
         u168Fh/5oviOmCA6R2CawHWozhimKelHpQnaKsJnYd9KJhY8gqVJ/ZO+XIBI4LFc8kN9
         VY3t1AdB1tSy0invkRMI5JCg6MSFlIEdHKzbyIK6yKZTdxuchOKiTD6FxwK2a+ukSdbd
         5uc0szF7mBAABpx+vRBzZ6q05+s2x1Kvm8eIH70qpv8sV1Lgedw0ICpOBUcRhTcuYid8
         CQzA==
Received: by 10.68.193.137 with SMTP id ho9mr20272471pbc.93.1344891035238;
 Mon, 13 Aug 2012 13:50:35 -0700 (PDT)
Received: by 10.68.120.112 with HTTP; Mon, 13 Aug 2012 13:50:35 -0700 (PDT)
In-Reply-To: <7vtxw6d0ct.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203361>

On Mon, Aug 13, 2012 at 1:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> y@google.com writes:
>
>> From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
>>
>> 'git cherry-pick' internally sets the --reverse option while walking
>> revisions, so that 'git cherry-pick branch@{u}..branch' will apply the
>> revisions starting at the oldest one. If no uninteresing revisions are
>> given, --no-walk is implied. Still, the documentation for 'git
>> cherry-pick --stdin' uses the following example:
>>
>>  git rev-list --reverse master -- README | git cherry-pick -n --stdin
>>
>> The above would seem to reverse the revisions in the output (which it
>> does), and then pipe them to 'git cherry-pick', which would reverse
>> them again and apply them in the wrong order.
>
> I think we have cleared this confusion up in the previous
> discussion.  It it sequencer's bug that reorders the commits when
> the caller ("rev-list --reverse" in this case) gives list of
> individual commits to replay.
>
> So I think we are all OK with chucking this patch.  Am I mistaken?

I can't really say. I suppose the current patch is smaller (it can't
really get smaller than one line), but iterating over the arguments
the sequencer level might be more correct. Would the result be
different in some cases? I would be happy to add a test case at least,
although I'm not sure when I would have time to implement it in
sequencer.

To connect to the other mail I sent on this thread (in parallel with
yours), do you think "git cherrry-pick HEAD HEAD~1" should apply the
commits in the same order as "git cherry-pick HEAD~2..HEAD" (which
would give the same result if passed to 'rev-list --no-walk' for a
linear history) or in the order specified on the command line? I
couldn't find any conclusive evidence of what was intended in either
log messages or test cases.
