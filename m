From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv4] gitweb: refactor input parameters parse/validation
Date: Fri, 3 Oct 2008 09:24:35 +0200
Message-ID: <cb7bb73a0810030024t663940dbqa23f2e1bb75e23bc@mail.gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1222906234-8182-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <1222906234-8182-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <200810030336.31469.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 09:25:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klf2q-0002vz-RH
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 09:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbYJCHYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 03:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752818AbYJCHYi
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 03:24:38 -0400
Received: from hs-out-0708.google.com ([64.233.178.244]:1069 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbYJCHYh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 03:24:37 -0400
Received: by hs-out-0708.google.com with SMTP id 4so456229hsl.5
        for <git@vger.kernel.org>; Fri, 03 Oct 2008 00:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FOUDWIghOKCp0WvTSiONzpdM8Z9uLja5GfS40dpV5J4=;
        b=xpv0gDQf+ijH4CFIKY0/R0a+nD8KytHKyB/S7wQeBIvOsm5stP4FGu1F+l4NBriRat
         0suokYs79RSbKErZmzHy2gr0Z8DeXOseuqG/dFjTR8fyaH94oMXjj4xn5X5wDXbPaAqs
         Mu66QCzx/jyff0nSYIANks3awwRRFif8Tue/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=sdNO18vCTjXSM6RTh+hM/WtfVENKbN4LaH7Yxkxigq6rzzc/R2Z0z0douq0U6qm6c/
         Z1LGpNKCRan3UbvVWZAmG/3b+BCTQKzhrxjuzK3zba6RcAQMKvSoqeEisLTuVLpdBBD3
         PZt/BMaA2yeHRwqXC1EU9SytTgbf3lAVIggUo=
Received: by 10.150.58.17 with SMTP id g17mr1326516yba.175.1223018675952;
        Fri, 03 Oct 2008 00:24:35 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Fri, 3 Oct 2008 00:24:35 -0700 (PDT)
In-Reply-To: <200810030336.31469.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97400>

On Fri, Oct 3, 2008 at 3:36 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Thu, 2 Oct 2008, Giuseppe Bilotta wrote:
>
>> Since input parameters can now be obtained both from CGI parameters and
>> PATH_INFO, we would like most of the code to be agnostic about the way
>> parameters were retrieved.
>
> I'd prefer that this cleanup/refactoring patch was _first_ patch in
> the series, as we were able to obtain parameters both from CGI query
> parameters and from PATH_INFO ($project, $hash or $hash_base+$file_name)
> _before_ first patch in this series.  So it correct not only issue
> introduced by first patch (and fixed somewhat there), but what was
> outstanding (but rare because gitweb did not generate such links)
> issue.

It's true that the patch makes sense regardless of the rest of the
path_info patch, indeed.

>> We thus collect all the parameters into the new %input_params hash,
>> removing the need for ad-hoc kludgy code in href().
>
> Alternate solution would be push data from PATH_INFO in query params
> data using (for example)
>
>  $cgi->param('a', $action);
>
> or, naming parameters explicitely
>
>  $cgi->param(-name=>'a', -value=>$action);
>
> This avoids need for additional variable, reuses current code, and
> nicely sidesteps issue whether to use long names for keys ('action',
> 'file_name') or short ones from CGI query ('a', 'f').
>
>
> It would probably has to be at least partially written to check which
> of those two solutions (%input_params or $cgi->param('a', $a)))
> is better.

If we really don't want to care where the parameters came from *at
all*, writing on $cgi->param is likely to be the cleanest solution.

>> As much of the
>> parameters validation code is now shared between CGI and PATH_INFO,
>> although this requires PATH_INFO parsing to be interleaved into the main
>> code instead of being factored out into its own routine.
>
> I'm not sure if it is worth it then to unify parameters validation,
> with such drawback.

Yeah, I don't like it very much either. But it does spare a little on
the validation. OTOH, the amount we spare is not extraordinary, so
it's probably not worth the spaghettization of the code ...

>>  # if we're called with PATH_INFO, we have to strip that
>> -# from the URL to find our real URL
>> -if (my $path_info = $ENV{"PATH_INFO"}) {
>> +# from the URL to find our real URL. PATH_INFO is kept
>> +# as it's used later on for parameter extraction
>> +my $path_info = $ENV{"PATH_INFO"};
>> +if ($path_info) {
>>       $my_url =~ s,\Q$path_info\E$,,;
>>       $my_uri =~ s,\Q$path_info\E$,,;
>>  }
>
> This might be separate patch, if you wanted to increase your commit
> count ;-)  More seriously I think it should be at least briefly
> mentioned in commit message (make $path_info global).

Note however that the path_info evaluation is _destructive_, so after
evaluation is complete we don't have much of it left.

[snip]

> Nice, although I'm not sure if [%@]cgi_param_mapping has to global.
> If we use long parameters names as keys, I think it has to, somewhat.
> See also comment below.

