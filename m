From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 3/3] t9001: use older Getopt::Long boolean prefix '--no'
 rather than '--no-'
Date: Thu, 23 Dec 2010 10:45:56 -0600
Message-ID: <_1hzkErx0quc_gF2Ej78xfngJOZd0RMiZQaYIRcFD87zYn8eAiFJUQ@cipher.nrlssc.navy.mil>
References: <jpN7nm-rtl4sNXi5qt9pXMafcDOI0AxF95o77x_r5JQwZeaH94BApUuIwonUaYfzmYTgqeFNpSm6S7VFnIZVag@cipher.nrlssc.navy.mil> <jpN7nm-rtl4sNXi5qt9pXHOvlLOZP9xRq2h9eZev444l6GTi02jDn5C-Llxwsz3_tVhVKGvU5Vryto5cM6uchw@cipher.nrlssc.navy.mil> <7vlj3g326l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 23 17:47:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVoJk-00079D-ET
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 17:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281Ab0LWQq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Dec 2010 11:46:58 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57906 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117Ab0LWQq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Dec 2010 11:46:58 -0500
Received: by mail.nrlssc.navy.mil id oBNGjv7N009562; Thu, 23 Dec 2010 10:45:57 -0600
In-Reply-To: <7vlj3g326l.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 23 Dec 2010 16:45:57.0202 (UTC) FILETIME=[DF2F2320:01CBA2C0]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164130>

On 12/23/2010 10:05 AM, Junio C Hamano wrote:
> This still leaves --no-bcc, --no-to and --no-cc in "no-foo overrides
> sendemail.foo" tests, it seems.  Do they also need to be fixed?

No, those are handled completely separately.  The --chainreplyto
option is a boolean option, and the '--no' prefix is an automatic
feature that is provided by Getopt::Long for boolean options (i.e.
those suffixed with '!').

The three options you mentioned are actually distinct options that
are configured in the call to GetOptions and are named so that they
appear to be 'no-' prefixed automatic versions of --bcc, --to, and
--cc, just like the boolean options.  But there is really just a
separate option named --no-bcc, that sets the variable $no_bcc that
is distinct from the --bcc option which populates @bcclist.

So, people with a somewhat old Getopt::Long (or those accustomed
to prefixing '--no' without the dash) may get confused when they
have to leave off the dash when negating --chainreplyto as
--nochainreplyto, but _must_ use the dash when typing --no-bcc.
If we want to be consistent with Getopt::Long which accepts both
'--no-' and '--no', then we could add --nobcc, --noto, and --nocc.
Not sure if it's worth the trouble.

-Brandon
