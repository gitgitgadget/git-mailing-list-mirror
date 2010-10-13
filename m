From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v2 0/3] Teach fetch and pull to recursively fetch submodules
 too
Date: Wed, 13 Oct 2010 10:48:56 -0400
Message-ID: <4CB5C6D8.1070108@xiplink.com>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de> <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org> <4C953DE5.6020900@web.de> <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org> <4C963D00.9050207@web.de> <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org> <4CAB8DDF.8080004@web.de> <FB03A7DB-67D2-4EAE-A0F0-2F3E3CEA9878@sb.org> <4CB0BFDB.7010503@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 13 16:56:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P62lC-0008Br-PV
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 16:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826Ab0JMO4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 10:56:41 -0400
Received: from smtp142.iad.emailsrvr.com ([207.97.245.142]:57970 "EHLO
	smtp142.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843Ab0JMO4j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 10:56:39 -0400
X-Greylist: delayed 505 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Oct 2010 10:56:39 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp44.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 4DEA51283DE;
	Wed, 13 Oct 2010 10:48:14 -0400 (EDT)
X-Orig-To: gitster@pobox.com
X-Orig-To: kevin@sb.org
X-Orig-To: git@vger.kernel.org
X-Orig-To: Jens.Lehmann@web.de
X-Orig-To: mbranchaud@xiplink.com
X-Virus-Scanned: OK
Received: by smtp44.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 1BE6412826C;
	Wed, 13 Oct 2010 10:48:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100915 Thunderbird/3.0.8
In-Reply-To: <4CB0BFDB.7010503@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158937>

On 10-10-09 03:17 PM, Jens Lehmann wrote:
> Am 07.10.2010 00:52, schrieb Kevin Ballard:
>> On Oct 5, 2010, at 2:06 PM, Junio C Hamano wrote:
>>> I dunno.  I've never been a fan of automatically recursing into submodules
>>> (iow, treating the nested structure as if there is no nesting), so...
>>
>> I agree with this as well.
> 
> There are use cases like mine where automatic recursion is just the right
> thing to do. But I would be fine with having to turn the recursion on
> explicitly in the configuration if most people think recursion is not a
> desirable default. It would be really nice to hear from other submodule
> users what they think about that ...

I tend to think that the right default for fetch is to employ the same level
of recursion that was used for the initial clone.  So if the clone was made
with --recursive then fetch should default to using --recursive.

But I'd like to see finer-grained control than that.  For us the set of
submodules to clone depends on what we're trying to build.  Ideally we'd have
a lot of different submodules, and some would be required no matter what the
build target.  It'd be great if clone could be smart enough to recursively
clone those required submodules (i.e. the upstream repo specifies a set of
default submodules -- I believe this is already on Jens's TODO list).  Then
building a particular target could trigger the cloning of ancillary
submodules specific to that target.

In that scenario, the default for later fetches could be to either (a)
retrieve upstream's default set of submodules, or (b) retrieve all populated
submodules.  Either way, a config option is needed to override the default
behaviour, with a third configurable-but-never-default setting to recursively
fetch all submodules, populated or not.

		M.
