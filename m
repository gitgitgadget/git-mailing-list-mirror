From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: Git Community Book
Date: Fri, 5 Sep 2008 14:34:34 -0700
Message-ID: <d411cc4a0809051434g4e92790fsa38d12487630aa9f@mail.gmail.com>
References: <d411cc4a0809051208k2a15c4a7te09a6979929e52f7@mail.gmail.com>
	 <7vmyimv0qr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 23:36:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbiyF-0005nf-Qu
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 23:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbYIEVeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 17:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbYIEVeh
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 17:34:37 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:17989 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbYIEVeg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 17:34:36 -0400
Received: by py-out-1112.google.com with SMTP id p76so372344pyb.10
        for <git@vger.kernel.org>; Fri, 05 Sep 2008 14:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=0yw7ZwMybldqVgt9SOxVDhnEiyQSVvyNNMWFNujka5w=;
        b=IeyVLpw69mA8e3e2foKlxYaIKIn+H28FAh/0feJnzuKIylL285n1SeukZFT3cJvOP+
         d3KrSXMK1q+jb+NctKI5T5qAOXXygFyFc+IVggHdSefuJcPSRmxZn2H4dNnjycuA5Ff4
         OqChgdzhXSq5AqkxiDYQI31q160xNaNK2nZ8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Vv8UHALTUzoM9sEYY+aGN9ogxKswtIsLVPs4gEXiHrmKWH7fUnCkFAsdVOwOg/YiNc
         1MCX7jv6tAmIcYBkq5hrZ4/lJheEpqvQbWTSkqts8IXsG9YaNTZGzEJ7Qc4m+2UfIitN
         o7wIgH115E8BlQGgLLVnOtVl3dQOuqlisJdVc=
Received: by 10.114.145.18 with SMTP id s18mr10597572wad.26.1220650474419;
        Fri, 05 Sep 2008 14:34:34 -0700 (PDT)
Received: by 10.114.135.18 with HTTP; Fri, 5 Sep 2008 14:34:34 -0700 (PDT)
In-Reply-To: <7vmyimv0qr.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95042>

On Fri, Sep 5, 2008 at 12:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Scott Chacon" <schacon@gmail.com> writes:
>
>> Also, the last section of the book is on some of the plumbing - mostly
>> stuff I've found difficult to pick up with the existing documentation
>> while re-implementing stuff in Ruby.  I would really appreciate it if
>> someone could proofread some of these chapters for errors:
>>
>> http://book.git-scm.com/7_the_packfile.html
>
> Nice pictures.  You might also want to know that code for reading pack idx
> version 2 was backported to 1.4.4.5 for people who are stuck on 1.4.4
> series for whatever reason.
>
> What is the target audience of this section?  If it is written for a mere
> curious type, or if it is written to give "here is the general idea, for
> more details read the source", the level of detail here would be Ok.
>
> If you are writing for people who want to (re)implement something that
> produces these files, you might want to at least say that offset/sha1[]
> table is sorted by sha1[] values (this is to allow binary search of this
> table), and fanout[] table points at the offset/sha1[] table in a specific
> way (so that part of the latter table that covers all hashes that start
> with a given byte can be found to avoid 8 iterations of the binary
> search).
>
> <data> part is just zlib stream for non-delta object types; for the two
> delta object representations, the <data> portion contains something that
> identifies which base object this delta representation depends on, and the
> delta to apply on the base object to resurrect this object.  ref-delta
> uses 20-byte hash of the base object at the beginning of <data>, while
> ofs-delta stores an offset within the same packfile to identify the base
> object.  In either case, two important constraints a reimplementor must
> adhere to are:
>
>  * delta representation must be based on some other object within the same
>   packfile;
>
>  * the base object must be of the same underlying type (blob, tree, commit
>   or tag);
>
>> http://book.git-scm.com/7_raw_git.html
>
> I am guessing this is for Porcelain writers who use plumbing.  Please
> don't teach echoing into .git/refs/...  but DO teach using update-ref with
> the -m option.  We do not want people's random Porcelains flipping the tip
> of branches without leaving trail in reflog for users to use to recover
> from mistakes.
>

I've implemented all of these and Linus's fixes and suggestions.
Thanks for the feedback.

To answer your earlier question, these docs are basically for people
working on bindings/re-implementations in other languages, since there
is no real linked library available yet, as a primer before they dig
into the source, or possibly so they don't have to.

I'm not fantastic at C, so it took me a while in some cases - figuring
out that the size listed in the object header was not the actual size
of the data, but the size of it when expanded, for example, was not
very easy to do.  I've been doing a lot of work on re-implementations
in Ruby and ObjC because I can't easily make real bindings, so I
thought I would add things that I could not easily find in the docs
for others that are trying in other languages.

If you want, I could create a patch for any of this stuff to
Documentation/ (that goes for the whole book), but someone will have
to tell me which parts might be useful to add.

Thanks again for taking the time!
Scott
