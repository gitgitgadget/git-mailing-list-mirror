From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] fsck_handle_reflog_sha1(): new function
Date: Mon, 08 Jun 2015 17:17:11 +0200
Message-ID: <5575B1F7.8030400@alum.mit.edu>
References: <cover.1433769878.git.mhagger@alum.mit.edu>	<1c6f5540fe974016c1547163c7b891707019154d.1433769878.git.mhagger@alum.mit.edu> <xmqqwpzeck72.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 17:17:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1ynt-0004wj-Oz
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 17:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbbFHPRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 11:17:30 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:59467 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932599AbbFHPR2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 11:17:28 -0400
X-AuditID: 12074413-f79386d000000d23-4e-5575b1f981f4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 81.B9.03363.9F1B5755; Mon,  8 Jun 2015 11:17:13 -0400 (EDT)
Received: from [192.168.69.130] (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t58FHBf1026831
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 11:17:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <xmqqwpzeck72.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqPtzY2moweN/qhZdV7qZLBp6rzBb
	9C/vYrP40dLD7MDi8eFjnMez3j2MHhcvKXt83iQXwBLFbZOUWFIWnJmep2+XwJ2x+vkjloJT
	rBU9uy+wNTDuZuli5OSQEDCR+DB1KzuELSZx4d56ti5GLg4hgcuMEgd6m5ghnPNMEodn/QZy
	ODh4BbQlbqyRAmlgEVCVaFy1CWwQm4CuxKKeZiaQElGBIInXL3NBwrwCghInZz4BKxERUJOY
	2HYIzGYWyJXonHSHGcQWFnCQWLjlOxPEqq2MEovP72IFSXAKWEucu/mCEaJBT2LH9V+sELa8
	xPa3c5gnMArMQrJjFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdfLzSzRS00p
	3cQICWbhHYy7TsodYhTgYFTi4T2wqCRUiDWxrLgy9xCjJAeTkijvvPWloUJ8SfkplRmJxRnx
	RaU5qcWHGCU4mJVEeJOnA+V4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwc
	ShK87zcANQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDIjW+GBirICkeoL0fQNp5
	iwsSc4GiEK2nGHU57kz5v4hJiCUvPy9VSpz3K0iRAEhRRmke3ApY6nrFKA70sTBvIUgVDzDt
	wU16BbSECWjJ96/FIEtKEhFSUg2ME/iL82YvMKq55/yUk/t3rPy7+T3iL7ufbpFf/jxzpqeX
	vcxbEevamvKchQ4m/EF2n+coaTS9abMM29YebOS59IPwhvWsd7ffDZa1ylKo2f+g 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271045>

On 06/08/2015 05:07 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> New function, extracted from fsck_handle_reflog_ent(). The extra
>> is_null_sha1() test for the new reference is currently unnecessary, as
>> reflogs are deleted when the reference itself is deleted. But it
>> doesn't hurt, either.
> 
> I think we would crash with today's code in such a situation, but
> wouldn't we want to diagnose a 0{40} object name on the "new" side
> of the reflog entry as an error in the endgame state?

Good point. new_sha1 == NULL_SHA1 should be diagnosed and reported with
a distinct error message.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
