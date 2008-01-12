From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config variable
Date: Sat, 12 Jan 2008 17:24:26 -0500
Message-ID: <47893E1A.5020702@gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>	<1200022189-2400-2-git-send-email-mlevedahl@gmail.com>	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>	<7v63xzzszp.fsf@gitster.siamese.dyndns.org>	<478855B5.9070600@gmail.com>	<7vbq7ry405.fsf@gitster.siamese.dyndns.org>	<47885B2C.8020809@gmail.com>	<7v7iify2wm.fsf@gitster.siamese.dyndns.org>	<4788BFA8.2030508@gmail.com>	<7vwsqeubj8.fsf@gitster.siamese.dyndns.org>	<47891658.3090604@gmail.com> <7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 23:25:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDonH-0002Vn-Js
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 23:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762713AbYALWYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 17:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762688AbYALWYd
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 17:24:33 -0500
Received: from ag-out-0708.google.com ([72.14.246.243]:27669 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757630AbYALWYc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 17:24:32 -0500
Received: by ag-out-0708.google.com with SMTP id 23so1111153agd.10
        for <git@vger.kernel.org>; Sat, 12 Jan 2008 14:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=1k9/fXQ4b/d2bGqMZDbA0iU42JTTDimuPE+1az0MBZs=;
        b=ApF0xDVMlYjYlrvvFsCRf6kDCs6wfZNCqZYdTRvn6//HkJcqNc6JWCg5Vym8kbUADHzPUvU45u8Ux7Tluw/1JrpTOwJVN9iklLbz7QJBZbEUI+Mxo8VE3hdfcm/qoAWdAUOxs4uk3z10KTOuG0vn/SS3ZU1BHvuXfpUFrqE/qsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ABBKfbQdKCUjVWfowqirKExE/U3UsckKyf73ZVfo9tcBS5e1nMhtdFkYEosPdtlAMfWOt1jJv7W5Qhf30ATAR021S27xCbAGnzyJJewHWSlkm0y/Tit2flK2KqxCaxPGfLj0uy88mD2sKg2RKL/0PWsxDoGqFu6+irT4Rju1T7w=
Received: by 10.100.139.20 with SMTP id m20mr10299458and.34.1200176670285;
        Sat, 12 Jan 2008 14:24:30 -0800 (PST)
Received: from ?192.168.1.117? ( [71.163.17.196])
        by mx.google.com with ESMTPS id 31sm8058970wri.24.2008.01.12.14.24.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Jan 2008 14:24:28 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70360>

Junio C Hamano wrote:
> If it is truly only about "submodule update" then the change
> seems too intrusive, especially "remotes.default" variable that
> affects the way how fetch and merge works in situations that do
> not involve submodules.
> If it is not limited to "submodule update" but equally valid fix
> to non-submodule situations, the changes to the other parts may
> very well be justifiable, but that would mean your "Yes" is a
> lie and instead should be "No, but these situations are helped
> by these changes because...".
>
>   
First, I resent the patch series last night, it now uses core.origin to 
avoid touching remotes.* namespace.

The changes *do* fix a nit when on a non-tracking branch. With this, 
fetch / merge / pull will now honor that the user said (via git clone -o 
frotz) "my upstream is nicknamed frotz" and not try to use origin when 
origin was never defined.

So, while fixing this minor aggravation wasn't my motivation, I view 
this as a nice side-benefit :^).

The driving issues:
1) I deal with too many servers for "origin" to be a useful nick name, 
and we have an agreed set of nickname / server pairings across my project.
2) Therefore, we always do git clone -o frotz  frotz.foo.bar/path_to_git.
3) Because of 2, for top-level, "origin" is not defined, tracking 
branches set up via git branch --track point to the correct remote, and 
we basically understand branch names as <nickname>/branch. In other 
words, we *are* aware of what server we are using.
4) git-submodule update breaks the above:
- a) it invokes git clone frotz.foo.bar/path_to_git thus defining 
"origin" as the nickname for frotz.foo.bar.
  b) it invokes bare git-fetch on a detached head, so the upstream *has* 
to be origin.

> If your top-level repository needs to access a specific server
> "frotz.foo.bar" for updates, then you would have bootstrapped
> the whole thing with:
>
> 	$ git clone git://frotz.foo.bar/toplevel.git
>
> and in that particular instance of the repository, the source
> repository on frotz.foo.bar would have been known as 'origin',
> right? 
Nope, we did it with git clone -o frotz git://frotz.foo.bar/toplevel.git
We *never* define origin, frozt.foo.bar is *always* frotz.

>  I would not object if you also gave another nickname
> 'frotz' to the same repository for consistency across
> developers.
>   
good. We are making (some) progress. :^)
> If that is the case, I am wondering why your subprojects are not
> pointing at the corresponding repository on that same
> 'frotz.foo.bar' machine as 'origin'.  I suspect the reason is
> that .gitmodules do not say 'frotz.foo.bar' but name some other
> machine.
>   
Actually,
1) We don't use origin because we avoid having to wonder "Is 
frotz.foo.bar named "origin" or "frotz" on this client, and thus how do 
I get data from frotz?
2) I submitted the change allowing submodules to be recorded into 
.gitmodules with a relative url (e.g., ./path_from_parent_to_submodule) 
rather than an absolute, so we record the relative path only.
3) Thus, git submodule has set up the submodules to point at the parent 
project's default remote. However, in the parent the server is nicknamed 
"frotz", but now in the submodule the server is nicknamed "origin"  Oops.

With my patches, parent and submodule both refer to frotz.foo.bar as frotz.

