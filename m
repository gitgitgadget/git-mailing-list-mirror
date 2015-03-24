From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] read-cache: tighten checks for do_read_index
Date: Tue, 24 Mar 2015 22:51:04 +0100
Message-ID: <20150324215104.GB2006@hank>
References: <CACsJy8CYi+hYu8zwOy=m7zZk3-8fr+Jq9uT4kEf8fLCOcjHJzw@mail.gmail.com>
 <1427216429-15569-1-git-send-email-t.gummerer@gmail.com>
 <xmqq384u5be7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Jaime Soriano Pastor <jsorianopastor@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 22:51:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaWjC-0002Dt-Pf
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 22:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366AbbCXVvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 17:51:10 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:36627 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbbCXVvI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 17:51:08 -0400
Received: by wgra20 with SMTP id a20so5498249wgr.3
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 14:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LoihTJZhxQp9Sx7N1pPiQYDBF42jwi2ac+iNikoKGZs=;
        b=vpiG+vV00gXQ0Cb/2pPMMXxIBlYuV5fISuLz1aWCTH0CQ4x9/mgKP9vzHAmf/lMLUn
         QpUwaiaW9m4PUBNxouw2HJDZfmx4CS+0vDDn3TzBaakhJToxHFUR5cFgRY1KkgJgJ905
         5jmD1W+KLz0R1HQNB7dT82wx82Q65eo2K+qmRoTuvMyEkdAnFJNwuBUKyhSP2FIJu+5U
         UE1PvIJo+nP9fF7zKoesMuriv6aCckChMwGYqWRD/LjeTGg2uDhcn7TEe2kqLNoHNMHY
         gfM7PqOMF7KWJriDJk5OP0Og+XcIvd959ZQcEqU22gvOBqq/01wrIB2S9VYkD6d6nI0q
         tUGw==
X-Received: by 10.194.76.146 with SMTP id k18mr11878918wjw.115.1427233866896;
        Tue, 24 Mar 2015 14:51:06 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id ew13sm1345666wid.1.2015.03.24.14.51.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2015 14:51:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq384u5be7.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266231>

On 03/24, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
> > 03f15a7 read-cache: fix reading of split index moved the checks for the
> > correct order of index entries out of do_read_index.  This loosens the
> > checks more than necessary.  Re-introduce the checks for the order, but
> > don't error out when we have multiple stage-0 entries in the index.
> > Return a flag for the caller instead, if we have multiple stage-0
> > entries and let the caller decide if we need to error out.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >
> > This is a patch on top of my previous patch, as that one has already
> > been merged to next.
>
> I am not convinced that this is a good change in the first place.
>
> The original before your fix was wrong exactly because it was too
> tightly tied to the implementation of the index file format where
> there was only one file whose contents must be sorted, and that is
> why it was a broken check in a new world with split-index.  And your
> fix in 'next' is the right fix---it makes the verification happen
> only on the result is given to the caller for its consumption.
>
> It may be true that entries may have to be sorted in a certain order
> when reading the original index file format and also reading some
> steps in reading the split-index, but that merely happens to be an
> imprementation detail of the two format currently supported, and as
> we improve these formats (or even introduce yet another one) in the
> longer term, this patch would re-introduce the same issue your
> earlier fix corrected, wouldn't it?

Yes, after looking at it again I completely agree.  Sorry for the noise.
