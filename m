From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Disallow '\' in ref names
Date: Fri, 08 May 2009 10:04:28 +0200
Message-ID: <4A03E78C.8000801@viscovery.net>
References: <1241760757-26068-1-git-send-email-robin.rosenberg@dewire.com> <4A03D776.6070309@op5.se> <4A03DC9C.2050204@viscovery.net> <4A03E343.4020000@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, gitster@pobox.com,
	git@vger.kernel.org, spearce@spearce.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri May 08 10:04:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2L4c-0002cN-AM
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 10:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757553AbZEHIEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 04:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754696AbZEHIEd
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 04:04:33 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:42850 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582AbZEHIEb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 04:04:31 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M2L4G-0000rs-Es; Fri, 08 May 2009 10:04:28 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 328884E4; Fri,  8 May 2009 10:04:28 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A03E343.4020000@op5.se>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118582>

Andreas Ericsson schrieb:
> Johannes Sixt wrote:
>> Andreas Ericsson schrieb:
>>> Robin Rosenberg wrote:
>>>> This is asking for trouble since '\' is a directory separator in
>>>> Windows and thus may produce unpredictable results.
>>>>
>>> NAK. We allow / on unixy systems, and that's the path separator there.
>>> Junio even makes extensive use of it to create per-contributor
>>> namespaces for topic-branches.
>>>
>>> Are you guessing this might be a problem in the future, or have you
>>> actually run into it?
>>
>> This is not possible on Windows:
>>
>> $ git update-ref refs/heads/foo\bar HEAD
>> fatal: Unable to create '.git/refs/heads/foo\bar.lock': No such file or
>> directory
>>
>> The problem is that git doesn't create the directory .git/refs/heads/foo
>> because the ref handling only mkdir()s directories that were split off
>> from the ref at forward-slashes.
>>
> 
> Ok. Isn't the slash -> backslash conversion thing supposed to be done by
> a macro? I seem to remember something about PATH_DELIM.

It is is_dir_sep(). This macro is only used with pathspec, not with refs.
Therefore, backslashes in refs enter git unaltered and cause havoc on
Windows because git internally only knows how to treat forward-slashes in
refs in a special way.

Note that using is_dir_sep() in refs is not a solution because then refs
that were read from the file system would be reported with a forward-slash.

>> The decision not to mangle command line arguments that are refs (on
>> Windows) was intentional. (We do mangle pathspec, i.e. we convert '\' to
>> '/'.) But back then I did not think about what should happen if a ref
>> contains a backslash.
> 
> But what about when locating directory cutoffs for mkdir() stuff?

I can't parse your statement. ;)

-- Hannes
