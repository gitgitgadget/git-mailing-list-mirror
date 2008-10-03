From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4] gitweb: parse project/action/hash_base:filename PATH_INFO
Date: Fri, 3 Oct 2008 02:48:56 +0200
Message-ID: <200810030248.57144.jnareb@gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com> <200810021059.19708.jnareb@gmail.com> <cb7bb73a0810020243v37759f79xfde4c32c49e1a375@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 03:50:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlZny-0005EL-NW
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 03:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbYJCBsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 21:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753774AbYJCBsq
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 21:48:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:6368 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbYJCBsp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 21:48:45 -0400
Received: by nf-out-0910.google.com with SMTP id d3so551338nfc.21
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 18:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=v0CVgeZQsv5WQkOYSkhfGV4mg/6Ng0HpEbneop+EqTs=;
        b=rhFdqaj07rhjpdrj/EnOyGn4Vb5/siZJi94RP53yPD9KVAwiSC5B/0CvcqSejm+zzc
         5smvQpWyDAsqHJ8KN9ADziaYOzqwlwiv788RzZT/s3lN3WYBoWASs9zVNOaEouqcx443
         k0Fv9NlXOvXJ223zM4aYXX3cfqVm8F+2suh5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BxwXrnqk6G+KQl+2mSqpNBKSFMW0cSv1oNWenP4KV0uw4yIP0Tf8zcZ2cE+uRJwlXS
         j+0gFfhOrWI+LSaodhuZ0CWUD9jUAE/0+vxwSiv+sEOCUc9P22qkkcpW2QpMz8h6SJgB
         G5lT4QsnKlqHv20+nHk3oSJ0awT0WMgTyFBe0=
Received: by 10.210.25.18 with SMTP id 18mr474360eby.78.1222998524032;
        Thu, 02 Oct 2008 18:48:44 -0700 (PDT)
Received: from ?192.168.1.11? (abvs210.neoplus.adsl.tpnet.pl [83.8.216.210])
        by mx.google.com with ESMTPS id 5sm3442182eyf.8.2008.10.02.18.48.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Oct 2008 18:48:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0810020243v37759f79xfde4c32c49e1a375@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97388>

On Thu, 2 Oct 2008, Giuseppe Bilotta wrote:
> On Thu, Oct 2, 2008 at 10:59 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> Giuseppe Bilotta wrote:

>>> -             $action ||= "shortlog";
>>> -             $hash   ||= validate_refname($refname);
>>> +             $action    ||= "shortlog";
>>> +             $hash      ||= validate_refname($refname);
>>> +             $hash_base ||= validate_refname($refname);
>>>       }
>>>  }
>>
>> This hunk is IMHO incorrect.  First, $refname is _either_ $hash, or
>> $hash_base; it cannot be both.  Second, in most cases (like the case
>> of 'shortlog' action, either explicit or implicit) it is simply $hash;
>> I think it can be $hash_base when $file_name is not set only in
>> singular exception case of 'tree' view for the top tree (lack of
>> filename is not an error, but is equivalent to $file_name='/').
> 
> OTOH, while setting both $hash and $hash_base has worked fine for me
> so far (because the right one is automatically used and apparently
> setting the other doesn't hurt), choosing which one to set is a much
> hairier case. Do you have suggestions for a better way to always make
> it work?

Well, it is either checking $action and setting either $hash or
$hash_base, or setting both, with some comments on why and when it is
needed (as discussed on #git). IIUC $hash_base is needed only for
filename-taking tree actions which acts on top-tree, and therefore
don't need $file_name, like 'project/tree/branch' or related 
'project/history/branch' (the latter is practically almost equivalent
to 'project/shortlog/branch' or 'project/branch').

I'm not sure if it wouldn't be better to call validate_refname($refname)
once, either as:

  $hash_base ||= $hash ||= validate_refname($refname);
 
but that might be incorrect in the obscure case of setting $hash via 'h'
CGI query parameter, and letting gitweb to set-up $hash_base via
path_info, so perhaps ($refname is local to evaluate_path_info, IIRC)

  $refname = validate_refname($refname);
  $hash      ||= $refname;
  $hash_base ||= $refname;

But that is just nitpicking this fragment of code to death. In short:
either check which of $hash and $hash_base to set in this branch of
conditional, or explain why setting both $hash and $hash_base is needed,
and why it is acceptable, either as comments, or in commit message.

>>> @@ -631,8 +642,15 @@ sub href (%) {
>>>       if ($params{-replay}) {
>>>               while (my ($name, $symbol) = each %mapping) {
>>>                       if (!exists $params{$name}) {
>>> -                             # to allow for multivalued params we use arrayref form
>>> -                             $params{$name} = [ $cgi->param($symbol) ];
>>> +                             # the parameter we want to recycle may be either part of the
>>> +                             # list of CGI parameter, or recovered from PATH_INFO
>>> +                             if ($cgi->param($symbol)) {
>>> +                                     # to allow for multivalued params we use arrayref form
>>> +                                     $params{$name} = [ $cgi->param($symbol) ];
>>> +                             } else {
>>> +                                     no strict 'refs';
>>> +                                     $params{$name} = $$name if $$name;
>>
>> I would _perhaps_ add here comment that multivalued parameters can come
>> only from CGI query string, so there is no need for something like:
>>
>> +                                       $params{$name} = (ref($$name) ? @$name : $$name) if $$name;
>>
>>> +                             }
>>>                       }
>>>               }
>>>       }
>>
>> This fragment is a bit of ugly code, hopefully corrected in later patch.
>> I think it would be better to have 'refactor parsing/validation of input
>> parameters' to be very fist patch in series; I am not sure but I suspect
>> that is a kind of bugfix for current "$project/$hash" ('shortlog' view)
>> and "$project/$hash_base:$file_name" ('blob_plain' and 'tree' view)
>> path_info.
> 
> But implementing the path_info parsing first makes the input param
> refactoring SO much nicer that I would rather put a comment here
> saying "this code sucks: we should rather collect all input
> parameters" and then clean it up on the subsequent patch.

Why not cleanup first?

When implementing href(..., -replay=>1) I have forgot that some of
gitweb parameters are implicitly passed ($project, because it is needed
in most gitweb links), and some can be passed via path_info ($hash 
and/or $hash_base, $file_name). Your code adds $action to the mix, but
it doesn't change the fact that 1.) even before your code -replay case
was incorrect for some path_info links (handcrafted, as gitweb generates
only $project via path_info); 2.) code you have added is a bit ugly.

Besides using variables change a little meaning of -replay, namely
in your code gitweb always sets action, even for non-path_name links
when we started from "default action" (i.e. without action set) links.
I guess this is mainly theoretical issue, as I don't think that default
views use many -replay links.


P.S. with the idea of pushing parameters obtained not from CGI query
string to $cgi->param() via "$cgi->param($name, $value);" or in named
params form "$cgi->(-name=>$name, -value=>$value);" you would not need
to change (a bit hacky, admittedly) href(...,-replay=>1) code.
-- 
Jakub Narebski
Poland
