From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 09/16] documentation: add documentation for the bitmap format
Date: Tue, 25 Jun 2013 08:58:54 -0700
Message-ID: <87y59xlvt7.fsf@linux-k42r.v.cablecom.net>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
	<1372116193-32762-10-git-send-email-tanoku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 23:33:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uras1-000522-6u
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 23:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817Ab3FYVdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 17:33:45 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:54794 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490Ab3FYVdo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 17:33:44 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 25 Jun
 2013 23:33:40 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.210.110) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 25 Jun 2013 23:33:42 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.210.110]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228997>

Vicent Marti <tanoku@gmail.com> writes:

> This is the technical documentation and design rationale for the new
> Bitmap v2 on-disk format.

Hrmpf, that's what I get for reading the series in order...

> +			The folowing flags are supported:
                              ^^

typos marked by ^

> +		By storing all the hashes in a cache together with the bitmapsin
                                                                             ^^

> +		The obvious consequence is that the XOR of all 4 bitmaps will result
> +		in a full set (all bits sets), and the AND of all 4 bitmaps will
                                           ^

> +		- 1-byte XOR-offset
> +			The xor offset used to compress this bitmap. For an entry
> +			in position `x`, a XOR offset of `y` means that the actual
> +			bitmap representing for this commit is composed by XORing the
> +			bitmap for this entry with the bitmap in entry `x-y` (i.e.
> +			the bitmap `y` entries before this one).
> +
> +			Note that this compression can be recursive. In order to
> +			XOR this entry with a previous one, the previous entry needs
> +			to be decompressed first, and so on.
> +
> +			The hard-limit for this offset is 160 (an entry can only be
> +			xor'ed against one of the 160 entries preceding it). This
> +			number is always positivea, and hence entries are always xor'ed
                                                 ^

> +			with **previous** bitmaps, not bitmaps that will come afterwards
> +			in the index.

Clever.  Why 160 though?

> +		- 2 bytes of RESERVED data (used right now for better packing).

What do they mean?

> +  With an index at the end of the file, we can load only this index in memory,
> +  allowing for very efficient access to all the available bitmaps lazily (we
> +  have their offsets in the mmaped file).

Is there anything preventing you from mmap()ing the index also?

> +== Appendix A: Serialization format for an EWAH bitmap
> +
> +Ewah bitmaps are serialized in the protocol as the JAVAEWAH
> +library, making them backwards compatible with the JGit
> +implementation:
> +
> +	- 4-byte number of bits of the resulting UNCOMPRESSED bitmap
> +
> +	- 4-byte number of words of the COMPRESSED bitmap, when stored
> +
> +	- N x 8-byte words, as specified by the previous field
> +
> +		This is the actual content of the compressed bitmap.
> +
> +	- 4-byte position of the current RLW for the compressed
> +		bitmap
> +
> +Note that the byte order for this serialization is not defined by
> +default. The byte order for all the content in a serialized EWAH
> +bitmap can be known by the byte order flags in the header of the
> +bitmap index file.

Please document the RLW format here.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
