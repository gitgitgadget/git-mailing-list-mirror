From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Plumbing-only support for storing object metadata
Date: Sun, 17 Aug 2008 23:12:36 -0700
Message-ID: <20080818061236.GF7376@spearce.org>
References: <20080809210733.GA6637@oh.minilop.net> <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com> <20080810035101.GA22664@spearce.org> <20080810112038.GB30892@cuci.nl> <20080809210733.GA6637@oh.minilop.net> <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com> <20080810035101.GA22664@spearce.org> <20080809210733.GA6637@oh.minilop.net> <20080810110925.GB3955@efreet.light.src> <20080816062130.GA4554@oh.minilop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Hudec <bulb@ucw.cz>, "Stephen R. van den Berg" <srb@cuci.nl>,
	Junio C Hamano <gitster@pobox.com>, david@lang.hm,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>,
	Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Mon Aug 18 08:13:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUxzo-0002sI-6W
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 08:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbYHRGMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 02:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbYHRGMh
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 02:12:37 -0400
Received: from george.spearce.org ([209.20.77.23]:51684 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbYHRGMg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 02:12:36 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0DE0238375; Mon, 18 Aug 2008 06:12:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080816062130.GA4554@oh.minilop.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92686>

Josh Triplett <josh@freedesktop.org>, Jamey Sharp <jamey@minilop.net> wrote:
> On Sat, Aug 09, 2008 at 08:51:01PM -0700, Shawn O. Pearce wrote:
> > Nico and I have (at least in the past) agreed that type 0 is meant
> > as an escape indicator.  If the type is set to 0 then the real type
> > code appears in another byte of data which follows the object's
> > inflated length.
> >
> > That leaves only type 5 available.
> [...]
> > So yea, there really aren't any new type bits available.
> 
> If consensus opinion was that new object types were a reasonable way to
> solve this problem, then it sounds as if there's plenty of room to
> create new types using this escape mechanism.

Yes, but we'd hate to see the majority of the encodings within a
pack using the escape mechanism.

So a lot of my argument here was just trying to point out that
type bits aren't free, and we need to make sure the limited ones
available are applied to the majority of the pack contents.

Adding a new type bit is a lot more than just adding it to the pack
data field.  Look at the amount of code that needed to be changed to
support gitlink in trees, and that was "reusing" the OBJ_COMMIT type.
Anytime you start poking at the core object enumeration code with
new cases there's a lot of corners that are affected.

-- 
Shawn.
