From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: refactor input parameters parse/validation
Date: Tue, 7 Oct 2008 14:42:58 +0200
Message-ID: <cb7bb73a0810070542v4c8a9820x4d91ea20597ddf01@mail.gmail.com>
References: <1223054356-17643-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200810071257.38423.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	"Matthias Lederhofer" <matled@gmx.net>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 14:45:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnBvE-00015M-MT
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 14:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbYJGMnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 08:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753209AbYJGMnD
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 08:43:03 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:64550 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158AbYJGMnA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 08:43:00 -0400
Received: by gxk9 with SMTP id 9so6411663gxk.13
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 05:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=RYGl51DNAqgNv0Kkx3yTjicfoF3LVPJGb9dsnIs14Ug=;
        b=IV7ri6wNreaexVGLg73hifnjm3Ecec6BcvXrLifXnxz/f9OD5HYYeUfn156qeqxEpo
         fzOG9OcNBCLZMCViugx9YJIdbhonmKtopDkOz7YuzZPQnUqSOZkXndYKDK6VcBiJvVmJ
         aROyWmLYq/u2yJcyw7TU1qEq9F1YMpAXD410I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QHHjxbzfVjVKz25TzK/6HqVyLiCj1ZZ+BDkEzkP0Js98av7aEvK2AZs+hDjuy+p0IV
         Ec9QfMzsUTjl//YBAiTGYFgRWrj0J3kYjhvtLGcblrLTOY57/A3eYiQZAoSotDeM5yQh
         I+JD6Ot1Mj29owZK+EiD8zhp5r9Pvd6cDY2bA=
Received: by 10.150.58.5 with SMTP id g5mr9772915yba.27.1223383379070;
        Tue, 07 Oct 2008 05:42:59 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Tue, 7 Oct 2008 05:42:58 -0700 (PDT)
In-Reply-To: <200810071257.38423.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97703>

On Tue, Oct 7, 2008 at 12:57 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Fri, 3 Oct 2008, Giuseppe Bilotta wrote:

>> +# we make $path_info global because it's also used later on
>> +my $path_info = $ENV{"PATH_INFO"};
>> +if ($path_info) {
>>       $my_url =~ s,\Q$path_info\E$,,;
>>       $my_uri =~ s,\Q$path_info\E$,,;
>>  }
>
> I think we could have left it as it was, i.e. have $path_info be
> a local variable.  Unless there is something I don't see.

Well, it's being reassigned locally in evaluate_path_info ... since
we're looking at it anyway, I thought it made sense to do it once and
for all. The var could also potentially have other uses, such as
enabling the use of path_info whenever path_info was used (something
which is currently not done), so ...

>> +# input parameters are stored with the long parameter name as key, so we need
>> +# the name -> CGI key mapping here. This will also be used in the href
>> +# subroutine to convert parameters to their CGI equivalent.
>
> Actually href() subroutine would be called many times, while parsing of
> input params happens only once; that is why it is longname => shortname
> hash, and not the reverse (shortname => longname).  Also it does not
> result in loss of performance as we parse all input params anyway.
>
> This explanation might be obvious, or could be put in comment
> (increasing comment to code count ;-))

It's actually a good point, I'll put it in (and not for the comment to
code ratio 8-D)

