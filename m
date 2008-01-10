From: "Dana How" <danahow@gmail.com>
Subject: Re: Decompression speed: zip vs lzo
Date: Thu, 10 Jan 2008 11:34:52 -0800
Message-ID: <56b7f5510801101134l334c3eabu20513b7402cd2720@mail.gmail.com>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com>
	 <7v4pdmfw27.fsf@gitster.siamese.dyndns.org>
	 <47855765.9090001@vilain.net>
	 <alpine.LSU.1.00.0801092328580.31053@racer.site>
	 <alpine.LFD.1.00.0801092234130.3054@xanadu.home>
	 <e5bfff550801092255wc852252m9086567a88b1ae99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>, danahow@gmail.com
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 20:35:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD3BX-0006ZF-Qm
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 20:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbYAJTe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 14:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752935AbYAJTe6
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 14:34:58 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:3002 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbYAJTe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 14:34:57 -0500
Received: by fk-out-0910.google.com with SMTP id z23so597236fkz.5
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 11:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=adJXTOPSwRWLJsPhcxHfmXjsmBSuYuMUH8qLfYoX/mA=;
        b=PUtlImejodBpddBwv6BWQSwuuLf+ihpvBpzCccUKAtgPSyp9gyY+GkdKiNB8d97qZAhjeAgdvD5KBm+wLQJdYCae6uTD5BTTHw0g1UbQLi0xPWHZzsrFkfs2Sje47DYFEzbR6o30tCYgVHXYA7KtsNZwoA8dy6LaZBICLlHL4kY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YXvXBtbiwSuqMjeg8jdxAACL2UUkyQMS1NdPf0muRMfOMF2mG9NCG9fkJgql2sYN3ErVI7er0/HYNFGFDAxF1XAgezmav4hj+MTbGBR8UARvKJJjlFEGfk7WUIAGoUj7C+n5FU6RrdvX5ncJYRN+hs/yw5CdO+cJ4h34rvRMYDQ=
Received: by 10.78.200.3 with SMTP id x3mr2896415huf.0.1199993693033;
        Thu, 10 Jan 2008 11:34:53 -0800 (PST)
Received: by 10.78.106.8 with HTTP; Thu, 10 Jan 2008 11:34:52 -0800 (PST)
In-Reply-To: <e5bfff550801092255wc852252m9086567a88b1ae99@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70079>

On Jan 9, 2008 10:55 PM, Marco Costalba <mcostalba@gmail.com> wrote:
> On Jan 10, 2008 4:41 AM, Nicolas Pitre <nico@cam.org> wrote:
> > On Wed, 9 Jan 2008, Johannes Schindelin wrote:
> >
> > > I agree that gzip is already fast enough.
> > >
> > > However, pack v4 had more goodies than just being faster; it also promised
> > > to have smaller packs.
> >
> > Right, like not having to compress tree objects and half of commit
> > objects at all.
>
> Decompression speed has been shown to be a bottle neck on some tests
> involving mainly 'git log'.

Thanks for looking into this,  in this email and your subsequent ones.

I agree that zip time is an issue.  I was looking into reducing the _number_
of zip calls on the same data,  but work and personal crises have reduced
me from an infrequent contributor to an occasional gadfly for the moment.

> Regarding back compatibility I really don't know at what level git
> functions actually need to know the compression format, looking at the
> code I would say at very low level, functions that deal directly with
> inflate() and friends are few [1] and not directly connected to UI,
> nor to git config. Is this compression format something user should
> know/care? and if yes why?
>
> In my tests the assumption of a source files tar ball is unrealistic,
> to test the final size difference I would like testing different
> compressions on a big already packaged but still not zipped file.
> Someone could be so kind to hint me on how to create such a package
> with good quality, i.e. with packaging levels similar to what is done
> for public repos?
>
> This does not realistically tests speed because as Junio pointed out
> the real decompressing schema is different: many calls on small
> objects, not one call on a big one. But if final size is acceptable we
> can go on more difficult tests.

The approach you're taking (here and in following emails) of being
able to make zip/lzo selection and measure the results should be
enlightening.  For the vast majority of git users,  Junio's scenario
is the most relevant.

Of additional interest to me is handling enormous objects more quickly.
I would like to replace some p4 usage here with git,  but most users will
only notice the speed difference and not use git's extra features.  Thus
they will compare git add/git commit/git push unfavorably to p4 edit/p4 submit,
because the former effectively does zip/unzip/zip/send,  while the latter
only does zip/send (git's extra "unzip/zip" comes from loose objects not
being directly copyable into packs).  This speed difference is irrelevant
for small to normal files,  but a killer when commiting a collection of say
100MB files.

Your lzo option could reduce this performance degradation vs p4 from
3x to close to 1.5x.  If you get it accepted,  I'd love to then "fix" the loose
object copying "problem" making git _faster_ than p4 on large files!
2 simple forms for this "fix" would be to use the once-and-future "new"
loose object format (an idea already rejected),  or to encode all loose
objects as singleton packs under .git/objects/xx (so that all (re)packing,
in the absence of new deltification,  becomes pack-to-pack copying).
This latter idea is a modification of an idea from Nicolas Pitre.
It certainly adds less code than other approaches for such a "fix".

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
