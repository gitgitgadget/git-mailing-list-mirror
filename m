From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Tue, 16 Apr 2013 00:32:14 -0500
Message-ID: <CAMP44s3shDEx9dfWw_jNu0zQrReabgAMW-mti86wyoxhk+N2Ow@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
	<7vip3npet0.fsf@alter.siamese.dyndns.org>
	<CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
	<7v1uabp109.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 07:32:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URyVA-0007SN-SA
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 07:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478Ab3DPFcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 01:32:16 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:42980 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab3DPFcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 01:32:16 -0400
Received: by mail-lb0-f170.google.com with SMTP id x11so191420lbi.1
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 22:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=7kTyj94JC5wWUxye52WLVFUdLr02FLhBlmQeUiUpOYQ=;
        b=Geh8H6U2yyH/cH9nxo+KbxDRXFaUQb7WqHCbR17Nm3HOEikyXiLjEiA6kaKdyl5pzL
         KczjZ4CyDEJs+eDX5MHub9+20XFUHwMKtMy2CrOj+Ttne1QiOj9fOH3/O73+Uo/8JH+9
         0qqoB/iAF9faUasEzg6vpjiRdvuELtooZrG20ZS/GPuDCfNX7kckUCC9UI45KgKcPCvY
         1s/42dOfzF6IK1TfP+jJadVDR5m1m8VfrQ8O2WeXB1K3avDa2p5YjyYKaA4B6y82JWbF
         SxdQNXFgd2weAL+ezlK/6YNBvH2PjqWWshVMbOye+A8Au7gPnG3ccApq/twBqfvzrOBQ
         twRA==
X-Received: by 10.112.163.6 with SMTP id ye6mr600055lbb.59.1366090334579; Mon,
 15 Apr 2013 22:32:14 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Mon, 15 Apr 2013 22:32:14 -0700 (PDT)
In-Reply-To: <7v1uabp109.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221367>

On Mon, Apr 15, 2013 at 11:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> So it should be clear now: the remote namespace refs/origin/master is
>> updated, but not the remote helper's namespace
>> refs/testgit/origin/master, which is what I already said. I don't know
>> what more do you expect. When you push 'refs/heads/master' to origin,
>> you expect 'refs/remotes/origin/master' to point to the same commit,
>> same with 'refs/testgit/origin/master', why would you expect to point
>> somewhere else?
>
> Let me play somebody who comes later and wonders about this exchange
> three months down the road...
>
> You mention three refs/ here.  Do they live in the same repository?
> Any Git person is expected to know refs/heads/master, which is "my
> local branch I have worked on and I am pushing".  It also is easy to
> guess what "refs/remotes/origin/master" is, even though we are not
> talking about a usual Git remote.  It is to keep track of the remote
> behind the helper we are pushing into, and is updated to pretend as
> if we fetched immediately from the place we just pushed.  The latter
> being in sync with what we pushed is something that can naturally be
> expected.
>
> Now, what is this third "refs/testgit/origin/master" thing?  Is it
> expected to always be the same as "refs/remotes/origin/master"?  If
> that is the case, why do we even need such a redundant information
> in the first place?

Answering that question is beyond the scope of the commit message. The
purpose of the commit message is not to educate people about the
current design of transport-helpers, we have
Documentation/gitremote-helpers.txt for that. We also have discussions
in the mailing list.

The untold answer is 'if you have to ask, you don't understand this
code', but if you must, the short answer is: because it doesn't work
otherwise.

Yes, in theory not using a remote helper ref namespace should work,
but it doesn't, and I sent patches to try to fix this behavior, but
those, along with this particular patch, where ignored. So I gave up
on those patches that tried to fix the behavior for more corner cases
and tried to push the simplest one I could find, still finding
trouble. I tried to document that in t/t5801-remote-helpers.sh,
although to be honest, the tests that pass can be hardly be considered
proper behavior. This is of course, for import/export, which are the
only operations I'm familiar with (maybe the namespace makes sense for
push/fetch operations.

So basically I'm just tired of explaining the same things over and
over again, and if you try to explain every single detail, I think any
reasonable person would reach the conclusion that the design doesn't
really make sense. But the only person that seems to be trying to
explain it and improve it seems to be me.

The commit message is no place to explain all these subtleties, it
would be huge and would need to refer to plenty of mails in the
mailing list.

I could send the whole patch series I have, and then it might become
clearer why not having the refspec doesn't work, but then ,the chances
of this patch not getting through would be higher, as the last time I
sent such series, it didn't go through.

Cheers.

-- 
Felipe Contreras
