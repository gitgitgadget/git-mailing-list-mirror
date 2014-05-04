From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC PATCH 0/9] Use a structure for object IDs.
Date: Sun, 04 May 2014 08:35:00 +0200
Message-ID: <5365DF94.9060707@alum.mit.edu>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 08:35:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wgq13-00025F-Bl
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 08:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525AbaEDGfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 02:35:05 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:49010 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753498AbaEDGfE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 May 2014 02:35:04 -0400
X-AuditID: 12074414-f79d96d000002d2b-b0-5365df965cee
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id CC.2F.11563.69FD5635; Sun,  4 May 2014 02:35:02 -0400 (EDT)
Received: from [192.168.69.130] (p4FC963E8.dip0.t-ipconnect.de [79.201.99.232])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s446Z0Ob021493
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 4 May 2014 02:35:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsUixO6iqDvtfmqwwYYHphZdV7qZLNpm/mBy
	YPJYfvMvk8fnTXIBTFHcNkmJJWXBmel5+nYJ3Bm7T8xmLbguVXF0y2TGBsY1ol2MnBwSAiYS
	bVeb2CBsMYkL99YD2VwcQgKXGSUeTNrCDuGcY5K4f+8HE0gVr4C2xM7171lAbBYBVYl3Hyaz
	g9hsAroSi3qagWo4OEQFgiT+nFWEKBeUODnzCVi5iICXxPxHM1hBbGEBG4lrkxczgthCAr4S
	D/uugo3nFPCTmPdkBQvIGAkBcYmexiCQMLOAjsS7vgfMELa8xPa3c5gnMArMQrJhFpKyWUjK
	FjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3StdDLzSzRS00p3cQICVORHYxHTsodYhTgYFTi
	4T1xKzlYiDWxrLgy9xCjJAeTkihvx87UYCG+pPyUyozE4oz4otKc1OJDjBIczEoivNf3AOV4
	UxIrq1KL8mFS0hwsSuK83xar+wkJpCeWpGanphakFsFkZTg4lCR4N90DahQsSk1PrUjLzClB
	SDNxcIIM55ISKU7NS0ktSiwtyYgHxWl8MTBSQVI8QHt3g7TzFhck5gJFIVpPMepyXGhY0cIk
	xJKXn5cqJc5rAlIkAFKUUZoHtwKWlF4xigN9LMzbD1LFA0xocJNeAS1hAloi7pgMsqQkESEl
	1cDo6lKz+cL/bftX/4hwVqhern7gMQPn5rKPB+/lqrmyC8m4zt/jcUb3L5PwjJszv3pqcaxb
	Xv+r7JBB4doPe35zfw6eeeWB8EKtQjWV46/9t+3Iutclvf8CX8XGA6+PzWo/yKxs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248079>

On 05/03/2014 10:12 PM, brian m. carlson wrote:
> This is a preliminary RFC patch series to move all the relevant uses of
> unsigned char [20] to struct object_id.  It should not be applied to any
> branch yet.
> 
> The goal of this series to improve type-checking in the codebase and to
> make it easier to move to a different hash function if the project
> decides to do that.  This series does not convert all of the codebase,
> but only parts.  I'm looking for feedback to see if there is consensus
> that this is the right direction before investing a large amount of
> time.
> 
> Certain parts of the code have to be converted before others to keep the
> patch sizes small, maintainable, and bisectable, so functions and
> structures that are used across the codebase (e.g. hashcmp and struct
> object) will be converted later.  Conversion has been done in a roughly
> alphabetical order by name of file.
> 
> The constants for raw and hex sizes of SHA-1 values are maintained.
> These constants are used where the quantity is the size of an SHA-1
> value, and sizeof(struct object_id) is used wherever memory is to be
> allocated.  This is done to permit the struct to turn into a union later
> if multiple hashes are supported.  I left the names at GIT_OID_RAWSZ and
> GIT_OID_HEXSZ because that's what libgit2 uses and what Junio seemed to
> prefer, but they can be changed later if there's a desire to do that.
> 
> I called the structure member "oid" because it was easily grepable and
> distinct from the rest of the codebase.  It, too, can be changed if we
> decide on a better name.  I specifically did not choose "sha1" since it
> looks weird to have "sha1->sha1" and I didn't want to rename lots of
> variables.

That means that we will have sha1->oid all over the place, right?
That's unfortunate, because it is exactly backwards from what we would
want in a hypothetical future where OIDs are not necessarily SHA-1s.  In
that future we would certainly have to support SHA-1s in parallel with
the new hash.  So (in that hypothetical future) we will probably want
these expressions to look like oid->sha1, to allow, say, a second struct
or union field oid->sha256 [1].

If that future would come to pass, then we would also want to have
distinct constants like GIT_SHA1_RAWSZ and GIT_SHA256_RAWSZ rather than
the generically-named GIT_OID_RAWSZ.

I think that this patch series will improve the code clarity and type
safety independent of thoughts about supporting different hash
algorithms, so I'm not objecting to your naming decision.  But *if* such
support is part of your long-term hope, then you might ease the future
transition by choosing different names now.

(Maybe renaming local variables "sha1 -> oid" might be a handy way of
making clear which code has been converted to the new style.)

Just to be clear, the above are just some random thoughts for your
consideration, but feel free to disregard them.

In any case, it sure will be a lot of code churn.  If you succeed in
this project, then "git blame" will probably consider you the author of
about 2/3 of git :-)

Michael

[1] I'm certainly not advocating that we want to support a different
hash, let alone that that hash should be SHA-256; these examples are
just for illustration.

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
