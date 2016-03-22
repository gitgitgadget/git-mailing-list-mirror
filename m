From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v7 04/33] files-backend: break out ref reading
Date: Tue, 22 Mar 2016 09:33:08 +0100
Message-ID: <56F10344.6000408@alum.mit.edu>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
 <1456793586-22082-5-git-send-email-dturner@twopensource.com>
 <56EE2F0D.5030709@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	peff@peff.net, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 22 09:40:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiHro-00039d-1u
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 09:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758557AbcCVIka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 04:40:30 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:63403 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758530AbcCVIkY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2016 04:40:24 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Mar 2016 04:40:24 EDT
X-AuditID: 1207440c-99fff700000008b4-ef-56f1034871f5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 0F.B2.02228.84301F65; Tue, 22 Mar 2016 04:33:12 -0400 (EDT)
Received: from [192.168.69.130] (p548D657A.dip0.t-ipconnect.de [84.141.101.122])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2M8X9Cx009850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 22 Mar 2016 04:33:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <56EE2F0D.5030709@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqOvB/DHM4NIKCYv5m04wWnRd6Way
	aOi9wmzRPeUto8WPlh5mB1aPnbPusns8693D6HHxkrLHguf32T0+b5ILYI3itklKLCkLzkzP
	07dL4M6YuP0mW0Era8WBh69YGhi7WLoYOTgkBEwknrbwdjFycQgJbGWUeHr8NiOEc4FJ4v7M
	g0xdjJwcwgJOErP/TmQHsUUEsiXmfDrHClG0klFi3+8nLCAJZgE1ifZNU1hBbDYBXYlFPc1g
	zbwC2hLTzu4Gq2ERUJVoa54FViMqECKxbd03VogaQYmTM5+AXcQpoCNxbpkjxEg9iR3Xf7FC
	2PIS29/OYZ7AyD8LSccsJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrqJebWaKX
	mlK6iRESyjw7GL+tkznEKMDBqMTD27DhQ5gQa2JZcWXuIUZJDiYlUd6VekAhvqT8lMqMxOKM
	+KLSnNTiQ4wSHMxKIrxLvwLleFMSK6tSi/JhUtIcLErivKpL1P2EBNITS1KzU1MLUotgsjIc
	HEoSvDcZP4YJCRalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIMiMr4YGJMgKR6gvZtA
	2nmLCxJzgaIQracYdTkW/Li9lkmIJS8/L1VKnNeXCahIAKQoozQPbgUscb1iFAf6WJiXEaSK
	B5j04Ca9AlrCBLTEJfIdyJKSRISUVAMjR8YDc+7vazNCl55uvrZPh//wgx88hjs2d5xfeKH3
	tKWX+pn6aw6BdadeLue4nbH+2TfB70Kp6cdjbbj7rblyBR9dOhV05Rh/6L2yHUVs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289496>

On 03/20/2016 06:03 AM, Michael Haggerty wrote:
> On 03/01/2016 01:52 AM, David Turner wrote:
>> Refactor resolve_ref_1 in terms of a new function read_raw_ref, which
>> is responsible for reading ref data from the ref storage.
>>
>> Later, we will make read_raw_ref a pluggable backend function, and make
>> resolve_ref_unsafe common.
>>
>> Testing done: Hacked in code to run both old and new version of
>> resolve_ref_1 and compare all outputs, failing dramatically if outputs
>> differed.  Ran test suite.

I found some other subtle differences in the behavior after this patch.
I'm still working out the details.

Michael
