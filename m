From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/6] gitweb: action in path with use_pathinfo
Date: Mon, 29 Sep 2008 16:22:40 +0200
Message-ID: <cb7bb73a0809290722w5ed92171v98d6b83a7dae8f8b@mail.gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1222030663-22540-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <200809290303.21290.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@ucw.cz>,
	"Lea Wiemann" <lewiemann@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 16:23:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkJfF-0003bg-Mk
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 16:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbYI2OWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 10:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbYI2OWn
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 10:22:43 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:51830 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbYI2OWm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 10:22:42 -0400
Received: by yw-out-2324.google.com with SMTP id 9so313269ywe.1
        for <git@vger.kernel.org>; Mon, 29 Sep 2008 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=prVcLgu0RHFIK79oLpeVhi1Cdbsm24jz3Efl1yFPGt4=;
        b=n04JTManAyY5HVZnTXvIqwM03M70PvQCmUC3R9nQhiVzqlOiG7sWA0VxCXvUwvQTVf
         tORHjfxABAKzWqLlKqvPgotXXYCiXwVag2YvEGs0yBePkAWJLBtbwysKz1g4y8d33ORP
         8GBYiCI/or0TYHoZGLwrNYIbOCpCaIl7uw3mo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=T0BbFB0lUU4v7AfiP+NOn76IDKIVFJqmPAQa/cv344S8rVqnLxqSxMGWRzFqDiZXxs
         99mECLHZkNRAvlGqjGv2bZvqGtzsy1n90S0CIgMBwadwYgNx/D7e6V37zDrHAcwv9z0L
         st0bFEbydaZf4XJX47DoRm/u3DLvt51727C6U=
Received: by 10.151.48.20 with SMTP id a20mr7901668ybk.227.1222698160254;
        Mon, 29 Sep 2008 07:22:40 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Mon, 29 Sep 2008 07:22:40 -0700 (PDT)
In-Reply-To: <200809290303.21290.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97013>

On Mon, Sep 29, 2008 at 3:03 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> I'm sorry for the delay reviewing those patches.
>
> On Sun, 21 Sep 2008, Giuseppe Bilotta wrote:
>
>> When using path info, reduce the number of CGI parameters by embedding
>> the action in the path. The typicial cgiweb path is thus
>> $project/$action/$hash_base:$file_name or $project/$action/$hash
>
> cgiweb?

Good question. I have no idea why I wrote that instad of gitweb.

>> This is mostly backwards compatible with the old-style gitweb paths,
>> except when $project/$branch was used to access a branch whose name
>> matches a gitweb action.
>
> I would also state that gitweb _generates_ such pathinfo links if
> configured (or if coming from pahinfo URL), and that this change
> allow to represent wider number of gitweb links (gitweb URLs) in
> pathinfo form.

Can do.

> Also, from what I understand, generated pathinfo links now always
> use action, so they are a tiny little bit longer.

Is that a problem, by the way? I've had half-thoughts about making the
action implicit when possible, but I'm afraid that's prone to make the
code way more complex and the path info handling much less robust.

