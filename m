From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 1/2] sha1_file: Add sha1_object_type_literally and
 export it.
Date: Thu, 26 Feb 2015 20:37:38 +0530
Message-ID: <1424963258.13965.1.camel@gmail.com>
References: <54EDACC9.5080204@gmail.com>
	 <1424862460-13514-1-git-send-email-karthik.188@gmail.com>
	 <CAPig+cQDLU4CBQtE8vAKLyz4Xv=2DsDDMz787DVjrFwW2tiKXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 16:07:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR02X-0008Ir-8B
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 16:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbbBZPHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 10:07:44 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:41459 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbbBZPHn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 10:07:43 -0500
Received: by padfb1 with SMTP id fb1so14571654pad.8
        for <git@vger.kernel.org>; Thu, 26 Feb 2015 07:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=hh8x20VMX4CmPb9YiLEruBXQfVcqfV0YBIY591WARDk=;
        b=ZmZFI7vhVuPauiba2bDbpwSO7FbRHq4WFmBxOXLgBWH/Hs6KNWtCBqI+uQS6n1dvnD
         252Xfl5yFCJHJVx1YXWs7kk1Sf24jLV3ooA6bhpdoz02bEBBaRC2j1ef+oLYzdz2i99B
         XdFi7LMS4ggDqDxpjpm7l4UqJcR3TCNnRx7qmRFK4km167/4xjXOCt3vonAlaLGlb3ur
         8RYrJGhGoZ71UJM4s+fNtfRlALwOzONwoi62i+t8bsKJkZG0uGcLGEvZ3TG8FpeMvgTj
         SH993hbKeMS5obF7XwE7BXjWM3v6L3WQ7zOx70Se5f3hyx9G8eCj1iDTtlrqmUCYKwY2
         hF3w==
X-Received: by 10.70.40.209 with SMTP id z17mr15763854pdk.9.1424963262065;
        Thu, 26 Feb 2015 07:07:42 -0800 (PST)
Received: from nayak ([103.227.98.178])
        by mx.google.com with ESMTPSA id fh1sm1251795pbb.70.2015.02.26.07.07.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2015 07:07:41 -0800 (PST)
In-Reply-To: <CAPig+cQDLU4CBQtE8vAKLyz4Xv=2DsDDMz787DVjrFwW2tiKXg@mail.gmail.com>
X-Mailer: Evolution 3.12.11 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264447>

On Wed, 2015-02-25 at 16:55 -0500, Eric Sunshine wrote:
> I had written a longer review but was interrupted for a several hours,
> and upon returning found that David and Junio covered many of the same
> issues or overrode comments I was making, so the below review is pared
> down quite a bit. Junio's proposed approach negates all of the below
> review comments, but they may still be meaningful if kept in mind for
> future submissions.
> 
> On Wed, Feb 25, 2015 at 6:07 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> > sha1_file: Add sha1_object_type_literally and export it.
> 
> Style: downcase "Add"; drop terminating period.
> 
> > sha1_object_type_literally takes a sha value and
> > gives the type of the given loose object, used by
> > git cat-file -t --literally.
> >
> > Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> > ---
> > --- a/sha1_file.c
> > +++ b/sha1_file.c
> > @@ -2635,6 +2635,33 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
> >         return type;
> >  }
> >
> > +int sha1_object_type_literally(const unsigned char *sha1, char *type)
> 
> This functionality is very specific to the --literally option you're
> adding to cat-file, so it would make more sense to make it private to
> builtin/cat-file.c rather than publishing it globally.
> 
> Also, this is an unsafe contract. The caller does not know how many
> bytes to allocate for 'type', and this new function may write past the
> end of the buffer. It is more common to also pass in the size of the
> 'type' buffer and ensure that you do not write beyond that. Or, if
> this is intended for wider consumption, pass in a strbuf instead.
> 
> > +{
> > +       int status = 0;
> > +       unsigned long mapsize;
> > +       void *map;
> > +       git_zstream stream;
> > +       char hdr[32];
> > +       int i;
> > +
> > +       map = map_sha1_file(sha1, &mapsize);
> > +       if (!map)
> > +               return -1;
> > +       if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
> > +               status = error("unable to unpack %s header",
> > +                              sha1_to_hex(sha1));
> 
> Since 'hdr' unpacking failed, shouldn't you be returning at this point
> rather than continuing to the 'hdr' processing loop?
> 
> > +       for (i = 0; i < 32; i++) {
> > +               if (hdr[i] == ' ') {
> > +                       type[i] = '\0';
> > +                       break;
> > +               }
> > +               type[i] = hdr[i];
> > +       }
> 
> David already mentioned that this loop is suspect. Perhaps take a look
> at, sha1_file.c:parse_sha1_header() for an example of cleaner logic.
> 
> > +
> > +       return status;
> > +}
> > +
> >  static void *read_packed_sha1(const unsigned char *sha1,
> >                               enum object_type *type, unsigned long *size)
> >  {
> > --
> > 2.3.1.129.g11acff1.dirty

Thanks for all your inputs, I will work on the points you've mentioned
considering what David and Junio also have mentioned.
