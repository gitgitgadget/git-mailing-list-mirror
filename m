From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 14/13] wildmatch: fix tests that fail on Windows due to
 path mangling
Date: Wed, 07 Nov 2012 20:32:58 +0100
Message-ID: <509AB76A.3070700@kdbg.org>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com> <1350282362-4505-1-git-send-email-pclouds@gmail.com> <1350282362-4505-13-git-send-email-pclouds@gmail.com> <5096D76F.5090907@kdbg.org> <CACsJy8DEH53mA4fDyZwbVsbyGcNY8b54Sn1p5-rto6r_h48dkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 20:33:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWBNH-0006Sr-CB
	for gcvg-git-2@plane.gmane.org; Wed, 07 Nov 2012 20:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053Ab2KGTdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2012 14:33:04 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:18662 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966Ab2KGTdD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2012 14:33:03 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6AE672C4003;
	Wed,  7 Nov 2012 20:32:59 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id AA73A19F411;
	Wed,  7 Nov 2012 20:32:58 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121025 Thunderbird/16.0.2
In-Reply-To: <CACsJy8DEH53mA4fDyZwbVsbyGcNY8b54Sn1p5-rto6r_h48dkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209139>

Am 06.11.2012 13:47, schrieb Nguyen Thai Ngoc Duy:
> On Mon, Nov 5, 2012 at 4:00 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Patterns beginning with a slash are converted to Windows paths before
>> test-wildmatch gets to see them. Use a different first character.
> 
> Or we could prepend the paths with something, which is then cut out by
> test-wildmatch. Not sure if it's intuitive to look at the tests
> though.

That would be a possibility, too.

>>  After this change, there are still 3 failing tests that are in connection
>>  with [[:xdigit:]]. Don't know, yet, what's going on there.
> 
> the wildmatch tests or fnmatch ones?

fnmatch ones:

ok 147 - wildmatch:    match '5' '[[:xdigit:]]'
not ok 148 - fnmatch:      match '5' '[[:xdigit:]]'
#
#                   test-wildmatch fnmatch '5' '[[:xdigit:]]'
#
ok 149 - wildmatch:    match 'f' '[[:xdigit:]]'
not ok 150 - fnmatch:      match 'f' '[[:xdigit:]]'
#
#                   test-wildmatch fnmatch 'f' '[[:xdigit:]]'
#
ok 151 - wildmatch:    match 'D' '[[:xdigit:]]'
not ok 152 - fnmatch:      match 'D' '[[:xdigit:]]'
#
#                   test-wildmatch fnmatch 'D' '[[:xdigit:]]'
#

She same tests fail on Linux, BTW, when built with NO_FNMATCH=1 and the
"#if defined _LIBC || !defined __GNU_LIBRARY__" brackets removed.

-- Hannes
