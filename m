From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Index format v5
Date: Thu, 10 May 2012 14:19:11 +0200
Message-ID: <20120510121911.GB98491@tgummerer>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
 <4FA7E703.7040408@alum.mit.edu>
 <20120508141137.GA3937@tgummerer.surfnet.iacbox>
 <4FAA2CAF.3040408@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	peff@peff.net, spearce@spearce.org, davidbarr@google.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu May 10 14:19:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSSL3-0000U5-Js
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 14:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756296Ab2EJMTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 08:19:16 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:39017 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754274Ab2EJMTP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 08:19:15 -0400
Received: by wibhr2 with SMTP id hr2so422091wib.1
        for <git@vger.kernel.org>; Thu, 10 May 2012 05:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=S+Mhd0xIUJup6Y1KozETrcQH8JRDXzFHGCaVo/dazaM=;
        b=v+1+CSmWXEbrrOWYMswIMGW91rsDcSiPtxBV2JLRknW5WMAVQphsfZfotWt+y/t/+f
         O+fYSfRzrBfwOXFXj8JY6IuG+dR3MDcdTcETC9TERyOvRjklHmekAp6OVfAEZ7LoWZ3I
         x4u8RY3A12dm/+hrIM2LLvZLmNIE5CO10vUybnE5YfWXc5+bHazjXwpu/KmBHppukmJq
         9YXwABV3bmhuFelL3ciWFaBoFzHY/L6W/F01UXadSrpvN5bPc1j9VExwimfWyVGSFvvO
         GlVv0MjzjezSpbfzzz8voxjZG13dV8VN4KRN0jX1PrdY3q8bjqelaOYb+8v11VnSZ8NR
         oqGg==
Received: by 10.180.77.4 with SMTP id o4mr9022917wiw.17.1336652354182;
        Thu, 10 May 2012 05:19:14 -0700 (PDT)
Received: from localhost ([46.18.27.126])
        by mx.google.com with ESMTPS id bn9sm2840610wib.5.2012.05.10.05.19.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 May 2012 05:19:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FAA2CAF.3040408@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197557>

On 05/09, Michael Haggerty wrote:
> On 05/08/2012 04:11 PM, Thomas Gummerer wrote:
> >>* The details of the extension data blocks are described in the first
> >>   (overview) section, whereas it seems like they should be described
> >>   in their own section following the "conflict data" section.  But
> >>   wouldn't the presence of extension data blocks prevent the addition
> >>   of conflict data?
> >
> >Only the details that should be there for every extension are described
> >in the overview (the header of the extension), to make sure every
> >extension has the same header format, and thus a reader which doesn't
> >understand a specific extension still can read its header and know
> >what's going on.
> >
> >They won't prevent the addition of conflicted data, since when a
> >conflict is created, other files were probably added and the index has
> >to be rewritten anyway. Once the conflict is resolved however only a
> >bit has to be flipped, so there is no rewrite necessary.
> 
> In other words, the presence of extensions *does indeed* prevent the
> addition of conflict data, but you don't think that it is a problem.

Exactly.

> Moving the conflict data to after the extensions, on the other hand,
> would mean that conflict data can sometimes be added without a
> rewrite.  I cannot judge whether this would be useful.
>
> Handling conflict data *as* an extension would allow the conflict
> data to be added at any time without rewriting.  I cannot judge
> whether this would be useful.

Since there are offsets in the directory data to the conflicted data
I don't think it's good to call this data extension data. It may
however be beneficial to have the conflict data after the extension.
I'll investigate this.

> >>* Does the index file include directory entries for empty directories?
> >>   What about directories that contain only other directories?
> >
> >In theory the index is able to include empty directories. I'm however
> >not sure if this should be implemented. I'd be happy to get more
> >feedback there.
> 
> Currently git does not keep track of empty directories.  Even though
> there have been proposals to fix this, it is far beyond the scope of
> your project to implement the handling of empty directories.  The
> question is whether your format definition *forbids* the presence of
> empty directories in the index file (in the interest of
> definiteness, and it might make the reader implementation a little
> bit simpler, but it imposes a constraint on the writer).  Obviously
> empty directories, even if present, mustn't have an effect on the
> SHA1 of the trees containing them.

