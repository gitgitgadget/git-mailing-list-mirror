From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] vcs-svn: rename check_overflow arguments for clarity
Date: Thu, 2 Feb 2012 05:27:32 -0600
Message-ID: <20120202112732.GA15537@burratino>
References: <4F28378F.6080108@ramsay1.demon.co.uk>
 <20120131192053.GC12443@burratino>
 <7vipjpzxav.fsf@alter.siamese.dyndns.org>
 <20120202104128.GG3823@burratino>
 <20120202105923.GJ3823@burratino>
 <CA+gfSn9Exv3T0UCB-bFShmSvRCMgygVuWraiToR6ZjgOA_sZ8A@mail.gmail.com>
 <20120202111628.GN3823@burratino>
 <CAFfmPPOeFk871m_N+nLXgQx3Uj4wVhgR9BNFzM2ggtseop0JaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Ivankov <divanorama@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 12:27:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsupa-00053w-5f
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 12:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755774Ab2BBL1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 06:27:54 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34282 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240Ab2BBL1x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 06:27:53 -0500
Received: by ggnh1 with SMTP id h1so1102627ggn.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 03:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5xUTFMVSPPMhxt/Igzv/abmaI+1oMwa0nC1+BHZeVEE=;
        b=VQRDJX5mWTzB9OXUKDOjfCS9wbtggMcbDHyhgkgqVeUyO1XT+VhrXkCM5rswdBz4eB
         ubq+rhH3s/yTmaK8/awcrdFKupS62fBn29eawvEJAMqRSEzCyqH5bEc7oNCQpoviEVVG
         rwb9/ybrgOaBjKBVlZtfl110kKvHisl6JB/E8=
Received: by 10.50.170.41 with SMTP id aj9mr2839852igc.0.1328182072712;
        Thu, 02 Feb 2012 03:27:52 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gw1sm6748800igb.0.2012.02.02.03.27.51
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 03:27:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAFfmPPOeFk871m_N+nLXgQx3Uj4wVhgR9BNFzM2ggtseop0JaA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189631>

David Barr wrote:

> Maybe rename to check_offset_overflow to make it explicit?

Ok, here's the patch I'll squash in. ;-)

diff --git i/vcs-svn/sliding_window.c w/vcs-svn/sliding_window.c
index 2f4ae60f..ec2707c9 100644
--- i/vcs-svn/sliding_window.c
+++ w/vcs-svn/sliding_window.c
@@ -31,7 +31,7 @@ static int read_to_fill_or_whine(struct line_buffer *file,
 	return 0;
 }
 
-static int check_overflow(off_t offset, uintmax_t len)
+static int check_offset_overflow(off_t offset, uintmax_t len)
 {
 	if (len > maximum_signed_value_of_type(off_t))
 		return error("unrepresentable length in delta: "
@@ -48,9 +48,9 @@ int move_window(struct sliding_view *view, off_t off, size_t width)
 	off_t file_offset;
 	assert(view);
 	assert(view->width <= view->buf.len);
-	assert(!check_overflow(view->off, view->buf.len));
+	assert(!check_offset_overflow(view->off, view->buf.len));
 
-	if (check_overflow(off, width))
+	if (check_offset_overflow(off, width))
 		return -1;
 	if (off < view->off || off + width < view->off + view->width)
 		return error("invalid delta: window slides left");
