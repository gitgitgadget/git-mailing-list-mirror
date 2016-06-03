From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] t1308: do not get fooled by symbolic links to the source
 tree
Date: Fri, 3 Jun 2016 08:53:52 +0200
Message-ID: <57512980.1070200@kdbg.org>
References: <xmqqzir53mdc.fsf@gitster.mtv.corp.google.com>
 <712e0755-6008-21f5-0ee6-25ed9d97fd45@web.de>
 <xmqq1t4ftheu.fsf@gitster.mtv.corp.google.com>
 <xmqqwpm7s2ex.fsf@gitster.mtv.corp.google.com>
 <20160602213920.GA13356@sigill.intra.peff.net>
 <xmqqeg8fs0dw.fsf_-_@gitster.mtv.corp.google.com> <57511E44.1090708@kdbg.org>
 <20160603061023.GA7687@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 03 08:54:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8izX-000125-AH
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 08:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbcFCGxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 02:53:55 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:16542 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437AbcFCGxy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 02:53:54 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rLZZ83QvGz5tlc;
	Fri,  3 Jun 2016 08:53:52 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 1647E52C2;
	Fri,  3 Jun 2016 08:53:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <20160603061023.GA7687@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296270>

Am 03.06.2016 um 08:10 schrieb Jeff King:
> On Fri, Jun 03, 2016 at 08:05:56AM +0200, Johannes Sixt wrote:
>
>>> -	name=$(pwd)/.gitconfig
>>> +	name=$HOME/.gitconfig
>>
>> I haven't tested this, yet, but my guess is that this breaks on Windows:
>> test-config will produce C:/foo style path, but the updated test would
>> expect /c/foo style path. Dscho, do you have an idea how to fix this?
>
> Hmm. This should come directly from expand_user_path("~/.gitconfig")
> which prepends the literal contents of the $HOME variable. It does go
> through convert_slashes() afterwards, but I don't see any other
> massaging (but I won't be surprised when you tell me there is some that
> happens behind the scenes).

Yes, it happens behind the scenes: /c/foo absolute paths are a 
convention used by the POSIX emulation layer (MSYS). When bash (an MSYS 
program) runs a non-MSYS program such as git or test-config, it converts 
the /c/foo paths in the environment (and argument list) to c:/foo style 
because the non-MSYS programs do not understand the MSYS convention.

-- Hannes
