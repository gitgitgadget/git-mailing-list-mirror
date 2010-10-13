From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2 0/3] Teach fetch and pull to recursively fetch submodules
 too
Date: Wed, 13 Oct 2010 21:32:15 +0200
Message-ID: <4CB6093F.3040800@web.de>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de> <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org> <4C953DE5.6020900@web.de> <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org> <4C963D00.9050207@web.de> <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org> <4CAB8DDF.8080004@web.de> <FB03A7DB-67D2-4EAE-A0F0-2F3E3CEA9878@sb.org> <4CB0BFDB.7010503@web.de> <4CB5C6D8.1070108@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 21:32:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P673q-0006Qs-SS
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 21:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663Ab0JMTcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 15:32:18 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:36730 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab0JMTcR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 15:32:17 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate03.web.de (Postfix) with ESMTP id 39162167740E7;
	Wed, 13 Oct 2010 21:32:16 +0200 (CEST)
Received: from [93.240.100.90] (helo=[192.168.178.29])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #24)
	id 1P673g-0006Ye-00; Wed, 13 Oct 2010 21:32:16 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <4CB5C6D8.1070108@xiplink.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18oKJkCmsIpTCZXJJgkA4tuuCaQJtlIW25NL6Ko
	JJNclepCVHc6brgt+hve22xzMLuOrvvYX61+YP5QZMhCUTtd9Z
	d1CKEJIFHMP4Xw5E09RA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158968>

Am 13.10.2010 16:48, schrieb Marc Branchaud:
> On 10-10-09 03:17 PM, Jens Lehmann wrote:
>> Am 07.10.2010 00:52, schrieb Kevin Ballard:
>>> On Oct 5, 2010, at 2:06 PM, Junio C Hamano wrote:
>>>> I dunno.  I've never been a fan of automatically recursing into submodules
>>>> (iow, treating the nested structure as if there is no nesting), so...
>>>
>>> I agree with this as well.
>>
>> There are use cases like mine where automatic recursion is just the right
>> thing to do. But I would be fine with having to turn the recursion on
>> explicitly in the configuration if most people think recursion is not a
>> desirable default. It would be really nice to hear from other submodule
>> users what they think about that ...
> 
> I tend to think that the right default for fetch is to employ the same level
> of recursion that was used for the initial clone.  So if the clone was made
> with --recursive then fetch should default to using --recursive.

That's a very interesting idea.


> But I'd like to see finer-grained control than that.  For us the set of
> submodules to clone depends on what we're trying to build.  Ideally we'd have
> a lot of different submodules, and some would be required no matter what the
> build target.  It'd be great if clone could be smart enough to recursively
> clone those required submodules (i.e. the upstream repo specifies a set of
> default submodules -- I believe this is already on Jens's TODO list).

Yup, right now I have new entries in .gitmodules in mind which will
tell clone to clone certain submodules too. I'm just not so sure if
those should be the same I intend to use for recursive checkout ...


>  Then
> building a particular target could trigger the cloning of ancillary
> submodules specific to that target.

And the build could do that using my proposal by adding entries to the
submodule configs in .git/config, which override those from .gitmodules.


> In that scenario, the default for later fetches could be to either (a)
> retrieve upstream's default set of submodules, or (b) retrieve all populated
> submodules.  Either way, a config option is needed to override the default
> behaviour, with a third configurable-but-never-default setting to recursively
> fetch all submodules, populated or not.

If I understand that correctly my proposal should handle all these cases.
(a) could be done by configuring the entries in .gitmodules (even though
there have been votes against that feature), (b) can be achieved by setting
the repo-wide option. But I fear that its impossible to fetch non-populated
submodules, as they lack a .git directory to fetch into.

Thanks for your feedback!