>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>> ---
>>  gitweb/gitweb.perl |  109 ++++++++++++++++++++++++++++++++++------------------
>>  1 files changed, 72 insertions(+), 37 deletions(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index da474d0..e783d12 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -488,6 +488,37 @@ if (defined $searchtext) {
>>       $search_regexp = $search_use_regexp ? $searchtext : quotemeta $searchtext;
>>  }
>>
>> +# dispatch
>> +my %actions = (
>> +     "blame" => \&git_blame,
>> +     "blobdiff" => \&git_blobdiff,
>> +     "blobdiff_plain" => \&git_blobdiff_plain,
>> +     "blob" => \&git_blob,
>> +     "blob_plain" => \&git_blob_plain,
>> +     "commitdiff" => \&git_commitdiff,
>> +     "commitdiff_plain" => \&git_commitdiff_plain,
>> +     "commit" => \&git_commit,
>> +     "forks" => \&git_forks,
>> +     "heads" => \&git_heads,
>> +     "history" => \&git_history,
>> +     "log" => \&git_log,
>> +     "rss" => \&git_rss,
>> +     "atom" => \&git_atom,
>> +     "search" => \&git_search,
>> +     "search_help" => \&git_search_help,
>> +     "shortlog" => \&git_shortlog,
>> +     "summary" => \&git_summary,
>> +     "tag" => \&git_tag,
>> +     "tags" => \&git_tags,
>> +     "tree" => \&git_tree,
>> +     "snapshot" => \&git_snapshot,
>> +     "object" => \&git_object,
>> +     # those below don't need $project
>> +     "opml" => \&git_opml,
>> +     "project_list" => \&git_project_list,
>> +     "project_index" => \&git_project_index,
>> +);
>> +
>
> This is as I understand simply moving %actions hash around?

Yes.

> Well, you could instead split hash declaration from defining it,
> in the form of
>
>   my %actions = ();
>   ...
>   %actions = (
>        ...
>   );
>
> but I guess moving declaration earlier is good solution.

Is there some coding style recommendation wrt this situations, or is
it just a matter of making the patch smaller?

>>  # now read PATH_INFO and use it as alternative to parameters
>>  sub evaluate_path_info {
>>       return if defined $project;
>> @@ -512,6 +543,16 @@ sub evaluate_path_info {
>>       # do not change any parameters if an action is given using the query string
>>       return if $action;
>>       $path_info =~ s,^\Q$project\E/*,,;
>> +
>> +     # next comes the action
>> +     $action = $path_info;
>> +     $action =~ s,/.*$,,;
>
> I would use perhaps "$action = ($path_info =~ m!^([^/]+)/!;"
> But that is Perl, so TIMTOWDI.

Well, Perl is not my native language so I tend to stay away from
complex expressions if possible ;-)

>> +     if (exists $actions{$action}) {
>> +             $path_info =~ s,^\Q$action\E/*,,;
>> +     } else {
>> +             $action  = undef;
>> +     }
>> +
>
> I don't think you need quoting pattern metacharacters; valid actions
> should not contain regexp metacharacters.  Defensive programming?

You're right, in this case it's probably excessive. I'll strip it out.

>>       my ($refname, $pathname) = split(/:/, $path_info, 2);
>>       if (defined $pathname) {
>>               # we got "project.git/branch:filename" or "project.git/branch:dir/"
>> @@ -525,10 +566,12 @@ sub evaluate_path_info {
>>               }
>>               $hash_base ||= validate_refname($refname);
>>               $file_name ||= validate_pathname($pathname);
>> +             $hash      ||= git_get_hash_by_path($hash_base, $file_name);
>
> I don't understand why you feel that you need to do this (this is
> additional git command fork, as git_get_hash_by_path calls Git, to
> be more exact it calls git-ls-tree (it could call git-rev-parse
> instead).  Moreover, I don't understand why you need to do this _here_,
> instead of just before where you would have to have $hash variable set.

Hm. I must confess that I honestly don't remember. The same holds for
the other chunks you have perplexities on. When I started writing
these patches I came across a few situations where $hash wouldn't
carry over properly, but now I can't seem to recreate those issues
anymore, which leads me to suspect it was a problem with hand-crafted
links (i.e. before I coded the link generation part too). I'll resend
without these chunks.


> > @@ -624,8 +636,13 @@ sub href (%) {
> >       if ($params{-replay}) {
> >               while (my ($name, $symbol) = each %mapping) {
> >                       if (!exists $params{$name}) {
> > -                             # to allow for multivalued params we use arrayref form
> > -                             $params{$name} = [ $cgi->param($symbol) ];
> > +                             if ($cgi->param($symbol)) {
> > +                                     # to allow for multivalued params we use arrayref form
> > +                                     $params{$name} = [ $cgi->param($symbol) ];
> > +                             } else {
> > +                                     no strict 'refs';
> > +                                     $params{$name} = $$name if $$name;
> > +                             }
> >                       }
> >               }
> >       }
>
> What this change is about? And why this change is _here_, in this
> commit? It is I think unrelated, and wrong change.

This is about being able to recycle CGI parameters that came through
as part of path_info instead of the CGI parameter list. It might not
be the best way to recover it, though. I *did* have a few thoughts
about an alternative way that consisted of build a parameter list
merging CGI and path-info parameter, but since this approach seemed to
work, I went with it.

> href(..., -replay=>1) is all about reusing current URL, perhaps with
> a few parameters changed, like for example pagination links differ only
> in page number param change.  For example if we had only hb= and f=
> parameters, -replay=>1 links should use only those, and not add h=
> parameter because somewhere we felt that we need $hash to be calculated.

Assume for example that you are to an url such as

http://git.oblomov.eu/git/tree/refs/remotes/origin/master:gitweb

Without this patch, the 'history' link on the second header line links
to ARRAY(0xblah)ARRAY(0xblah). With this patch, it shows the proper
link. So either replay is being abused somewhere in the link
generation code, or this CGI+path_info parameter retrieval is
necessary, one way or the other.

>> @@ -636,10 +653,28 @@ sub href (%) {
>
> This hunk is about generating pathinfo URL, isn't it?

Yes.

> You probably would want to change comment at the top of this part
> of href() subroutine, namely
>
>        if ($use_pathinfo) {
>                # use PATH_INFO for project name
>
> as you now try to use PATH_INFO for more than project name. Please do
> not leave comments to get out of sync with the code.

Right.

>>               $href .= "/".esc_url($params{'project'}) if defined $params{'project'};
>>               delete $params{'project'};
>>
>> -             # Summary just uses the project path URL
>> -             if (defined $params{'action'} && $params{'action'} eq 'summary') {
>> +             # Summary just uses the project path URL, any other action come next
>> +             # in the URL
>> +             if (defined $params{'action'}) {
>> +                     $href .= "/".esc_url($params{'action'}) unless $params{'action'} eq 'summary';
>>                       delete $params{'action'};
>>               }
>> +
>> +             # next, we put either hash_base:file_name or hash
>> +             if (defined $params{'hash_base'}) {
>> +                     $href .= "/".esc_url($params{'hash_base'});
>> +                     if (defined $params{'file_name'}) {
>> +                             $href .= ":".esc_url($params{'file_name'});
>> +                             delete $params{'hash'} if $params{'hash'} eq git_get_hash_by_path($params{'hash_base'},$params{'file_name'});
>
> First, this page has around 140 characters. That is too long, much too long.
> Please try to wrap code around 80-characters.
>
> Second, following Petr 'Pasky' Baudis suggestion of reducing complexity
> and shortening gitweb URLs, we could unconditionally remove redundant
> 'hash' parameter if we have both 'hash_base' and 'file_name'
> parameters.  This would also simplify and speed up (lack of extra fork)
> gitweb code.

If it's indeed guaranteed that hash is not needed in these cases, it's
surely the best course of action. I changed the code to that effect.

>> +                             delete $params{'file_name'};
>> +                     } else {
>> +                             delete $params{'hash'} if $params{'hash'} eq $params{'hash_base'};
>> +                     }
>> +                     delete $params{'hash_base'};
>> +             } elsif (defined $params{'hash'}) {
>> +                     $href .= "/".esc_url($params{'hash'});
>> +                     delete $params{'hash'};
>> +             }
>
> O.K.... I think.
>
> Did you test this, preferably also using Mechanize test, with gitweb
> configuration turning path_info on by default.?

The whole patchset is running both on my machine on
http://git.oblomov.eu and on the rbot repository
http://ruby-rbot.org/gitweb (older version there, though). I have no
idea how to run automated Mechanize tests though.

>>       }
>>
>>       # now encode the parameters explicitly
>
> Hmmm... now I am not so sure if it wouldn't be better to split this
> patch in pathinfo parsing and pathinfo generation. The first part
> would be obvious, the second part would be smaller and easier to review.

Ok, I'll split parsing from generation. Since it's what I did for
subsequent extensions (such as the parent..current thing) it also fits
nicely with the patchflow.



-- 
Giuseppe "Oblomov" Bilotta