No, the index format doesn't forbid the presence of empty directories.
Empty directories will have a fileoffset of 0, and the reader will
just ignore them as long as there is no empty directory tracking.

> >>Directory entry
> >>===============
> >>
> >>* "4-byte number of entries in the index that is covered by the tree
> >>   this entry represents."  What does this include?
> >>   Files/directories/both?  Recursive or non-recursive?
> >
> >This is from the cache-tree. I'm not sure but I think it includes both
> >files and directories, recursively.
> 
> Please figure this out for the final spec.

It includes only files, in a recursive manner. I've written this down
in the spec.

> >>File entry
> >>==========
> >>[...]
> >
> >>* Are file entries sorted by entire path or only by the basename?
> >
> >They are sorted by the basename, in the respective block of their
> >directories.
> >Example: paths: a/a a/z b/b
> >File entries in the index:
> >a ...
> >z ...
> >b ...
> 
> OK, so in other words, the file entries of all files in a directory
> (not including files in subdirectories) are stored contiguously,
> sorted by basename.  (The thing that wasn't immediately clear is
> whether files from subdirectories are intermingled with those of the
> parent directory.)

Yes, exactly.

> >>Flat loading
> >>============
> >>
> >>* I found the explanation pretty incomprehensible.  Perhaps some
> >>   pseudo-code would make it clearer?
> >>[...]
> >[...] I have changed the flat loading in the documentation,
> >hope it's more understandable now.
> 
> Maybe it's just be, but I still don't think it is very clear.  Here
> is version fbf8add1b026:
> 
> >== Flat loading
> >
> >Since internally git expects and works with lexicografic ordering,
> >a simple linear scan throught the subdirectories doesn't give
> >the right internal sorting. To achieve the right internal sorting
> >the loading will be done in the following way:
> >
> >1. Start with the root directory, and read also the name of the
> >  first subdirectory (=next directory in the list).
> >
> >1a. Use the next directory (the one against which the filenames
> >  were checked previously), and read the next directory name,
> >  to check the files against.
> >
> >2. Check the stack if the element at the top is < then the current
> >  directoryname.
> >
> >  If it's < then current directory name, add files from the stack
> >    to the entry list, until the file name is > then the
> >    directory name.
> >
> >2. While filename < directoryname add the filenames to the entry
> >  list
> >
> >3. Add the rest of the files to a stack.
> >
> >4. Continue with 1a, if there are more directories left.
> >
> >5. Add the rest of the files from the stack to the end of the
> >  entry list.
> 
> [..] 
> There is a reason that I asked for pseudocode, namely because it
> forces you to be more precise in your description.  I can certainly
> imagine several workable algorithms for reading the index file, and
> the different algorithms have different tradeoffs particularly
> regarding the amount of temporary space needed and locality of
> reference in the index file (which, I understand, will be mmapped
> when practical but it is not practical on all platforms).  Once you
> express the algorithm in pseudocode it is possible to be sure which
> variant you have chosen and consider whether it is really workable.

Ok, here is the variant in pseudo code. I hope it's understandable
this way. It needs some temporary space, but never more then the
actual entries will need in the end anyway.

== Flat loading

Since internally git expects and works with lexicografic ordering,
a simple linear scan throught the subdirectories doesn't give
the right internal sorting. To achieve the right internal sorting
the loading will be done in the following way:

The data structure is a stack of queues, to allow continous reading
of the file.

s -> queue1
t -> queue2
a -> queue3
c -> queue4
k -> queue5

dirs = read_all_directories

foreach dir in dirs do
    file = read_next_file

    while element_on_top_of_stack.first_element < nextdir
        indexentries.append(dequeue(element_on_top_of_stack))
        if element_on_top_of_stack == emtpy:
            remove_element_on_top_of_stack

    if file[filename] < nextdir
        indexentries.append(file)
    else
        queue.add(file)
        foreach f in rest_of_files_in_directory:
            queue.add(f)
        stack.push(queue)

foreach queue in stack:
    foreach entry in queue:
        indexentry.append(entry)
