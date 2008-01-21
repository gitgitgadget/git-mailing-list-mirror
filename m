From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 11:41:08 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801211129130.2957@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
 <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org>
 <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095!
 @ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801! 210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 20:42:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH2Ww-0005OJ-HY
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 20:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbYAUTl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 14:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbYAUTl3
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 14:41:29 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45871 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750781AbYAUTl2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 14:41:28 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LJf8x4020526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2008 11:41:09 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LJf8dr016325;
	Mon, 21 Jan 2008 11:41:08 -0800
In-Reply-To: <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.124 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_19,J_CHICKENPOX_33
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71316>



On Mon, 21 Jan 2008, Kevin Ballard wrote:
> 
> I'm not saying it's forced on you, I'm saying when you treat filenames as
> text, it DOESN'T MATTER if the string gets normalized. As long as the string
> remains equivalent, YOU DON'T CARE about the underlying byte stream.

Sure I do, because it matters a lot for things like - wait for it - things 
like checksumming it.

> Alright, fine. I'm not saying HFS+ is right in storing the normalized version,
> but I do believe the authors of HFS+ must have had a reason to do that, and I
> also believe that it shouldn't make any difference to me since it remains
> equivalent.

I've already told you the reason: they did the mistake of wanting to be 
case-independent, and a (bad) case compare is easier in NFD.

Once you give strings semantic meaning (and "case independent" implies 
that semantic meaning), suddenly normalization looks like a good idea, and 
since you're going to corrupt the data *anyway*, who cares? You just 
created a file like "Hello", and readdir() returns "hello" (because there 
was an old file under that name), and it's a lot more obviously corrupt 
than just due to normalization.

> Sure it does. Normalizing a string produces an equivalent string, and so
> unless I look at the octets the two strings are, for all intents and purposes,
> the same.

.. but you *have* to look at the octets at some point. They're kind of 
what the string is built up of. They never went away, even if you chose to 
ignore them. The encoding is really quite important, and is visible both 
in memory and on disk.

It's what shows up when you sha1sum, but it's also as simple as what shows 
up when you do an "ls -l" and look at a file size.

It doesn't matter if the text is "equivalent", when you then see the 
differences in all these small details.

You can shut your eyes as much as you want, and say that you don't care, 
but the differences are real, and they are visible.

> Decomposing and recomposing shouldn't lose any information we care about -
> when treating filenames as text, a<COMBINING DIARESIS> and <A WITH DIARESIS>
> are equivalent, and thus no distinction is made between them. I'm not sure
> what other information you might be considering lost in this case.

You're right, I messed up. I used a non-combining diaeresis, and you're 
right, it doesn't get corrupted. And I think that means that if Apple had 
used NFC, we'd not have this problem with Latin1 systems (because then the 
UTF-8 representation would be the same).

So I still think that normalization is totally idiotic, but the thing that 
actually causes most problems for people on OS X is that they chose the 
really inconvenient one.

			Linus
