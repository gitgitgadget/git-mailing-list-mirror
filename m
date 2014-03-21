From: Brian Bourn <ba.bourn@gmail.com>
Subject: Re: [RFC] [GSoC] Draft of Proposal for GSoC
Date: Fri, 21 Mar 2014 05:41:36 -0400
Message-ID: <CAM+=D-ATimdXmcYpqSyKwZXE=TYXg9cZFG9kyjEOg22K1wF+3Q@mail.gmail.com>
References: <CAM+=D-BWCt9kNSUUQ19ZcPykb6j-tuEr=igBz0ukEk2TA3vWkg@mail.gmail.com>
	<20140321054208.GA31737@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 10:41:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQvxW-0001xF-9j
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 10:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760501AbaCUJll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 05:41:41 -0400
Received: from mail-qa0-f54.google.com ([209.85.216.54]:57758 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760487AbaCUJlh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 05:41:37 -0400
Received: by mail-qa0-f54.google.com with SMTP id w8so2160069qac.13
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 02:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dle6vH5slmRv/jBFFuem4VCHs0iEatquXHGpF6I/hFk=;
        b=D/6qGej7LvB7qk8FaT5XCWinzsu0Dvoen3JUt7+piHuUZnwlVm9KSsmhR0VdP0J0Q3
         OYp7KTyx66S74+A3O1TturN+53MKwQxFOSHCWtTO5UQxTZLlaF4+ygCnorCiOiIsb5oP
         Ob7eF4cULdf2Q0FYdID5iGASEHeNEEb2JMfY9f7XcCvq/Sln6SZJ7yl0xsLjlD5cP7OP
         QUwZO30NYr/tXgBP/GEzzJKpdRUyKbve/6coxodF8YQGSL+v1dqiKde0c9ZyxZx5r+k0
         nNLTL86NBWMFQEWv61YzZpRYToDsUtdpMiB1CqdNGNe/O4THVWkxlyvmBY28gTevV0iO
         6hsQ==
X-Received: by 10.224.14.77 with SMTP id f13mr56457182qaa.31.1395394896653;
 Fri, 21 Mar 2014 02:41:36 -0700 (PDT)
Received: by 10.96.86.38 with HTTP; Fri, 21 Mar 2014 02:41:36 -0700 (PDT)
In-Reply-To: <20140321054208.GA31737@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244683>

Parts of v2, once again, i'd love some more comments on what I've
rewritten


On Fri, Mar 21, 2014 at 1:42 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 20, 2014 at 02:15:29PM -0400, Brian Bourn wrote:
>
>> Going through the annals of the listserve thus far I've found a few
>> discussions which provide some insight towards this process as well as
>> some experimental patches that never seem to have made it
>> through[1][2][3][4]
>
> Reading the past work in this area is a good way to get familiar with
> it. It looks like most of the features discussed in the threads you link
> have been implemented. The one exception seems to be negative patterns.
> I think that would be a good feature to build on top of the unified
> implementation, once all three commands are using it.
>
>> I would start by beginning a deprecation plan for git branch -l very
>> similar to the one Junio presents in [5], moving -create-reflog to -g,
>
> That makes sense. I hadn't really considered "-l" as another point of
> inconsistency between the commands, but it definitely is.
>
>> Following this I would begin the real work of the project which would
>> involve moving the following flag operations into a standard library
>> say 'list-options.h'
>>
>> --contains [6]
>> --merged [7]
>> --no-merged[8]
>> --format
>> This Library would build these options for later interpretation by parse_options
> Can you sketch out what the API would look like for this unified
> library? What calls would the 3 programs need to make into it?
>

Something like this?

Sample api calls
Add_Opt_Group()
Parse_with_contains()
Parse_with_merged()
Parse_with_no_merged()
Parse_with_formatting()
(each of the 4 calls above may have internal calls within the library
in order to parse the option for each of the different function which
may call these functions)


>> For the most part I haven't finalized my weekly schedule but a basic
>> breakdown would be
>
> Can you go into more detail here? Remember that writing code is only one
> part of the project. You'll need to be submitting your work, getting
> review and feedback, and iterating on it.
>
> One problem that students have is queuing up a large amount of work to
> send to the list. Then they twiddle their thumbs waiting for review to
> come back (which takes a long time, because they just dumped a large
> body of work on the reviewers). If you want to make effective use of
> your time, it helps to try to break tasks down into smaller chunks, and
> think about the dependencies between the chunks. When one chunk is in
> review, you can be designing and coding on another.

This one I can absolutely understand, I tried to break this part down into very
managable parts and give myself a little time at the end of each coding period
to clean up each previous section.  this slop time also allows for me
to hopefully
add some of the extra features that have been thought of. I'm thinking something
like this makes it a little better,

Weekly Schedule

Start-Midterm
Week 1- Begin deprecation of -l in git branch/establish exactly how
long each stage of the deprecation should take.  Spend some time
reading *.c files even deeper while getting to know any current
patches occurring in any area near my work files.  Lastly, this week
will be spent going through the Mailing-list finding previous work
done in this area and any other experimental patches
Week 2- Move Opt_Group callbacks for the functions  into Library
Week 3-Make a Contains Function in the library which will work for all
three functions
Week 4-Add Merge function in library
Week 5-Add a No Merge function in library
Weeks 7-8 spend time polishing the library and cleaning up the patches
for final submission of library to the project

Deliverables for midterm- Library finished pending polish and
acceptance into the git repository

Midterm

Week 9- refactor all files to use the contains flag from the file.
Week 10- use Merge from library in all relevant files
Week 11-use no-merge from library in all relevant files
Week 11-12- implement the format flags in all relevant files (this
will be slightly harder as I think this might involve calling
for-each-ref in the code for tag and branch. Ultimately there is a
chance that part of the code for doing for-each-ref will end up in
this library as well), additionally add in the code for formatting the
relevant opt_Groups into the necessary files.
Week 13-14 Polish patches via mailing-list and clean up all the
refactoring of the files that has occurred.(optionally, add more
formatting changes such as negative patterns and numbering each output
into the library).

Deliverables for Final- working library hopefully added into the code,
and all of the relevant patches for using the library mostly polished
and, minimally, pending peer review for submission into the code base.

I do wonder if this plan might be a little on the conservative side,
if anything, I think
this could take a slightly shorter time than planned, but In that case
I can always
work on other additions to format.


>
>> Additionally I am thinking about adding some more formatting tools
>> such as numbering outputs. What do you all think of this?
>
> Something like numbering might make sense as part of the formatting code
> (e.g., a new placeholder that expands to "n" for the nth line of
> output). I think that would be fairly straightforward, but again, it
> makes sense to me to unify the implementations first, and then we can
> build new features on top.
>
> -Peff