>> +# fill %input_params with the CGI parameters. All values except for 'opt'
>> +# should be single values, but opt can be an array. We should probably
>> +# build an array of parameters that can be multi-valued, but since for the time
>> +# being it's only this one, we just single it out
>> +while (my ($name, $symbol) = each %cgi_param_mapping) {
>> +     if ($symbol eq 'opt') {
>> +             $input_params{$name} = [$cgi->param($symbol)];
>> +     } else {
>> +             $input_params{$name} = $cgi->param($symbol);
>>       }
>>  }
>
> If it was chosen to use short (CGI query) parameter names, the above
> loop could be replaced by simple
>
>  %input_params = $cgi->Vars;
>
> or to be more exact, if we want to have multi-valued parameters stored
> as array ref
>
>  %input_params = map { [ split /\0/ ] if /\0/; } $cgi->Vars;
>
>
> See CGI(3pm):
>
>    When using this [Vars], the thing you must watch out for are multivalued CGI
>    parameters.  Because a hash cannot distinguish between scalar and list con-
>    text, multivalued parameters will be returned as a packed string, separated
>    by the "\0" (null) character.  You must split this packed string in order
>    to get at the individual values.

Ah, an interesting alternative. This would make parameter copying a
one-liner, almost as good as just using $cgi->param for everything :)

>> -# parameters which are pathnames
>> -our $project = $cgi->param('p');
>> +# next, we want to parse PATH_INFO (which was already stored in $path_info at
>> +# the beginning). This is a little hairy because PATH_INFO parsing needs some
>> +# form of parameter validation, so we interleave parsing and validation.
>
> I don't think it is a good idea. In my opinion, for my taste, it would
> be better to separate evaluating path_info from the rest.
>
> We could instead introduce convention that if variable (like $project)
> is set, then it is assumed to be validated; if it is present only in
> the %input_params hash, then it has to be validated.
>
>
> On the other hand this ordering, first by parameter, then by method
> of extraction could be seem quite equally valid.  Nevertheless I think
> that previous flow with separate evaluate_path_info() and what should
> be evaluate_CGI_query() has better encapsulation.
>
>> +#
>> +# The accepted PATH_INFO syntax is $project/$action/$hash or
>> +# $project/$action/$hash_base:$file_name, where $action may be missing (mostly for
>> +# backwards compatibility), so we need to parse and validate the parameters in
>> +# this same order.
>> +
>> +# clear $path_info of any leading /
>> +$path_info =~ s,^/+,,;
>> +
>> +our $project = $input_params{'project'};
>> +if ($path_info && !defined $project) {
>> +     # if $project was not defined by CGI, we try to extract it from
>> +     # $path_info
>> +     $project = $path_info;
>> +     $project =~ s,/+$,,;
>> +     while ($project && !check_head_link("$projectroot/$project")) {
>> +             $project =~ s,/*[^/]*$,,;
>> +     }
>> +     $input_params{'project'} = $project;
>> +} else {
>> +     # otherwise, we suppress $path_info parsing altogether
>> +     $path_info = undef;
>> +}
>> +
>> +# project name validation
>>  if (defined $project) {
>>       if (!validate_pathname($project) ||
>>           !(-d "$projectroot/$project") ||
>
> Note that this code does less checking if $project is in path_info than
> for the case where it is set by CGI query. Perhaps there should be base
> fast check in a loop, and more extensive test later.

Uh ... isn't this exactly what's happening? In the loop we just gobble
until we find a git dir. Validation is then done, and it's the _same_
validation for both cases. Why do you say that path_info $project is
less checked?

>> @@ -408,16 +506,66 @@ if (defined $project) {
>>               undef $project;
>>               die_error(404, "No such project");
>>       }
>> +
>> +     # we purge the $project name from the $path_info, preparing it for
>> +     # subsequent parameters extraction
>> +     $path_info =~ s,^\Q$project\E/*,, if defined $path_info;
>> +} else {
>> +     # we also suppress $path_info parsing if no project was defined
>> +     $path_info = undef;
>> +}
>
> In evaluate_path_info it was simply 'return if...'; here with mentioned
> interleaving it is harder and a bit hacky.

I know.

>>       $params{'project'} = $project unless exists $params{'project'};
>>
>>       if ($params{-replay}) {
>> -             while (my ($name, $symbol) = each %mapping) {
>> -                     if (!exists $params{$name}) {
>> -                             # the parameter we want to recycle may be either part of the
>> -                             # list of CGI parameter, or recovered from PATH_INFO
>> -                             if ($cgi->param($symbol)) {
>> -                                     # to allow for multivalued params we use arrayref form
>> -                                     $params{$name} = [ $cgi->param($symbol) ];
>> -                             } else {
>> -                                     no strict 'refs';
>> -                                     $params{$name} = $$name if $$name;
>> -                             }
>> -                     }
>> +             while (my ($name, $val) = each %input_params) {
>> +                     $params{$name} = $input_params{$name}
>> +                             unless (exists $params{$name});
>
> Very nice, short code.  Should be something like that from
> the very beginning.

Ok, I'll try working up a patch for params merging before any
path_info extensions.

-- 
Giuseppe "Oblomov" Bilotta
