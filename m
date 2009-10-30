From: David Brown <davidb@quicinc.com>
Subject: Re: [RFC PATCH v4 03/26] pkt-line: Make packet_read_line easier to
 debug
Date: Fri, 30 Oct 2009 12:31:08 -0700
Message-ID: <20091030193108.GA30397@huya.quicinc.com>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
 <1256774448-7625-4-git-send-email-spearce@spearce.org>
 <7vhbtidgmp.fsf@alter.siamese.dyndns.org>
 <20091029151152.GX10505@spearce.org>
 <7v1vkm6id9.fsf@alter.siamese.dyndns.org>
 <20091029215829.GD10505@spearce.org>
 <20091030175741.GC18583@coredump.intra.peff.net>
 <20091030191239.GF10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:31:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3xBr-0000e7-1x
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 20:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756191AbZJ3TbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 15:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756135AbZJ3TbD
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 15:31:03 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:54703 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755487AbZJ3TbC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 15:31:02 -0400
X-IronPort-AV: E=McAfee;i="5300,2777,5787"; a="26481556"
Received: from pdmz-ns-mip.qualcomm.com (HELO numenor.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Oct 2009 12:31:07 -0700
Received: from msgtransport05.qualcomm.com (msgtransport05.qualcomm.com [129.46.61.150])
	by numenor.qualcomm.com (8.14.2/8.14.2/1.0) with ESMTP id n9UJV6AK029189
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Fri, 30 Oct 2009 12:31:06 -0700
Received: from huya.quicinc.com (huya.qualcomm.com [10.46.167.38])
	by msgtransport05.qualcomm.com (8.14.2/8.14.2/1.0) with ESMTP id n9UJV4m4016177
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 30 Oct 2009 12:31:06 -0700
Content-Disposition: inline
In-Reply-To: <20091030191239.GF10505@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131735>

On Fri, Oct 30, 2009 at 12:12:40PM -0700, Shawn O. Pearce wrote:

> > If you really just want to initialize to zero, using
> > 
> >   char linelen[5] = { 0 };
> 
> Bleh, I find that has hard to grok as what we have now.  Perhaps my
> understanding of the relevant standards is incomplete, but I'd read
> that as linelen[0] = 0, but the other 4 positions are undefined
> and may be not be initialized.

C isn't that into undefined things.  In this particular case, all
remaining values will be initialized to zero.

> I actually considered this one, but again I wasn't clear what would
> happen in the standard C library when we fed a string that wasn't
> actually NUL terminated.  Is the library permitted to call strlen()
> before formatting?  If so strlen() could SIGSEGV if we are unlucky
> and no NUL is present between our string and the end of the assigned
> memory region.

The linux manpage says "If a precision is given, no null byte
need be present".  This text is copied verbatim out of the Posix
specification, so a C library that failed to handle this would be
non-compliant.

I think the %.4s is clearest, and is, in fact, somewhat
idiomatic.

David
