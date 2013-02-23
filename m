From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] add: allow users to silence Git 2.0 warnings about "add -u"
Date: Fri, 22 Feb 2013 23:59:06 -0800
Message-ID: <CAJDDKr7F-wunjT_SS0mw+WUgoM3-Lu9bA3JUKk4sQiWWK0N9Jw@mail.gmail.com>
References: <1361513224-34550-1-git-send-email-davvid@gmail.com>
	<7vtxp4sw8e.fsf@alter.siamese.dyndns.org>
	<CAJDDKr4dCJ3p9QBGr09kW4_0BsVJcpE7s83=eNxKE15pMznWCw@mail.gmail.com>
	<vpqd2vssnh7.fsf@grenoble-inp.fr>
	<7v621ks1cf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 09:00:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9A1i-00035M-IN
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 09:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756694Ab3BWH7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 02:59:43 -0500
Received: from mail-we0-f181.google.com ([74.125.82.181]:32954 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755437Ab3BWH7I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 02:59:08 -0500
Received: by mail-we0-f181.google.com with SMTP id t44so1125451wey.12
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 23:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=sStDxdfoiyKSLuxcQ3Pot3Hnsm0cK3yv0OpzDI2UuhY=;
        b=mImtOHj6sWQxAPnNqfOL1Uh2QlpOoCo7mt3gUb/m2/pST2qG7JhklP0g8a9jk8UhTB
         IE6/PfD7x7AJrchL0MNXPBlpXp1jS68tcTCE7qu6+v2+p0kNoQ2MIRtFKUuiht74+dis
         4fTHo0V/MmMVTRIQ/5PLMtnzh6DTeavuCo91xYaEunSKv2PH9D0No61k06K3zmj4ZVi6
         29s98A/B9YcJC34wOkSL6vVEeryqKNEEPelNQK139DQb5BsfcXyn0FxZeHN1WvczgxDl
         Q+Ed/WNDNszVaoBR9QPODQu/2u9TuGxlp1CNoxIR81e+BUGiIzJ6yMOBQLP2WYbYzdRu
         Wc4Q==
X-Received: by 10.180.83.227 with SMTP id t3mr1744290wiy.2.1361606346331; Fri,
 22 Feb 2013 23:59:06 -0800 (PST)
Received: by 10.194.13.129 with HTTP; Fri, 22 Feb 2013 23:59:06 -0800 (PST)
In-Reply-To: <7v621ks1cf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216891>

On Fri, Feb 22, 2013 at 9:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Yes, but push.default is really different: there is a config variable,
>> and we want the behavior to be configurable. In the case of "git add",
>> I don't think adding a configuration option would be the right thing.
>> That would mean typing "git add -u" on an account which isn't yours will
>> be unpredictable *forever*.
>
> Exactly.

I completely agree.  We don't want that [1].

I'm actually a big enemy of configuration, don't get me wrong.
The real point of the patch I sent was to start a conversation
about the thing I actually care about:

After reading the draft release notes I now realize that
"git add -u" will not die() in Git 2.0.  It will operate on the
full tree, as described in the note.  Sweet.

I was originally concerned that "git add -u" was going to die()
and we would no longer be able to use it without pathspec.
My concerns were unfounded.

(If I am not understanding this correctly then it is a sign
 that the draft release notes can be made more clear)

> Another problem with use2dot0 configuration is that it would invite
> people to imagine that setting it to false will keep the old
> behaviour forever, which is against what you set out to do with the
> patch under discussion.

I agree with both sides.  There's the part of me that wants the 2.0
behavior now with a config switch for the same reasons as was
discussed earlier:

http://thread.gmane.org/gmane.comp.version-control.git/166223/focus=168238

In addition, mindful users would see one less warning,
which is the only weight I've added to that side of the discussion.

We would never want to go back to the old behavior when 2.0
roll around.  Jakub's "future.wholeTree" suggestion makes
sense in that context as the entire "future.*" namespace
could be designated as variables with these semantics.

One downside is that adding such a configuration is just more
temporary code to maintain and rip out when 2.0 rolls around.

OTOH a positive thing about adding configuration to get
the better behavior is that the code path materializes
sooner, and it will be better exercised before 2.0.  This
increases confidence that removing the false side of the
imaginary "future.fullTree" configuration will be harmless.

In the original-original thread Matthieu and I seemed to
agree that configuration to get the new behavior
(but not get the old behavior) would be nice. Peff went
even farther and suggested that having a way to keep
the old behavior would be good, and I agree that this is
the thing [1] to avoid since it makes the command forever
unpredictable.

"future.*" means the ambiguous/unpredictable behavior
does eventually go away.

It's a flag day, there's no way around that.
Script writers will be hurt, there is no escaping that.

I guess the real question is whether it's a flag day that
happens through availability of configuration, or by the
inevitability of 2.0.

I have one scenario where "future.fullTree" would be
helpful to script writers: it would allow them to
test their scripts with the new behavior and back it out
if their scripts break.  This gives them more time to
make the tiny change needed to be portable across
different git versions, which helps make the later
default change into much less of an event.

Having such a configuration would probably mean that
git should probably warn for all pathless "git add -u",
even from the root.  It will help usher users towards
the new behavior.  The current behavior makes the
most sense since we do not have a config variable.

The current behavior is certainly the simplest.

I don't know what we can do about the clueless user on
stackoverflow that follows the first suggestion to
set the future.fullTree variable.  My gut feeling is
that optimizing for them is a lost cause.

Providing a way for mindful users to ease themselves
into the new behavior does help them, and git is
certainly the tool of choice for the mindful user. ;-)

I hope I haven't misrepresented anybody's opinions.
If I'm the only one who thinks that "future.fullTree"
is a good idea then I have no problem with the current
behavior since the noisy warning will be gone in 2.0.

Does anyone else have any weight to add to either side?
-- 
David
