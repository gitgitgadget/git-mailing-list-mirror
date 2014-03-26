From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 00/27] Clean up update-refs --stdin and implement ref_transaction
Date: Wed, 26 Mar 2014 22:47:09 +0100
Message-ID: <53334ADD.8030806@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu> <53331EE6.2010100@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 22:47:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSvfK-0005O7-Bc
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 22:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212AbaCZVrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 17:47:14 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:42166 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756168AbaCZVrN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2014 17:47:13 -0400
X-AuditID: 1207440f-f79326d000003c9f-d4-53334ae011dc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id CE.FF.15519.0EA43335; Wed, 26 Mar 2014 17:47:12 -0400 (EDT)
Received: from [192.168.69.148] (p57A25757.dip0.t-ipconnect.de [87.162.87.87])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2QLl9uT001638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 26 Mar 2014 17:47:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <53331EE6.2010100@kitware.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsUixO6iqPvAyzjY4PpdNoud6yQsuq50M1k0
	9F5htph3dxeTxY+WHmaLj50LmB3YPHbOusvucenldzaPj8+Ws3s8693D6HHxkrLH501yAWxR
	3DZJiSVlwZnpefp2CdwZryd9Yi14y1nx+v5y5gbGP+xdjJwcEgImErMfLGWFsMUkLtxbz9bF
	yMUhJHCZUWLR7U5GCOcck8SlgxdZQKp4BbQlzu3pYwaxWQRUJZY0rmUDsdkEdCUW9TQzgdii
	AkEShzecYoWoF5Q4OfMJWK8IUP2qdQ1gG5gF1jBKrP3RBHQGB4ewQITEvx0xIDVCAskSS9fM
	BZvJCbTr9N/brCAlEgLiEj2NQSBhZgEdiXd9D5ghbHmJ7W/nME9gFJyFZNssJGWzkJQtYGRe
	xSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRropebWaKXmlK6iRESDfw7GLvWyxxiFOBgVOLhTbhr
	FCzEmlhWXJl7iFGSg0lJlLfX0ThYiC8pP6UyI7E4I76oNCe1+BCjBAezkghvtwdQjjclsbIq
	tSgfJiXNwaIkzqu+RN1PSCA9sSQ1OzW1ILUIJivDwaEkwZsP0ihYlJqeWpGWmVOCkGbi4AQZ
	ziUlUpyal5JalFhakhEPiuD4YmAMg6R4gPZaeYLsLS5IzAWKQrSeYtTl2LBtTSOTEEtefl6q
	lDivGkiRAEhRRmke3ApY6nvFKA70sTBvIkgVDzBtwk16BbSECWgJV5URyJKSRISUVANj6Lb3
	zKeSLKdxBF4LZp3fW33fP6A69plC8IlrhzdwW/yyzZkqnHulvffKySkz4v8ryzyS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245233>

On 03/26/2014 07:39 PM, Brad King wrote:
> On 03/24/2014 01:56 PM, Michael Haggerty wrote:
>> Changes relative to v1:
>>
>> * Rename the functions associated with ref_transactions to be more
>>   reminiscent of database transactions:
>>
>>   * create_ref_transaction() -> ref_transaction_begin()
>>   * free_ref_transaction() -> ref_transaction_rollback()
>>   * queue_update_ref() -> ref_transaction_update()
>>   * queue_create_ref() -> ref_transaction_create()
>>   * queue_delete_ref() -> ref_transaction_delete()
>>   * commit_ref_transaction() -> ref_transaction_commit()
> 
> Those new names look better.
> 
>> * Fix backwards compatibility of "git update-ref --stdin -z"'s
>>   handling of the "create" command: allow <newvalue> to be the empty
>>   string, treating it the same zeros.  But deprecate this usage.
> 
> The changes related to that look good.  The new documentation is
> much clearer than my old wording.
> 
> Series v2 looks good to me except for my responses to individual
> commits.

Thanks a lot for the review.  Your other two comments are correct, of
course, and I will fix them if there needs to be a re-roll.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
