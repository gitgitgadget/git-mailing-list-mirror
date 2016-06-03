From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 12/13] dir_iterator: new API for iterating over a
 directory tree
Date: Fri, 3 Jun 2016 13:57:49 +0200
Message-ID: <575170BD.2050604@alum.mit.edu>
References: <cover.1464537050.git.mhagger@alum.mit.edu>
 <e99655e5d919852479d223caec42e5bb294b4a2c.1464537050.git.mhagger@alum.mit.edu>
 <1464739954.3988.6.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?Q?y?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 13:58:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8njt-0002oc-HB
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 13:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbcFCL5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 07:57:54 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57726 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932536AbcFCL5x (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 07:57:53 -0400
X-AuditID: 12074411-e2bff70000000955-bc-575170bfa88e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id DB.9B.02389.FB071575; Fri,  3 Jun 2016 07:57:51 -0400 (EDT)
Received: from [192.168.69.130] (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53BvnZV004057
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 07:57:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <1464739954.3988.6.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqLu/IDDcYOlvU4v5m04wWnRd6Way
	aOi9wmzRPeUto8WPlh5mB1aPnbPusns8693D6HHxkrLHguf32T0+b5ILYI3itklKLCkLzkzP
	07dL4M6Y8/YxU8Ec1ort69YwNzD+YO5i5OSQEDCRWLP5JVsXIxeHkMBWRonFy26xQzjnmCQ2
	rWlhBKkSFgiTmLjnAQuILSIQIbFk8j5WEBui414SSAOzwDRGiSfbroGNZRPQlVjU08wEYvMK
	aEtsmPAdrJlFQEViy7HD7CC2qECIxPl1W1khagQlTs58AlbDKWAuMWfvE7A5zALqEn/mXYKy
	5SW2v53DPIGRfxaSlllIymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdULzezRC81
	pXQTIyScBXcwzjgpd4hRgINRiYd3xYKAcCHWxLLiytxDjJIcTEqivOfPAoX4kvJTKjMSizPi
	i0pzUosPMUpwMCuJ8HrmBIYL8aYkVlalFuXDpKQ5WJTEefmWqPsJCaQnlqRmp6YWpBbBZGU4
	OJQkePvzgRoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQVEZXwyMS5AUD9De7yDt
	vMUFiblAUYjWU4y6HAt+3F7LJMSSl5+XKiXOuxGkSACkKKM0D24FLHm9YhQH+liYNwSkigeY
	+OAmvQJawgS0pOCRP8iSkkSElFQDYzBnuPeFoN85ncdjTljtrqvdtsLe+N5HntW929/tY54l
	3B/7N+TDll1ZP62nVyxjUrK633rgDU9pVUtj9Q9lg6aYf2rrzbedaV5XXpXyMsZ4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296306>

On 06/01/2016 02:12 AM, David Turner wrote:
> On Mon, 2016-05-30 at 09:55 +0200, Michael Haggerty wrote:
>> +struct dir_iterator_level {
>> +	int initialized;
>> +
>> +	DIR *dir;
>> +
>> +	/*
>> +	 * The length of the directory part of refname at this level
> 
> 
> "refname"? Isn't this was for directories?

Thanks.

>> +			if (lstat(iter->base.path.buf, &iter
> ->base.st) < 0)
>> +				continue; /* silently skip */
> 
> Should we warn on non-ENOENT errors here?

Good idea. I'll add that.

>> +/*
>> + * End the iteration before it has been exhausted. Free the
>> reference
> 
> s/reference/directory/

Thanks. Will fix.

Michael
