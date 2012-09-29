From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 3/8] longest_ancestor_length(): use string_list_split()
Date: Sat, 29 Sep 2012 07:25:18 +0200
Message-ID: <5066863E.1030005@alum.mit.edu>
References: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu> <1348688090-13648-4-git-send-email-mhagger@alum.mit.edu> <7vr4pnnkux.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 07:25:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THpYT-0006Hm-Pk
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 07:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514Ab2I2FZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 01:25:23 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:52520 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751556Ab2I2FZW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Sep 2012 01:25:22 -0400
X-AuditID: 12074414-b7f846d0000008b8-8d-506686414f95
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 17.C3.02232.14686605; Sat, 29 Sep 2012 01:25:21 -0400 (EDT)
Received: from [192.168.69.140] (p57A246BE.dip.t-dialin.net [87.162.70.190])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8T5PIul024376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 29 Sep 2012 01:25:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vr4pnnkux.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsUixO6iqOvYlhZgMHOTgEXXlW4mi4beK8wW
	R09ZWKx/d5XZgcVj56y77B4XLyl7fN4kF8AcxW2TlFhSFpyZnqdvl8CdsaKph6lgIn9Fz6xJ
	rA2MX7m7GDk5JARMJDr+rWaHsMUkLtxbz9bFyMUhJHCZUaL/8gdWCOcMk8TvVafAqngFtCWW
	T+hkBrFZBFQlPh/cyARiswnoSizqaQazRQVCJGZcnswMUS8ocXLmExYQW0RATWJi2yEwm1kg
	U6Llyzs2EFtYwFvi48Ql7BDLljNKTN92B6yIU8BMYt+pl2wQDToS7/oeMEPY8hLb385hnsAo
	MAvJjllIymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdCLzezRC81pXQTIySMRXYw
	Hjkpd4hRgINRiYdX63hqgBBrYllxZe4hRkkOJiVRXu+WtAAhvqT8lMqMxOKM+KLSnNTiQ4wS
	HMxKIrwZxUDlvCmJlVWpRfkwKWkOFiVx3m+L1f2EBNITS1KzU1MLUotgsjIcHEoSvD9AhgoW
	paanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDojW+GBivICkeoL3BIO28xQWJuUBRiNZT
	jLoca+8ueMAoxJKXn5cqJc57E6RIAKQoozQPbgUsab1iFAf6WJhXvBWoigeY8OAmvQJawgS0
	ZOmmJJAlJYkIKakGRpbNPV+aD17s+b5cSDzk/vvNd2R2WTk//hO7/E7d7WKbhdNWMU+o2bR+
	lt48iQexwirSHVa2tUti15iZZVxc2rftobbfh3Cup/FRH2r+/jogvvVhgsmpF3vO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206625>

On 09/28/2012 12:48 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> -	for (colon = ceil = prefix_list; *colon; ceil = colon+1) {
>> -		for (colon = ceil; *colon && *colon != PATH_SEP; colon++);
>> -		len = colon - ceil;
>> +	string_list_split(&prefixes, prefix_list, PATH_SEP, -1);
>> +
>> +	for (i = 0; i < prefixes.nr; i++) {
>> +		const char *ceil = prefixes.items[i].string;
>> +		int len = strlen(ceil);
>> +
> 
> Much nicer than the yucky original ;-)

If your winky-smiley implies irony, then I would like to object.  Even
though the original is not difficult to understand, it is more difficult
to review than the new version because one has to think about off-by-one
errors etc.  The new version has a bit more boilerplate, but a quick
read suffices both to understand it and to see that it is correct.
Though of course I admit that the improvement is small.

But the main point of this change is to move towards using more testable
parts, so it is a step forward regardless of whether it is more readable.

>>  		if (len == 0 || len > PATH_MAX || !is_absolute_path(ceil))
>>  			continue;
>> -		strlcpy(buf, ceil, len+1);
>> +		memcpy(buf, ceil, len+1);
>>  		if (normalize_path_copy(buf, buf) < 0)
>>  			continue;
> 
> Why do you need this memcpy in the first place?  Isn't ceil already
> a NUL terminated string unlike the original code that points into a
> part of the prefix_list string?  IOW, why not
> 
> 	normalize_path_copy(buf, ceil);
> 
> or something?

Good point.  I will fix this in v2.

> Can normalize_path_copy() overflow buf[PATH_MAX+1] here (before or
> after this patch)?

normalize_path_copy() can only shrink paths, not grow them.  So the
length check on ceil guarantees that the result of normalize_path_copy()
will fit in buf.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
