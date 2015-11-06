From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 25/25] refs: break out ref conflict checks
Date: Fri, 06 Nov 2015 14:34:16 +0100
Message-ID: <563CAC58.3070907@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>		 <3060e6410e8798064ef84cd31645021d1b84fbb9.1446534991.git.mhagger@alum.mit.edu>	 <1446670884.4131.42.camel@twopensource.com> <563AD452.2030301@alum.mit.edu> <1446740535.4131.50.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 14:34:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zuh9r-00023j-Us
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 14:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161263AbbKFNeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 08:34:20 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:50754 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161192AbbKFNeT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2015 08:34:19 -0500
X-AuditID: 12074411-f797e6d000007df3-da-563cac5a7ee1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id A1.DC.32243.A5CAC365; Fri,  6 Nov 2015 08:34:18 -0500 (EST)
Received: from [192.168.69.130] (p4FC96C46.dip0.t-ipconnect.de [79.201.108.70])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA6DYG62020719
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 6 Nov 2015 08:34:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1446740535.4131.50.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsUixO6iqBu1xibMYPt2Q4v5m04wWnRd6Way
	aOi9wuzA7HHxkrLHguf32T0+b5ILYI7itklKLCkLzkzP07dL4M6YOecoS8EyjopTZy6zNzBe
	ZOti5OSQEDCRuLHrIAuELSZx4d56oDgXh5DAZUaJezcPsUM455gk/iw+DlbFK6At8e/qFEYQ
	m0VAVeL/i/9MIDabgK7Eop5mMFtUIEhixfIXjBD1ghInZz4B6xUB6p19pIcVxGYWsJZY8fow
	WL2wgKPEryePmSGWNTJJ7Pr0AKyBU8BC4tCz1UwQDeoSf+ZdYoaw5SWat85mnsAoMAvJjllI
	ymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdULzezRC81pXQTIyR8BXcwzjgpd4hR
	gINRiYf3xhLrMCHWxLLiytxDjJIcTEqivCmzbcKE+JLyUyozEosz4otKc1KLDzFKcDArifDG
	rQDK8aYkVlalFuXDpKQ5WJTEefmWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeM1XAzUKFqWmp1ak
	ZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg6I1vhgYryApHqC9YO28xQWJuUBRiNZTjIpSQFtB
	EgIgiYzSPLixsKT0ilEc6Eth3gaQKh5gQoPrfgU0mAlosEMU2OCSRISUVAOj8a1v562sY/bc
	/nHkyfYy5rpFkzW3pQm19Vw/EF3EtfdpmN6yiT3CF99Ev5jl7Cj5ZumapZHLV20unfrH4XOC
	sWhfR2m/ePhdc93HawyL4x2+hKyaPOf9+z2zpSurJkRr9MxxWTHjQN65cua8e3PL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280980>

On 11/05/2015 05:22 PM, David Turner wrote:
> [...] But while looking at it, I
> noticed that the commit message doesn't look quite right (my fault):
> 
> On Thu, 2015-11-05 at 05:00 +0100, Michael Haggerty wrote:
>> Create new function verify_no_descendants, to hold one of the ref
>> conflict checks used in verify_refname_available. Multiple backends
>> will need this function, so move it to the common code.
> 
> The function is find_descendant_ref not verify_no_descendants.

Thanks for noticing.

Junio, if there are no more comments, would you mind

    s/verify_no_descendants/find_descendant_ref/

in the log message of this commit? And then, if you are also OK with the
new subdirectory introduced in this patch series, David and I seem to be
in agreement that it is ready to go. It would be great if this patch
series could be merged in a timely manner, as it will conflict with
nearly any other changes that people might want to undertake in the refs
code.

Thanks,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
