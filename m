From: Paul Smith <paul@mad-scientist.net>
Subject: Re: [PATCH] git-new-workdir: Don't fail if the target directory is
 empty
Date: Thu, 20 Nov 2014 10:41:37 -0500
Message-ID: <1416498097.23953.5.camel@mad-scientist.net>
References: <1416339408.3899.22.camel@mad-scientist.net>
	 <xmqqd28jt7tb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 16:48:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrTyF-0002vI-Gt
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 16:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062AbaKTPsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 10:48:31 -0500
Received: from qproxy2-pub.mail.unifiedlayer.com ([69.89.16.161]:37611 "HELO
	qproxy2.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1751257AbaKTPsa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Nov 2014 10:48:30 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Nov 2014 10:48:30 EST
Received: (qmail 13309 invoked by uid 0); 20 Nov 2014 15:41:50 -0000
Received: from unknown (HELO cmgw2) (10.0.90.83)
  by qproxy2.mail.unifiedlayer.com with SMTP; 20 Nov 2014 15:41:50 -0000
Received: from box531.bluehost.com ([74.220.219.131])
	by cmgw2 with 
	id Hrhm1p00Z2qhmhE01rhpRM; Thu, 20 Nov 2014 08:41:50 -0700
X-Authority-Analysis: v=2.1 cv=Hd2HEE08 c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17 a=cNaOj0WVAAAA:8
 a=f5113yIGAAAA:8 a=IkcTkHD0fZMA:10 a=pBbsfl06AAAA:8 a=cdVwids0oJMA:10
 a=2NV5t7OSZ7cA:10 a=5y4faFyK3SkA:10 a=PtAkvS83V1K660kFbvEA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mad-scientist.net; s=default;
	h=Content-Transfer-Encoding:Mime-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=h2VQkwNCUQMokI2T1CcNQjz5/Fik/MYAxjpN7CELlWo=;
	b=YKZMZna/3ShqIHEmzTEL/yvGfMlG1lcglUJY5feDBDljS2wNGhCPRB0DUIsVY2lXSVRsUTpsgtUA/plqYktLMYsbULF2nwoLnYYsMYrg7Ii/W7Cn8Z9Ylv/4UbHK5srI;
Received: from [173.9.45.73] (port=50438 helo=pdsdesk)
	by box531.bluehost.com with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.82)
	(envelope-from <paul@mad-scientist.net>)
	id 1XrTrd-0005kh-WB; Thu, 20 Nov 2014 08:41:46 -0700
In-Reply-To: <xmqqd28jt7tb.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.7-0ubuntu1 
X-Identified-User: {678:box531.bluehost.com:madscie1:mad-scientist.us} {sentby:smtp auth 173.9.45.73 authed with paul@mad-scientist.us}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2014-11-19 at 09:32 -0800, Junio C Hamano wrote:
> Paul Smith <paul@mad-scientist.net> writes:
> I took a look at this again, and I do not agree with one design
> decision it makes, namely:
> 
> >> I split the creation of the directories from the symlinks: see the new
> >> loop above.  This allows us to avoid the icky dirname stuff.
> 
> which forces those who maintain the script to make sure that these
> two loops
> kept consistent with each other.  If you forget to add frotz to the
> upper loop when adding frotz/nitfol to the latter, you are breaking
> it.

Yes, but this mistake won't live past even a single attempt to run the
script, since it will immediately cause a fatal error.  So this doesn't
bother me.

> I find it much more icky than computing what is necessary on the fly.

OK, I'll go back to the previous way.

> Aversion to turning $cleandir to an absolute path?  Why?

In some situations switching to absolute can cause unexpected behaviors,
where relative paths are no longer where you expect them etc.  However
in this case it's not a problem: I'll change it.

> These uses of --git-dir/--work-tree look somewhat funny.  You want
> to say "I want to run checkout in that $new_workdir", so say it in a
> more direct way, i.e.
> 
>     git -C "$new_workdir" checkout -f "$branch"

Good idea.
