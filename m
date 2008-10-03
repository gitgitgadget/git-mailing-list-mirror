From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv4] gitweb: parse project/action/hash_base:filename PATH_INFO
Date: Fri, 3 Oct 2008 08:04:13 +0200
Message-ID: <cb7bb73a0810022304r11d2ad87q7691213ff67f7e4c@mail.gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200810021059.19708.jnareb@gmail.com>
	 <cb7bb73a0810020243v37759f79xfde4c32c49e1a375@mail.gmail.com>
	 <200810030248.57144.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 08:06:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kldn4-0007JU-HO
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 08:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbYJCGEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 02:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752864AbYJCGEQ
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 02:04:16 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:41898 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbYJCGEP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 02:04:15 -0400
Received: by gxk9 with SMTP id 9so2279961gxk.13
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 23:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+YMj3Ra9S1YG9m/9h2JZ792BzwjwjR/zcl0S2g8N5S4=;
        b=xH6REGElG9iO5laf3YFDPYPJOydNoTYpWcQiMW4yGSd9vnKlACMtkrtcjbg07dSnI6
         70iUUvXJf4VG+1eUWOAQP/J6z5orBGA9jcTTGHiY2tS6D4U1rLSx9Id474RuQ7hENpFA
         MpbGpkdngo4TDWYPB0BveaKmlBNLt8NFM1JAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=esVxqVk+3hG+gPk4O5N/Bb2QKNSi0TtqIBakK3LCaXB+Miz6Da2uUCEOMrPjMJnU7u
         nBJfjrUtxA4hippoOI9NpD0QHmq5UK3h+WPD8feP1wm3yC+xRbx+w4IIUsPAEA+KZ5LQ
         eyTzK4cAc7lW7ud+VahemGxa8a++LN+zmK3VE=
Received: by 10.150.133.18 with SMTP id g18mr1224589ybd.137.1223013853952;
        Thu, 02 Oct 2008 23:04:13 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Thu, 2 Oct 2008 23:04:13 -0700 (PDT)
In-Reply-To: <200810030248.57144.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97398>

On Fri, Oct 3, 2008 at 2:48 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Thu, 2 Oct 2008, Giuseppe Bilotta wrote:
>> OTOH, while setting both $hash and $hash_base has worked fine for me
>> so far (because the right one is automatically used and apparently
>> setting the other doesn't hurt), choosing which one to set is a much
>> hairier case. Do you have suggestions for a better way to always make
>> it work?
>
> Well, it is either checking $action and setting either $hash or
> $hash_base, or setting both, with some comments on why and when it is
> needed (as discussed on #git). IIUC $hash_base is needed only for
> filename-taking tree actions which acts on top-tree, and therefore
> don't need $file_name, like 'project/tree/branch' or related
> 'project/history/branch' (the latter is practically almost equivalent
> to 'project/shortlog/branch' or 'project/branch').
>
> I'm not sure if it wouldn't be better to call validate_refname($refname)
> once, either as:
>
>  $hash_base ||= $hash ||= validate_refname($refname);
>
> but that might be incorrect in the obscure case of setting $hash via 'h'
> CGI query parameter, and letting gitweb to set-up $hash_base via
> path_info, so perhaps ($refname is local to evaluate_path_info, IIRC)
>
>  $refname = validate_refname($refname);
>  $hash      ||= $refname;
>  $hash_base ||= $refname;

I'll go with this.

> But that is just nitpicking this fragment of code to death. In short:
> either check which of $hash and $hash_base to set in this branch of
> conditional, or explain why setting both $hash and $hash_base is needed,
> and why it is acceptable, either as comments, or in commit message.

Comment is probably better, as long as I remember to move it with the
code it belongs to ;)

>>>> @@ -631,8 +642,15 @@ sub href (%) {
>>>>       if ($params{-replay}) {
>>>>               while (my ($name, $symbol) = each %mapping) {
>>>>                       if (!exists $params{$name}) {
>>>> -                             # to allow for multivalued params we use arrayref form
>>>> -                             $params{$name} = [ $cgi->param($symbol) ];
>>>> +                             # the parameter we want to recycle may be either part of the
>>>> +                             # list of CGI parameter, or recovered from PATH_INFO
>>>> +                             if ($cgi->param($symbol)) {
>>>> +                                     # to allow for multivalued params we use arrayref form
>>>> +                                     $params{$name} = [ $cgi->param($symbol) ];
>>>> +                             } else {
>>>> +                                     no strict 'refs';
>>>> +                                     $params{$name} = $$name if $$name;
>>>
>>> I would _perhaps_ add here comment that multivalued parameters can come
>>> only from CGI query string, so there is no need for something like:
>>>
>>> +                                       $params{$name} = (ref($$name) ? @$name : $$name) if $$name;
>>>
>>>> +                             }
>>>>                       }
>>>>               }
>>>>       }
>>>
>>> This fragment is a bit of ugly code, hopefully corrected in later patch.
>>> I think it would be better to have 'refactor parsing/validation of input
>>> parameters' to be very fist patch in series; I am not sure but I suspect
>>> that is a kind of bugfix for current "$project/$hash" ('shortlog' view)
>>> and "$project/$hash_base:$file_name" ('blob_plain' and 'tree' view)
>>> path_info.
>>
>> But implementing the path_info parsing first makes the input param
>> refactoring SO much nicer that I would rather put a comment here
>> saying "this code sucks: we should rather collect all input
>> parameters" and then clean it up on the subsequent patch.
>
> Why not cleanup first?

Because cleaning it up depends on the refactoring, and the refactoring
is much cleaner when path_info already handles $action too.

> When implementing href(..., -replay=>1) I have forgot that some of
> gitweb parameters are implicitly passed ($project, because it is needed
> in most gitweb links), and some can be passed via path_info ($hash
> and/or $hash_base, $file_name). Your code adds $action to the mix, but
> it doesn't change the fact that 1.) even before your code -replay case
> was incorrect for some path_info links (handcrafted, as gitweb generates
> only $project via path_info); 2.) code you have added is a bit ugly.
>
> Besides using variables change a little meaning of -replay, namely
> in your code gitweb always sets action, even for non-path_name links
> when we started from "default action" (i.e. without action set) links.
> I guess this is mainly theoretical issue, as I don't think that default
> views use many -replay links.

Ah the issue of the default action is something I hadn't taken into
consideration, actually. Now the question is, should replay keep
default -> default, or should it go with default -> last incantation?

> P.S. with the idea of pushing parameters obtained not from CGI query
> string to $cgi->param() via "$cgi->param($name, $value);" or in named
> params form "$cgi->(-name=>$name, -value=>$value);" you would not need
> to change (a bit hacky, admittedly) href(...,-replay=>1) code.

Yes, but it would muddy the waters about 'where did this parameter
come from' in case we ever need to know that.

-- 
Giuseppe "Oblomov" Bilotta
