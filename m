From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4] gitweb: refactor input parameters parse/validation
Date: Fri, 3 Oct 2008 13:20:28 +0200
Message-ID: <200810031320.28843.jnareb@gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com> <200810030336.31469.jnareb@gmail.com> <cb7bb73a0810030024t663940dbqa23f2e1bb75e23bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 13:30:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlirW-0004h3-20
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 13:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbYJCL3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 07:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752842AbYJCL3M
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 07:29:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:55021 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448AbYJCL3J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 07:29:09 -0400
Received: by nf-out-0910.google.com with SMTP id d3so600738nfc.21
        for <git@vger.kernel.org>; Fri, 03 Oct 2008 04:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=7ntH+GxNWK4OcBJuBzV1r5RiMMIKuXsdpjoP+q87M3E=;
        b=AfiyY78SQiYHUobU/ZN/d9vSd0y5++tJpim4pNnz2lXlpiBTT4iJqjAsdt84pmt+6q
         DFQEu4CURzjPRq4P5h15fNB77XmdL9ScwAsFiF+X2+ieMNG7Cf04ix3LJiL/gc8UUDxW
         VeK5jIVpAZynvalqmsRWTeWgXEnkqa62BYb1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZMsfcdq/KQ5UM24J5vKVfpgY2DynSnXgZNKzwc4pX1S/eg87LqUxD1/qPbYnyEADik
         kGaDNzctiTIPsjlx1E1UTQZWJhgkQU4wcKkvehYsmA3IHCW+2Vf5iRQoj4Ydn4JAxVMm
         tCWT/f8nWQaoLXn4EXWggFk31Fkjt3hNDfuuk=
Received: by 10.210.115.17 with SMTP id n17mr1122164ebc.148.1223033347863;
        Fri, 03 Oct 2008 04:29:07 -0700 (PDT)
Received: from ?192.168.1.11? (abvs210.neoplus.adsl.tpnet.pl [83.8.216.210])
        by mx.google.com with ESMTPS id 5sm4069380eyf.8.2008.10.03.04.29.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Oct 2008 04:29:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0810030024t663940dbqa23f2e1bb75e23bc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97412>

On Fri, 3 Oct 2008, Giuseppe Bilotta wrote:
> On Fri, Oct 3, 2008 at 3:36 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Thu, 2 Oct 2008, Giuseppe Bilotta wrote:

>>> We thus collect all the parameters into the new %input_params hash,
>>> removing the need for ad-hoc kludgy code in href().
>>
>> Alternate solution would be push data from PATH_INFO in query params
>> data using (for example)
>>
>>  $cgi->param('a', $action);
>>
>> or, naming parameters explicitely
>>
>>  $cgi->param(-name=>'a', -value=>$action);
>>
>> This avoids need for additional variable, reuses current code, and
>> nicely sidesteps issue whether to use long names for keys ('action',
>> 'file_name') or short ones from CGI query ('a', 'f').
>>
>>
>> It would probably has to be at least partially written to check which
>> of those two solutions (%input_params or $cgi->param('a', $a)))
>> is better.
> 
> If we really don't want to care where the parameters came from *at
> all*, writing on $cgi->param is likely to be the cleanest solution.

I now think that %input_params is a better solution, even if we won't
be implementing -true_replay / -faithful_replay option, where options
gotten in path_info would be passed in path_info, and options passed
in query string would be passed as CGI params (even if those params
could be encoded in path_info).
 
One of the advantages is that having @cgi_param_mapping near the top
provides opportunity to describe short CGI query options.

Another advantage is that with %input_params it is easy to find if
parameter is multivalued, or is meant to be multivalued: just check
ref($input_params{long_name}); well, perhaps not _that_ easy, but...

>>> As much of the
>>> parameters validation code is now shared between CGI and PATH_INFO,
>>> although this requires PATH_INFO parsing to be interleaved into the main
>>> code instead of being factored out into its own routine.
>>
>> I'm not sure if it is worth it then to unify parameters validation,
>> with such drawback.
> 
> Yeah, I don't like it very much either. But it does spare a little on
> the validation. OTOH, the amount we spare is not extraordinary, so
> it's probably not worth the spaghettization of the code ...

