From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] show-branch: fix description of --date-order
Date: Tue, 16 Jul 2013 11:22:54 -0700
Message-ID: <20130716182254.GL14690@google.com>
References: <8df0d41caa10a38e46783bebd3148a7b8445dd47.1373966389.git.trast@inf.ethz.ch>
 <8768923c2d317d02beabbf1bff2f61927e126f81.1373966389.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>,
	Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 16 20:23:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz9tw-0007hq-Jk
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 20:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933561Ab3GPSW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 14:22:59 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:55819 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933193Ab3GPSW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 14:22:58 -0400
Received: by mail-pb0-f44.google.com with SMTP id uo1so981417pbc.17
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fa7KDcP7AvmIEJJc6iQJ16IxATLbq+Oy3aHHuiPiv00=;
        b=xWuHLB9kIEC5ExAJfwwSz39lR+JIMdaX/JW+v4v3u6GTnImIZJPOjcgWlkO8CcSqve
         MhRHKmzWV2vb9iRUTxdsaDbruQbXrgUUBERjX2/H665RMHfHy12RFal2OSkIL2G300wK
         sZG+WxxltEl5q1cWzSf55gzaae4J/ZaH6A1OiCxVcvM/cpDDN0HIWOvySGP6kmhJfnY0
         0xVN3lLY6AXdkx+RUpheL6pVG375UpPzC70gDOltChJ5ZY9i2BGTXrFmjHvF7PnNnEni
         FBuG5vhNmj7j9BigZHq3SmJ9cXcmf15L6JcEDKgEB1KtwB8jnv/S1eyTaNFD/F2PHk9a
         k2Tw==
X-Received: by 10.66.144.230 with SMTP id sp6mr262213pab.64.1373998978442;
        Tue, 16 Jul 2013 11:22:58 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id fl2sm5611675pab.23.2013.07.16.11.22.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 11:22:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8768923c2d317d02beabbf1bff2f61927e126f81.1373966389.git.trast@inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230570>

Thomas Rast wrote:

> The existing description reads as if it somehow applies a filter.
> Change it to explain that it is merely about the ordering.
[...]
>  		OPT_SET_INT(0, "date-order", &sort_order,
> -			    N_("show commits where no parent comes before its "
> +			    N_("sort commits such that no parent comes before its "
>  			       "children"),
>  			    REV_SORT_BY_COMMIT_DATE),

I fear this wording tweak doesn't go far enough.  The above
description seems to describe --topo-order just as well as
--date-order.

How about something like

		N_("topologically sort, maintaining date order where possible"),

?  I haven't checked the code to see if that's accurate, though.

Is the idea that:

 - by default, commits are listed in commit date order (newest first)

 - with --topo-order, they are topologically sorted in such a way as
   to ensure that in cases like

	---1---2---4---7
	    \           \
	     3---5---6---8

   (from git-log(1)), parallel tracks are not interleaved

 - with --date-order, they are topologically sorted but less
   aggressively, in particular matching commit date order in the
   usual case that that is already topologically sorted.

That would make --topo-order stronger than "show commits in
topological order" --- it should say something like "sort trying to
avoid breaking up lines of development".
