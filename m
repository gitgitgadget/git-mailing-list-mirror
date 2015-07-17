From: Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v2] gitk: Add a "Copy commit summary" command
Date: Fri, 17 Jul 2015 11:16:56 +0200
Message-ID: <748fbe6a4bf00ec8afcd6e4c7d5176bb@drbeat.li>
References: <1m7p7z9.36ajnyli8ph2M%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <gitster@pobox.com>, <git@vger.kernel.org>, <paulus@samba.org>
To: <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Fri Jul 17 11:17:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG1lW-0000rz-S3
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 11:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbbGQJRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 05:17:04 -0400
Received: from mx1.2b3w.ch ([92.42.186.250]:33171 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932546AbbGQJQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 05:16:59 -0400
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id D4137C33DD;
	Fri, 17 Jul 2015 11:16:56 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_RELAYS
	autolearn=ham version=3.3.2
Received: by mx1.2b3w.ch (Postfix, from userid 33)
	id BAB40C3442; Fri, 17 Jul 2015 11:16:56 +0200 (CEST)
X-PHP-Originating-Script: 0:main.inc
In-Reply-To: <1m7p7z9.36ajnyli8ph2M%lists@haller-berlin.de>
X-Sender: dev+git@drbeat.li
User-Agent: Roundcube Webmail/0.7.2
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274063>

On 2015-07-17 10:50, lists@haller-berlin.de wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Beat Bolli <dev+git@drbeat.li> writes:
>>
>> > When referring to earlier commits in commit messages or other 
>> text, one
>> > of the established formats is
>> >
>> >     <abbrev-sha> ("<summary>", <author-date>)
>> > ...
>> > +proc copysummary {} {
>> > +    global rowmenuid commitinfo
>> > +
>> > +    set id [string range $rowmenuid 0 7]
>> > +    set info $commitinfo($rowmenuid)
>> > +    set commit [lindex $info 0]
>>
>> 7 hexdigits is not always an appropriate value for all projects.
>> The minimum necessary to guarantee uniqueness varies on project, and
>> it is not a good idea to hardcode such a small value.  Not-so-old
>> Linux kernel history seems to use at least 12, for example.
>>
>> I believe that the "one of the established formats" comes from a
>> "git one" alias I published somewhere long time ago, that did
>> something like this:
>>
>>   git show -s --abbrev=8 --pretty='format:%h (%s, %ai' "$@" |
>>   sed -e 's/ [012][0-9]:[0-5][0-9]:[0-5][0-9] 
>> [-+][0-9][0-9][0-9][0-9]$/)/'
>>
>> where the combination of --abbrev=8 and format:%h asks for a unique
>> abbreviation that is at least 8 hexdigits long but can use more than
>> 8 if it is not long enough to uniquely identify the given commit.
>
> For the intended use case of this feature (referring to earlier 
> commits
> in commit messages), guaranteeing uniqueness isn't sufficiant either.
> What is unique at the time of creating the commit might no longer be
> unique a few years later.

This is true, but the purpose of the format with the summary text and 
date
is exactly to make it redundant enough that the hash doesn't have to be 
unique
in eternity.

> So one strategy would be to add one or two digits to what %h returns, 
> to
> give some future leeway; or rely on the user to configure core.abbrev
> appropriatly for their project; or just make the hard-coded value
> configurable, as Hannes suggests.
>
> FWIW, a discussion of this that I find useful can be found here:
> <http://blog.cuviper.com/2013/11/10/how-short-can-git-abbreviate/>.