> And in-tree .gitmodules can name only one URL, as it is project
> global and shared by everybody.  There is no escaping it.
> At least as things were designed, "git submodule init" takes URL
> recorded in .gitmodules as a hint, but this is for the user to
> override in .git/config in the top-level.  Maybe the UI to allow
> this overriding is not easy enough to use, and your submodules
> ended up pointing at wrong (from the machine's point of view)
> URL as 'origin'.  And perhaps that is the root cause of this
> issue?
>
>   
Again, the relative-url patch was to address this so that a project that 
is mirrored to another server remains valid on the new server without 
modifying the .gitmodules in-tree. (Yes, I know you *can* modify 
information in a given clones .git/config, but I'm trying to avoid such 
manual per clone/checkout modifications where it can reasonably be done.).

Basically, I think an important (but not complete) test of the design is 
that

    git clone -o frotz git://frotz.foo.bar/myproject.git
    cd myproject
    git submodule init
    git submodule update

work, with origin = frotz throughout the submodules, and with the whole 
project correctly checked out even if the entire project was rehosted 
onto a different server. With relative urls and my latest patch series 
last night, this all works, and of course upstream can still be "origin" 
if that is what is desired.

While our overall project exists on many servers, mirroring is an 
incorrect term. Rather, only certain branches of  various parts exist 
everywhere, many other branches are specific to a given server, so we 
really name branches using servername/branchname. It is this aspect of 
the project that causes us to be aware of the server in use, and thus 
makes use of "origin" as a generic upstream not useful.

> I am looking at the discussion on the list archive when we
> discussed the initial design of .gitmodules:
>
>     http://thread.gmane.org/gmane.comp.version-control.git/47466/focus=47502
>     http://thread.gmane.org/gmane.comp.version-control.git/47466/focus=47548
>     http://thread.gmane.org/gmane.comp.version-control.git/47466/focus=47621
>
> I do not think we are there yet, and suspect that the current
> "git submodule init" does not give the user a chance to say "the
> URL recorded in the in-tree .gitmodules corresponds to this URL
> in this repository for administrative or network connectivity or
> whatever reasons".
>   
> Maybe that is the real issue that we should be tackling.  I
> dunno.
>
> Although I _think_ being able to use nickname other than
> hardcoded 'origin' for fetch/merge is a good change, if my above
> suspicion is correct, that change alone would not make the life
> easier to people who _use_ submodules, as the need for them to
> set up extra nicknames (like 'frotz') and configure the
> submodule repositories to use that specific nickname instead of
> 'origin' would not change.
>
>   

git-submodule right now supports two different layouts (urls relative to 
the parent, and absolute urls such that each sub-module is on an 
independent server). The management approaches to these are going to be 
different.

I also suspect there are two basic use cases here: accumulation of a 
number of independently managed projects vs. splitting a single major 
project into a number of smaller pieces to allow some decoupling, but 
still managing the set as a composite whole.

There may be some direct correlation of use-case and submodule layout, 
don't know. My project uses relative-urls, and I am managing a large 
project that has been split into a number of components. So, my 
suggestions are focused entirely upon this design and use-case, and I 
don't expect I am addressing the others at all. (As usual, this requires 
someone who needs the other model(s) to step up and drive).

For *my* uses (relative urls, single logical project):

1) There are times when the parent's branch.<name>.remote should be 
flowed down to all subprojects for git submodule update, of course this 
would require that the remote be defined for all.
2) Thus, there needs to be a way to define a new remote globally for the 
project, and have it be correctly interpreted by each submodule (e.g., a 
repeat of the relative-url dereferencing now done by submodule init, but 
applied later to all submodules to define a new remote). Yes, this could 
be accomplished by going into each submodule independently and issuing 
appropriate commands, but administration would be much easier given a 
top-level command that could recurse and "do the right thing" per 
sub-project.

I *suspect* that origin is a much more useful concept for the alternate 
construct (absolute urls, loose alliance of separately managed 
projects), but as I said that is not my problem so please ask folks who 
have that model to define what works for them.
> For communication purposes, I would agree with Dscho that the
> name 'origin' that names different things for different people
> is wrong and using specific name 'frotz' would solve
> communication issues.  But when using the repository and doing
> actual work, wouldn't it be _much_ better if you can
> consistently go to a repository on a random machine and always
> can say 'origin' to mean the other repository this repository
> usually gets new objects from (and sends its new objects to)?
>
>
>   
(Acutally, I thought I was the one arguing that using origin when it 
means different things to different folks is not good. That's the root 
of my problems. :^) )

Anyway, I have not found any use of "origin" on my project really 
useful. We have to be and *are* aware of the server/branchname in use, 
not just the branch. Partly this is because different subgroups have 
different natural gathering points (we tend to exchange data via ad hoc 
"mob" branches on whatever server is most accessible to the particular 
group), and partly because some information simply cannot be allowed on 
some servers, but basically the more accessible a server is, the less 
information that server can have. I believe "origin" is really useful 
only when it has just one meaning, or when all values are effectively 
identical (e.g., you have several mirrors for load balancing, etc, but 
all are identical modulo mirroring delays).

OTOH, a reasonable change to the semantics of "origin" might be to have:
1) core.origin name the remote that is the "normal" upstream.
2) Reserve and allow use of the name "origin" to mean $core.origin, 
e.g., in shell scripts replace all references to remote "origin" with 
$(git config core.origin). Of course, if core.origin = origin, then no 
user visible change occurs.

In this way, git would  not record the same remote's branches in two 
ways (as origin/master and as frotz/master), but rather dereference 
origin -> frotz and then get frotz/master. Dunno, no matter how you 
slice it, having more than one way to refer to the same remote is going 
to be confusing, and that's why we don't use origin.


Mark
