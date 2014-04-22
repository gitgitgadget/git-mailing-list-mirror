From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [SECURITY PATCH] git-prompt.sh: don't put unsanitized branch
 names in $PS1
Date: Tue, 22 Apr 2014 10:38:46 +0200
Message-ID: <53562A96.6000002@alum.mit.edu>
References: <1398107248-32140-1-git-send-email-rhansen@bbn.com> <20140421202454.GA6062@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sitaramc@gmail.com
To: Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 10:38:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcWED-0003Gr-7W
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 10:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834AbaDVIiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 04:38:52 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:65264 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752138AbaDVIiu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Apr 2014 04:38:50 -0400
X-AuditID: 1207440d-f79d86d0000043db-b7-53562a9918ad
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 0E.2F.17371.99A26535; Tue, 22 Apr 2014 04:38:49 -0400 (EDT)
Received: from [192.168.69.130] (p4FC975D0.dip0.t-ipconnect.de [79.201.117.208])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3M8clgY007101
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 22 Apr 2014 04:38:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <20140421202454.GA6062@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsUixO6iqDtTKyzYYN0ndYuuK91MFj9aepgt
	DrUkWax+fIfdgcVj6vlQj52z7rJ7POvdw+jxeZNcAEsUt01SYklZcGZ6nr5dAnfG1NVf2Qu+
	81Vc6vnB3MA4l6eLkZNDQsBEYu6qyWwQtpjEhXvrgWwuDiGBy4wSl/cfYoVwLjBJnPq/lB2k
	ildAW+L0hUlgNouAqsTJYzNYQWw2AV2JRT3NTF2MHByiAkESf84qQpQLSpyc+YQFJCwiYC8x
	9TXYLmagKf8vrGECsYUFIiVW7r3AAmILCeRKTFn7DqycU8BKYtY+URBTQkBcoqcxCMRkFlCX
	WD9PCGKIvMT2t3OYJzAKzkKyahZC1SwkVQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrp
	5WaW6KWmlG5ihIQ27w7G/+tkDjEKcDAq8fBKGoQGC7EmlhVX5h5ilORgUhLl5dIMCxbiS8pP
	qcxILM6ILyrNSS0+xCjBwawkwtsEkuNNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgt
	gsnKcHAoSfAeBWkULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB8VtfDEwckFSPEB7
	D4DtLS5IzAWKQrSeYtTluNCwooVJiCUvPy9VSpw3CKRIAKQoozQPbgUskb1iFAf6WJj3FkgV
	DzAJwk16BbSECWjJky0hIEtKEhFSUg2MzrvLzibOKTDsPHm6gOfbksYCM8Vtf6fKFUxv23Tm
	RanHy+47v+5p/wi5LCOhJalzyijX4Izi8c2tp+O26O29/fJ1h4ajAcervQWP5oaV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246719>

On 04/21/2014 10:24 PM, Jeff King wrote:
> On Mon, Apr 21, 2014 at 03:07:28PM -0400, Richard Hansen wrote:
> 
>> Both bash and zsh subject the value of PS1 to parameter expansion,
>> command substitution, and arithmetic expansion.  Rather than include
>> the raw, unescaped branch name in PS1 when running in two- or
>> three-argument mode, construct PS1 to reference a variable that holds
>> the branch name.  Because the shells do not recursively expand, this
>> avoids arbitrary code execution by specially-crafted branch names such
>> as '$(IFS=_;cmd=sudo_rm_-rf_/;$cmd)'.
> 
> Cute. We already disallow quite a few characters in refnames (including
> space, as you probably discovered), and generally enforce that during
> ref transfer. I wonder if we should tighten that more as a precuation.
> It would be backwards-incompatible, but I wonder if things like "$" and
> ";" in refnames are actually useful to people.

While we're at it, I think it would be prudent to ban '-' at the
beginning of reference name segments.  For example, reference names like

    refs/heads/--cmd=/sbin/halt
    refs/tags/--exec=forkbomb(){forkbomb|forkbomb&};forkbomb

are currently both legal, but I think they shouldn't be.  I wouldn't be
surprised if somebody could find a way to exploit
references-named-like-command-line-options.

At a minimum, it is very difficult to write scripts robust against such
names.  Some branch- and tag-oriented commands *require* short names and
don't allow the full reference name including refs/heads/ or refs/tags/
to be specified.  In such cases there is no systematic way to prevent
the names from being seen as command-line options.  And '--' by itself,
which many Unix commands use to separate options from arguments, has a
different meaning in Gitland.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
