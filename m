From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Thu, 24 May 2012 06:54:07 +0200
Message-ID: <4FBDBEEF.4030500@alum.mit.edu>
References: <4FB9F92D.8000305@alum.mit.edu> <20120521174525.GA22643@sigill.intra.peff.net> <CACsJy8Dw+mbP+ttTP6gAfX9o4q4NyZgPYpbhS=tket=5fvBXwg@mail.gmail.com> <20120522170101.GA11600@sigill.intra.peff.net> <7vaa105dah.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 24 06:54:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXQ47-0002bp-P7
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 06:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362Ab2EXEyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 00:54:12 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:56794 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750944Ab2EXEyK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 00:54:10 -0400
X-AuditID: 1207440f-b7fe16d000000920-5d-4fbdbef1262e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 24.87.02336.1FEBDBF4; Thu, 24 May 2012 00:54:09 -0400 (EDT)
Received: from [192.168.69.140] (p4FC0D6A9.dip.t-dialin.net [79.192.214.169])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4O4s7UC004023
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 24 May 2012 00:54:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <7vaa105dah.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqPtx315/g4ZlZhZdV7qZLBp6rzBb
	dE95y2jxo6WH2YHFY+esu+wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xoJHHxgL
	ngtWfN61iamBcR1fFyMnh4SAicSDV4vYIWwxiQv31rN1MXJxCAlcZpSY+XAFE4Rzlkli0ZVV
	LCBVvALaEmdO/WMFsVkEVCUmX13OBGKzCehKLOppBrI5OEQFwiRWP9CAKBeUODnzCViriICa
	xMS2QywgJcwC1RITOzJBwsICThIrfkxlhVj1g1GibeFkNpAEp4CZxLetl6HqrSW+7S4CCTML
	yEtsfzuHeQKjwCwkG2YhVM1CUrWAkXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6JXm5miV5q
	SukmRkgo8+9g7Fovc4hRgINRiYe3S2CvvxBrYllxZe4hRkkOJiVR3lu7gUJ8SfkplRmJxRnx
	RaU5qcWHGCU4mJVEeL2KgXK8KYmVValF+TApaQ4WJXFe9SXqfkIC6YklqdmpqQWpRTBZGQ4O
	JQne/3uBGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBURpfDIxTkBQP0F6ffSB7
	iwsSc4GiEK2nGHU5rvyeeJ1RiCUvPy9VSpxXCKRIAKQoozQPbgUscb1iFAf6WJhXHaSKB5j0
	4Ca9AlrCBLQk6MVOkCUliQgpqQbGFqbZy+4tKHmxVavqccq518zOJc9+hTdqqf+Z/z7Lwjk/
	VPFT/UVz+w87Fp2LE+b+Xr4wwClN4Mbv4haedUEpP6dYv++Y3r7V39bOsVpUR4LN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198349>

On 05/22/2012 07:35 PM, Junio C Hamano wrote:
> The current code reads the whole thing in upon first use of _any_ element
> in the file, just like the index codepath does for the index file.
>
> But the calling pattern to the refs machinery is fairly well isolated and
> all happens in refs.c file.  Especially thanks to the recent work by
> Michael Haggerty, for "I am about to create a new branch 'frotz'; do I
> have 'refs/heads/frotz' or anything that begins with 'refs/heads/frotz/'?"
> kind of callers, it is reasonably easy to design a better structured
> packed-refs file format to allow us to read only a subtree portion of
> refs/ hierarchy, and plug that logic into the lazy ref population code.
> Such a "design a better packed-refs format for scalability to 400k refs"
> is a very well isolated project that has high chance of succeeding without
> breaking things.  No code outside refs.c assumes that there is a flat
> array of refs that records what was read from the packed-refs file and can
> walk linearly over it, unlike the in-core index.

Even with the current file format, it would not be so difficult to 
bisect the file, synchronizing on record boundaries by looking for the 
next NL character.  Because of the way the file is sorted, it would also 
be reasonably efficient to read whole subtrees in one slurp (e.g., for 
for_each_ref() with a prefix argument).  Nontrivial modifications would 
of course not be possible without a rewrite.

There would need to be some intelligence built-in; after enough 
single-reference accesses come in a row, then the refs module should 
probably take it upon itself to read the whole packed-refs file to speed 
up further lookups.

> If you do "for_each_ref()" for everything (e.g. sending 'have' during the
> object transfer, or repacking the whole repository), you would end up
> needing to read the whole thing for obvious reasons.

Yes.  ISTM that any hope to avoid O(number of refs) problems when 
exchanging commits must involve using more intelligence about how 
references are related to each other topologically to improve the 
negotiation about what needs to be transferred.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
