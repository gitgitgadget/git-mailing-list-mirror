From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] refs.c: get rid of force_write flag
Date: Thu, 12 Feb 2015 16:35:34 +0100
Message-ID: <54DCC846.7080004@alum.mit.edu>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu> <1423609951-8301-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com, ronniesahlberg@gmail.com, jrnieder@gmail.com,
	pclouds@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 16:35:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLvo0-0008T2-Ho
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 16:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755681AbbBLPfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 10:35:48 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:50585 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753150AbbBLPfr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 10:35:47 -0500
X-AuditID: 12074414-f797f6d000004084-10-54dcc84850a6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 4F.31.16516.848CCD45; Thu, 12 Feb 2015 10:35:36 -0500 (EST)
Received: from [192.168.69.130] (p4FC96396.dip0.t-ipconnect.de [79.201.99.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1CFZYxo014535
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 12 Feb 2015 10:35:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <1423609951-8301-1-git-send-email-sbeller@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqOtx4k6IwYopMhZdV7qZLBp6rzBb
	vL25hNGie8pbRovevk+sFps3t7M4sHnsnHWX3WPBplKPi5eUPT5vkgtgieK2SUosKQvOTM/T
	t0vgzni4+TxLwSWeitapLcwNjI84uhg5OSQETCR+P33FDGGLSVy4t56ti5GLQ0jgMqPEq43b
	GSGc80wS93qfsYFU8QpoS3yb9xDMZhFQlXj48C4jiM0moCuxqKeZCcQWFQiSOHT6MQtEvaDE
	yZlPwGwRATWJmatmg/UyC5RItD1+AbZZWMBCov9JP5gtJFApcXL7TjCbU8BJonvFGhaIej2J
	Hdd/sULY8hLNW2czT2AUmIVkxSwkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuh
	l5tZopeaUrqJERLiIjsYj5yUO8QowMGoxMO7wvROiBBrYllxZe4hRkkOJiVR3q7DQCG+pPyU
	yozE4oz4otKc1OJDjBIczEoivFHLgHK8KYmVValF+TApaQ4WJXHeb4vV/YQE0hNLUrNTUwtS
	i2CyMhwcShK8F48BNQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDYjW+GBitICke
	oL2RIO28xQWJuUBRiNZTjIpS4ryHQBICIImM0jy4sbDE9YpRHOhLYV6Z40BVPMCkB9f9Cmgw
	E9DgiTNugwwuSURISTUwijI4uF29Z8ixxlvGOu/un5KN7LzC16KeeWy6fWp/4zv/tPndUkf7
	np/aGsuzW43x04E/vi2GX+sW/w1PvLb86Kzc0y/2n65lOmMa3fPaQn0FyxvzzhDF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263741>

On 02/11/2015 12:12 AM, Stefan Beller wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
> Notes:
>     When this patch series is applied, you only have 3 occurences of force_write.
>     
>     1. In the struct as an undocumented int.
>     2. In  lock_ref_sha1_basic:
>     	if ((flags & REF_NODEREF) && (type & REF_ISSYMREF))
>     		lock->force_write = 1;
>     3: In ref_transaction_commit:
>     	/* Perform updates first so live commits remain referenced */
>     	for (i = 0; i < n; i++) {
>     		struct ref_update *update = updates[i];
>     
>     		if (!is_null_sha1(update->new_sha1)) {
>     			if (!update->lock->force_write &&
>     			    !hashcmp(update->lock->old_sha1, update->new_sha1)) {
>     				unlock_ref(update->lock);
>     				update->lock = NULL;
>     			} else if (write_ref_sha1(update->lock, update->new_sha1,
>     						  update->msg)) {
>     				update->lock = NULL; /* freed by write_ref_sha1 */
>     				strbuf_addf(err, "Cannot update the ref '%s'.",
>     					    update->refname);
>     				ret = TRANSACTION_GENERIC_ERROR;
>     				goto cleanup;
>     			} else {
>     				/* freed by write_ref_sha1(): */
>     				update->lock = NULL;
>     			}
>     		}
>     	}
>     
>     So maybe we can solve it even more elegant by omiting the first 2 occurences and
>     directly check the type and flags in ref_transaction_commit.
>     
>     Maybe this makes sense to go on top of that series?
> [...]

This is a good idea; I'll add it in the re-roll.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
