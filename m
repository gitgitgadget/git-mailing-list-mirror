From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: pack operation is thrashing my server
Date: Wed, 13 Aug 2008 16:26:48 +0100
Message-ID: <e1dab3980808130826m4870df3ctf09ecf0062ef6e7c@mail.gmail.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
	 <20080811030444.GC27195@spearce.org>
	 <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
	 <87vdy71i6w.fsf@basil.nowhere.org>
	 <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
	 <20080813031503.GC5855@spearce.org>
	 <70550C21-8358-4BEF-A7BA-3A41C1ACB346@adacore.com>
	 <alpine.LFD.1.10.0808131036590.4352@xanadu.home>
	 <m363q5t152.fsf@localhost.localdomain>
	 <20080813150425.GC3782@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Nicolas Pitre" <nico@cam.org>, "Geert Bosch" <bosch@adacore.com>,
	"Andi Kleen" <andi@firstfloor.org>, "Ken Pratt" <ken@kenpratt.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 17:28:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTIGQ-0002Tl-J9
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 17:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517AbYHMP0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 11:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753395AbYHMP0u
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 11:26:50 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:50116 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387AbYHMP0t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 11:26:49 -0400
Received: by wf-out-1314.google.com with SMTP id 27so42720wfd.4
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 08:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ywZ653RsI4BBT24M/Rbz2pc1iioZtGM3f26X+syuVfE=;
        b=pGj9FbgkM7ZpLPKPII6XlIkDS0+gRMwv74hn1VM4IHB0VWuUubc+jD1Ds++Czl2H5U
         SgLjMs3XC/lOPpuInJq9GG29xSqFOCLAz0OZb0Lcr2ey1cznM97/VbxD1hNseFdDlLd1
         HI/d8+20reKbJj5xsj+fepZVMKJU6fQwkMsME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=B9HvoYz164GjituXvxJ6v/ogQRld8CWzOKM4yz5hBKVCagAYfIr9YDM4ceSbTQnKLx
         GLhuQGP1RO4HjOg8Tbx6X7NuOpS1tCmR9/Ffr7ShEkqQ/6greKWrIoiu6tnE7BR/ZHWz
         FMSAxYsNnTm4q7/aY1RHGmdtNhQuHDGgkLFOo=
Received: by 10.142.171.6 with SMTP id t6mr3362441wfe.229.1218641208499;
        Wed, 13 Aug 2008 08:26:48 -0700 (PDT)
Received: by 10.142.233.14 with HTTP; Wed, 13 Aug 2008 08:26:48 -0700 (PDT)
In-Reply-To: <20080813150425.GC3782@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92230>

On Wed, Aug 13, 2008 at 4:04 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>> Nicolas Pitre <nico@cam.org> writes:
>> > On Tue, 12 Aug 2008, Geert Bosch wrote:
>> >
>> > > One nice optimization we could do for those pesky binary large objects
>> > > (like PDF, JPG and GZIP-ed data), is to detect such files and revert
>> > > to compression level 0. This should be especially beneficial
>> > > since already compressed data takes most time to compress again.
>> >
>> > That would be a good thing indeed.
>>
>> Perhaps take a sample of some given size and calculate entropy in it?
>> Or just simply add gitattribute for per file compression ratio...
>
> Estimating the entropy would make it "just magic".  Most of Git is
> "just magic" so that's a good direction to take.  I'm not familiar
> enough with the PDF/JPG/GZIP/ZIP stream formats to know what the
> first 4-8k looks like to know if it would give a good indication
> of being already compressed.
>
> Though I'd imagine looking at the first 4k should be sufficient
> for any compressed file.  Having a header composed of 4k of _text_
> before binary compressed data would be nuts.  Or a git-bundle with
> a large refs listing.  ;-)

FWIW, PDF format is a mix of sections of uncompressed higher level
ASCII notation and sections of compressed actual glyph/location data
for individual pages, and I don't think the rules are very strict
about what goes where. Looking at some academic papers some contain
compressed data within the first hundred characters whilst I've got a
couple with the first compressed byte 1968 and 12304; I'm sure if I
had a longer pdf to look at I'd find one where compression data first
occurred even later. I leave discussions of whether this is nuts to
others ;-) .

JPG is pretty much guaranteed to contain compressed data after a
couple of metadata lines.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