Avoiding repetition can be done in different ways, for example we can
have gitweb assume that if value is already in params variable
($project, $action, $hash,...) it is already validated, and if it is
only in %input_params it is not.  Add to that for example putting
common part of project path checks into validate_project and you have
all the advantages (no code repetition, spared validation) without
drawback of harder to maintain spaghetti-like code.

>>> +# fill %input_params with the CGI parameters. All values except for 'opt'
>>> +# should be single values, but opt can be an array. We should probably
>>> +# build an array of parameters that can be multi-valued, but since for the time
>>> +# being it's only this one, we just single it out
>>> +while (my ($name, $symbol) = each %cgi_param_mapping) {
>>> +     if ($symbol eq 'opt') {
>>> +             $input_params{$name} = [$cgi->param($symbol)];
>>> +     } else {
>>> +             $input_params{$name} = $cgi->param($symbol);
>>>       }
>>>  }
>>
>> If it was chosen to use short (CGI query) parameter names, the above
>> loop could be replaced by simple
>>
>>  %input_params = $cgi->Vars;
>>
>> or to be more exact, if we want to have multi-valued parameters stored
>> as array ref
>>
>>  %input_params = map { [ split /\0/ ] if /\0/; } $cgi->Vars;
>>
>>
>> See CGI(3pm):
>>
>>    When using this [Vars], the thing you must watch out for are multivalued CGI
>>    parameters.  Because a hash cannot distinguish between scalar and list con-
>>    text, multivalued parameters will be returned as a packed string, separated
>>    by the "\0" (null) character.  You must split this packed string in order
>>    to get at the individual values.
> 
> Ah, an interesting alternative. This would make parameter copying a
> one-liner, almost as good as just using $cgi->param for everything :)

Hmmmm...
 

[cut]
>> Note that this code does less checking if $project is in path_info than
>> for the case where it is set by CGI query. Perhaps there should be base
>> fast check in a loop, and more extensive test later.
> 
> Uh ... isn't this exactly what's happening? In the loop we just gobble
> until we find a git dir. Validation is then done, and it's the _same_
> validation for both cases. Why do you say that path_info $project is
> less checked?

For project from query string we now have:

  !validate_pathname($project) ||
  !(-d "$projectroot/$project") ||
  !check_head_link("$projectroot/$project") ||
  ($export_ok && !(-e "$projectroot/$project/$export_ok")) ||
  ($strict_export && !project_in_list($project))

For project from path_info we now have:

  while ($project && !check_head_link("$projectroot/$project")) {
	$project =~ s,/*[^/]*$,,;
  }
  ...
  !validate_pathname($project) ||
  ($export_ok && !-e "$projectroot/$project/$export_ok") ||
  ($strict_export && !project_in_list($project))
  
It is almost the same; I have thought that they differ more. Perhaps
some of above code could be refactored into validate_project(), or
project_ok() subroutine.

>>>       $params{'project'} = $project unless exists $params{'project'};
>>>
>>>       if ($params{-replay}) {
>>> -             while (my ($name, $symbol) = each %mapping) {
>>> -                     if (!exists $params{$name}) {
>>> -                             # the parameter we want to recycle may be either part of the
>>> -                             # list of CGI parameter, or recovered from PATH_INFO
>>> -                             if ($cgi->param($symbol)) {
>>> -                                     # to allow for multivalued params we use arrayref form
>>> -                                     $params{$name} = [ $cgi->param($symbol) ];
>>> -                             } else {
>>> -                                     no strict 'refs';
>>> -                                     $params{$name} = $$name if $$name;
>>> -                             }
>>> -                     }
>>> +             while (my ($name, $val) = each %input_params) {
>>> +                     $params{$name} = $input_params{$name}
>>> +                             unless (exists $params{$name});
>>
>> Very nice, short code.  Should be something like that from
>> the very beginning.
> 
> Ok, I'll try working up a patch for params merging before any
> path_info extensions.

Perhaps also put query string handling into evaluate_CGI_query(), or
evaluate_query_string(), similar to evaluate_path_info()?

-- 
Jakub Narebski
Poland
