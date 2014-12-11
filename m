From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 2/5] glossary: introduce glossary lookup command
Date: Thu, 11 Dec 2014 16:23:58 +0100
Message-ID: <5489B70E.2040604@drmicha.warpmail.net>
References: <cover.1418052470.git.git@drmicha.warpmail.net>	<585191103e7bdd21ed422324504b6503bec2b914.1418052470.git.git@drmicha.warpmail.net> <xmqqa92vf7ao.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 16:24:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xz5b4-00023d-SA
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 16:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbaLKPYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 10:24:01 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45673 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964877AbaLKPYA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Dec 2014 10:24:00 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 8C7DA20BD5
	for <git@vger.kernel.org>; Thu, 11 Dec 2014 10:23:59 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Thu, 11 Dec 2014 10:23:59 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=oGhvi7eH5Q9rSBWG9qm27B
	n7eeA=; b=bW5vzCCxmDxlStkYR2vLfmCFJAIA6iObno5NB7u91zA6bSNEIQ/ZLP
	AisxsQHEGSusYUUBH9cPv7IJQhGTKEfSN73UiU9cDR4U1dZLUylzKCZ+T45xo4RE
	tXJXD4L6Qxcc27A7wGv/t1yth3zDZh7XRUtTxDDcXMtLp3LOOTsnQ=
X-Sasl-enc: 0j+/ogww+wjoNYHYVkKt4IxAuMjZAuKvy9XYxRsdC0jR 1418311439
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1630AC00282;
	Thu, 11 Dec 2014 10:23:58 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqqa92vf7ao.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261281>

Junio C Hamano schrieb am 10.12.2014 um 23:50:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> When using a localised git, there are many reasons why a correspondence
>> between English and localised git terms is needed:
>> - connect localised messages with English ones (porcelain vs. plumbing)
>> - connect localised messages with English man pages or online docs
>> - help out someone in a different locale
>>
>> Introduce a `git glossary' command that leverages the existing infrastructure
>> in three possible ways:
>> - `git glossary' lists all glossary terms along with their translation
>> - `git glossary foo' matches `foo' in the glossary (both English and
>>   localisation; partial matches shown)
>> - `git glossary -a foo' matches `foo' in the git message catalogue
>>   (English, exact match only).
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> Some bike-shedding expected regarding the interface...
>> Once I've learned how to test l10n stuff, this will be amended.
> 
> This is interesting.
> 
> I wondered if we want to also have the associated documentation in
> response to a query, but I am not sure how well that would go
> without having a translated glossary at least.  I.e. pulling the

Yes, I think we would need something different then. The glossary
entries are asciidoc which we can't format easily from the glossary
command. I really think of the glossary command as being orthogonal to
the definitory glossary. I guess I should name it "translate" instead.

It's just that I don't know how to do the translation from the locale
back to English for stuff in the message catalogue (i.e. how to search
the translations), unless I list the msgids the way I do for the
glossary terms. It could be any list of terms. The glossary seemed to be
a good place for that list of most important terms which users may want
to translate both ways.

> original from glossary-content.txt would produce something like
> this:
> 
> 	$ LANG=de git glossary -l blob object
>         Blob-Objekten
> 	Untyped <<def_object,object>>, e.g. the contents of a file.
> 
> which is not ideal.
> 
> I noticed that you allow querying more than one term from the
> command line, so the above example would not work quite well, as we
> would end up querying "blob" and then "object", not a single term
> "blob object" which does have N_() translation in <glossary.h>.

Exactly, one would need to query for "blob object". Or we concatenate
arguments automatically, but I think being able to query multiple terms
(also) is more useful.

Michael
