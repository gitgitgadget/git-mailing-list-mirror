From: "Andrew Arnott" <andrewarnott@gmail.com>
Subject: Re: Intensive rename detection
Date: Mon, 3 Nov 2008 21:19:30 -0800
Message-ID: <216e54900811032119h4cb51327v2d85712acc444185@mail.gmail.com>
References: <216e54900811031717j70669868p3c7503357ceb5138@mail.gmail.com>
	 <216e54900811031718o4cc81294sc0c32be1e71b9372@mail.gmail.com>
	 <alpine.LFD.2.00.0811032021210.3419@nehalem.linux-foundation.org>
	 <216e54900811032107p159e98ecn8958f0a78efde8f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 06:20:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxELO-0002Cs-6M
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 06:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbYKDFTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 00:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbYKDFTc
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 00:19:32 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:24657 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbYKDFTc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 00:19:32 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1117340ywe.1
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 21:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1KjO8RZn1YUB3tN5A5OTBuo9q8jVtpQrSyFYY2hH7mA=;
        b=YzjyrL1Y8NxLKvlMNYkmjq6mzU1UyY1KLi0S7/Sy1BtUiqad8h1lLaSghYsnNxMXaP
         z891JY0Ycwpvy7XrFnWJcKau6JpDF94f3pAMvBjUMZb4FOtC/P0WV1VPjoT4iH/wJdYi
         wqi9axxiCuRHprMqsXCrY2h2WqLQnchLokr64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=sFIaPiS92FvcjwBdrdNkBlu+h/aJzHm5DxMPTkc0cR0HVlO7JwEfThJVoHIgRyteji
         YzLLJ9m6E9GtxWy7NrgiFGcVExaMzQV/SI/0OBwSInPqhU3nzWzok+TXfujBhDfm+Wjm
         kLSpFDN9J9Hl4UDIykasWD49QSHA6bkcpN5ro=
Received: by 10.151.148.2 with SMTP id a2mr1733671ybo.56.1225775970529;
        Mon, 03 Nov 2008 21:19:30 -0800 (PST)
Received: by 10.151.142.12 with HTTP; Mon, 3 Nov 2008 21:19:30 -0800 (PST)
In-Reply-To: <216e54900811032107p159e98ecn8958f0a78efde8f2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100038>

Awesome.  Per Linus' tip, I just noticed at the top of a long list of
messages git said:
warning: too many files, skipping inexact rename detection

So I added the config file change, and that did the trick.  Thanks, everyone!

Here's a related but slightly different question: I've been stashing
and unstashing in the midst of all these renames and refactoring, and
now I'm left with some files listed in git status 3 times.  I
understand why this is, but I don't know the best way to proceed.  Git
is telling me:

$ git status | grep MessageBase
src/DotNetOAuth/Messages/MessageBase.cs: needs merge
src/DotNetOAuth/OAuth/Messages/MessageBase.cs: needs merge
src/DotNetOpenAuth/Messages/MessageBase.cs: needs merge
#       unmerged:   src/DotNetOAuth/Messages/MessageBase.cs
#       unmerged:   src/DotNetOAuth/OAuth/Messages/MessageBase.cs
#       unmerged:   src/DotNetOpenAuth/Messages/MessageBase.cs

I want to end up with MessageBase.cs in
src/DotNetOpenAuth/OAuth/Messages/MessageBase.cs, which ironically is
none of these three.  And the couple of lines that changed in the file
need to be merged.  Only two of these listed files exist on disk.  How
can I best leverage git to merge the two files on disk while moving it
to a new location?

> On Mon, Nov 3, 2008 at 8:22 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>>
>> On Mon, 3 Nov 2008, Andrew Arnott wrote:
>> >
>> > I'm refactoring a library including renaming both files and
>> > directories.  A few lines of each file are also changed, but they are
>> > substantially unchanged in content.  I've done a git add to put all my
>> > changes into the index, but a git status shows that git only detected
>> > a few of the renames... most of them are delete-add operations.  Is
>> > there anything I can do to help git recognize the rename so that
>> > history is preserved across this commit?
>>
>> How many renames do you have? Modern versions of git will do any number of
>> exact renames, but the (rather expensive) inexact rename detection has a
>> default limit of something fairly small.
>>
>> You could try adding
>>
>>        [diff]
>>                renamelimit=0
>>
>> to your ~/.gitconfig file. It can be quite expensive though.
>>
>>                        Linus
>
