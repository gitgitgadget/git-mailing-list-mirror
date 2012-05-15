From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Index format v5
Date: Tue, 15 May 2012 15:49:16 +0200
Message-ID: <20120515134916.GA2074@tgummerer.unibz.it>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
 <4FA7E703.7040408@alum.mit.edu>
 <20120508141137.GA3937@tgummerer.surfnet.iacbox>
 <4FAA2CAF.3040408@alum.mit.edu>
 <20120510121911.GB98491@tgummerer>
 <4FAC0633.90809@alum.mit.edu>
 <20120511171230.GA2107@tgummerer>
 <4FB01080.6010605@alum.mit.edu>
 <20120514150113.GD2107@tgummerer>
 <4FB1746A.6090408@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	peff@peff.net, spearce@spearce.org, davidbarr@google.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 15 15:49:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUI82-0002dB-Vp
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 15:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932845Ab2EONt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 09:49:26 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61796 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758898Ab2EONtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 09:49:25 -0400
Received: by pbbrp8 with SMTP id rp8so7555843pbb.19
        for <git@vger.kernel.org>; Tue, 15 May 2012 06:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=W4fqzJuuab1E8tCuqUcXET4PGEkRCYCamJZjgrtPpyk=;
        b=RCBhGQH8jQiRzf13rm+drCGEzkJmULdXJqFv1O+D1CcxpiwKyD0T3WWLbakmnCcUFq
         WKQWIXDvU1+lsrWjMxF4+1Dm2Ml6pHUhpwS2g2+YySmXxWkEV0eEAiSVP+j6/eMc/1gH
         yfNb/5TCNEpnZ7KS+pTNhSPjdxwYLc/4xde2TXnxTUY6E1C6UqbE8GMR/y4QkaE4bS5X
         QzaYYUGMtBKHJ/UdpjhJWKLR8h7c1SiXY+LBjhtl7nb+eD/Rfuk44QomcH5+av2TzUxm
         ialW51YdwEkZ0X1lUIkJWtFpxZC/NUZQVSVc6Li8ViRad+ESnQjUkIhNVHE1yGZ33wau
         RNXg==
Received: by 10.68.212.197 with SMTP id nm5mr5624903pbc.110.1337089765214;
        Tue, 15 May 2012 06:49:25 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPS id iw4sm1941457pbc.7.2012.05.15.06.49.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 May 2012 06:49:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FB1746A.6090408@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197832>



On 05/14, Michael Haggerty wrote:
> On 05/14/2012 05:01 PM, Thomas Gummerer wrote:
> >Thanks a lot for your feedback. I've now refactored the code and
> >thanks to your suggestions hopefully made it simpler and easier
> >to read. The reader should now read exactly the data from the
> >spec.
> 
> Yes, the style is much better now.  Here is the next round of feedback:
> [...]
> 
> >DIR_DATA_STRUCT = struct.Struct("!HIIIIII 20s")
> >
> >
> >def read_dirs(f, ndir):
> >    dirs = list()
> >    for i in xrange(0, ndir):
> >        (pathname, partialcrc) = read_name(f)
> >
> >        (filedata, partialcrc) = read_calc_crc(f, DIR_DATA_STRUCT.size, partialcrc)
> >        (flags, foffset, cr, ncr, nsubtrees, nfiles,
> >                nentries, objname) = DIR_DATA_STRUCT.unpack(filedata)
> >    # ...
> 
> [...]

Thanks again for your feedback. I've refactored the code again,
thanks to your suggestions. If I'm correct it's fine to have the
compiled structs global?

> What is your plan for testing this code, and later the C version?
> For example, you might want to have a suite of index files with
> various contents, and compare the "git ls-files --debug" output with
> the output that is expected.  How would you create index files like
> this?  Via git commands?  Or should one of your Python scripts be
> taught how to do it?

I thought of using real world examples for this, for example the
WebKit index, which is pretty large, and some others, for example the
git index and the linux kernel index.

There would be some changes necessary to the output format of 
git ls-files --debug, to work with the new index format, but those
should be fairly simple.

> To make testing easier, you probably don't want to hard-code the
> name of the input file in git-read-index-v5.py, so that you can use
> it to read arbitrary files.  For example, you might want to honor
> the GIT_INDEX_FILES environment variable in some form, or to take
> the name of the index file as a command-line argument.

I've changed this in the script, which now takes a --file argument
with the file name of the index file that should be read.
(git-read-index-v5.py --file=FILENAME)

-- 
Thomas
