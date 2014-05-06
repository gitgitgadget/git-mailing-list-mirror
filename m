From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 8/9] cache-tree: convert struct cache_tree to use object_id
Date: Tue, 06 May 2014 17:02:40 +0200
Message-ID: <5368F990.2040702@alum.mit.edu>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net> <1399147942-165308-9-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 19:34:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiUx-0008Jm-7e
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbaEFPCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 11:02:45 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:62625 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750944AbaEFPCo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2014 11:02:44 -0400
X-AuditID: 1207440e-f79c76d000003e2c-35-5368f993b463
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id E8.80.15916.399F8635; Tue,  6 May 2014 11:02:43 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97C6E.dip0.t-ipconnect.de [79.201.124.110])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s46F2fuX030560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 6 May 2014 11:02:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1399147942-165308-9-git-send-email-sandals@crustytoothpaste.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsUixO6iqDv5Z0awwb3n0hZdV7qZLNpm/mBy
	YPJYfvMvk8fnTXIBTFHcNkmJJWXBmel5+nYJ3BnP3p1lLLjFWrHmcmYD43GWLkZODgkBE4lD
	U86xQthiEhfurWfrYuTiEBK4zCjxc+ctJgjnPJPEq2cP2UCqeAW0JWZMOQ1mswioSrQ9us4I
	YrMJ6Eos6mkGauDgEBUIkvhzVhGiXFDi5MwnYMtEBLwk5j+aAbZMWMBf4s6rBhaI+f2MEsvu
	zgSbwyngJ7HtyApmkDkSAuISPY1BIGFmAR2Jd30PmCFseYntb+cwT2AUmIVkxSwkZbOQlC1g
	ZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGusl5tZopeaUrqJERKmfDsY29fLHGIU4GBU4uF9
	8CojWIg1say4MvcQoyQHk5Io74TPQCG+pPyUyozE4oz4otKc1OJDjBIczEoivA1fgHK8KYmV
	ValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4OJQneCz+AGgWLUtNTK9Iyc0oQ0kwc
	nCDDuaREilPzUlKLEktLMuJBcRpfDIxUkBQP0N5DIO28xQWJuUBRiNZTjLocFxpWtDAJseTl
	56VKifNOBSkSACnKKM2DWwFLSq8YxYE+FuY9A1LFA0xocJNeAS1hAlrCZZwOsqQkESEl1cCY
	v2Om3q7iWY80pnpUpk7W9sytijdWbI3aV7Xy/NK9GwpFdzxjmcclNm/BEUvm6DuWGXIMUf16
	HyJv/ywxnMDjUHKMZYeHztoJ3FdCU/8XOU9YUB232OLFjYsFWg8tA10nvmmVLOmf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248188>

On 05/03/2014 10:12 PM, brian m. carlson wrote:
> [...]
> diff --git a/cache-tree.c b/cache-tree.c
> index 7fa524a..b7b2d06 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c

In this file I also found a couple other "20" that could be converted to
GIT_OID_RAWSZ:

Around line 369:
		strbuf_add(&buffer, sha1, 20);

And around line 490 (three instances):
		if (size < 20)
			goto free_return;
		hashcpy(it->sha1, (const unsigned char*)buf);
		buf += 20;
		size -= 20;

I guess a search for "\<[24][0-9]\>" will find most (but not all!) of
the literal constants that are derived from GIT_OID_RAWSZ and GIT_OID_HEXSZ.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
