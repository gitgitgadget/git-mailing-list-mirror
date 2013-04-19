From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 1/8] Add new git-cc-cmd helper to contrib
Date: Fri, 19 Apr 2013 11:30:17 -0500
Message-ID: <CAMP44s0sXk9xCXjY5bYsy2mrvkKrPPWqAVhZHChv+MHpNySPsg@mail.gmail.com>
References: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
	<1366348458-7706-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0n+cWspBJtH7JFvsvoeHHuiWR0bGpYVU63e7O74XY=4sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 18:30:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTECu-00049M-Ky
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 18:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030917Ab3DSQad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 12:30:33 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:40460 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968422Ab3DSQaT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 12:30:19 -0400
Received: by mail-lb0-f169.google.com with SMTP id p11so3941982lbi.0
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 09:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ZPlxkdP/EIEtlSK0hbZuAq9pA+t+yVus6YWE0+bbK2o=;
        b=kpEcjGfHLSvHMQCvc+4qbjK3zEHApOP7Y7lgEyiHlkaXXFBwLW1N/QtNA7Bqb52qz8
         3vRIxHoh3w2wemsGWksUAFfFBuK74rR5FRmKnISKo5G5H9DVmlgJlWAJwKQNyQSUFB0Y
         pDVIn4zuCa9rSB1JlB2jPcwyFi2MJkfOoh8nh+tM7jsTCtvI/yr/eomSlHtYhIrq/rGv
         dgf7Xz/G+ZgRpWwx+Wp9slg1WTRDRqZNWqPQX+nnlcQ+A48RovON0QUGeh0l48tmLzlG
         x3t/tPQSMC2MAdBM4dHBDYf0phMTlJIFe2l1sMjVSA9D2M77a/MKc+ikUggq4mTW8fo/
         Ypzg==
X-Received: by 10.112.22.198 with SMTP id g6mr4406275lbf.135.1366389017920;
 Fri, 19 Apr 2013 09:30:17 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Fri, 19 Apr 2013 09:30:17 -0700 (PDT)
In-Reply-To: <CALkWK0n+cWspBJtH7JFvsvoeHHuiWR0bGpYVU63e7O74XY=4sQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221768>

On Fri, Apr 19, 2013 at 8:26 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> The code finds the changes of a commit, runs 'git blame' for each chunk
>> to see which other commits are relevant, and then reports the author and
>> signers.
>>
>> Finally, it calculates what percentage of the total relevant commits
>> each person was involved in, and show only the ones that pass the
>> threshold.
>
> Um, this didn't really explain it to me.  How about:
>
> This command takes a patch prepared by 'git format-patch' as an
> argument, and runs 'git blame' on every hunk of the diff to determine
> the commits that added/removed those lines.  It then aggregates the
> authors and signers of all the commits, and prints out these people in
> descending order of the percentage of commits they were responsible
> for.  It omits people are below a certain threshold.

Fine by me.

>>   % git cc-cmd 0001-remote-hg-trivial-cleanups.patch
>>   Felipe Contreras <felipe.contreras@gmail.com> (author: 100%)
>>   Jeff King <peff@peff.net> (signer: 83%)
>>   Max Horn <max@quendi.de> (signer: 16%)
>>   Junio C Hamano <gitster@pobox.com> (signer: 16%)
>
> Won't my name appear as the first one on each of my patches?  Will I
> be CC'ed on every patch that I send out?

No. The patches being analyzed are ignored. Either way, you are the
s-o-b, so send-email Cc's you by default.

>>  contrib/cc-cmd/git-cc-cmd | 140 ++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 140 insertions(+)
>>  create mode 100755 contrib/cc-cmd/git-cc-cmd
>
> No README?

No README. Half the stuff in contrib doesn't have one. And I don't see
what stuff of value we could have there.

>> diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
>> new file mode 100755
>> index 0000000..c7ecf79
>> --- /dev/null
>> +++ b/contrib/cc-cmd/git-cc-cmd
>> @@ -0,0 +1,140 @@
>> +#!/usr/bin/env ruby
>
> What is the minimum required version of Ruby, by the way?

