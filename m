From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Wed, 21 Jul 2010 15:56:54 -0400
Message-ID: <AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bryan Larsen <bryan.larsen@gmail.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 21:57:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObfPu-0007xg-I6
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 21:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575Ab0GUT5Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jul 2010 15:57:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36812 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab0GUT5P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 15:57:15 -0400
Received: by fxm14 with SMTP id 14so3869076fxm.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 12:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ajLuBwO4Vg09kw8j3tw7ddKZomkPyWvIolEYg0+J9uY=;
        b=O4+J982VEBYtw+KrfQoPuOKXFwFaff30QNzuKnshmKyD/RsvwncaOGxlyDPs4FE+uo
         /rPov0WALwhQlwLL/PxR+nAphi2Cz4F3NLVRPveSlLbisln9LD/hDpO1RRCtSNC7QjJ/
         bjDVugHi+AoDE04CZwdebiUuBWcMXuQlorblg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=F467pdWnzzcRf1Z+EprjhMmftrVtMxbIZFRxxJAIetpb70us1U8/2O0Y9OHRnZwLA8
         +1LK5c05aFqCHhDGKIOlDXUMsU2CRpB0GhOTPSycvBBujmVgrpYpNwcBh9PqsH/RAS/y
         VPMqJIqmwabL+OnvAEiPR61qhhk+eYTI9sdoA=
Received: by 10.216.175.143 with SMTP id z15mr660166wel.64.1279742234342; Wed, 
	21 Jul 2010 12:57:14 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Wed, 21 Jul 2010 12:56:54 -0700 (PDT)
In-Reply-To: <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151415>

On Wed, Jul 21, 2010 at 3:43 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> What sort of workflows do you find bad with git-submodule that are
> better with git-subtree?
>
> The submodule concept is simple, but a lot of the implementation is
> bad IMO. It doesn't integrate well, e.g. you have to remember to do
> git clone --recursive, or git clone and git submodule update --init
> after that, submodules don't remember what branch you wanted, so git
> submodule foreach 'git pull' doesn't DWYM (although I have a hack for
> that) etc.

In my experience, there is exactly one killer problem with submodules
that people are looking to solve with git-subtree:

Branching.

If you have a random developer in your office and they need to make a
patch to one of your subprojects in the course of making their main
project work, with submodules this requires incredibly error-prone
contortions involving branching both projects, making sure you have
push access to both projects, learning how to use git-submodule, etc.
And then merging that branch into someone else's branch is
complicated, particularly if they've also applied their own changes to
the subproject.

With git-subtree, that developer just commits the changes to the
merged project - and that's it.  Then you or someone else, who knows
how git-subtree works, at any point in the future, can submit the
subproject changes upstream, or not, as appropriate.

No amount of bugfixing in git submodule can fix this workflow, because
it's not a result of bugs.  (The bugs, particularly the
disconnected-by-default HEADs on submodule checkouts, do make it a bit
worse :( )  It would require a fundamental redesign to make this work
nicely with submodules.

git-subtree is certainly a fundamental redesign.  Arguably there might
be even better ways to design it, of course.  And submodules are good
for certain other situations that git-subtree isn't, so it's obviously
not a one-for-one replacement.

If we can get some kind of consensus in principle that git-subtree is
a good idea to merge into git core, I can prepare some patches and we
can talk about the details.

Have fun,

Avery
