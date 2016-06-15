From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv3] gpg-interface: check gpg signature creation status
Date: Wed, 15 Jun 2016 09:17:54 +0200
Message-ID: <75709ea6-b2bb-fddf-1175-cb8aae66629a@drmicha.warpmail.net>
References: <26353a3d-e495-075f-4f84-b34a2420a6cf@drmicha.warpmail.net>
 <8e08b63b58302b6e7fe91f0dfb5b476781bfd37d.1465915311.git.git@drmicha.warpmail.net>
 <xmqq60tbaba5.fsf@gitster.mtv.corp.google.com>
 <20160614215019.GB22334@sigill.intra.peff.net>
 <20160614222633.GA32020@sigill.intra.peff.net>
 <xmqqporj72p4.fsf@gitster.mtv.corp.google.com>
 <20160615005614.GB32601@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, ZhenTian <loooseleaves@gmail.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 09:18:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bD55Q-0001Lo-8b
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 09:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbcFOHR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 03:17:59 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59773 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752120AbcFOHR6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2016 03:17:58 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 2E7C220D14;
	Wed, 15 Jun 2016 03:17:56 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 15 Jun 2016 03:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=ru/btLpgDw9/54lGai/E04zMMWI=; b=FcMsre
	PFUxGpb6q/emPDCOZil4MXAupOkfBmTclSZJiJMx7t2jbtherplj4qdkmZUdsUrw
	ohAGA9NcsOb44bmH0e5+yArokZ/tUyrHl+iVun3EsXEWoE4hIfnEYLnOMMdGzUu1
	PxNwZoTi9mv9Eot0nFwa6c6HILrdciNvC/+7w=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=ru/btLpgDw9/54l
	Gai/E04zMMWI=; b=gYTBZYVmXYUANv7IqEQCnRoAD8rBVSl8b2PilU52CIoljYf
	sm7e1idKo9SmvSzL1z85azbrWF4EWYWmTkyglcSS360DRmmC59xXbbGK6lgWZRob
	wvj7TlR0QkzU/m8eOu7qEylZz0k8AR7IB5YnfI4c5Rc0VN2OEf73f1maiAFE=
X-Sasl-enc: m5Kr7xA6O3GNzuxTFVIRzt1QIHpJuou6tlfzERa3sR2O 1465975075
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5B174CCDAB;
	Wed, 15 Jun 2016 03:17:55 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <20160615005614.GB32601@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297358>

Jeff King venit, vidit, dixit 15.06.2016 02:56:
> On Tue, Jun 14, 2016 at 04:47:35PM -0700, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>> I'm still undecided on whether it is a better approach than making
>>> sure the stdout we got looks sane. In particular I'd worry that it
>>> would make things harder for somebody trying to plug in something
>>> gpg-like (e.g., if you wanted to do something exotic like call a
>>> program which fetched the signature from a remote device or
>>> something).  But it's probably not _that_ hard for such a script
>>> to emulate --status-fd.
>>
>> I share the same thinking, but at the same time, it already is a
>> requirement to give --status-fd output that is close enough on the
>> signature verification side, isn't it?
> 
> Yeah, though I could see somebody wanting to sit amidst the signing side
> but not verification (e.g., if your keys are elsewhere from the machine
> running git). Of course such a case could probably ferry --status-fd
> from the other side anyway.
> 
> I admit I don't know of such a case in practice, though, and
> implementing a rudimentary --status-fd to say "SIG OK" or whatever on
> the signing side is not _that_ big a deal. So if we think this approach
> is a more robust solution in the normal case, let's not hold it up over
> what-ifs.
> 
> -Peff

As for the flexibility:
We do code specifically for gpg, which happens to work for gpg2 also.
The patch doesn't add any gpg ui requirements that we don't require
elsewhere already.
More flexibility requires a completely pluggable approach - gpgsm
already fails to meet the gpg command line ui.

In any case, "status-fd" is *the* way to interface with gpg reliably
just like plumbing commands are *the* way to interface with git reliably.

As for the read locking:
I'm sorry I have no idea about that area at all. I thought that I'm
doing the same that we do for verify, but apparently not. My
strbuf_read-fu is not that strong either (read: copy&paste). I trust
your assessment completely, though.

As for the original problem:
That had a different cause, as we know now (rebase dropping signatures
without hint). I still think we should check gpg status codes properly.

Michael
