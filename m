From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/8] cherry-pick: add --skip-empty option
Date: Tue, 4 Jun 2013 12:10:00 -0500
Message-ID: <CAMP44s2DvtiT6hi-RoPt_bVdGr01S367usz=089E1Ht+Bvh-tA@mail.gmail.com>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
	<1369799788-24803-4-git-send-email-felipe.contreras@gmail.com>
	<7vr4gjdomk.fsf@alter.siamese.dyndns.org>
	<CAMP44s1GQ2iwwscx4Sx1cxK0U6yWWYvOJqDk_FO_GkFcNKREYw@mail.gmail.com>
	<7vehcidg1i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 19:10:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjukN-0000gi-Su
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 19:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758231Ab3FDRKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 13:10:06 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:50076 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758286Ab3FDRKD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 13:10:03 -0400
Received: by mail-la0-f53.google.com with SMTP id ea20so490994lab.40
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 10:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6+bMZvfwTwnZvp5bZJzHtukndrq4ZpWNN3U93M6YFOI=;
        b=u4VYlgWN2PabQl1bGuYfFcvRmQER8MCGrQDO+DdgqASqK/8XVkvfmii6221vClAqBC
         P86AQQSItnGeHvP7Ohhnc6h649bFaQOoaV2mlOOAJOdOqw807ELnOLbPdqZi+dS5Wu9T
         JhYpIhNr9/PjnHpnkm4pzE7ZiOuvvK9k+6su4b9DcatKS+S3Ws4HPD++V91wvZAdXGDh
         MvufL3lSvIrnyavgf8kTjG5KtDtcawdzWUvsDpS4PCHv17/TZSpacU63WUE2PXDAcfLM
         TWiXqOZE176/2FmLX/W2yOcF4KbWiEDZR3y9hlsoZlhAQ+6QPO7k7fwWlSMOn2XRZogv
         WkvQ==
X-Received: by 10.152.26.137 with SMTP id l9mr13686596lag.2.1370365800667;
 Tue, 04 Jun 2013 10:10:00 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Tue, 4 Jun 2013 10:10:00 -0700 (PDT)
In-Reply-To: <7vehcidg1i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226378>

On Mon, Jun 3, 2013 at 4:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Mon, Jun 3, 2013 at 1:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> Pretty much what it says on the tin.
>>>>
>>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>>> ---
>>>>  Documentation/git-cherry-pick.txt   |  3 +++
>>>>  builtin/revert.c                    |  2 ++
>>>>  sequencer.c                         |  6 ++++++
>>>>  sequencer.h                         |  1 +
>>>>  t/t3508-cherry-pick-many-commits.sh | 13 +++++++++++++
>>>>  5 files changed, 25 insertions(+)
>>>>
>>>> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
>>>> index c205d23..fccd936 100644
>>>> --- a/Documentation/git-cherry-pick.txt
>>>> +++ b/Documentation/git-cherry-pick.txt
>>>> @@ -129,6 +129,9 @@ effect to your index in a row.
>>>>       redundant commits are ignored.  This option overrides that behavior and
>>>>       creates an empty commit object.  Implies `--allow-empty`.
>>>>
>>>> +--skip-empty::
>>>> +     Instead of failing, skip commits that are or become empty.
>>>
>>> Not quite sure.  Is this "instead of recording an empty commit,"
>>> (which may or may not fail depending on the allow-empty settings)?
>>
>> We are explaining --skip-empty, not --allow-empty.
>
> Exactly.  That is why I found the "Instead of failing" questionable.
> It is very easy to read the above as "commits that are or become
> empty usually causes the command to fail, and this is a way to cause
> it not to fail.".
>
> It is true that
>
>     cherry-pick A
>
> when A becomes empty, dies.  But
>
>     cherry-pick --allow-empty A
>
> when A becomes empty, does not fail, but still does create an empty
> commit.  A large difference with --skip-empty, which applies to use
> scenario different from --allow-empty was meant to address, is that
>
>     cherry-pick --skip-empty A
>
> when A becomes empty, does not fail and does not create an empty
> commit, either.

We are not explaining --allow-empty.

What happens when you do --skip-empty --allow-empty? Somebody
suggested a new option, so we could do --foo-empty=skip,allow to
clarify that.

> I think just "Skip commits that are or become empty" without saying
> "Instead of failing," is fine, too.

I think "Instead of failing" makes perfect sense, because it's not our
job to describe what other options do, simply explain what this option
do. If the user is interested in other options, he can read them in
the help for those.

-- 
Felipe Contreras
