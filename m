From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH] bisect--helper: `bisect_clean_state` shell function
 in C
Date: Tue, 31 May 2016 06:25:19 +0200
Message-ID: <574D122F.7080608@alum.mit.edu>
References: <20160530182148.18801-1-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: larsxschneider@gmail.com, chriscool@tuxfamily.org,
	christian.couder@gmail.com, peff@peff.net
To: Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 06:25:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7bF9-0006yz-N0
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 06:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbcEaEZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 00:25:24 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:55194 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751828AbcEaEZX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 00:25:23 -0400
X-AuditID: 1207440c-c53ff70000000b85-ab-574d12316980
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 58.AE.02949.1321D475; Tue, 31 May 2016 00:25:22 -0400 (EDT)
Received: from [192.168.69.130] (p508EABD0.dip0.t-ipconnect.de [80.142.171.208])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u4V4PJpe025167
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 31 May 2016 00:25:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <20160530182148.18801-1-pranit.bauva@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsUixO6iqGsk5Btu0NXMbLHp+URmi9szW5gt
	uq50M1k8friE1eJHSw+zxf+v21gc2Dx2zrrL7vGsdw+jx/IHr9g9Pm+SC2CJ4rZJSiwpC85M
	z9O3S+DOOHrjKmvBPL6KhksJDYx/uLsYOTkkBEwkbvw9x9zFyMUhJLCVUWJt0x5WCOcCk8Tl
	5q/sIFXCAsESN+7MZQSxRQTsJCZNe88EYgsJWEt8utYL1M3BwSyQKXF1MSdImE1AV2JRTzMT
	SJhXQFvi8DMOkDCLgKrEzQn7wDpFBUIkzq/bygpi8woISpyc+YQFpJxTwEai7asXSJhZQE9i
	x/VfrBC2vMT2t3OYJzDyz0LSMQtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrq
	5WaW6KWmlG5ihIQxzw7Gb+tkDjEKcDAq8fBGdPuEC7EmlhVX5h5ilORgUhLltfoNFOJLyk+p
	zEgszogvKs1JLT7EKMHBrCTC6yDoGy7Em5JYWZValA+TkuZgURLnVV2i7ickkJ5YkpqdmlqQ
	WgSTleHgUJLg/SMA1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPisX4YmA0gqR4
	gPZOBGnnLS5IzAWKQrSeYtTlOLL/3lomIZa8/LxUKXHeYyBFAiBFGaV5cCtgSesVozjQx8K8
	USAv8AATHtykV0BLmICWxGf4gCwpSURISTUw5gg/UDzPbH28+JGTr4fyJb6DfxoOHD4ia3Hz
	xCbTXatv5v26F7n4fdrunWIMnRNLp8zvePX86KSdx9slNrXP1Ll4ZhWLCePjS7pS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295949>

On 05/30/2016 08:21 PM, Pranit Bauva wrote:
> Reimplement `bisect_clean_state` shell function in C and add a
> `bisect-clean-state` subcommand to `git bisect--helper` to call it from
> git-bisect.sh .
> 
> Using `bisect_clean_state` subcommand is a measure to port shell
> function to C so as to use the existing test suite. As more functions
> are ported, this subcommand will be retired and will be called by
> bisect_reset() and bisect_start().
> 
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> This patch contains a bug. I have tried to identify the bug and I suppose it
> exists in do_for_each_entry_in_dir(). I have reproduced the debugging session
> at this link[1]. I have seen that some patches in mailing list regarding
> iterating over refs. Will those affect this? Or is this bug fixed in those
> patches?

The problem is that it is not legal to modify references while iterating
over them. See [1]. Your remove_bisect_ref() callback function deletes
references, which modifies the reference cache that is being iterated over.

Instead I suggest that your remove_bisect_ref() add the references to a
string_list, then call delete_refs() *after* the iteration is over.
Alternatively, you can change remove_bisect_ref() to call
ref_transaction_delete() to add reference deletions to a
ref_transaction, then call ref_transaction_commit() after the iteration
is over. See the rm() function in builtin/remote.c [2] for an example.

[1]
https://github.com/git/git/blob/f3913c2d03abc660140678a9e14dac399f847647/refs.h#L176-L184
[2]
https://github.com/git/git/blob/f3913c2d03abc660140678a9e14dac399f847647/builtin/remote.c#L738

> [...]

Michael
