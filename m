From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Tue, 01 Dec 2009 11:00:20 +0100
Message-ID: <4B14E934.9090304@viscovery.net>
References: <4B1168D4.5010902@syntevo.com> <4B11AD43.3070307@gmail.com> <4B123C80.30607@syntevo.com> <4B14CA79.6040408@syntevo.com> <4B14D381.3010706@viscovery.net> <4B14DA1A.4060505@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 11:00:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFPX6-0002Et-28
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 11:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824AbZLAKAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 05:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753736AbZLAKAS
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 05:00:18 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:65049 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753696AbZLAKAR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 05:00:17 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NFPWv-0000E4-Q2; Tue, 01 Dec 2009 11:00:22 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 23CB51660F;
	Tue,  1 Dec 2009 11:00:20 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B14DA1A.4060505@syntevo.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Singer schrieb:
> Is it a German Windows limitation, that far-east characters are not
> supported on it (but work fine on a Japanese Windows), are there different
> (mysys)Git versions available or is this a configuration issue?

It is a matter of configuration.

Since 8 bits are not sufficient to support Japanese alphabet in addition
to the German alphabet, programs that are not Unicode aware -- such as git
-- have to make a decision which alphabet they support. The decision is
made by picking a "codepage".

On German Windows, you are in codepage 850 (in the console). The filenames
 (that actually are in Unicode) are converted to bytes according to
codepage 850 *before* git sees them. If your filenames contain Hiragana,
they are substituted by the "unknown character" marker because there is no
place for them in codepage 850.

However, you can install Japanese language support on German Windows. Then
you can change your console to codepage 932:

  chcp 932

When you run git from *this* console, Hiragana in the filenames are
converted to cp932 before git sees them. The resulting byte sequence is
different from the one in cp850, but git will be able to see that the file
exists and was modified, and you can 'git add' it.

But if you have files with umlauts, they will not be recognized anymore
because umlauts have no place in cp932.

In neither case can you exchange the repository with Linux if you have
your locale set to UTF-8 on Linux, because neither byte sequence (umlauts
from cp850 or Hiragana from cp932) are valid UTF-8 sequences, let alone
result in the expected glyphs.

Corollary: Stick to ASCII file names.

There have been suggestions to switch the console to codepage 65001
(UTF-8), but I have never heard of success reports. I'm not saying it does
not work, though.

-- Hannes