I don't know.

> I see you
> haven't used any fancy lazy enumerators

I did, but they are implicit.

>> +$since = '3-years-ago'
>> +$min_percent = 5
>
> Do I get to configure these two?

Patience. That's for another patch.

> Also, the '$' prefix from your Perl
> habit?  It's not idiomatic in Ruby afaik.

It is for global variables.

>> +class Commit
>> +
>> +  attr_reader :id
>> +  attr_accessor :roles
>> +
>> +  def initialize(id)
>> +    @id = id
>> +    @roles = []
>
> What are id, roles exactly?  This isn't C where we have types, so
> you're going to have to use some (rdoc-parseable) comments, if you
> want me to be able to read the code without jumping around too much.

The id of the commit, of course (aka. SHA-1), and the roles people had
in this commit. We are after all in the Commit class.

>> +  end
>> +
>> +  def self.parse(data)
>> +    id = author = msg = nil
>
> This is not C.  You don't need to initialize stuff, unless you're
> going to start accessing it using a .append() or similar.  In that
> case, you need to initialize it as an empty list, so the compiler
> knows what you're appending to.

You need to define them if you are going to modify them in a block,
and access them after the block.

>> +    roles = {}
>
> Shouldn't this be @roles?

No, we are in a class method, we don't have instance variables; we
don't have an instance.

> Didn't you initialize it as an empty list
> in initialize()?

No, that's for the instance; we don't have an instance yet.

> Why did you suddenly change your mind and make it a
> hashtable now?

It's a completely different variable; it's local to the method.

>> +    data.each_line do |line|
>> +      if not msg
>> +        case line
>> +        when /^commit (.+)$/
>> +          id = $1
>
> Okay, I have no idea what you're parsing yet.  There's some commit
> line, so I know this is not a raw commit object, as the name of the
> class Commit would've indicated.

Yeah, it's parsing a raw commit object.

>> +        when /^author ([^<>]+) <(\S+)>$/
>> +          author = $1, $2
>> +          roles[author] = 'author'
>
> Huh?  the key is a two-item list, and the value is a hard-coded
> 'author' string?  If it's meant to be a sematic value, use a symbol.

Yeah, that might make sense.

> Also, why don't you just collect the authors and signers in two
> separate lists, instead of doing this and burdening yourself with
> accumulation later?

Go ahead and try this change. How are you going to group persons by
the role they took in the relevant commits? It's much simpler to have
generic code that is agnostic of the types of roles there are. Also,
this would make it simpler to add other roles.

>> +        when /^$/
>> +          msg = true
>
> I can't see msg being used later in the function, so I don't know what
> you're doing.

It's used before.

>> +    roles = roles.map do |person, role|
>> +      address = "%s <%s>" % person
>> +      [person, role]
>
> What?!  If you wanted address in the first place, why did you stuff a
> two-member list into roles as the key?

What difference does it make? 'person' could be an object, it could be anything.

> Where is address being used?

In a later patch. This line creeped in.

>> +  def import
>> +    return if @items.empty?
>> +    format = [ 'commit %H', 'author %an <%ae>', '', '%B' ].join('%n')
>> +    File.popen(['git', 'show', '-z', '-s', '--format=format:' + format] + @items.keys) do |p|
>
> Ah, you're using 'git show'.  I thought cat-file --batch was
> especially well-suited for this task.

Perhaps, but the code might end more complicated though.

> What do you need the
> pretty-printing for?

To generate a raw commit; the raw format is not really so.

>> +      p.each("\0") do |data|
>> +        next if data == "\0" # bug in git show?
>
> What is the bug exactly?  It displays two consecutive \0 characters
> sometimes, when given a bunch of items to display?

Apparently.

>> +        id, roles = Commit.parse(data)
>> +        commit = @items[id]
>> +        commit.roles = roles
>
> @items[id].roles = roles

