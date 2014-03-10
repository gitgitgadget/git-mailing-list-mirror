From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/26] Clean up update-refs --stdin and implement ref_transaction
Date: Mon, 10 Mar 2014 22:46:54 +0100
Message-ID: <531E32CE.9040509@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu> <531DF9FC.4070707@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 22:47:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN82J-0007op-37
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 22:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327AbaCJVq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 17:46:59 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:50822 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753254AbaCJVq6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 17:46:58 -0400
X-AuditID: 1207440e-f79c76d000003e2c-2e-531e32d17dbe
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 8D.1A.15916.1D23E135; Mon, 10 Mar 2014 17:46:57 -0400 (EDT)
Received: from [192.168.69.148] (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ALksj6020772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 17:46:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <531DF9FC.4070707@kitware.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsUixO6iqHvRSC7Y4MMhEYud6yQsuq50M1k0
	9F5htph3dxeTxY+WHmaLj50LmB3YPHbOusvucenldzaPj8+Ws3s8693D6HHxkrLH501yAWxR
	3DZJiSVlwZnpefp2CdwZKx58Yyro5avYu+YcSwPjCu4uRk4OCQETiUNfjrNA2GISF+6tZ+ti
	5OIQErjMKHH6yUdmCOc8k8TGB5+ZQKp4BbQlXuw4AmazCKhKXF7zjw3EZhPQlVjU0wwWFxUI
	llh9+QELRL2gxMmZT8BsEaD6VesawOqZBdYwStzcWANiCwuESjxa+hssLiSQJLH+TC9YPSfQ
	rt9Hu4CO4AC6TlyipzEIolVH4l3fA2YIW15i+9s5zBMYBWch2TYLSdksJGULGJlXMcol5pTm
	6uYmZuYUpybrFicn5uWlFuka6+VmluilppRuYoREA98Oxvb1MocYBTgYlXh4D7yVCRZiTSwr
	rsw9xCjJwaQkypunIxcsxJeUn1KZkVicEV9UmpNafIhRgoNZSYR3nThQjjclsbIqtSgfJiXN
	waIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwcsEjHohwaLU9NSKtMycEoQ0EwcnyHAuKZHi
	1LyU1KLE0pKMeFAExxcDYxgkxQO0N8QQZG9xQWIuUBSi9RSjLsfttl+fGIVY8vLzUqXEefcZ
	ABUJgBRllObBrYClvleM4kAfC/M+AhnFA0ybcJNeAS1hAlrSfFwKZElJIkJKqoFxuvtjHlnu
	qZeSLjc+OXtBgNHjzNMWh9/Tf/7Xz5lTGr5x3oH9F11uTw2+scnxztazRxl/z9L1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243821>

On 03/10/2014 06:44 PM, Brad King wrote:
> [...]

Thanks for your kind words.

> On 03/10/2014 08:46 AM, Michael Haggerty wrote:
>> The new API for dealing with reference transactions is
>>
>>     ref_transaction *transaction = create_ref_transaction();
>>     queue_create_ref(transaction, refname, new_sha1, ...);
>>     queue_update_ref(transaction, refname, new_sha1, old_sha1, ...);
>>     queue_delete_ref(transaction, refname, old_sha1, ...);
>>     ...
>>     if (commit_ref_transaction(transaction, msg, ...))
>>         die(...);
> 
> The layout of this API looks good.
> 
> The name "queue" is not fully representative of the current behavior.
> It implies that the order is meaningful but we currently allow at most
> one update to a ref and sort them by refname.  Does your follow-up work
> define behavior for multiple updates to one ref?  Can it collapse them
> into a single update after checking internal consistency of the sequence?

I don't really like the word "queue" in these function names, but I
couldn't think of a better alternative.  I wanted a word that conveys
that the change is being collected for later application as opposed to
being applied immediately.  Other suggestions are welcome.

In the future I *do* want to define the behavior for multiple updates to
a single ref.  Even now, although order is not preserved when carrying
out the updates, the facts that (1) at most one update is allowed to
each reference and (2) the changes are made (approximately) atomically
together mean that the effect of committing a transaction is
(approximately) indistinguishable from the effect it would have if order
were preserved.

> [...]

Cheers,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
