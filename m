From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git-push: forced update of tag shows unabbreviated SHA1
Date: Thu, 31 Jan 2008 11:01:35 +0100
Message-ID: <47A19C7F.1060204@viscovery.net>
References: <47A1948F.6080308@viscovery.net> <7vsl0ecp3i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 11:02:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKWFI-0002lE-CI
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 11:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbYAaKBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 05:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753239AbYAaKBk
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 05:01:40 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:45927 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbYAaKBj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 05:01:39 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JKWER-0001RJ-QQ; Thu, 31 Jan 2008 11:01:20 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3D6FC6B7; Thu, 31 Jan 2008 11:01:35 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vsl0ecp3i.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72116>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> This is just a cosmetical flaw:
>> ...
>> To file:///home/jsixt/tmp/foo/B/../A
>>  + 639669ce44f84417f30842c622064827dda01461...475e55f T -> T (forced update)
>>
>> Notice that the original SHA1 is not abbreviated.
> 
> I suspect that is because you do not _have_ the original object,
> so there is no uniquely usable abbreviation to name the object
> in your repository.

Yes, you are right. This also happens for a commit.

> This obviously is not tested at all (not even compile tested),
> but I think it would show you what is going on.
> 
> ---
>  builtin-send-pack.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/builtin-send-pack.c b/builtin-send-pack.c
> index 8afb1d0..9c558ee 100644
> --- a/builtin-send-pack.c
> +++ b/builtin-send-pack.c
> @@ -265,7 +265,7 @@ static const char *status_abbrev(unsigned char sha1[20])
>  {
>  	const char *abbrev;
>  	abbrev = find_unique_abbrev(sha1, DEFAULT_ABBREV);
> -	return abbrev ? abbrev : sha1_to_hex(sha1);
> +	return abbrev ? abbrev : "<you do not have it>";
>  }

No, that would be information hiding. I prefer an unabbreviated name.
Nevertheless, if we know the name, we could be able to find a suitable
abbreviation. But it's really not *that* important...

-- Hannes
