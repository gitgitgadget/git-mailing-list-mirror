From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Tue, 01 Dec 2009 13:08:39 +0100
Message-ID: <4B150747.2030900@syntevo.com>
References: <4B1168D4.5010902@syntevo.com> <4B11AD43.3070307@gmail.com> <4B123C80.30607@syntevo.com> <4B14CA79.6040408@syntevo.com> <4B14D381.3010706@viscovery.net> <4B14DA1A.4060505@syntevo.com> <4B14E934.9090304@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 01 13:08:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFRWk-0002o6-KC
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 13:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001AbZLAMIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 07:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753710AbZLAMIG
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 07:08:06 -0500
Received: from syntevo.com ([85.214.39.145]:35297 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753567AbZLAMIF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 07:08:05 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id F2D6837C7B0
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B14E934.9090304@viscovery.net>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134200>

Johannes Sixt wrote:
> Thomas Singer schrieb:
>> Is it a German Windows limitation, that far-east characters are not
>> supported on it (but work fine on a Japanese Windows), are there different
>> (mysys)Git versions available or is this a configuration issue?
> 
> It is a matter of configuration.
> 
> Since 8 bits are not sufficient to support Japanese alphabet in addition
> to the German alphabet, programs that are not Unicode aware -- such as git
> -- have to make a decision which alphabet they support. The decision is
> made by picking a "codepage".
> 
> On German Windows, you are in codepage 850 (in the console). The filenames
>  (that actually are in Unicode) are converted to bytes according to
> codepage 850 *before* git sees them. If your filenames contain Hiragana,
> they are substituted by the "unknown character" marker because there is no
> place for them in codepage 850.
> 
> However, you can install Japanese language support on German Windows. Then
> you can change your console to codepage 932:
> 
>   chcp 932
> 
> When you run git from *this* console, Hiragana in the filenames are
> converted to cp932 before git sees them. The resulting byte sequence is
> different from the one in cp850, but git will be able to see that the file
> exists and was modified, and you can 'git add' it.
> 
> But if you have files with umlauts, they will not be recognized anymore
> because umlauts have no place in cp932.
> 
> In neither case can you exchange the repository with Linux if you have
> your locale set to UTF-8 on Linux, because neither byte sequence (umlauts
> from cp850 or Hiragana from cp932) are valid UTF-8 sequences, let alone
> result in the expected glyphs.
> 
> Corollary: Stick to ASCII file names.
> 
> There have been suggestions to switch the console to codepage 65001
> (UTF-8), but I have never heard of success reports. I'm not saying it does
> not work, though.

Thanks for the detailed explanation. I know the differences between bytes
and characters and the needed *encoding* to convert from one to another, but
I did not know how Git handles it. I'm quite surprised, that -- as I
understand you -- msys-Git (or Git at all?) is not able to handle all
characters (aka unicode) at the same time. I expected it would be better
than older tools, e.g. SVN.

BTW, we are invoking the Git executable from Java. Is there automatically a
console "around" Git? Should we invoke a shell-script (which sets the
console's code page) instead of the Git executable directly?

-- 
Tom
