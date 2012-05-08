From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Index format v5
Date: Tue, 8 May 2012 16:11:37 +0200
Message-ID: <20120508141137.GA3937@tgummerer.surfnet.iacbox>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
 <4FA7E703.7040408@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	peff@peff.net, spearce@spearce.org, davidbarr@google.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 08 16:11:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRl8r-0008V6-G4
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 16:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755420Ab2EHOLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 10:11:49 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64454 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582Ab2EHOLs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 10:11:48 -0400
Received: by obbtb18 with SMTP id tb18so9828698obb.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VXtUwKBgK7SRLUfuMUBcFKUNG9MA7L/UDfWcVm8K1Sg=;
        b=lBL1fy5n/3ClAPI+BIm9n+ZwgN4DN84LDkM0pRSiskkJsieG+PY5Mr9jV39Bd+o9m3
         fRmWqmXlyo2cg1eINvWUYHF/UFiaMhdhFQeEfVJUDA9ovnp/9HPN8jrFjX2BEO1jn3m+
         QAtgozmQ7/mP1bmdjDvbu63vmSS8qAe/H8i8dIG7XuBMiU1nOlswDnLXs4U8IgmWiXcf
         B0YxeqMCru4qCiB2OSQpiy9krwRMzydPPnTafFUs+O4wpQgXMACCZDGnAmXK+sDLDiGa
         DtWRqAm3DLw9yfwD1+XehwxNlXYnDhwKG2nwcPP4ZJ1oV1/eu6YvnGVdn927p08JpIe8
         OueQ==
Received: by 10.182.85.39 with SMTP id e7mr27106179obz.51.1336486306960;
        Tue, 08 May 2012 07:11:46 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPS id m3sm17424910oem.7.2012.05.08.07.11.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 May 2012 07:11:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FA7E703.7040408@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197368>



On 05/07, Michael Haggerty wrote:
> Here are some comments about the format document, version 55047b3d.
> They probably overlap with other feedback that you have gotten, but
> I don't have time to cross-correlate everything.  Hope it helps.

Thanks for the feedback!

For those who may not know yet, I've created a wiki on github, since
this file is going through a lot of revisions, it may not be a good
idea to post every revision on the mailing list.
https://github.com/tgummerer/git/wiki/Index-format-v5

> Overall
> =======
> 
> I find the format definition pretty difficult to read.  The following
> suggestions might make it easier to follow.

Thanks, I've incorporated your feedback. I hope it's easier readable now.

> [...] 
> * You seem to switch randomly between counting sizes in bits vs bytes.
>   Please try to be more consistent.  BTW, I think the size of an SHA1
>   object name is more commonly described as "20 bytes" rather than
>   "160 bits".

All sizes are now in bits. I have taken the 160 bits for the SHA1 from
the old index documentation in Documentation/technical. I chose to
leave it as 160bits for now, as all the other sizes were changed to
bits too.

> * The details of the extension data blocks are described in the first
>   (overview) section, whereas it seems like they should be described
>   in their own section following the "conflict data" section.  But
>   wouldn't the presence of extension data blocks prevent the addition
>   of conflict data?

Only the details that should be there for every extension are described
in the overview (the header of the extension), to make sure every
extension has the same header format, and thus a reader which doesn't
understand a specific extension still can read its header and know 
what's going on.

They won't prevent the addition of conflicted data, since when a
conflict is created, other files were probably added and the index has
to be rewritten anyway. Once the conflict is resolved however only a
bit has to be flipped, so there is no rewrite necessary.

> * Are there situations (for example during conflicts?) when it is
>   allowed to have directory and file entries with the same name?

Yes, that's why I have added the stage data to the directory.

> * Does the index file include directory entries for empty directories?
>   What about directories that contain only other directories?

In theory the index is able to include empty directories. I'm however
not sure if this should be implemented. I'd be happy to get more
feedback there.

> Overview
> ========
> 
> * Does "32-bit size of the extension" include the whole extension data
>   block (including header) or only the "extension data"?

It includes only the extension data. It's clarified in the documentation
now.

> Directory entry
> ===============
> 
> * "4-byte number of entries in the index that is covered by the tree
>   this entry represents."  What does this include?
>   Files/directories/both?  Recursive or non-recursive?

This is from the cache-tree. I'm not sure but I think it includes both
files and directories, recursively.

> * "160-bit object name for the object that would result from writing
>   this span of index as a tree."  Is this always valid?

No, this is only valid if the entry count is not -1. It's clarified
now.

> * It might be convenient to store directory names with trailing '/'
>   characters (except for the top-level directory, which can be stored
>   as "").  That way (1) it is trivial to concatenate the directory
>   name and the filename to produce the file path; (2) directories and
>   files can be distinguished by name and therefore intermingled in
>   lists; (3) such lists can be sorted using strcmp() without having to
>   simulate an invisible '/' character.

Good point. Changed this in the documentation.

> File entry
> ==========
> 
> * I believe that only the basename is stored, not the whole path.  But
>   then why is the encoding for '/' specified (there should be no '/'
>   characters)?
>
> * Why is the encoding of '.' specified?  Is it somehow significant for
>   the index file format?

Yes, you are right, only the basename is stored. '.' and '/' don't need
a specific encoding, it's removed from the documentation.

> * Are file entries sorted by entire path or only by the basename?

They are sorted by the basename, in the respective block of their
directories.
Example: paths: a/a a/z b/b
File entries in the index:
a ...
z ...
b ...

> Flat loading
> ============
> 
> * I found the explanation pretty incomprehensible.  Perhaps some
>   pseudo-code would make it clearer?
> 
> * Since I can't understand the explanation, I'm not sure if this
>   comment makes any sense.  But when traversing into a subdirectory,
>   don't *all* of the remaining files from the parent directory need to
>   be tucked away somewhere?
> 
> * At an even higher level of abstraction, your directory entry
>   contains a count "number of entries in the index that is covered by
>   the tree this entry represents".  If this count is recursive, then
>   it seems like it would be enough to know how many entries will come
>   from traversing a whole subdirectory tree.  So it should be possible
>   to skip that many entries in the in-memory array and continue
>   reading the file entries for the parent subdirectory.  For example,
>   suppose our files are [A, B/1, B/2/a, B/2/b, B/3, C].  If I start by
>   reading the files in the root directory, then I can fill the index
>   array entries
> 
>       [A, -, -, -, -, C]
> 
>   because when I see that "B" is a directory containing a total of
>   four entries, I just leave fours spaces for them in the array and
>   continue with the next file, "C".  Of course I would have to
>   remember (e.g., on a queue) that directory "B" still needs to be
>   processed, and the starting index in the array where its entries
>   have to be filled in.  Still, this jumping around would be in the
>   RAM holding the index array pointers rather than in the file
>   positions.

The entry_count in the index is only valid, if the cache-tree is valid,
which is not always the case. Therefore it's impossible to rely on that
for the reading. I have changed the flat loading in the documentation,
hope it's more understandable now.

--
Thomas
