From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 0/7] Tying loose ends on grep-pcre
Date: Wed, 10 Oct 2012 17:17:51 +0200
Message-ID: <5075919F.5030306@alum.mit.edu>
References: <1349855714-17008-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 17:18:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLy2w-0007kF-CK
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 17:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394Ab2JJPRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 11:17:55 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:58237 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932351Ab2JJPRy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2012 11:17:54 -0400
X-AuditID: 1207440f-b7fde6d00000095c-a4-507591a1496e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 27.4A.02396.1A195705; Wed, 10 Oct 2012 11:17:53 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9AFHpNu032107
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 10 Oct 2012 11:17:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <1349855714-17008-1-git-send-email-gitster@pobox.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsUixO6iqLtwYmmAwZI3AhZdV7qZLBp6rzA7
	MHlcvKTs8XmTXABTFLdNUmJJWXBmep6+XQJ3xsO25awFq3gqrvx4w9TA2MjVxcjJISFgItEy
	dyUzhC0mceHeerYuRi4OIYHLjBKXbi5lhHCOM0nsa3jJBlLFK6AtsX7DF0YQm0VAVeJCXzML
	iM0moCuxqKeZCcQWFQiRmHF5MjNEvaDEyZlPwGpEBNQkJrYdArI5OJgFxCX6/4GFhQUsJdbM
	eMcKYgsJOErcnveHHcTmFHCSmNSyESzOLKAj8a7vATOELS+x/e0c5gmMArOQbJiFpGwWkrIF
	jMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3RN9HIzS/RSU0o3MULClH8HY9d6mUOMAhyMSjy8
	EvElAUKsiWXFlbmHGCU5mJREeV9NKA0Q4kvKT6nMSCzOiC8qzUktPsQowcGsJMJr6gOU401J
	rKxKLcqHSUlzsCiJ86ovUfcTEkhPLEnNTk0tSC2CycpwcChJ8K4GGSpYlJqeWpGWmVOCkGbi
	4AQZziUlUpyal5JalFhakhEPitT4YmCsgqR4gPYKTQTZW1yQmAsUhWg9xajL8bFx3kNGIZa8
	/LxUKXHeGyA7BECKMkrz4FbAktIrRnGgj4UhRvEAExrcpFdAS5iAlshMKgFZUpKIkJJqYOTK
	CV4gXNp3YfGdDXU/99x3W1f5WFVKIaGQ9VYBw86k9txHD6f+SqrkOs/Ac63CtUEmea+r6NLd
	smeceq6ylsmqzCgK83Ob1Sa3sIJJ8ZTWd+4PreE/NsydeFpQ4q2o4Puo3I8Pjx3b 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207415>

On 10/10/2012 09:55 AM, Junio C Hamano wrote:
> It took longer than expected, but here is a reroll of the previous
> series to bring more recent "git grep" enhancements to the "--grep"
> option of commands in "git log" family.
> 
> The early part of the series (1-3) refactors the code that reads
> configuration items related to "grep" and the code that mixes the
> result with the command line options to prepare grep_opt, which so
> far lived in builtin/grep.c, and moves them to the grep.[ch] at the
> top-level.
> 
> The middle part (4-6) reuses the code to set-up grep_opt refactored
> by the earlier part of the series on revs->grep_filter that is used
> in "git log --grep=..." processing.  It incidentally fixes a small
> bug where "git log -F -E --grep='<ere>'" did not look for matches to
> the pattern in extended regular expression, and adds --basic-regexp
> and --perl-regexp command line options to "git log" family for
> completeness.
> 
> The last one teaches "git log" family to honor the "grep.*"
> configuration variables, e.g. "grep.patterntype", so that you can
> say "git -c grep.patterntype=perl log --grep='(?:pcre)'".

Maybe this has been discussed already, but it seems to me that adding a
persistent setting that affects how "git log --grep" interprets the
pattern argument could break some scripts that assume that the "old"
interpretation is always used.  Shouldn't this at least be documented as
a backwards incompatibility?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
