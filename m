From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 3/5] verify_lock(): report errors via a strbuf
Date: Wed, 27 May 2015 23:18:05 +0200
Message-ID: <5566348D.7040506@alum.mit.edu>
References: <1432337697-29161-1-git-send-email-mhagger@alum.mit.edu>	<1432337697-29161-4-git-send-email-mhagger@alum.mit.edu> <xmqqk2vtls2q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 23:18:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxiia-0000Py-GJ
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 23:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbbE0VSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 17:18:24 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:50794 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751361AbbE0VSX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2015 17:18:23 -0400
X-AuditID: 1207440e-f79fc6d000000caf-30-5566348fe932
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id A4.4C.03247.F8436655; Wed, 27 May 2015 17:18:07 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB0143.dip0.t-ipconnect.de [93.219.1.67])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4RLI61Z010345
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 27 May 2015 17:18:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <xmqqk2vtls2q.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqNtvkhZqcHCnmUXXlW4mi4beK8wW
	mze3szgweyzYVOpx8ZKyx+dNcgHMUdw2SYklZcGZ6Xn6dgncGS+PJhScYK+4++AMcwPjX9Yu
	Rk4OCQETiVd7VrFA2GISF+6tZ+ti5OIQErjMKDH57AlGCOcsk8Tr3bfZQap4BbQlbuy5DtbN
	IqAqcfnOPjYQm01AV2JRTzNTFyMHh6hAkMTrl7kQ5YISJ2c+AVsgIqAmMbHtEJjNLGAtsbxr
	LdhIYQEnib9tW6B2rWGUOLTvNBNIghOo6MzsA4wQDXoSO67/YoWw5SW2v53DPIFRYBaSHbOQ
	lM1CUraAkXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6xXm5miV5qSukmRkjg8u1gbF8vc4hR
	gINRiYf3gHRqqBBrYllxZe4hRkkOJiVRXlfttFAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrwK
	ekA53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IE7wYjoEbBotT01Iq0
	zJwShDQTByfIcC4pkeLUvJTUosTSkox4UKTGFwNjFSTFA7T3Kkg7b3FBYi5QFKL1FKMux50p
	/xcxCbHk5eelSonzMhsDFQmAFGWU5sGtgKWpV4ziQB8L82qCVPEAUxzcpFdAS5iAlpgdTQFZ
	UpKIkJJqYOw/w+VRYS/Km/RmfaZLbk5+/s2OV2+4/50OjLXeqfg7uC50TXl8+7/yf0IekTuf
	rXb2rS/e9FZUr+RBYJtUn2P/iT/3TOOj9kY/nfxML9fSWLFGZ4evic7dw3LmG5ln 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270099>

On 05/27/2015 09:48 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Instead of writing error messages directly to stderr, write them to a
>> "strbuf *err". In lock_ref_sha1_basic(), arrange for these errors to
>> be returned to its caller.
> 
> I had to scratch my head and view long outside the context before
> realizing that the caller lock_ref_sha1_basic() already arranges
> with its caller that errors from it are passed via the strbuf, and
> this change is just turning verify_lock(), a callee from it, follows
> that already established pattern.
> 
> Looks sensible, but the last sentence was misleading at least to me.
> 
> 	The caller, lock_ref_sha1_basic(), uses this error reporting
> 	convention with all the other callees, and reports its error
>         this way to its callers.
> 
> perhaps?

+1

Thanks for clarifying this sentence.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
