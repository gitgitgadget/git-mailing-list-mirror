From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug#757297: 'git status' output is confusing after 'git add -N'
Date: Thu, 07 Aug 2014 09:31:41 -0700
Message-ID: <xmqqmwbgl0r6.fsf@gitster.dls.corp.google.com>
References: <20140807003449.GC12427@google.com>
	<CACsJy8DnWZfKqwjOjjU17YtN1Zqk0vy5nyfOBLjn-RiJkKCo6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, 757297@bugs.debian.org,
	Git Mailing List <git@vger.kernel.org>,
	submit@bugs.debian.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 18:32:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFQbc-0002gv-CQ
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 18:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbaHGQbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 12:31:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52374 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932084AbaHGQbv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 12:31:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 177C32E95D;
	Thu,  7 Aug 2014 12:31:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dKWLl/U9b41eDeLEWzVjfnUu8ow=; b=EK4C4F
	U3Tugn9cM7d6MEiTS1/9NcAkRn/YYWRlY0aHIp+jR9JUExtuj0nsycbiDhHSAZDs
	TJnK2APSAxwQS0ZFjS4gvmKHtG+CjjDB/d3NDRPxmWiCLgOZ65j7J7nRl5LzAM20
	jWT2nZvwMf0SK8FMEf9akZHE5zVeQkCnA+VNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VRTZ6+dBZ0jIfXG9EzUWJsYK+OUFfQRp
	U9prtvKnS97DrY36xBHYFrNkhN2o7+3U5jYfg+44Az4pB6i/tHqhZDGJat3VgU2W
	zBSqtgQ4xLH8s6V3Q3gNatURm1I5liXW0tuKrIni/eB3+PKEB8/AdWxn4iBML/TK
	5yBL3U6Rlyo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0D0C92E95C;
	Thu,  7 Aug 2014 12:31:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4298E2E950;
	Thu,  7 Aug 2014 12:31:43 -0400 (EDT)
In-Reply-To: <CACsJy8DnWZfKqwjOjjU17YtN1Zqk0vy5nyfOBLjn-RiJkKCo6Q@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 7 Aug 2014 08:51:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5106149A-1E50-11E4-AC5F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254976>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Aug 7, 2014 at 7:34 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Package: git
>> Version: 1:2.0.0-1
>> Tags: upstream
>>
>>   $ git init foo
>>   Initialized empty Git repository in /tmp/t/foo/.git/
>>   $ cd foo
>>   $ echo hi >README
>>   $ git add -N README
>>   $ git status
>>   On branch master
>>
>>   Initial commit
>>
>>   Changes to be committed:
>>     (use "git rm --cached <file>..." to unstage)
>>
>>           new file:   README
>>
>>   Changes not staged for commit:
>>     (use "git add <file>..." to update what will be committed)
>>     (use "git checkout -- <file>..." to discard changes in working directory)
>>
>>           modified:   README
>>
>> If I then run "git commit", it does not actually commit the addition
>> of the README file.
>
> We used to reject such a commit operation before 3f6d56d (commit:
> ignore intent-to-add entries instead of refusing - 2012-02-07) so it
> was harder to misunderstand this case.
>
>> It would be clearer to have a separate section,like so:
>>
>>   Tracked files not to be committed:
>>     (use "git rm --cached <file>..." to stop tracking)
>>
>>            new file:   README
>>
>
> Or make the "Changes not staged for commit" part say "new file:
> README" ("modified" is implied)

Yeah, after reading the justification in the quoted commit, I agree
that it is status that is at fault in the above; "new file: README"
is part of "Changes not staged for commit" in this case (it is told
to the index, but the user never said it is "for commit" yet, which
is the whole point of "-N"), so instead of adding a new section, I
agree that it should be classified as "new file" not "modified"
there.
