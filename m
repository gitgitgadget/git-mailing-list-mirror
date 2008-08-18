From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Call Me Gitless
Date: Mon, 18 Aug 2008 13:20:55 -0700
Message-ID: <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Trans <transfire@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Aug 18 22:22:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVBEz-0006CI-BI
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 22:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610AbYHRUVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 16:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754888AbYHRUVI
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 16:21:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61653 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605AbYHRUVF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 16:21:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 171D3511A1;
	Mon, 18 Aug 2008 16:21:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0126C511A0; Mon, 18 Aug 2008 16:20:56 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2DEF30A8-6D63-11DD-9212-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92737>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Sun, 17 Aug 2008, Trans wrote:
>
>> Well, after a few days of using git, I've decide Linus is too smart to
>> be designing end-user interfaces.
>
> This is true, but hardly relevant. Git's end-user interface was almost 
> entirely designed by other people, using Linus's excellent 
> script-developer API.

I'd agree that you cannot judge Linus's ability to design end-user
interfaces by observing the UI of git.

I am pleased to see that almost everybody who responded in this thread has
refrained from saying meaningless things (aka feeding the troll) to waste
people's mental bandwidth.

I think there are three majorly different reasons that new people can get
confused.

(1) Some concepts in git are different from what people from other systems
    are used to.  For example, A new person may be puzzled by the
    distinction among "git diff", "git diff HEAD" and "git diff --cached"
    and say "why do you have these three?"

    Complaining that we have these three instead of two, claiming that
    such complexity is a source of UI clunkiness, is an invalid argument
    made by a new person who does not understand the index.  People who do
    take advantage of the index need the distinction among these three.
    We shouldn't be doing anything but educate them against that kind of
    complaints.

    However, I think it is valid to say, for a person who does not use
    index very actively (i.e. one who does not incrementally stage), what
    "git diff" does is confusing.  It does not say anything about new
    files (until it is modified since added) while showing changes for
    existing files.  CVS does the same thing ("file foo is a newly added
    file, no comparison available"), but that may not be a good excuse.

    If we had a configuration for "index-free" people, that changes the
    semantics of "git add" to register object name of an empty blob when a
    new path is added, makes "git add" for existing blobs a no-op, but
    keeps "git commit -a" and "git commit <paths>" to operate as they
    currently do, then people with such configuration could:

	$ >new-file
        $ git add new-file
        $ edit old-file
        $ edit new-file
        $ git diff

    to always see what's the difference from the HEAD is with "git diff",
    and any of these three:

	$ git commit -a
        $ git commit old-file
        $ git commit old-file new-file

    would work as expected by them.  We still need to support the three
    diff variants for normal git people, but people who do not use index
    do not have to know the two variants ("git diff" vs "git diff HEAD");
    such a change could be argued as a "UI improvement" [*1*].

(2) Some concepts in git are different from what they are used to, without
    any good reason.  IOW, the concepts have room for improvement, and our
    UI is based on these faulty concepts.

(3) Some concepts in git may be exactly the same with other systems, yet
    our UI may operate differently from them without any good reason.

I'd be surprised if there is _no_ UI element that falls into the latter
two categories, but obviously I would not be able to list examples.  If I
could, they instead would have long been fixed already.


[Footnote]

*1* I need to stress that this is just an example for example's sake.  I
personally do not think such an index-free "training wheel" configuration
is a good idea.
