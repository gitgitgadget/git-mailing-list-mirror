From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Sat, 14 Jun 2008 22:07:51 -0700
Message-ID: <7vabhne15k.fsf@gitster.siamese.dyndns.org>
References: <612BAE20-8DF3-4323-8AEF-527B92122A7A@wincent.com>
 <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <7vzlpqza0t.fsf@gitster.siamese.dyndns.org> <279b37b20806121335p90a6d40qb39b73f71dae990b@mail.gmail.com> <7vlk1az8aa.fsf@gitster.siamese.dyndns.org> <279b37b20806121436w4f09c8f7n1009ef2f77b66f87@mail.gmail.com> <alpine.DEB.1.00.0806130551200.6439@racer> <0F87000C-B51E-45B8-A21D-1DA184BD603F@wincent.com> <alpine.DEB.1.00.0806132239490.6439@racer> <612BAE20-8DF3-4323-8AEF-527B92122A7A@wincent.com> <200806142359.m5ENxsBI028758
 @mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Wincent Colaiuta <win@wincent.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 07:09:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7kUF-0005KM-Ee
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 07:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbYFOFIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 01:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbYFOFIN
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 01:08:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44737 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbYFOFIM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 01:08:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A7F533725;
	Sun, 15 Jun 2008 01:08:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 250723724; Sun, 15 Jun 2008 01:07:59 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0ACF6AFE-3A99-11DD-8659-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85063>

しらいしななこ  <nanako3@bluebottle.com> writes:

> I apologize for my lack of perfect foresight as the original
> author of the command.  As I already said, I think expiration
> period of reflogs that is configurable for each ref as suggested
> earlier by Junio makes sense.

You do not need to be overly apologetic.

It's not your fault that the way you originally scratched your own itch is
already 90% useful to others in different context of theirs but with 10%
"caveat emptor".  Others owe kudos to you for what they're given, and the
way for them to thank you would be to scratch their own itch by filling
the remaining 10% to make it work better in their context, not by bitching
and quibbling on what the dictionary definition of the word "stash" is.

> But changing the default expiration "never" for stash has its
> own problem and I think we need to modify the way a stash entry
> is created to solve it.
> ...
> If you do not expire stash forever, you will keep the history
> behind the commit H.  This is unnecessary and is problematic
> particularly if you rebase your branches frequently.
>
> In order to apply a stash, all you need is the tree of the three
> commits contained in this structure.  You do not need the
> history behind commit H.
>
> The following is a trial patch to change how a stash is recorded.
> With this patch I do not think we will keep unnecessary commits
> behind H in the repository even when a stash is kept forever.

Keeping stashes indefinitely is a relatively easy change (even though
there may need design discussions on the cleanest way to do so) but nobody
so far seemed to have thought about the ramifications of doing so.  I am
glad somebody is thinking one step ahead, and I think what you raised is a
valid concern.  Crufts from rebases will usually be purged from repository
thanks to reflog autoexpiration, but if somebody keeps a stash that was
made on a commit that has long been rebased away, it will keep the rebased
commits pinned to the repository, and we are talking about indefinite
retention here.  People should get worried.

I suspect this won't be a huge issue, but the only reason behind that
suspicion is because I expect people won't have insane number of rebases
nor keep insane number of stash entries, so the extra cruft that is kept
behind the stash entries won't be insanely large.  But people are known to
be insane enough to break my expectations, so I'd say we should make
things safer before we make the change to keep stashes forever by default.

I think the steps from here on would be:

 - Apply the patch in your message I am responding to, so that a stash
   that is kept forever will not pin the unnecessary history behind it in
   the repository.  As you said there is no reason to make the base commit
   (H) actually the same as the commit in the true history --- the only
   thing we care about it is its tree object;

 - Design and decide the way to tell git to make stash entries unexpirable
   (or maybe have very long expiration period).  I am leaning toward a
   configuration option that lets you specify expiration period per ref,
   rather than marking individual reflog entries as I suggested earlier;

 - Make the default for new repositories' stash reflog expiry period
   "never", by setting the above configuration upon "git init".

None of the above should obviously be in 1.5.6, but I think even the third
step to the change the default would be acceptable in the next 1.6.0
release.
