From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 13/14] t4135-*.sh: Skip the "backslash" tests on cygwin
Date: Wed, 22 Dec 2010 08:44:32 +0700
Message-ID: <AANLkTi=-7ihdW_cMiAqnyjbUE_d35OFrSSnQQw4mi64G@mail.gmail.com>
References: <4D07B977.9010502@ramsay1.demon.co.uk> <201012142149.33725.j6t@kdbg.org>
 <4D0A94D8.6090206@ramsay1.demon.co.uk> <201012172254.31242.j6t@kdbg.org> <4D1100A3.2010309@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, jrnieder@gmail.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Dec 22 02:45:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVDlQ-00079A-OR
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 02:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364Ab0LVBpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 20:45:05 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58696 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab0LVBpD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 20:45:03 -0500
Received: by wwa36 with SMTP id 36so4799675wwa.1
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 17:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=bZFcMEvKe6IPacH8iR4z9GnXuDAKIDHdKV1e8nbglKU=;
        b=pp8uUQyuncWYzUbsbMneP01WYmsWW9Biz+2SKeoAiXAAvbix25kCh+Uh31zf7Bs3M7
         gdDBQcXWQ1lGBVD0B+TFGk9SEJRGGisGiLcbA6hv4RaOppd12S4NfZaTB1G6tJfpaWHW
         FyNrolPoYEk6ukM9rIQroB/j+FbbloeG7Omk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=CA32Bi2nbuGvZvhWlZ0ADFNjGAHzNRrhGaSHPmp4ncW1Um1/dA+g4mU2K2jlIGg9hA
         90JGHGi2RFwvmUZFjj7kmS1i/ZwVuT4cDKxGlWlz+KROBgUceiZ7qqGw0RBxUhVxWYGd
         0TX0bPc5jQoxAy6CY9F/Enbe58aEDml+4DNz4=
Received: by 10.216.142.101 with SMTP id h79mr7019590wej.49.1292982302376;
 Tue, 21 Dec 2010 17:45:02 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Tue, 21 Dec 2010 17:44:32 -0800 (PST)
In-Reply-To: <4D1100A3.2010309@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164067>

On Wed, Dec 22, 2010 at 2:31 AM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
> The problem boils down to the call to strncmp_icase() suppressing the call to
> fnmatch() when the pattern contains glob chars, but the (remaining) string is
> equal to the name; thus returning an exact match (MATCHED_EXACTLY) rather than
> calling fnmatch (and returning either no-match or MATCHED_FNMATCH).

I think that's expected behavior. Wildcard pathspecs are fixed
pathspecs will additional wildcard matching support and can match both
ways. See 186d604 (glossary: define pathspec)

> [BTW, I started looking at the history of this function and I think this
> problem has been there for a long time!]

Not only in this function. pathspec_matches() in builtin/grep.c
behaves the same (I think).

> Hmm, I think this is all being rewritten, at the moment (in branch
> nd/struct-pathspec) isn't it?

Yes. Thanks for pulling me in. I didn't know recent match_one() has
case-insensitive support.
-- 
Duy
