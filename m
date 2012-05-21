From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Mon, 21 May 2012 10:13:33 +0200
Message-ID: <4FB9F92D.8000305@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 21 10:20:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWNrA-00029J-7j
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 10:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755680Ab2EUIUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 04:20:39 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:51373 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751505Ab2EUIUh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 May 2012 04:20:37 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 May 2012 04:20:37 EDT
X-AuditID: 12074413-b7f886d0000008a0-5b-4fb9f92f3406
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 47.37.02208.F29F9BF4; Mon, 21 May 2012 04:13:35 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4L8DY91007546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 21 May 2012 04:13:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqKv/c6e/wfrNkhZdV7qZLBp6rzA7
	MHlcvKTs8XmTXABTFLdNUmJJWXBmep6+XQJ3xoMfvWwFj1krGh7dZGpgPMPSxcjJISFgIvHo
	2xJmCFtM4sK99WxdjFwcQgKXGSWWLP7CDOEcZ5KY/e0LUAcHB6+AtsSMnaUgDSwCqhJf785m
	BbHZBHQlFvU0M4GUiAqESax+oAES5hUQlDg58wnYLhGgkl3PrrKB2MwCahKHljxiBLGFBewk
	Dq0/xAbSyixgLfFtdxFEibzE9rdzmCcw8s1CMmkWQtUsJFULGJlXMcol5pTm6uYmZuYUpybr
	Ficn5uWlFuma6+VmluilppRuYoQEnPAOxl0n5Q4xCnAwKvHwOs7Y6S/EmlhWXJl7iFGSg0lJ
	lPf1N6AQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd67D4FyvCmJlVWpRfkwKWkOFiVxXrUl6n5C
	AumJJanZqakFqUUwWRkODiUJXr0fQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnx
	oJiLLwZGHUiKB2jv9+8ge4sLEnOBohCtpxh1OWZ8WnSNUYglLz8vVUqcVxlkhwBIUUZpHtwK
	WHp5xSgO9LEwrwVIFQ8wNcFNegW0hAloSdALsCUliQgpqQbGpIUfvfWs1/k//tXX2VWzcSVP
	WsYHpbcPF+fna7xedKJ35ovrcb6PFkcsmrFBkfnKhCtrmWd5PT1w+VNtemTSxnbHvyalMtuN
	md5ymWjFrXTVFJ8rz7j0TGJAaer+8FefInfrPebI3lu6uKhaIlFx9y2jstunrn1j 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198095>

I just noticed that the remove_duplicates() function in 
builtin/fetch-pack.c is O(N^2) in the number of heads.  Empirically, 
this function takes on the order of 25 seconds to process 100k references.

I know that 100k heads is kindof absurd.  Perhaps handling this many 
heads is unrealistic for other reasons.  But I vaguely recall numbers 
like this being mentioned on the mailing list.

It would be pretty trivial to reduce the work to O(N) by using a hash 
set to keep track of the references that have already been seen.

I don't plan to work on this, but I thought I would point it out in case 
it is causing somebody pain.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
