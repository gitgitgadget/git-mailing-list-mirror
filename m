From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 01/19] add strbuf_set operations
Date: Thu, 12 Jun 2014 12:21:48 +0200
Message-ID: <53997F3C.9010608@alum.mit.edu>
References: <cover.1402348696.git.jmmahler@gmail.com> <6fe33498512fc2ca1678517e51dc2e94a4260ff4.1402348696.git.jmmahler@gmail.com> <5398460F.3040900@alum.mit.edu> <20140612071045.GC25353@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 12:21:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv28r-0005cS-JV
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 12:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932983AbaFLKVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 06:21:53 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:46929 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932894AbaFLKVw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2014 06:21:52 -0400
X-AuditID: 1207440f-f79536d000000bcf-05-53997f3f21d2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id C8.7E.03023.F3F79935; Thu, 12 Jun 2014 06:21:51 -0400 (EDT)
Received: from [192.168.69.130] (p4FC964CF.dip0.t-ipconnect.de [79.201.100.207])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5CALnfc005241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 12 Jun 2014 06:21:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <20140612071045.GC25353@hudson.localdomain>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsUixO6iqGtfPzPYYOF3dYuuK91MFm8e5Tow
	eeycdZfd4/MmuQCmKG6bpMSSsuDM9Dx9uwTujNlr9jEWLBOo2NZ8nbmBsYu3i5GTQ0LARGJv
	705WCFtM4sK99WxdjFwcQgKXGSX+NyxihHAuMElMfXOQBaSKV0BbYvPcbjYQm0VAVWLm941g
	NpuArsSinmYmEFtUIEhi9ud57BD1ghInZz4B6xURsJX4erIRbJuwgLnEgeWfWSEWnGOUOLjj
	CTNIglPAQmLpnGNAgziAThKX6GkMAgkzC+hIvOt7wAxhy0tsfzuHeQKjwCwkK2YhKZuFpGwB
	I/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0TvdzMEr3UlNJNjJBA5d/B2LVe5hCjAAejEg8v
	Q+2MYCHWxLLiytxDjJIcTEqivHUVM4OF+JLyUyozEosz4otKc1KLDzFKcDArifB6pAHleFMS
	K6tSi/JhUtIcLErivOpL1P2EBNITS1KzU1MLUotgsjIcHEoSvIdrgRoFi1LTUyvSMnNKENJM
	HJwgw7mkRIpT81JSixJLSzLiQbEaXwyMVpAUD9Be9jqQvcUFiblAUYjWU4y6HKfuHGtjEmLJ
	y89LlRLnPVwDVCQAUpRRmge3ApaWXjGKA30szHsN5BIeYEqDm/QKaAkT0JLXntNBlpQkIqSk
	Ghjn/BBRXc4eeUUgK7b04PtLyo89pa/er10Y1eGyX9vniVrXg4Oblf7ZfXVyOJcTL2KzdUai
	2eP3kW3lr5T4CpzvyfiF5a5LS2r4auTAdmfmL90XHtnHkzg/dc6ZYHT5RI5gkUrD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251405>

On 06/12/2014 09:10 AM, Jeremiah Mahler wrote:
> On Wed, Jun 11, 2014 at 02:05:35PM +0200, Michael Haggerty wrote:
>> [...]
>> If there were a function like strbuf_grow_to(sb, len):
>>
>> void strbuf_grow_to(struct strbuf *sb, size_t len)
>> {
>> 	int new_buf = !sb->alloc;
>> 	if (unsigned_add_overflows(len, 1))
>> 		die("you want to use way too much memory");
>> 	if (new_buf)
>> 		sb->buf = NULL;
>> 	ALLOC_GROW(sb->buf, len + 1, sb->alloc);
>> 	if (new_buf)
>> 		sb->buf[0] = '\0';
>> }
>>
> grow_to() which could reduce in size, interesting.

I don't understand what you mean by "could reduce in size".  This
function can only grow, never reduce, the size of the strbuf, because
ALLOC_GROW doesn't do anything unless the requested size is larger than
the currently-allocated size.

>> (strbuf_grow() could call it:
>>
>> static inline void strbuf_grow(struct strbuf *sb, size_t extra)
>> {
>> 	if (unsigned_add_overflows(sb->len, extra))
>> 		die("you want to use way too much memory");
>> 	strbuf_grow_to(sb, sb->len + extra);
>> }
>>
>> ), then your function could be minimized to
>>
>> void strbuf_set(struct strbuf *sb, const void *data, size_t len)
>> {
>> 	strbuf_grow_to(sb, len);
>> 	memcpy(sb->buf, data, len);
>> 	strbuf_setlen(sb, len);
>> }
>>
>> I think strbuf_grow_to() would be useful in other situations too.
>>
>> This is just an idea; I'm not saying that you have to make this change.
>>
> I like your idea.  I am leaning towards doing the un-optimized
> strbuf_set operations first, then optimizing in a later patch.

That's a good plan.

In case you're interested, I sketched what the strbuf_grow_to() changes
might look like, and also looked for other places in the code where
strbuf_grow_to() could be used instead of strbuf_grow() [1].  This is
only a sketch; I haven't even tested the result.  Feel free to use what
you want from it.

Michael

[1] Branch "strbuf-grow-to-sketch" on https://github.com/mhagger/git

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