>> +my @cgi_param_mapping = (
>> +my %cgi_param_mapping = @cgi_param_mapping;
>> +my %actions = (
>
> Perhaps %allowed_options should also be there, to have everything about
> input params in single place... or perhaps not...

I had thought about it. It makes sense in a way to put it after
cgi_param_mapping. I didn't do it to reduce the code move.

>> +# fill %input_params with the CGI parameters. All values except for 'opt'
>> +# should be single values, but opt can be an array. We should probably
>> +# build an array of parameters that can be multi-valued, but since for the time
>> +# being it's only this one, we just single it out
>> +while (my ($name, $symbol) = each %cgi_param_mapping) {
>> +     if ($symbol eq 'opt') {
>> +             $input_params{$name} = [$cgi->param($symbol)];
>
> I would personally use "[ $cgi->param($symbol) ]" instead for better
> (IMVHO) visibility, but this is just a matter of taste.

Ah yes, much more readable. I'll do it.

>> +     } else {
>> +             $input_params{$name} = $cgi->param($symbol);
>> +     }
>> +}
>
> Nice. I guess that you have checked that you caught all
> $cgi->param(...) calls, and there aren't any beside those above...

I did a grep so I *think* I didn't miss any.


>> +# now read PATH_INFO and update the parameter list for missing parameters
>> +sub evaluate_path_info {
>> +     return if defined $input_params{'project'};
>
> I was 'my $path_info = $ENV{"PATH_INFO"};' there, when $path_info
> wasn't global variable.  Any advantages to having it global?
>
> (This is just a minor thing, not worth resending patch over, I think).

As I mentioned above, just sparing a double assignment for something
that is going to be checked anyway both at the beginning and here. And
it can also have other uses, potentially.

>> +     # find which part of PATH_INFO is project
>> +     my $project = $path_info;
>
> Hmmm... now $project is local (lexically) here.

Yes, itt's only used temporarily here, to see if  a proper $project
can be defined. It gets redefined outside. It just made sense to name
it like this 8-)

>> +     $project =~ s,/+$,,;
>> +     while ($project && !check_head_link("$projectroot/$project")) {
>> +             $project =~ s,/*[^/]*$,,;
>> +     }
>> +     # validate project
>> +     $project = validate_project($project);
>
> I'm not sure if it is worth worrying over, but I think you repeat
> check_head_link() check here.
>
> [After examining code further].  But I think you do double validation;
> once you do it here, and once you do it copying to global variables
> such as $action or $project, and double checking check_head_link()
> won't be easy to avoid; fortunately it is cheap filesystem-level check
> (might be slow only when stat is extremely slow, and is not cached).

I know. This is actually the reason why I had interleaved path_info
definition and global validation in my previous version of the patch.
The big issue here is that path_info evaluation _needs_ (partial)
validation.

A possible alternative could be to only put validated parameters into
%input_params. This would completely separate the validation for cgi
and path_info (modulo shared subs).

Of course, the check_head_link would still be repeated inside
evaluate_path_info, but the other params could skip a double
validation.

>> +     return unless $project;
>> +     $input_params{'project'} = $project;
>> +
>> +     # do not change any parameters if an action is given using the query string
>> +     return if $input_params{'action'};
>> +     $path_info =~ s,^\Q$project\E/*,,;
>
> Hmmm... I wonder if it is good idea. It was done in commit 645927c
> (gitweb: fix warnings in PATH_INFO code and add export_ok/strict_export)
> by Matthias Lederhofer, but I don't see why we do not remove project
> from path_info if action is set.  But this is belongs probably to
> independent code cleanup (if it is needed), so don't worry about that.

path_info information is simply discarded if action was already
defined, because it was assumed that path_info was only used for
default action. it's something that might be retaught with the rest of
the path_info enhancements.

> Perhaps it would be good to add empty line here before beginning of
> 'hash' and 'hash_base:file_name' handling.

Can do.

>> +     my ($refname, $pathname) = split(/:/, $path_info, 2);
>> +     if (defined $pathname) {
>> +             # we got "project.git/branch:filename" or "project.git/branch:dir/"
>> +             # we could use git_get_type(branch:pathname), but it needs $git_dir
>
> Additionally git_get_type(<extended sha1>) is additional call to git
> (additional fork) currently; that might change with gitweb caching code,
> which uses permanent connection to 'git cat-file --batch/--batch-check'
> for that.

I can add that to the comment.

>> +             $pathname =~ s,^/+,,;
>> +             if (!$pathname || substr($pathname, -1) eq "/") {
>> +                     $input_params{'action'} = "tree";
>> +                     $pathname =~ s,/$,,;
>> +             } else {
>> +                     $input_params{'action'} = "blob_plain";
>> +             }
>> +             $input_params{'hash_base'} ||= validate_refname($refname);
>> +             $input_params{'file_name'} ||= validate_pathname($pathname);
>> +     } elsif (defined $refname) {
>> +             # we got "project.git/branch"
>> +             $input_params{'action'} = "shortlog";
>> +             $input_params{'hash'} ||= validate_refname($refname);
>> +     }
>> +}
>
> Nice defensive programming with '||=' here for setting %input_params.
>
> [After examining code further].  But I think you do double validation;
> see comment below.

[see above]

>> +evaluate_path_info();
>> +
>> +our $action = $input_params{'action'};
>>  if (defined $action) {
>> -     if ($action =~ m/[^0-9a-zA-Z\.\-_]/) {
>> +     if (!validate_action($action)) {
>>               die_error(400, "Invalid action parameter");
>>       }
>>  }
>
> Hmm... don't you do double validation now? Once in evaluate_path_info,
> and once copying to global variables like $action?
>
> Very nice moving param validation for 'a'/'action' parameter to
> validate_action() subroutine.

As I mentioned, this could be the solution to the double validation,
I'll just validate the cgi params separately from the path_info ones,
and only embed validated parameters in the %input_params hash

>> +our @extra_options = @{$input_params{'extra_options'}};
>> +# @extra_options is always defined, since it can only be (currently) set from
>> +# CGI, and $cgi->param() returns the empty array in array context
>
> ...if param was not set.

Ah, yes. I'll add it.

>>       if ($params{-replay}) {
>> -             while (my ($name, $symbol) = each %mapping) {
>> +             while (my ($name, $symbol) = each %cgi_param_mapping) {
>>                       if (!exists $params{$name}) {
>> -                             # to allow for multivalued params we use arrayref form
>> -                             $params{$name} = [ $cgi->param($symbol) ];
>> +                             $params{$name} = $input_params{$name};
>>                       }
>>               }
>>       }
>
> Nice cleanup.

Well, one would expect, given that this was the 'trigger' ;-)

I'll try to whip up a revised patch ASAP.

-- 
Giuseppe "Oblomov" Bilotta
