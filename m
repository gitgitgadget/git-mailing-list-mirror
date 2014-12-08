From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: Blobs not referenced by file (anymore) are not removed by GC
Date: Mon, 8 Dec 2014 16:47:49 +0000
Message-ID: <CAFY1edarWL1B72ZO0m=RALJ+p3KtnBBX9qQ85iueU6EVD0akaA@mail.gmail.com>
References: <5485D03F.3060008@fu-berlin.de>
	<CAFY1edaEq1zYV0vgSfiPAXU6bqVBzaA-apVnSn8DBMbzcAa2tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin Scherer <m.scherer@fu-berlin.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 17:48:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy1Tc-0006ds-5p
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756064AbaLHQrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:47:52 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:58352 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756008AbaLHQru (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 11:47:50 -0500
Received: by mail-ig0-f176.google.com with SMTP id l13so3185742iga.15
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 08:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5aRETB5J6jIe8VuZxsiD0y5J1VJg4BWVj9Cx3N3q5XI=;
        b=VYMVw2mGVzJX2UcS39StJvuw5BGMc4J5OtuQc9323itkdwphvWw4s2rX2IA1T4fCyt
         nr1Z2LXUYXYntfQVeLnaOLdiP/Oa9E9S7SuKgjYbr81AFX9LPuIqB1dtc+KqoooEq+cJ
         ehNy5pqYfrktWQjnD8p8eGxGFLPxCWa+2Pt1E90wdH6eu1+jKEfjckX771Pd/N4s2gmm
         RO+9MYa79ZeR4/ARHoqBpSeujXydcsZTxir7LxF1XGAMLs0Gi4P9QOhLanzaHzUwC8B0
         KVwNn7oci55kuuEU3SiBd+6H9+cZC0BmnxEiM4Mg52d0IcMwD5d2/2AU4SDZIS0JmVvT
         NMFw==
X-Received: by 10.50.103.3 with SMTP id fs3mr15454107igb.6.1418057269311; Mon,
 08 Dec 2014 08:47:49 -0800 (PST)
Received: by 10.64.240.171 with HTTP; Mon, 8 Dec 2014 08:47:49 -0800 (PST)
In-Reply-To: <CAFY1edaEq1zYV0vgSfiPAXU6bqVBzaA-apVnSn8DBMbzcAa2tQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261079>

Hi Martin, I'm the developer of the BFG - I'd guess that there
probably isn't a bug for Git developers here, so you might want to
open one or more issues at
https://github.com/rtyley/bfg-repo-cleaner/issues, where I'd be happy
to take a look.

best regards,
Roberto

> On 8 Dec 2014 16:35, "Martin Scherer" <m.scherer@fu-berlin.de> wrote:
>>
>> Hi,
>>
>> after using BFG on a repo given certain directory globs, all of those
>> files(names) are gone from history, but can not be collected by garbage
>> collection anymore. So the blobs of the underlying files are not deleted
>> and only the file names are not associated with the blob anymore. I
>> wonder, if I discovered a bug (at least in bfg). But I expect git to
>> discover that this blobs are not used in any way (so they have to
>> associated to something right?)
>>
>> # invoke bfg --delete-folders something multiple times with different
>> pattern.
>>
>> # try to cleanup
>>
>> git gc --aggressive --prune=now # big blobs still in history
>> git fsck # no results
>> git fsck --full  --unreachable --dangling # no results
>>
>> to verify if the blobs are still there, see the output of
>>
>> git gc && git verify-pack -v .git/objects/pack/pack-*.idx | egrep "^\w+
>> blob\W+[0-9]+ [0-9]+ [0-9]+$" | sort -k 3 -n -r > bigobjects
>> .txt
>>
>> head bigobjects.txt # outputs 9451427d7335395779b91864418630d2f0af780a
>> blob   7895212 1869047 7657491
>>
>>
>> Also if bfg is being told to remove the biggest blob (bfg -B 1) with
>> no-blob-protection, it does not succeed in removing it.
>>
>> --- output of bfg -B 1
>>
>> Found 1 blob ids for large blobs - biggest=7895212 smallest=7895212
>> ....
>>
>> BFG aborting: No refs to update - no dirty commits found??
>> ---
>>
>> The repo can be found here.
>>
>> https://github.com/marscher/stallone_stale_objects
>>
>> I will restart all over to cleanup the history, but I guess this might
>> be interesting for git developers.
>>
>>
>> Best,
>> Martin
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
