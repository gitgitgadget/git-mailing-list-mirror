From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2] cache_tree_find(): remove redundant checks
Date: Tue, 04 Mar 2014 11:22:44 +0100
Message-ID: <5315A974.5000104@alum.mit.edu>
References: <1393921868-4382-1-git-send-email-mhagger@alum.mit.edu> <87ppm2i9ot.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 11:22:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKmUv-0002FB-Oe
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 11:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756790AbaCDKWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 05:22:50 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:44117 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756666AbaCDKWs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2014 05:22:48 -0500
X-AuditID: 1207440d-f79d86d0000043db-68-5315a977228f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 5A.35.17371.779A5135; Tue,  4 Mar 2014 05:22:47 -0500 (EST)
Received: from [192.168.69.148] (p57A2482C.dip0.t-ipconnect.de [87.162.72.44])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s24AMiJb004134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 4 Mar 2014 05:22:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <87ppm2i9ot.fsf@fencepost.gnu.org>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqFu+UjTYoPm2rsXsG9vYLLqudDNZ
	NPReYXZg9mibZuZx8ZKyx+dNcgHMUdw2SYklZcGZ6Xn6dgncGVdPLGMuaBCsaJp+iqWB8R9P
	FyMnh4SAicTra0+YIWwxiQv31rN1MXJxCAlcZpSY/fwnlHOWSWLmhHVsIFW8AtoS908tYwGx
	WQRUJdYt+ggWZxPQlVjU08wEYosKBEusvvyABaJeUOLkzCdgtoiAvMTyWW/ZQWxmAWuJFa8P
	g9ULCzhJTPi+lRHEFhJIk+heNg3sIk4BfYlV87cC9XIAXScu0dMYBNGqI/Gu7wEzhC0vsf3t
	HOYJjIKzkGybhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfRyM0v0UlNKNzFC
	App3B+P/dTKHGAU4GJV4eGdMEwkWYk0sK67MPcQoycGkJMp7cJlosBBfUn5KZUZicUZ8UWlO
	avEhRgkOZiURXsWFQDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgSv
	1wqgRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQBMcXA2MYJMUDtDcWpJ23uCAx
	FygK0XqKUZfjdtuvT4xCLHn5ealS4rz+y4GKBECKMkrz4FbA0tcrRnGgj4V5TUFG8QBTH9yk
	V0BLmICWcE8GW1KSiJCSamAs+Z9zw37ahWPGFzNnrDx9y1FRWaDgapK0WO63UL+EmTe9X99r
	Ovhy1pF33XtX6Jy8vHAW00ONtfv/dS/v1Q/JXN1x5Nz5GsHjN7aWBP2til9q9jRx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243335>

On 03/04/2014 10:40 AM, David Kastrup wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> The beginning of the loop ensures that slash can never be NULL.  So
>> don't keep checking whether it is NULL later in the loop.
>>
>> Furthermore, there is no need for an early
>>
>>     return it;
>>
>> from the loop if slash points at the end of the string, because that
>> is exactly what will happen when the while condition fails at the
>> start of the next iteration.
> 
> Hm.  Another suggestion.  You have
> 
> 		const char *slash = strchr(path, '/');
>  		if (!slash)
>  			slash = path + strlen(path);
> [...]
> 		sub = find_subtree(it, path, slash - path, 0);
> [...]
> 		path = slash;
> 		while (*path == '/')
> 			path++;
> 	}
> 
> At the price of introducing another variable, this could be
> 
> 		const char *slash = strchr(path, '/');
>  		size_t len = slash ? slash - path : strlen(path);
> [...]
> 		sub = find_subtree(it, path, len, 0);
> [...]
>                 if (!slash)
> 			break;
> 		for (path = slash; *path == '/';)
> 			path++;
> 	}
> 
> This introduces another variable and another condition.  The advantage
> is that "slash" indeed points at a slash or is NULL, so the variable
> names correspond better to what happens.  Alternatively, it might make
> sense to rename "slash" into "end" or "endpart" or whatever.  Since
> I can't think of a pretty name, I lean towards preferring the latter
> version as it reads nicer.  I prefer code to read like children's books
> rather than mystery novels.

I think we're reaching the point of diminishing returns here.  I can't
muster a strong feeling either way about your suggestion to add a "len"
variable.

BTW, I purposely didn't use a "for" loop at the end (even though I
usually like them) because I wanted to keep it prominent that path is
being updated to the value of slash.  Putting that assignment in a for
loop makes it easy to overlook because it puts "path" in the spot that
usually holds an inconsequential iteration variable.

YMMV.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
