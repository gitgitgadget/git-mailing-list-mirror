From: Brian Bourn <ba.bourn@gmail.com>
Subject: Re: [RFC] [GSoC] Draft of Proposal for GSoC
Date: Fri, 21 Mar 2014 14:35:42 -0400
Message-ID: <CAM+=D-DoacQWLuu6XEJzFQXFTaA4UiszJeD5BHJy2zXRFdWKSw@mail.gmail.com>
References: <CAM+=D-BWCt9kNSUUQ19ZcPykb6j-tuEr=igBz0ukEk2TA3vWkg@mail.gmail.com>
	<20140321054208.GA31737@sigill.intra.peff.net>
	<CAM+=D-ATimdXmcYpqSyKwZXE=TYXg9cZFG9kyjEOg22K1wF+3Q@mail.gmail.com>
	<xmqq8us3v42o.fsf@gitster.dls.corp.google.com>
	<CAM+=D-D=PW=ZJFvc0y+Zhs8tPcbXnP-q4w-MeeLwT+t-QD_55w@mail.gmail.com>
	<20140321180745.GB15508@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 19:36:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR4Ie-0007Dw-MT
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 19:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbaCUSfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 14:35:46 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:59712 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbaCUSfn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 14:35:43 -0400
Received: by mail-qg0-f46.google.com with SMTP id e89so8198840qgf.5
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 11:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qXXMehPGXxZiJVETzjT5CmrwL/VI3x+UufaT2fBlgH4=;
        b=kbDnjlxWL8i4mO7/MvKG6AlUAWiJN/9pxMlunsSH5tPZlm9hxX/HPA2v56k3fIjYC8
         f6sIScZzbc0YxHbP7BbRF9w5bwSgE//ic+y33+pQWc6wfDYV7WKNFPnFdeKHF69Orf4L
         BoIC2IgM6ULE+WX4zy6KYqpFQAzsnRmzeDjLHHYS7UVPIPlI+YcaHSuQH7EGah3XFbB3
         1WwOHmQtTOz/yy6RLXbhZhg9FdrKBgUrxOq+0ltuLOZeJQPku09wDB8kYnm4+fgh7jjL
         rKgJav9mkHFlbSUxh0VyQgTZXVfx7RrSSe09Mh84zrXxm1J+ynP8U/Jnm65grp5S+7RB
         yehw==
X-Received: by 10.224.127.129 with SMTP id g1mr59142607qas.22.1395426942379;
 Fri, 21 Mar 2014 11:35:42 -0700 (PDT)
Received: by 10.96.86.38 with HTTP; Fri, 21 Mar 2014 11:35:42 -0700 (PDT)
In-Reply-To: <20140321180745.GB15508@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244718>

On Fri, Mar 21, 2014 at 2:07 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Mar 21, 2014 at 02:03:41PM -0400, Brian Bourn wrote:
>
>> > What do they do, what does the caller expect to see (do they get
>> > something as return values?  do they expect some side effects?)?
>>
>> so something like this would be better I'm assuming?
>>
>> Some basic sample API calls are found below, each of these would hold
>> code to complete parsing and/or formatting the flags.
>> Add_Opt_Group() - returns an OPT_CALLBACK with contains, merged,
>> no-merged, or formatting which can be used in a commands options list.
>>
>> Execute_list()-the main call into the library and would pass into the
>> library all of the necessary flags and arguments for parsing the
>> request and executing it. This would accept the flags like
>> -contain, with arguments such as the commit or pattern that is being
>> searched for.
>>
>> The next four commands would be called by execute_list() to execute
>> the original command with respect to the flags that are passed into
>> this library.
>> Parse_with_contains()
>> Parse_with_merged()
>> Parse_with_no_merged()
>> Parse_with_formatting()
>
> Think about how the callers would use them. Will git-branch just call
> Parse_with_contains? If so, where would that call go? What arguments
> would it take, and what would it do?
>
> I don't think those calls are enough. We probably need:
>
>   1. Some structure to represent a "list of refs" and store its
>      intermediate state.
>
>   2. Some mechanism for telling that structure about the various
>      filters, sorters, and formatters we want to use (and this needs to
>      be hooked into the option-parsing somehow).
>
>   3. Some mechanism for getting the listed refs out of that structure,
>      formatting them, etc.

keeping some of my function calls to do the actual work I think I
settled on this

A possible API is given below, each of these would hold code to
complete parsing and/or formatting the flags.

There will be a struct in the library called refs_list() which when
initialized will iterate through all the refs in a repository and add
them to this list.

 there would be a function which would retrieve ref structs from that function.

Get_ref_from_list()- which would return a single ref from the list.

Add_Opt_Group() - returns an OPT_CALLBACK with contains, merged,
no-merged, or formatting which can be used in a commands options list.

Execute_list()-the main call into the library and would pass into the
library all of the necessary flags and arguments for parsing the
request and executing it. This would accept the flags like contain,
with arguments such as the commit or pattern that is being searched
for. This will then parse the refs_list using the four commands below
to make, sort, filter, and format an output list which will then be
printed or returned by this function.

Any Call into the API from an outside source would call one of the
previous two functions, all other commands in the API would be for
internal use only, in order to simplify the process of calling into
this library.

The next four commands would be called by execute_list() to further
format the refs_list with respect to the flags that are passed into
this library. These would also take the additional arguments from
execute_list() such as patterns to parse or which commit to filter
out. these calls would modify the refs_list for eventual printing.

Parse_list _with_contains()

Parse_list_with_merged()

Parse_list_with_no_merged()

Format_list()

of course this would still depend on deciding whether or not we want
to return to the original command to print or if printing can be
handled by the library itself.


> -Peff
