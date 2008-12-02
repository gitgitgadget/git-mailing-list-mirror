From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: Re: [RFC PATCH 0/4] deny push to current branch of non-bare repo
Date: Mon, 1 Dec 2008 21:22:43 -0500
Message-ID: <ee2a733e0812011822r4cef6a44ra68d6e84f9e30a90@mail.gmail.com>
References: <20081107220730.GA15942@coredump.intra.peff.net>
	 <7v3ai3f7oa.fsf@gitster.siamese.dyndns.org>
	 <20081108142756.GC17100@coredump.intra.peff.net>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Sam Vilain" <sam@vilain.net>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 03:24:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Kvj-000381-8x
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 03:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbYLBCWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 21:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbYLBCWq
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 21:22:46 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:28162 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbYLBCWp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 21:22:45 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1985351fgg.17
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 18:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=E0ij9bvQ5tHIERoKkUgi5arV3MZ173CjmOqsnPN+fy8=;
        b=lv4F4Saxmk8TgFnoIJSNcoD5C+WCjDg9awup3JtB5dSuZUkozUnJg36k/AXEGfYNLm
         +w/tpdEc+Zx6+NgLRgUuAJEnULv8xyjLDPMLinDeylzi1YyQgxVY9BfIVOdzfO0w91j3
         43BxW9EVZ1/VnYgum3CcqXeCwmCImGIP/TKQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=CzZs8WRk10OE7NRC33T9h6LnFphKqN9L/aFyPVTPsLK6mP1gu9ZLtp0ZYEkLmK9tIC
         FnXma9tH7iRO1RzG4RWZLAkeV3gq0Qd6gWLiiYCF1dseXdJXJGtGd/hwrfQ0hKkeSCnM
         4+C+VJvL7ASwo1DWAUv9JaHZtctvRldjNh/7Q=
Received: by 10.181.148.2 with SMTP id a2mr4126476bko.117.1228184563207;
        Mon, 01 Dec 2008 18:22:43 -0800 (PST)
Received: by 10.181.7.8 with HTTP; Mon, 1 Dec 2008 18:22:43 -0800 (PST)
In-Reply-To: <20081108142756.GC17100@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102104>

On 11/8/08, Jeff King <peff@peff.net> wrote:
> On Fri, Nov 07, 2008 at 03:16:53PM -0800, Junio C Hamano wrote:
>
>  > > The FAQ even says "don't do this until you know what you are doing." So
>  > > the safety valve is configurable, so that those who know what they are
>  > > doing can switch it off.
>  >
>  > "We are breaking your existing working setup but you can add a new
>  > configuration to unbreak it" should not be done lightly.  I think as the
>  > end result it is a reasonable thing to aim for for this particular
>  > feature, but we do need a transition plan patch in between that introduces
>  > a step that warns but not forbids.  We can ship 1.6.1 with it and then
>  > switch the default to forbid in 1.6.3, for example.
>
>
> Yeah, I was kind of hoping we could assume that anybody relying on this
>  behavior was somewhat insane, and wouldn't be too upset when it broke.

I do not think that having a work-flow different from yours deserves a
"somewhat insane" label. But let us consider the consequences of
banning push into a (current branch) non-bare repo. To propagate
changes to such a non-bare repo there are two remaining alternatives
neither of which is fully satisfactory:

(1) Switch target's current branch to something else (prevent a
conflict) before pushing and then restore it back after the push

(2) Use git-fetch from the target.

Method (1) is no better than what is available today with "git reset
--hard" to sync working directory.
Method (2) is even worse, because git-fetch provides no control of
what branches/tags to fetch, it sucks everything in from all branches.
"git-push", OTOH, can be instructed to be very selective.

Here is an example of such a work-flow

Foo.git -- main bare repo of the project
Foo.wip -- everyday "work in progress" repo. Cloned from Foo.git.
Pushes to Foo.git
Foo.wip.insane -- experimental "crazy" stuff cloned from Foo.wip.
Pushed to Foo.wip

Proposed patch makes this work flow impossible (cannot push from
Foo.wip.insane to Foo.wip)

--Leo--
