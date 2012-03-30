From: William Strecker-Kellogg <willsk@bnl.gov>
Subject: Re: [PATCH] Make http-backend REMOTE_USER configurable
Date: Thu, 29 Mar 2012 23:24:39 -0400
Message-ID: <4F752777.2020000@bnl.gov>
References: <1333051139-14262-1-git-send-email-willsk@bnl.gov> <7vzkazoyk3.fsf@alter.siamese.dyndns.org> <20120329222230.GB1413@sigill.intra.peff.net> <20120329222632.GC1413@sigill.intra.peff.net> <7vk422q2ho.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 05:24:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDSSD-0001FG-PV
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 05:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491Ab2C3DYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 23:24:42 -0400
Received: from smtpgw.bnl.gov ([130.199.3.132]:15337 "EHLO smtpgw.bnl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759598Ab2C3DYk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 23:24:40 -0400
X-BNL-policy-q: 
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ar0GAD0mdU+CxzYH/2dsb2JhbABEgw+2D4EHggkBAQQBeAEFCwsYCRYPCQMCAQIBRQYNAQUCAQGIAQW7K5EQBJtRg2CGXoMDgTgCAgQR
X-IronPort-AV: E=Sophos;i="4.75,339,1330923600"; 
   d="scan'208";a="175140248"
Received: from rcf.rhic.bnl.gov ([130.199.54.7])
  by smtpgw.sec.bnl.local with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Mar 2012 23:24:39 -0400
Received: from [192.168.1.131] (ool-457ccb3b.dyn.optonline.net [69.124.203.59])
	(authenticated bits=0)
	by rcf.rhic.bnl.gov (8.13.8/8.13.8) with ESMTP id q2U3OdjR001365
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Mar 2012 23:24:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120316 Thunderbird/11.0
In-Reply-To: <7vk422q2ho.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194319>

On 03/29/2012 09:52 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Thu, Mar 29, 2012 at 06:22:30PM -0400, Jeff King wrote:
>>
>>> I think an even better thing would be for http-backend to leave
>>> GIT_COMMITTER_* alone if it exists; that is the usual well-known
>>> interface for setting such things. And then you could specify a
>>> detailed committer name and email if you want, or leave them blank to
>>> pull from $REMOTE_USER as we do now. As it is now, even if you specify
>>> GIT_COMMITTER_EMAIL, it gets overwritten with
>>> "$REMOTE_USER@http.$REMOTE_ADDR".
>>
>> That patch would look something like this:
> 
> It would regress for somebody who is running the CGI program while
> exporting these environment variables pointing at himself and relying on
> the fact that these are canceled by REMOTE_USER/ADDR (perhaps a web-based
> editor can write into some repository and commits made by that editor
> takes the ident information from COMMITTER variables, while another part
> of the webserver takes a push by spawning the http backend???).
> 
> Which is very unlikely.

Agreed.

> 
> If somebody else comes up with a valid scenario to show why this patch is
> a bad idea, I'd stand corrected but at the same time I'd be very surprised.
> 
> But I think this is the right thing to do, even though it is not related
> to the issue William wanted to address with his patch.
> 

The reason we're interested in this is validation -- who can push to our
production puppet branch is determined by a post-update hook.  A wrapper
around http-backend like Jeff's combined with his patch would accomplish
what we need just fine.

> Care to sign it off?
> 