NoMethodError: undefined method `roles=' for nil:NilClass

>> +  def each_person_role
>> +    commit_roles = @items.values.map { |commit| commit.roles }.flatten(1)
>> +    commit_roles.group_by { |person, role| person }.each do |person, commit_roles|
>> +      commit_roles.group_by { |person, role| role }.each do |role, commit_roles|
>> +        yield person, role, commit_roles.size
>
> Unnecessary work if you'd chosen a better way to store the person =>
> role mapping in the first place.

No. The contents of the person key are irrelevant here, they are
merely used as that: a key.

It's trivial to get the role a person took in a given commit; we are
not interested in that. We want the sum of all the author roles a
person had, and the signer roles, and any other rules that might be
specified in the future. *And* we want that count to be grouped first
by person, and then by role, because that's precisely what we will
show the user.

There's no better way to represent the data of each commit than by a
Commit object, and there's no better way to represent the roles each
person took in a certain commit, than a Hash. Which is exactly what we
have.

>> +  def get_blame(source, start, offset, from)
>> +    return unless source
>> +    File.popen(['git', 'blame', '--incremental', '-C',
>> +               '-L', '%u,+%u' % [start, offset],
>> +               '--since', $since, from + '^',
>> +               '--', source]) do |p|
>
> While at it, why not blame -M -CCC?

-C implies -M, but the three times might make sense.

>> +  def from_patch(file)
>
> You're not going to 'git mailsplit', like am does, first?

Could be added later.

>> +        when /^@@\s-(\d+),(\d+)/
>> +          get_blame(source, $1, $2, from)
>
> Okay, so this is where you get the arguments for the -L in blame.
>
>> +exit 1 if ARGV.size != 1
>
> No usage?

Later patch.

>> +commits.each_person_role do |person, role, count|
>> +  persons[person][role] = count
>
> Oh dear.  Don't you think you're over-engineering here?  Just because
> you can stuff anything into hashes/lists in Ruby, doesn't mean that
> you should and kill efficiency.

Write the changes and show me the numbers. Ruby hashes are extremely
efficient, it hardly matters for less than ten people you are going to
Cc, and any other code would be more complicated, if at all possible,
I tried.

>> +persons.each do |person, roles|
>> +  roles = roles.map do |role, count|
>> +    percent = count.to_f * 100 / commits.size
>
> Interesting.  You also take into account the size of the commits when
> calculating the final score.

No, it's the total number of commits, like any array.size.

>> +    next if percent < $min_percent
>> +    "%s: %u%%" % [role, percent]
>> +  end.compact
>
> What are these nil elements you're filtering out with .compact?

The ones that are below the threshold.

> Overall, it looks like the whole thing is one giant first draft
> written in a big rush.

It's not. The first draft was sent more than three years ago[1]. I
have literally been developing this for years, fixing related bugs in
git along the way [2], and shaping some features [3]. I sent the
previous version last year, which was basically the same design, and
you thought it was great and even asked why it wasn't merged[4].

I have written and rewritten this code, simplified and refactored it.
And I'm fairly certain this version is clean and tidy, and could
hardly be made any simpler.

> For a relatively simple task,

That is the problem right there; you don't understand what the code is
doing, so you think because the code is relatively small, you do
understand it, and the task must be simple. I assure you, it's not.

But you have hands, go ahead and try to simplify it. If the task is so
simple, you can remove all the code you don't like, and see how it
fares. Then you'll see.

> I'm sorry, but this giant mess wasn't at all a pleasure to read.

It wasn't meant to be. It was meant to solve a problem in the simplest
way possible.

Surely the code can have some cosmetic changes to explain better what
it's doing, but I doubt you find a way to substantially improve _how_
it's doing it. Certainly none of the suggestions above did help in
that regard.

Cheers.

[1] http://article.gmane.org/gmane.comp.version-control.git/130391
[2] http://article.gmane.org/gmane.comp.version-control.git/189897
[3] http://article.gmane.org/gmane.comp.version-control.git/210059
[4] http://article.gmane.org/gmane.comp.version-control.git/209419

-- 
Felipe Contreras
